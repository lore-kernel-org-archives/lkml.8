Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72BFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4DB32073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3wcKRmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgEZRJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728444AbgEZRJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:09:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00F1C03E96D;
        Tue, 26 May 2020 10:09:46 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 9so2740730ilg.12;
        Tue, 26 May 2020 10:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDMtsfOhm3VjziHJE2E1cNppZGDhVrk8ubukeyWGRX4=;
        b=g3wcKRmbalgUtm11bVdHv8qL3LYhdL0QrZ0Tw1Vt7ECNYVsx3ibiBCGgGZjBTZ10Ut
         lseDTXK5zhZ0LR7F+V13fcBLCQjJX0R/054ayq1e0/Ao2kuTUi46uynzW69NKJJ8VbMj
         G/OMrFZnIm1yvnBYotaJfZ6fa/nyXwn1oR+DoexzlWBsBLjNrCSL2Z02AVObFJWWmOcX
         AFKwxV6TggtmLne1nHIzFnFzDVNGbWuvI2sla/LQidclclbb8k/v2wCfcpYwLcbpCG9I
         JVB+4GPEhuHmtKOW3ZpCS7XK6Zag9f5TgIogyl/NKcn60z+oRWid+995AOdeFDtAK3wz
         5OFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qDMtsfOhm3VjziHJE2E1cNppZGDhVrk8ubukeyWGRX4=;
        b=rU6YTudbhkFdicsHq9X6HzlTplzcLGGOmeDXOC8t+K+ALU39vOWvsX24uwIQZ9cdzs
         HX4GgartfRMK/m8v2HzKkFXFw+BN+5koolFrERieHV10KR52zVOd9WxX4Pj3+DZ6SLqk
         2WACOeakxa7glr1cneOJ81SpdxMWjsioF/GkohSEOcg5e/DCSMjmlMH0t/MzBbCfq4C6
         Fm0ONmcUGoFNmay1RfGqvM1HVo5JWFRrO3u6PKmLbD3RHpcdMpMKIdzAfpHjH/ZsNa5A
         jM4cjBNAzthj/H/LQaAgUWaqy7Ti2QqCi6CfPukU5PNaZrMwgODcdEmnnTtjP8mcp9kn
         39aA==
X-Gm-Message-State: AOAM532AKOTGAaYOP9424fD6tNn1O0iUo4wuyLf+WflxduS6L39DfYNO
        P31+VBkyH2UKVaNklxF1D2M=
X-Google-Smtp-Source: ABdhPJyiCTc5LxB7MGg1Mg2Z3LpRLDDmxxNgMXldniIQX8H7iq3tA9+sDdWDd7TrmiAT4bYBQZlC3A==
X-Received: by 2002:a92:c704:: with SMTP id a4mr2119077ilp.163.1590512985746;
        Tue, 26 May 2020 10:09:45 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id j17sm244116ilq.79.2020.05.26.10.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:09:45 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mm-beacon: Fix voltages on LDO1 and LDO2
Date:   Tue, 26 May 2020 12:09:39 -0500
Message-Id: <20200526170939.104111-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LDO1 and LDO2 settings are wrong and case the voltage to go above the
maximum level of 2.15V permitted by the SoC to 3.0V.

This patch is based on work done on the i.MX8M Mini-EVK which utilizes
the same fix.

Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index fb0137a8611c..94911b1707ef 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -136,7 +136,7 @@
 
 			ldo1_reg: LDO1 {
 				regulator-name = "LDO1";
-				regulator-min-microvolt = <3000000>;
+				regulator-min-microvolt = <1600000>;
 				regulator-max-microvolt = <3300000>;
 				regulator-boot-on;
 				regulator-always-on;
@@ -144,7 +144,7 @@
 
 			ldo2_reg: LDO2 {
 				regulator-name = "LDO2";
-				regulator-min-microvolt = <900000>;
+				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
 				regulator-boot-on;
 				regulator-always-on;
-- 
2.17.1

