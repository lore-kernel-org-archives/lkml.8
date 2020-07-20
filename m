Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6EEC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 286F722CBB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259477;
	bh=DJ1ilecmCb+OWeuhQTcrqgIMT3TIdepeMpd5ivd+l40=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WOGc1pwOQs7ZBqK11zLiiWUlxYfyuHZJBb1EJ/bTht6QCmi59CQB6lKk3i033m6wf
	 AbIe6KGSR4k4Em4gwnGXvBxy9FUGa/BPqjG/asnpiTu1Q3EE1mYr5YblJudnbKUS/M
	 nUDG3OMY3bAdEd1rMmbdK+S601BG0vD02PZttjJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgGTPhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:37:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728966AbgGTPhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:37:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EC0D22CB3;
        Mon, 20 Jul 2020 15:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259472;
        bh=DJ1ilecmCb+OWeuhQTcrqgIMT3TIdepeMpd5ivd+l40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yb5RU0OIS/gxoQQyPa6n5VqsC8pWVdjgaS/Yt2wVZtJZTLu6HPXqGc3Ek9RDWhGR1
         98em+apX43MnNoEhLP/g4NdBYfd5puY9xpdiccjXAiaQfKo4TtwyaKz/YxI/wLd1xM
         Kgo5KNBAjsEbjVVIsTrLiOlo5Ow+td/OMd5ugFvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Wouters <pwouters@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 20/58] ipv4: fill fl4_icmp_{type,code} in ping_v4_sendmsg
Date:   Mon, 20 Jul 2020 17:36:36 +0200
Message-Id: <20200720152748.151227677@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152747.127988571@linuxfoundation.org>
References: <20200720152747.127988571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 5eff06902394425c722f0a44d9545909a8800f79 ]

IPv4 ping sockets don't set fl4.fl4_icmp_{type,code}, which leads to
incomplete IPsec ACQUIRE messages being sent to userspace. Currently,
both raw sockets and IPv6 ping sockets set those fields.

Expected output of "ip xfrm monitor":
    acquire proto esp
      sel src 10.0.2.15/32 dst 8.8.8.8/32 proto icmp type 8 code 0 dev ens4
      policy src 10.0.2.15/32 dst 8.8.8.8/32
        <snip>

Currently with ping sockets:
    acquire proto esp
      sel src 10.0.2.15/32 dst 8.8.8.8/32 proto icmp type 0 code 0 dev ens4
      policy src 10.0.2.15/32 dst 8.8.8.8/32
        <snip>

The Libreswan test suite found this problem after Fedora changed the
value for the sysctl net.ipv4.ping_group_range.

Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
Reported-by: Paul Wouters <pwouters@redhat.com>
Tested-by: Paul Wouters <pwouters@redhat.com>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ping.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -802,6 +802,9 @@ static int ping_v4_sendmsg(struct sock *
 			   RT_SCOPE_UNIVERSE, sk->sk_protocol,
 			   inet_sk_flowi_flags(sk), faddr, saddr, 0, 0);
 
+	fl4.fl4_icmp_type = user_icmph.type;
+	fl4.fl4_icmp_code = user_icmph.code;
+
 	security_sk_classify_flow(sk, flowi4_to_flowi(&fl4));
 	rt = ip_route_output_flow(net, &fl4, sk);
 	if (IS_ERR(rt)) {


