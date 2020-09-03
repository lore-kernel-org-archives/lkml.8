Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6282C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E5E20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="j4UX5hi0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729252AbgICOzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:55:09 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:28900 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgICOyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:54:39 -0400
IronPort-SDR: BIradT9Qo+od6tGaIa22PAcKzvAEnKXDtbHHR7H9Uuz8lswDBip6wQ5QCWPLvg6HyquPIdcijE
 lvKut1gnlRXjc/ktN7y92Yez6qNZxBqrJpetDigwNqlQz8gKYSRB3Q11C1zHOOM205ukeyBI+0
 9uvK/+fR6hNf6ALQ6rYyO3lqnmWnebjRzNUzd4YH2XT8MCLI8Ux+dkj91onOK4m0uP0rXkfSF6
 Gv15jyTk8fRiubuKyNGdQ/wgXyB6lagu8il1packGdSMQJG7fH7Tx+mt6CH4DAzckxVeTKzEA1
 WQA=
X-IronPort-AV: E=Sophos;i="5.76,387,1592863200"; 
   d="scan'208";a="13722704"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 03 Sep 2020 16:54:28 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 03 Sep 2020 16:54:28 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 03 Sep 2020 16:54:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599144868; x=1630680868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=xAvjU3K53qOiucID1PuAA01N0+IW04yAdBoQr5C/F9U=;
  b=j4UX5hi0kUCWhCWFX+cMABYSRk4zW9DHyK5FSNL/FrC/wANFvx+FlH40
   T8O+NGY4flQByDBO2zstA5XdbVikXvDOv2O1Uxv9W5uXg1+7WxSn+jfQK
   MOcFcbMSOE1WtBAhv9SajbD31z2dsjiaqP4aVaizXVTespaLc2RtU8rt+
   SryL988+DaswLhAfDucxlgrwfjuWpuJ26ttVvsFmdpCjAkwctPYWjU++h
   PdsDbCs0ADJVaeIPjcXjdzCyNEH10TZgbdNFw1ar0WM8cymFzHAPF/gqJ
   pqgpwatw9orohcDvgEhxPt1dyRhiAT0t9AFzw++6A2VzWT9oVW5J1/OXX
   A==;
IronPort-SDR: veAbufCOmfUm3O71ekAsgPN+Ls+7N3vOd7T9U7JE1vwmqRG8jx0gO1Jt8tKgBKPbWeoeVt8po0
 Bpd3gg4G28BJBUapZ1cwdtQjY9v8HiLmOm+uir1yZQtkElzUvmy0k+R1673LZ10hpR0KTCBYhM
 cF/pdYg5uAIB+XnIB4samkBJ4Al4U8PuZl6VHh4N2oUw48LZHsrmlpyZg3u9JIY4CV1BBIi7Sc
 Uw5My9MI9F9I2z9CdDJUHGHSa8vBPPOBIX5LKDEwad6TpBRghf7JwX09IbtLB8FgdFTuBnZvEC
 Y0Q=
X-IronPort-AV: E=Sophos;i="5.76,387,1592863200"; 
   d="scan'208";a="13722703"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 03 Sep 2020 16:54:28 +0200
Received: from schifferm-ubuntu4.tq-net.de (unknown [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 8B449280070;
        Thu,  3 Sep 2020 16:54:28 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2 2/2] ARM: dts: imx6qdl: tqma6: minor fixes
Date:   Thu,  3 Sep 2020 16:53:47 +0200
Message-Id: <20200903145347.17830-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903145347.17830-1-matthias.schiffer@ew.tq-group.com>
References: <20200903145347.17830-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix national,lm75 compatible string
- Remove obsolete fsl,spi-num-chipselects

Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2: drop fsl,spi-num-chipselects instead of replacing with num-cs

 arch/arm/boot/dts/imx6qdl-tqma6.dtsi  | 1 -
 arch/arm/boot/dts/imx6qdl-tqma6a.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-tqma6b.dtsi | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
index 9513020ddd1a..b18b83ac6aee 100644
--- a/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tqma6.dtsi
@@ -20,7 +20,6 @@
 &ecspi1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi1>;
-	fsl,spi-num-chipselects = <1>;
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

