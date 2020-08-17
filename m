Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3405C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2ADC2087D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 03:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSek12SA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHQDEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 23:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgHQDES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 23:04:18 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005FFC061385;
        Sun, 16 Aug 2020 20:04:17 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id s14so824292plp.4;
        Sun, 16 Aug 2020 20:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2t9cZojup/XRAfOOohcGCISaz5vKpnzd7po0W7Brn4=;
        b=mSek12SAv1BJ6ldCV8GbAcqWxHtmYqybitk2vnr8tEQJDg9njV0L2OK9MMFHwSVXB6
         YnxwwLHYPWeXDaBxfiLBMJNil43M/nUv16OYieMI149G/rP1GXkdtR4wuNL8KZQK1V2h
         72RLjJvdNFsND45+Dqdz59o/YGYH6O8TF7G1tsVJQrFcuVYfFm81Eughm0igkP+dKzc+
         cwA9gKOIg45WjWBt8+BUkjutzNI6OoMVRcQgJd8iDr2OjsA6xlyj5Bn/JvToxwFtAjke
         E6+ncpe2QToaQBOZ/pD5FoGq/pkTAwoXDkhjCfoQfizb44tH/JRrefhlaplYFbfTIMS2
         pvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u2t9cZojup/XRAfOOohcGCISaz5vKpnzd7po0W7Brn4=;
        b=gmZ88t34LBisXCXakfD980N43vwkXMoxJ/XEnhMKXCXSCUuCFkD7X78pQNXlHYWmEO
         VoMoowSiacjQxzjWGPW4UOtaXk6836vZtB8Pg/DxWDRPhH70KIgymSRzxodMk0YyAnrO
         IhGTsIL3nabIJuys/o0LjVCDHzY/S0TlCNTdK30TOz0c5m9LW/ZRbusgY47ZfyDvR/dX
         aa+zFM97tIW6FLkVdAZjUV22RbEIbvgPM2fsXvtxuSWbKDnjBbv37zuo/7fBwAFOItOP
         JHItk2xHlmgj0gS7F5hV9x6k6unQQXLp0NWk28hQZ1mdoiZo4pIqCAhwDYUl4/kQ5eo2
         kvag==
X-Gm-Message-State: AOAM533SbKS+sPWP3nwzNYeKTpquim//SP31deq43QOCbwfhnajD7KQ/
        L2jQ4BuuzfL5ngCq9sqRE2M=
X-Google-Smtp-Source: ABdhPJwcOR2+1quyxWqjQQMMyinCGbyTuuXsCkvKpAd0p7fdGw5BaRkRa1UqMLxTq/Loy1rvyTeCgw==
X-Received: by 2002:a17:90a:2081:: with SMTP id f1mr11353865pjg.174.1597633457296;
        Sun, 16 Aug 2020 20:04:17 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:722f:a74:437d:fd3c])
        by smtp.gmail.com with ESMTPSA id n22sm14869939pjq.25.2020.08.16.20.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 20:04:16 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
X-Google-Original-From: Chris Healy <cphealy@gmail.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux@rempel-privat.de, davem@davemloft.net,
        philippe.schenker@toradex.com, andrew@lunn.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH] ARM: dts: imx7d-zii-rmu2: fix rgmii phy-mode for ksz9031 phy
Date:   Sun, 16 Aug 2020 20:04:01 -0700
Message-Id: <20200817030401.3124855-1-cphealy@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Healy <cphealy@gmail.com>

Since commit bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the
KSZ9031 PHY") the networking is broken on the imx7d-zii-rmu2 board.

Fix it by switching to phy-mode = "rgmii-id".

Fixes: bcf3440c6dd7 ("net: phy: micrel: add phy-mode support for the KSZ9031 PHY")
Signed-off-by: Chris Healy <cphealy@gmail.com>
---
 arch/arm/boot/dts/imx7d-zii-rmu2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx7d-zii-rmu2.dts b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
index e5e20b07f184..7cb6153fc650 100644
--- a/arch/arm/boot/dts/imx7d-zii-rmu2.dts
+++ b/arch/arm/boot/dts/imx7d-zii-rmu2.dts
@@ -58,7 +58,7 @@ &fec1 {
 			  <&clks IMX7D_ENET1_TIME_ROOT_CLK>;
 	assigned-clock-parents = <&clks IMX7D_PLL_ENET_MAIN_100M_CLK>;
 	assigned-clock-rates = <0>, <100000000>;
-	phy-mode = "rgmii";
+	phy-mode = "rgmii-id";
 	phy-handle = <&fec1_phy>;
 	status = "okay";
 
-- 
2.26.2

