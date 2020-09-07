Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF0C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7D32168B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="o+7UuSG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgIGIHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:07:12 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:43275 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgIGIFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:05:43 -0400
IronPort-SDR: ECn1pVEw+a7ObUmjaT9Kn8Z5U4U0uiLpJHnPH/s1TilWFYVx0tEI0zmyqDcxWtII2QXjfMMLgj
 qRHMeLiBH2+l594h1n+7AXky8rIkGJDVNmD0vvR+O1ya7m8Dp1HZhF8p3Jg43AZGPAd01WjeVV
 72pGpbuoKffckhhhbNsWnPezhJ3B9m8znETj1YH/dV2WbEp3VTetx1/lZ16CXDOVdF/D7BJL+O
 18PW0mVw5Io6J4GgYQw+TaRhEpLyIaS5ci9FTLH/Co4oQkbvoOk77YFHaXsYZWDEP08YdU0onQ
 xeA=
X-IronPort-AV: E=Sophos;i="5.76,401,1592863200"; 
   d="scan'208";a="13750640"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 07 Sep 2020 10:04:50 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 07 Sep 2020 10:04:50 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 07 Sep 2020 10:04:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1599465890; x=1631001890;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mSqXK7+4oej13H+0A6iOFOEMmv3JkefJyMtYaxuKi8I=;
  b=o+7UuSG/iHh8bupqbysranp3rdqkQ18G0Hg+8PdfXc9IbAloK3ydcQk3
   ZGw9ttNl+iltXavs0O0+IoHJgR0XPmxRXmPBBHxvPJOPS7V8viMwYybN6
   vZlHvV45HRAKvH2X9F7s5t07RA26IXEhCyLX7K0syGmaP9a0CjBowFmV8
   nKw0itFFPg7+8LI3flgW1cOBzi2z1z058JkSM97LAZVw6l/aBJdM60HKQ
   KRDPumluGG8CCgGwqV1L2Q1nkPdBGNUCpqMpH89bJxwfV76JMogNsTpxb
   8YocRnr1tsjDYrI8rI+ODQ5pnPvEM+I8TH/2bKh7WR4qA2OsGYo9ZQbnF
   w==;
IronPort-SDR: aXAP7txanBmOjk24dga3yHw/bxhsq8pN7wnfZuol8WAiUP7e/PAfY5hrwV3mbBQu+0m/D9AYHH
 w0ybhRelTv3UirXY2VE2I+WO+kPDXx+RqQgd/ZOiMcATs3uxgSIuYhrlbLeLfySOv17Fhr3GPW
 3iwGh2f9DlJQpyA+r+4vxTJxHLqWtr378cPux1MX/dDkTqvMvC6bugcuM4/RJ/4XcBgyIgNiQ+
 F3DMr/BJHY98Qr0L6wldvphmfuzyL99tcDy5neeWRvyVsgtN+Lbziiq+z6FhfvxrCauVNAxsLw
 yy0=
X-IronPort-AV: E=Sophos;i="5.76,401,1592863200"; 
   d="scan'208";a="13750639"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 07 Sep 2020 10:04:50 +0200
Received: from schifferm-ubuntu4.tq-net.de (unknown [10.117.49.134])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id A3F5B280065;
        Mon,  7 Sep 2020 10:04:50 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v3 3/3] ARM: dts: imx6qdl: tqma6: fix LM75 compatible string
Date:   Mon,  7 Sep 2020 10:04:29 +0200
Message-Id: <20200907080429.12496-3-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907080429.12496-1-matthias.schiffer@ew.tq-group.com>
References: <20200907080429.12496-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify the National LM75 sensor including its vendor name, as mandated
by the binding docs.

Fixes: cac849e9bbc8 ("ARM: dts: imx6qdl: add TQMa6{S,Q,QP} SoM")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v3: split patch

 arch/arm/boot/dts/imx6qdl-tqma6a.dtsi | 2 +-
 arch/arm/boot/dts/imx6qdl-tqma6b.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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

