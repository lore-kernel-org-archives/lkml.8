Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7357BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4812B229CA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753034;
	bh=UovwJC9PL68kcvH7rOCqjQnxpBm/H7ifrkPG3zBUV1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0cdGUkhNk499aIeNImHsS0sE5zzajli4h1aOqXpo/hx2aG69S9tVsjjMe6PsrjZlO
	 GGa4crdDSz2obikfSpvFrhMvcBCyQ847D4zmbV8MYMuZNy2UvRRq0bZd2qZrsLyqmo
	 I3WBba/P0O1wwUwyqNMt/15WRkjVljpUJd/U+qjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgGNS5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730420AbgGNS47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:56:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 658F022A99;
        Tue, 14 Jul 2020 18:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594753019;
        bh=UovwJC9PL68kcvH7rOCqjQnxpBm/H7ifrkPG3zBUV1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+68muocQDDHdtFb5GPWSRFIW52aViWh9uD5wp2bw9A5XjuJE96R/rtjwZx93fybP
         pFChZn9dW1QHd21gtfj0me+AQhKuVVpo0gTDS8eoJo0PgYqt1LretJuvRD/2BLnqLK
         Phu21kIzO4MvR3Ou98RzPydc96NkTOXEHt2351D0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Bogdanov <dbogdanov@marvell.com>,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Alexander Lobakin <alobakin@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 087/166] net: atlantic: fix ip dst and ipv6 address filters
Date:   Tue, 14 Jul 2020 20:44:12 +0200
Message-Id: <20200714184120.016289959@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dmitry Bogdanov <dbogdanov@marvell.com>

[ Upstream commit a42e6aee7f47a8a68d09923c720fc8f605a04207 ]

This patch fixes ip dst and ipv6 address filters.
There were 2 mistakes in the code, which led to the issue:
* invalid register was used for ipv4 dst address;
* incorrect write order of dwords for ipv6 addresses.

Fixes: 23e7a718a49b ("net: aquantia: add rx-flow filter definitions")
Signed-off-by: Dmitry Bogdanov <dbogdanov@marvell.com>
Signed-off-by: Mark Starovoytov <mstarovoitov@marvell.com>
Signed-off-by: Alexander Lobakin <alobakin@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c    | 4 ++--
 .../ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
index d1f68fc162918..e6b1fb10ad912 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh.c
@@ -1651,7 +1651,7 @@ void hw_atl_rpfl3l4_ipv6_src_addr_set(struct aq_hw_s *aq_hw, u8 location,
 	for (i = 0; i < 4; ++i)
 		aq_hw_write_reg(aq_hw,
 				HW_ATL_RPF_L3_SRCA_ADR(location + i),
-				ipv6_src[i]);
+				ipv6_src[3 - i]);
 }
 
 void hw_atl_rpfl3l4_ipv6_dest_addr_set(struct aq_hw_s *aq_hw, u8 location,
@@ -1662,7 +1662,7 @@ void hw_atl_rpfl3l4_ipv6_dest_addr_set(struct aq_hw_s *aq_hw, u8 location,
 	for (i = 0; i < 4; ++i)
 		aq_hw_write_reg(aq_hw,
 				HW_ATL_RPF_L3_DSTA_ADR(location + i),
-				ipv6_dest[i]);
+				ipv6_dest[3 - i]);
 }
 
 u32 hw_atl_sem_ram_get(struct aq_hw_s *self)
diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
index 18de2f7b89593..a7590b9ea2df5 100644
--- a/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
+++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_llh_internal.h
@@ -1360,7 +1360,7 @@
  */
 
  /* Register address for bitfield pif_rpf_l3_da0_i[31:0] */
-#define HW_ATL_RPF_L3_DSTA_ADR(filter) (0x000053B0 + (filter) * 0x4)
+#define HW_ATL_RPF_L3_DSTA_ADR(filter) (0x000053D0 + (filter) * 0x4)
 /* Bitmask for bitfield l3_da0[1F:0] */
 #define HW_ATL_RPF_L3_DSTA_MSK 0xFFFFFFFFu
 /* Inverted bitmask for bitfield l3_da0[1F:0] */
-- 
2.25.1



