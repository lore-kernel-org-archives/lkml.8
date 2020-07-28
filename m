Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6386BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BECA207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="chRwB+NR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgG1Kuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:50:44 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:10482 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728509AbgG1Kuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:50:44 -0400
IronPort-SDR: Z/oTkCVLaoIz2Y2pmYxYobCctdersksapKHKNB4iE9lxLmz8lwD/aeEU3+0P/BWjlg96JbZPph
 G9oQ/pTTV1n6EvY5wbrZ+oLr6Su7wH2gBvonsDbNyFPgG+Wcl0o3T1U8Av7wksiRYhA1Rlv77v
 7WC8MWNT9jnKk8Su6oZrFXvM8Stt/FPta9MdUhUniqFSH07HivqHY9SB9mjvApdnPMaNapwrNP
 ZZlsAJd3MjC063rpVqDVvykZpwn1+MxgK8O3SurBoKQ0qI8di9uYngvKBxY0+7YYn5jXJXzoFc
 G3s=
X-IronPort-AV: E=Sophos;i="5.75,406,1589234400"; 
   d="scan'208";a="13261595"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 28 Jul 2020 12:50:41 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 28 Jul 2020 12:50:42 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 28 Jul 2020 12:50:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1595933442; x=1627469442;
  h=from:to:cc:subject:date:message-id;
  bh=KV4iUdx+AdKeIi9RN6z2Ez4NYT+otJS82M/3jFBITAs=;
  b=chRwB+NRgjkxYOfCaSy1JPZ8tCuAUe0CjTOrLZ4p39YpI19RyCzVLaa9
   leWmiD27XgSjiSXCupwG3QXDitBraytJFp8rj17iYOB5MEQd6V0OoH799
   Qj9a5UKLi0hL3t+j8gfKjc/YCpvEfbvD9bjXIXYE/A2HS5iJ8Hy+3ARk3
   wDT8txQegzTlFCqxk6HRtFET5m8L4dxTKol2Z9ni5wUVrAyMMiU2Ew29k
   /4guuBnzUWZg0M912DffKmT9x9PVtJtOqXvoY/Mg0Iz3SwasIk5xAS2b/
   qdRXWTzj5M2DBLv/zTDMmFtqT0iAEphRbHW7yZvuDrwUboNy1kGqpsBgE
   w==;
IronPort-SDR: fuD4Pgi7nzd9mPXQj6NDAAXzDzeiVh66FsM7/EdrbC9OMVjR6Ir9BmG88j7aoffE+O+8E7UB9c
 mBuJVL2zPsK1jPFj+t1BqY5YCyEQ+GnALRxkb9w1S7CNnl1FFg3RQ55UX5ye2asRc3z+k7g9QW
 nX12LBjhjsPYgF8vmESUz63M/TsPoXRYYvMzO1HHDv+BcsMw6cY0nCBnvV8y6++aghE3LXigmC
 Lise3R8/wsWJrwf1dGAMasNiNExL2Zk0wvJwuDzJD+XOeetGlPhoB0DzDHqBWyQ85BvqQrR5za
 OkU=
X-IronPort-AV: E=Sophos;i="5.75,406,1589234400"; 
   d="scan'208";a="13261594"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 28 Jul 2020 12:50:41 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id BBAA7280075;
        Tue, 28 Jul 2020 12:50:41 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] arm: dts: ls1021a: fix QuadSPI-memory reg range
Date:   Tue, 28 Jul 2020 12:50:06 +0200
Message-Id: <20200728105006.7952-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the Reference Manual, the correct size is 512 MiB.

Without this fix, probing the QSPI fails:

    fsl-quadspi 1550000.spi: ioremap failed for resource
        [mem 0x40000000-0x7fffffff]
    fsl-quadspi 1550000.spi: Freescale QuadSPI probe failed
    fsl-quadspi: probe of 1550000.spi failed with error -12

Fixes: 85f8ee78ab72 ("ARM: dts: ls1021a: Add support for QSPI with ls1021a SoC")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index b2ff27af090e..9435ce527e85 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -181,7 +181,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <0x0 0x1550000 0x0 0x10000>,
-			      <0x0 0x40000000 0x0 0x40000000>;
+			      <0x0 0x40000000 0x0 0x20000000>;
 			reg-names = "QuadSPI", "QuadSPI-memory";
 			interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "qspi_en", "qspi";
-- 
2.17.1

