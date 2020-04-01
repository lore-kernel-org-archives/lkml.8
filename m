Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60F4C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC97212CC
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758395;
	bh=J+k6tNOuITWDjOMUJ/CB0Qmdfc51HhcF0TsMXLL9iXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=W7oxfKVhE/CqwSbagZmczhsMSkiukV1Bi8qJM3MFUIHZM4JKmzFXfISwc6f0d0iI1
	 lud2/B0iP0blU481REXi5EWK1Vj3gZG8YkpQUSOGrzBjErob9Flt4zOqJFl+ZjLhjL
	 UhI+TNFM5njwZ515vyoPJeLEgNfZ/IjoCpIVqUd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbgDAQ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:50856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387893AbgDAQ0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:26:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7DBB212CC;
        Wed,  1 Apr 2020 16:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758383;
        bh=J+k6tNOuITWDjOMUJ/CB0Qmdfc51HhcF0TsMXLL9iXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWO8Bf9RmbLrjhyVCmmQZzNVZVIaDM4fcjR78Sow+sIwz79e8cmiQ7i07RILbXIlU
         5AUnSnH6b3oIFOIKVxIwisxxr1nm2NNzewmSrCSnXLy5xrjj0ybdaGXvcQd1WVQxsN
         4MqwAypzIdDdITnnilcWPp08PCeo3Sd+1XSQnsCc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 072/116] netfilter: flowtable: reload ip{v6}h in nf_flow_tuple_ip{v6}
Date:   Wed,  1 Apr 2020 18:17:28 +0200
Message-Id: <20200401161552.153561555@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
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
@@ -188,6 +188,7 @@ static int nf_flow_tuple_ip(struct sk_bu
 	if (!pskb_may_pull(skb, thoff + sizeof(*ports)))
 		return -1;
 
+	iph = ip_hdr(skb);
 	ports = (struct flow_ports *)(skb_network_header(skb) + thoff);
 
 	tuple->src_v4.s_addr	= iph->saddr;
@@ -421,6 +422,7 @@ static int nf_flow_tuple_ipv6(struct sk_
 	if (!pskb_may_pull(skb, thoff + sizeof(*ports)))
 		return -1;
 
+	ip6h = ipv6_hdr(skb);
 	ports = (struct flow_ports *)(skb_network_header(skb) + thoff);
 
 	tuple->src_v6		= ip6h->saddr;


