Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926C3C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682612468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844434;
	bh=lH07DyGfCpn7Umrw/EPCa6h0VuEhaCMiaDb8h6et0cI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tefS9m+4ErAjRxPo880nQsCOFDE7b2tpxXRj+GvZx9gBfrilal8rCr0fSDxey0/y+
	 WAB1ZC6tRSa0iiAalnu7YGJ212fcnLYXNDHMyvTBZbm7GLoIz0bzUTbZuzfxNOL2Rh
	 uipZTwEFZHnqWBnsKZOC0UaKVrinqCjRJ8j/gpro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgCJMrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728112AbgCJMrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:47:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D732624696;
        Tue, 10 Mar 2020 12:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844429;
        bh=lH07DyGfCpn7Umrw/EPCa6h0VuEhaCMiaDb8h6et0cI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h2HpeYtoevXOSWDEUziZLGetMCSIbUfsJjWmjxb51FEHXYwctH4IxeQ9CjJDwO1W/
         DKdbKd/emQEsjik4yn43fIwU3Hg95GhQKZWog9satYQgZc3SGoYjiOzgQS2ZumItha
         Y0QkrjednCgXW1Htnv4R35PfncLXj0p3aCQVsPlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christophe Leroy <christophe.leroy@c-s.fr>,
        Richard Guy Briggs <rgb@redhat.com>,
        "Erhard F." <erhard_f@mailbox.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 40/88] net: netlink: cap max groups which will be considered in netlink_bind()
Date:   Tue, 10 Mar 2020 13:38:48 +0100
Message-Id: <20200310123615.720352829@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123606.543939933@linuxfoundation.org>
References: <20200310123606.543939933@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

commit 3a20773beeeeadec41477a5ba872175b778ff752 upstream.

Since nl_groups is a u32 we can't bind more groups via ->bind
(netlink_bind) call, but netlink has supported more groups via
setsockopt() for a long time and thus nlk->ngroups could be over 32.
Recently I added support for per-vlan notifications and increased the
groups to 33 for NETLINK_ROUTE which exposed an old bug in the
netlink_bind() code causing out-of-bounds access on archs where unsigned
long is 32 bits via test_bit() on a local variable. Fix this by capping the
maximum groups in netlink_bind() to BITS_PER_TYPE(u32), effectively
capping them at 32 which is the minimum of allocated groups and the
maximum groups which can be bound via netlink_bind().

CC: Christophe Leroy <christophe.leroy@c-s.fr>
CC: Richard Guy Briggs <rgb@redhat.com>
Fixes: 4f520900522f ("netlink: have netlink per-protocol bind function return an error code.")
Reported-by: Erhard F. <erhard_f@mailbox.org>
Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netlink/af_netlink.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1003,7 +1003,8 @@ static int netlink_bind(struct socket *s
 	if (nlk->netlink_bind && groups) {
 		int group;
 
-		for (group = 0; group < nlk->ngroups; group++) {
+		/* nl_groups is a u32, so cap the maximum groups we can bind */
+		for (group = 0; group < BITS_PER_TYPE(u32); group++) {
 			if (!test_bit(group, &groups))
 				continue;
 			err = nlk->netlink_bind(net, group + 1);
@@ -1022,7 +1023,7 @@ static int netlink_bind(struct socket *s
 			netlink_insert(sk, nladdr->nl_pid) :
 			netlink_autobind(sock);
 		if (err) {
-			netlink_undo_bind(nlk->ngroups, groups, sk);
+			netlink_undo_bind(BITS_PER_TYPE(u32), groups, sk);
 			return err;
 		}
 	}


