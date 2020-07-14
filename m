Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED83CC433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE3922B2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752427;
	bh=lyxEKoaNkK7E7mMANVO/l97JTCsXrjZDPER7yfusQxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Xrc31+StI6n2oPPnQTXoLi0kIJW2yPdPFKEaYyr1m1hN5KjKOW56WkfALx7lxmubw
	 cVUsO7hb314ZNld6pOCbFFkPl8F9wGbTiOv8I8P7/AwlFSXL4F/g3WsGsZUynPhC76
	 HGABvj65qeAYkLAePHvuG+texbCs+QQJruoPgzO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgGNSrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729634AbgGNSq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:46:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD4C022B2E;
        Tue, 14 Jul 2020 18:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752416;
        bh=lyxEKoaNkK7E7mMANVO/l97JTCsXrjZDPER7yfusQxQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=icbIehrWJHfdaAR13F6Al/Oo3b1vjztCmZfiWG18rvCYIrPi0kGPoovPh+eVasu6Z
         UsLg1JXYvaIs59zkruNmlLFHWiuYT0JKbWFdzNL9D0BJqtuggwZrQtlBi/LEH/Ca8B
         j1wOg8w5T/fewhuqliuNzKr/z3NY+Lor7Vvsb+MA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 34/58] cxgb4: fix all-mask IP address comparison
Date:   Tue, 14 Jul 2020 20:44:07 +0200
Message-Id: <20200714184057.840546789@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184056.149119318@linuxfoundation.org>
References: <20200714184056.149119318@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>

[ Upstream commit 76c4d85c9260c3d741cbd194c30c61983d0a4303 ]

Convert all-mask IP address to Big Endian, instead, for comparison.

Fixes: f286dd8eaad5 ("cxgb4: use correct type for all-mask IP address comparison")
Signed-off-by: Rahul Lakkireddy <rahul.lakkireddy@chelsio.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
index 86745f33a252d..97d97de9accc5 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_filter.c
@@ -810,16 +810,16 @@ static bool is_addr_all_mask(u8 *ipmask, int family)
 		struct in_addr *addr;
 
 		addr = (struct in_addr *)ipmask;
-		if (ntohl(addr->s_addr) == 0xffffffff)
+		if (addr->s_addr == htonl(0xffffffff))
 			return true;
 	} else if (family == AF_INET6) {
 		struct in6_addr *addr6;
 
 		addr6 = (struct in6_addr *)ipmask;
-		if (ntohl(addr6->s6_addr32[0]) == 0xffffffff &&
-		    ntohl(addr6->s6_addr32[1]) == 0xffffffff &&
-		    ntohl(addr6->s6_addr32[2]) == 0xffffffff &&
-		    ntohl(addr6->s6_addr32[3]) == 0xffffffff)
+		if (addr6->s6_addr32[0] == htonl(0xffffffff) &&
+		    addr6->s6_addr32[1] == htonl(0xffffffff) &&
+		    addr6->s6_addr32[2] == htonl(0xffffffff) &&
+		    addr6->s6_addr32[3] == htonl(0xffffffff))
 			return true;
 	}
 	return false;
-- 
2.25.1



