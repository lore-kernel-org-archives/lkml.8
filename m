Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60444C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BE582087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgDWXUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:20:37 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48604 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728212AbgDWXGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:33 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvM-0004bw-1Q; Fri, 24 Apr 2020 00:06:28 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvK-00E6j6-Cd; Fri, 24 Apr 2020 00:06:26 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Pablo Neira Ayuso" <pablo@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>
Date:   Fri, 24 Apr 2020 00:04:49 +0100
Message-ID: <lsq.1587683028.720742119@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 062/245] netfilter: ctnetlink: netns exit must wait
 for callbacks
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 18a110b022a5c02e7dc9f6109d0bd93e58ac6ebb upstream.

Curtis Taylor and Jon Maxwell reported and debugged a crash on 3.10
based kernel.

Crash occurs in ctnetlink_conntrack_events because net->nfnl socket is
NULL.  The nfnl socket was set to NULL by netns destruction running on
another cpu.

The exiting network namespace calls the relevant destructors in the
following order:

1. ctnetlink_net_exit_batch

This nulls out the event callback pointer in struct netns.

2. nfnetlink_net_exit_batch

This nulls net->nfnl socket and frees it.

3. nf_conntrack_cleanup_net_list

This removes all remaining conntrack entries.

This is order is correct. The only explanation for the crash so ar is:

cpu1: conntrack is dying, eviction occurs:
 -> nf_ct_delete()
   -> nf_conntrack_event_report \
     -> nf_conntrack_eventmask_report
       -> notify->fcn() (== ctnetlink_conntrack_events).

cpu1: a. fetches rcu protected pointer to obtain ctnetlink event callback.
      b. gets interrupted.
 cpu2: runs netns exit handlers:
     a runs ctnetlink destructor, event cb pointer set to NULL.
     b runs nfnetlink destructor, nfnl socket is closed and set to NULL.
cpu1: c. resumes and trips over NULL net->nfnl.

Problem appears to be that ctnetlink_net_exit_batch only prevents future
callers of nf_conntrack_eventmask_report() from obtaining the callback.
It doesn't wait of other cpus that might have already obtained the
callbacks address.

I don't see anything in upstream kernels that would prevent similar
crash: We need to wait for all cpus to have exited the event callback.

Fixes: 9592a5c01e79dbc59eb56fa ("netfilter: ctnetlink: netns support")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 net/netfilter/nf_conntrack_netlink.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3225,6 +3225,9 @@ static void __net_exit ctnetlink_net_exi
 
 	list_for_each_entry(net, net_exit_list, exit_list)
 		ctnetlink_net_exit(net);
+
+	/* wait for other cpus until they are done with ctnl_notifiers */
+	synchronize_rcu();
 }
 
 static struct pernet_operations ctnetlink_net_ops = {

