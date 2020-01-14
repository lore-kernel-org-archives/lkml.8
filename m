Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F41C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8678624676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996523;
	bh=Pe+dFRjzapqzZ3u+uMbMOYlB5SMIdJfnVdCronLZ9+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q7zQhAI12X9DLoyomW9J+DILr6soBxu1WqyUbDRnoiTnyel38JCS6h1dPGaRqzC4h
	 TWunF35BhAY33MUkZ4t3tUuQn7mvhMgnmusPKyOXNEXvfxqQygCNJmHjRFqYSIzT9i
	 mFxnqEriZkuT6fJQgrSpzGN1WkCzRYqR7Ox27xrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731060AbgANKIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:40352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbgANKIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:08:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8945A24676;
        Tue, 14 Jan 2020 10:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996520;
        bh=Pe+dFRjzapqzZ3u+uMbMOYlB5SMIdJfnVdCronLZ9+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouUL92JIbCKAlsSVgFfxeCJXe6xBFbxYxDjqyGPs1U3OfyCdRFUXnG8Hybtz2BVfr
         VuF6wEqaKxFW3HAQBkxSQTEOy2XOmhkP8pQBgDFMt1Bag+0Ak25ye48myXkZlvJ6ZC
         raQv3nyuHi9BcCNfVySkkgL09QsTlG2IWlHGyLGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+46a4ad33f345d1dd346e@syzkaller.appspotmail.com,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 45/46] netfilter: conntrack: dccp, sctp: handle null timeout argument
Date:   Tue, 14 Jan 2020 11:02:02 +0100
Message-Id: <20200114094348.771052110@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094339.608068818@linuxfoundation.org>
References: <20200114094339.608068818@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

commit 1d9a7acd3d1e74c2d150d8934f7f55bed6d70858 upstream.

The timeout pointer can be NULL which means we should modify the
per-nets timeout instead.

All do this, except sctp and dccp which instead give:

general protection fault: 0000 [#1] PREEMPT SMP KASAN
net/netfilter/nf_conntrack_proto_dccp.c:682
 ctnl_timeout_parse_policy+0x150/0x1d0 net/netfilter/nfnetlink_cttimeout.c:67
 cttimeout_default_set+0x150/0x1c0 net/netfilter/nfnetlink_cttimeout.c:368
 nfnetlink_rcv_msg+0xcf2/0xfb0 net/netfilter/nfnetlink.c:229
 netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477

Reported-by: syzbot+46a4ad33f345d1dd346e@syzkaller.appspotmail.com
Fixes: c779e849608a8 ("netfilter: conntrack: remove get_timeout() indirection")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conntrack_proto_dccp.c |    3 +++
 net/netfilter/nf_conntrack_proto_sctp.c |    3 +++
 2 files changed, 6 insertions(+)

--- a/net/netfilter/nf_conntrack_proto_dccp.c
+++ b/net/netfilter/nf_conntrack_proto_dccp.c
@@ -687,6 +687,9 @@ static int dccp_timeout_nlattr_to_obj(st
 	unsigned int *timeouts = data;
 	int i;
 
+	if (!timeouts)
+		 timeouts = dn->dccp_timeout;
+
 	/* set default DCCP timeouts. */
 	for (i=0; i<CT_DCCP_MAX; i++)
 		timeouts[i] = dn->dccp_timeout[i];
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -603,6 +603,9 @@ static int sctp_timeout_nlattr_to_obj(st
 	struct nf_sctp_net *sn = sctp_pernet(net);
 	int i;
 
+	if (!timeouts)
+		timeouts = sn->timeouts;
+
 	/* set default SCTP timeouts. */
 	for (i=0; i<SCTP_CONNTRACK_MAX; i++)
 		timeouts[i] = sn->timeouts[i];


