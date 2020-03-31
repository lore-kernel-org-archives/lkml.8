Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58762C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC53214D8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645702;
	bh=mtQU7ldRBNRJFWrn0CPhkTfp5h06s2WMQ8Ki9GlK1HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rBbqOGIxL1n3ywc3+mSX3XsFXRmc03slY707sKGFAAHQtjO5cwkbDoJ1bDNku+4bo
	 CxEsppwOVry00N38RJ5is+wAAh2+MHa8D9Nzk33Oq0PvMm5pTHmYvlky0b5Q0QcNd7
	 OqgYdNrjnohA2bAvv0drsTNrHOryBIgPcHCgKj1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731201AbgCaJIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730885AbgCaJIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:08:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B535520675;
        Tue, 31 Mar 2020 09:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645697;
        bh=mtQU7ldRBNRJFWrn0CPhkTfp5h06s2WMQ8Ki9GlK1HE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yYT9n4Sw1wNx+/lBq1MyByN0mlDGrzHDGP4veqJGPuIv2bYgshfWJf6hZ0q15amoi
         jtLcAT9FqH5uub4TZATAKxsSuKfY77FHiBNrcf1RnaJoiCXNzkoALcccyD5CMZ/Srb
         lfKc6RUKLIJm/ydSqi9NUIsZU+v80NF5QfgIThs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.5 135/170] netfilter: flowtable: reload ip{v6}h in nf_flow_tuple_ip{v6}
Date:   Tue, 31 Mar 2020 10:59:09 +0200
Message-Id: <20200331085437.894672280@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
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


