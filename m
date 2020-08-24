Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F408FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9379206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="NyOpcuIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgHXJKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:10:53 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:14027 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727894AbgHXJK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 05:10:28 -0400
IronPort-SDR: I1htXh3hSARW/PRzWBLMzq2VtwjELd18fBL1f5ou6LFUZNUIbjfoWfH3NtFYCeTOGgk+ZV/pWo
 MISPgfY0zP8LJ6Y9m8YwbXOMs9UWlFcjKQdpuXbHZfMB/PgKxeqWmhCZ/2zXepR682F818qO5A
 DqfyP3pYFNvEfzroDCo9S+qrLuwQ6jsSzQq/gNrZKwL0Eoq6outHRSZNwECgxMdzm4Fi1mhAr7
 motPJ91Jz/Jbqc0CjStYN+JJYsVdvxcPXBNos/FFV648xo/IALveRL/7MLtGPCDe2xzYzXyHmr
 efQ=
X-IronPort-AV: E=Sophos;i="5.76,347,1592863200"; 
   d="scan'208";a="13569871"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 24 Aug 2020 11:10:25 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 24 Aug 2020 11:10:25 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 24 Aug 2020 11:10:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1598260225; x=1629796225;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ic1epR6YENZ0FsbT/5osIwpU92qMovavjg0MzOrKnUg=;
  b=NyOpcuIXpq/5Mb4Y5ZOt/6uddOZFFSCOK6tTNGraJuvjpU+fNo5uFsaO
   cdHWsSrXPIfbYcxWm+Tw6w+Pm7SQQqYe/0hnHctDMpsbL3N/L05WRrM8h
   SCQK6Y0tk41vpRMefXPrV0TRlWKweJeVcnjeMVr75I+WEoseTZAx01PDV
   v3HSMBBmHsimeeffFx2sZSOnU0mhZHZ8JktykPOy1UZkjwBerzEKOCn2G
   os95my9p+CPnfi3ItFc3w7w49bUb9HzR6nmABrr0JHngQIMgXwiKkxlfP
   cfXTWP/mUg8kM0vlA2yA4zZGGKTtJqjcJFf1yv1ByVSFAb3Cfj4oi1d7S
   g==;
IronPort-SDR: jfPFUZt8zvC06kIV1UUrnP4gg3D6aeNnYf3go2CNHAI5Q/vNyCwu/GesUv2brOwlWxLsOEx0g0
 itOxDovRxZN2EOZXlyAvuPq0hCnRGrrA41WKeBTTCxvg53rHagOORHVhNCickFM8nmMr8bUbCD
 2MNUHz0sY1dAEO0jCkRDOJ4QTB/HeHZqPQ46QdtiJcTxLNPqE2bVkvfn9wxiXBuP7/edACCHgg
 sACecbXa7Fd2qPCGsc50y/tP5etfVsohFU1At0/nvw+rWSt28FbxuRyZ+Dk4JzKcqkJhuhlFLt
 AL8=
X-IronPort-AV: E=Sophos;i="5.76,347,1592863200"; 
   d="scan'208";a="13569870"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Aug 2020 11:10:25 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 76472280065;
        Mon, 24 Aug 2020 11:10:25 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
Date:   Mon, 24 Aug 2020 11:10:13 +0200
Message-Id: <20200824091013.20640-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
References: <20200824091013.20640-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix national,lm75 compatible string
- Replace obsolete fsl,spi-num-chipselects with num-cs

Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 arch/arm/boot/dts/imx6qdl-tqma6.dtsi  | 2 +-
 arch/arm/boot/dts/imx6qdl-tqma6a.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-tqma6b.dtsi | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
index 9513020ddd1a..7aaae83c1fae 100644
--- a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
@@ -20,7 +20,7 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <1>;
+	num-cs = <1>;
 	cs-gpios = <&gpio3 19 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
index c18a06cf7929..b679bec78e6c 100644
--- a/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tqma6a.dtsi
@@ -16,7 +16,7 @@
 	};
 
 	sensor@48 {
-		compatible = "lm75";
+		compatible = "national,lm75";
 		reg = <0x48>;
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi
index a7460075f517..49c472285c06 100644
--- a/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tqma6b.dtsi
@@ -16,7 +16,7 @@
 	};
 
 	sensor@48 {
-		compatible = "lm75";
+		compatible = "national,lm75";
 		reg = <0x48>;
 	};
 
-- 
2.17.1

