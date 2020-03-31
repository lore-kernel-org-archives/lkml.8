Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63F2C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C8B2137B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646241;
	bh=mtQU7ldRBNRJFWrn0CPhkTfp5h06s2WMQ8Ki9GlK1HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cBJZU8ev99BpXz6ebT06Kx3FUGhV9YbW9CuuxjMqWD12ZvY98b29jrZukVzoXev0h
	 PWh7VmgqaNvIrebxt2sjwYuAEri26F3FEKI9UGMbAUJxxMcmMq1NPcX9VW9D5s1Adi
	 DC0Pj+0XWoXzcaZN8EEovVUEJbpffeQStAiveVkY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731188AbgCaJRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:17:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:38304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731263AbgCaJRN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:17:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E046720675;
        Tue, 31 Mar 2020 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646233;
        bh=mtQU7ldRBNRJFWrn0CPhkTfp5h06s2WMQ8Ki9GlK1HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpZGUvpbMGIRwW2djYq3sCrHlFYOKAim0BCwUf2JQFChiMGl0OWYDJvKkz2a0S8B7
         MLNYYdaxzqt7G3Ue1VbR8Qr56eQicBzOQ251VB7h0szHCv3Uk4Z/7baSvBxT19WIii
         /9xX/RplOtOcG/xRRmCizStxutXO5s2JgB+RPg04=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 124/155] netfilter: flowtable: reload ip{v6}h in nf_flow_tuple_ip{v6}
Date:   Tue, 31 Mar 2020 10:59:24 +0200
Message-Id: <20200331085432.265404774@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>

commit 41e9ec5a54f95eee1a57c8d26ab70e0492548c1b upstream.

Since pskb_may_pull may change skb->data, so we need to reload ip{v6}h at
the right place.

Fixes: a908fdec3dda ("netfilter: nf_flow_table: move ipv6 offload hook code to nf_flow_table")
Fixes: 7d2086871762 ("netfilter: nf_flow_table: move ipv4 offload hook code to nf_flow_table")
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_flow_table_ip.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -189,6 +189,7 @@ static int nf_flow_tuple_ip(struct sk_bu
 	if (!pskb_may_pull(skb, thoff + sizeof(*ports)))
 		return -1;
 
+	iph = ip_hdr(skb);
 	ports = (struct flow_ports *)(skb_network_header(skb) + thoff);
 
 	tuple->src_v4.s_addr	= iph->saddr;
@@ -449,6 +450,7 @@ static int nf_flow_tuple_ipv6(struct sk_
 	if (!pskb_may_pull(skb, thoff + sizeof(*ports)))
 		return -1;
 
+	ip6h = ipv6_hdr(skb);
 	ports = (struct flow_ports *)(skb_network_header(skb) + thoff);
 
 	tuple->src_v6		= ip6h->saddr;


