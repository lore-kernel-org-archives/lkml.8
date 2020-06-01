Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8692EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C592068D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591035434;
	bh=50HIzBlE5cgtkzhTklOb2NH4NEGz76WiwXFCARxAil4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MkQ4bze/D/+NO8uiieSDfkmQRk6Tc8rl15p0iV9OzObxw2cEBSl/kXRfI+vbrbWMK
	 VnBcQuYlL+IiXxq3W6Nq1M0Vm15FNSrEu42pZ4SmAhwU1hkKsgsRkqD3v4J1e2kuvL
	 Nk4E74+uyf9G6L369jglAMjLIEXRX0iROmfPv9bU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgFASRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731787AbgFASRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:17:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 523B52065C;
        Mon,  1 Jun 2020 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591035428;
        bh=50HIzBlE5cgtkzhTklOb2NH4NEGz76WiwXFCARxAil4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y02DxiCFrrWjdBKsQe0rMNZ/VXn4NHRC/U2DIN24wPUdBZ8epcYZAGwAsc+QQRHHA
         z0JJy07opCW3p8zkhrToOPV4wIKhif+0GfchV5M4kMQVjVSpJahoLKXXOEtieUdbGG
         kuZoMkQ+0gg5iJkeYz6+0sgvDW6hSas/SDUK09gE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.6 155/177] netfilter: ipset: Fix subcounter update skip
Date:   Mon,  1 Jun 2020 19:54:53 +0200
Message-Id: <20200601174101.281925022@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174048.468952319@linuxfoundation.org>
References: <20200601174048.468952319@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Phil Sutter <phil@nwl.cc>

commit a164b95ad6055c50612795882f35e0efda1f1390 upstream.

If IPSET_FLAG_SKIP_SUBCOUNTER_UPDATE is set, user requested to not
update counters in sub sets. Therefore IPSET_FLAG_SKIP_COUNTER_UPDATE
must be set, not unset.

Fixes: 6e01781d1c80e ("netfilter: ipset: set match: add support to match the counters")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/ipset/ip_set_list_set.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/netfilter/ipset/ip_set_list_set.c
+++ b/net/netfilter/ipset/ip_set_list_set.c
@@ -59,7 +59,7 @@ list_set_ktest(struct ip_set *set, const
 	/* Don't lookup sub-counters at all */
 	opt->cmdflags &= ~IPSET_FLAG_MATCH_COUNTERS;
 	if (opt->cmdflags & IPSET_FLAG_SKIP_SUBCOUNTER_UPDATE)
-		opt->cmdflags &= ~IPSET_FLAG_SKIP_COUNTER_UPDATE;
+		opt->cmdflags |= IPSET_FLAG_SKIP_COUNTER_UPDATE;
 	list_for_each_entry_rcu(e, &map->members, list) {
 		ret = ip_set_test(e->id, skb, par, opt);
 		if (ret <= 0)


