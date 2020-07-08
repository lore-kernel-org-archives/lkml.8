Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71283C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D16B206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="owyw7wEk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728603AbgGHAc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGHAc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:32:28 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC929C061755;
        Tue,  7 Jul 2020 17:32:28 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k5so1572273plk.13;
        Tue, 07 Jul 2020 17:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHDJfrm1iVCzXn62MJNVnGg9njOwtMjb0Ejn5RE8S7E=;
        b=owyw7wEkXTNREIfTE95ihQVYKGKfCXyx4Dwrl6YPL76LuMiNPEcurMNkCO3vuSCiV8
         XueSoxQay/AvZtHz12CS/hKRwC/GGF8d8zsBzHHOswgS5iSib58NWFMHKG3K25oFW5jt
         YRJTJEAdLPX6LTNXLoNGj/Fv9lCfq5xX+BcWabCz2k4wuYHKVHVkm7NHEQgJekvYwhER
         3Ur3RryWLMPvQrxxJlFmY6ef74cA7Zhtv/f/6bczOexfEBl/lvLZXy74ATVoZ+XPLWiA
         JDX6Rbu5HiUNNep+aAE5IqBfl9P0TSfBT1iXDXFzIiWIxrke6Lc8Fjp16i0BcjIyQ55T
         p/GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eHDJfrm1iVCzXn62MJNVnGg9njOwtMjb0Ejn5RE8S7E=;
        b=mVBZv6cNi1dXq3Cj6lbfgrE5zhj+oTopCLfgQ+RHgVgT5oBJYDEovJFE/NBKb6NWOg
         nQrYKqoaSdFz5DHYQJhDOB+qvhUn2xlfq7fgy7251ZhjbyTqdWNokKAxanz/VMcsHR9e
         Y+rwHHXjXxWCnfmExmrxKfCZdRff57VFArg46VVJ5jS9JPEc6QcvODUNfToibq6ninkz
         IfSdU3xIgR6KdmFs+pEpeKDY+v8HE6kWWyjabGYXCzcygkPaoLBcJ31AkOfTUbF0V1xU
         BBRPAXey0vsYVuiqG9S0DFsiCj0ViTXsX5e6usgAKY2zcYlpHPipDZYYkOkgiWo7NnS7
         0i+Q==
X-Gm-Message-State: AOAM531nOBg2Ev+LsG/KvbXeU5S7s7VPkE2VSQXs/hfonFVHats8fCoN
        dqCK4TNzVqCm1VVQSKNARaI=
X-Google-Smtp-Source: ABdhPJzsMMA7bgeg5x/gyhvig2IHLGwrkt/biGxfDDUwtcPyTs1Zzxmp0vVv7SqNzu7Pk2OOpXPCwQ==
X-Received: by 2002:a17:90a:1544:: with SMTP id y4mr6835214pja.130.1594168348225;
        Tue, 07 Jul 2020 17:32:28 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:a2ce:c8ff:fe03:6cb0])
        by smtp.gmail.com with ESMTPSA id 21sm23419020pfv.43.2020.07.07.17.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 17:32:27 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, andrew.smirnov@gmail.com,
        l.stach@pengutronix.de, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH v2] arm64: dts: zii-ultra: update MDIO speed and preamble device
Date:   Tue,  7 Jul 2020 17:32:09 -0700
Message-Id: <20200708003209.4737-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.21.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update MDIO configuration with zii-ultra device to fully utilize
MDIO endpoint capabilities.  Device supports 12.5MHz clock and
doesn't require MDIO preamble.

Signed-off-by: Chris Healy <cphealy@gmail.com>
---
v2:
- Fix subject line to reference zii-ultra:
- Get rid of "=<1>;" from suppress-preamble lines

 arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 6a55165bd76a..98aa67a4c040 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -132,6 +132,8 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 		status = "okay";
+		suppress-preamble;
+		clock-frequency = <12500000>;
 
 		switch: switch@0 {
 			compatible = "marvell,mv88e6085";
-- 
2.21.3

