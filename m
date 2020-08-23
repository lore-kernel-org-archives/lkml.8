Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04794C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D715B20724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 02:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgYnjdt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgHWCZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 22:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgHWCZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 22:25:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B2EC061573;
        Sat, 22 Aug 2020 19:25:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so2458836pjd.1;
        Sat, 22 Aug 2020 19:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjidLqGbJG8Me/D9pV5CMHOfGHdBLM7VaSZt6TwM0nE=;
        b=dgYnjdt7h1nUl7wOnJltPzk+Dxnmy5hZxJcDdq6KydTszr1V744le1tP/k4zmkv5vP
         z9OuSt/5za8/BFs1vOnN45xhJJ83SkFvFUyMYMLs5HRq0f0GGkn+Jf8QJw3/xcVO1juZ
         7TNhl41/LuPQPz1O+TPVDOZvpOju6x6dk5hPLgSz4wTIaZnXU6BCispY4OgHRJFBOhF5
         ZXTUN6kEmJo7WoBim8voAy1ZskQQJYoyNkuFYO7ldLF8HtJ1vrKM1J6aZTbP2ihA2BSr
         jfy5VRJSUh59tMB7dCbpg09/Vz8VpphV8f+yrUktpncOpCHpLL3XPxYa1ZERdJhqGj3I
         cJLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HjidLqGbJG8Me/D9pV5CMHOfGHdBLM7VaSZt6TwM0nE=;
        b=qj+szFQ8rRHXa1+zuycdq4cPvHOfbxEQ2XQ3cfVC5NkMEGQcThygbnRq+phO7wk4vB
         /+qrZA22jukXT8Eqw/Po1U1j4gSJvyft7/WPSGkAjhiLiGv5EsNuaPsBY3gMgPSBkx5h
         TinrmZERGu99Wl0+97tWfnvatT9h8bds34Zkfdi3Oagb4de7LoW65YHWPNh//xQXDce7
         w3GS9bd3itnbEQ6Y6xJzT7L8IOUQRrzAV3iSEwBWmRWCPSMi8+Z/u+EXlNA1/PXrUmgE
         Z/yJikPGxt3wuzEe++atJT26HPEy2C+UlxmZdIcAWUU5qZK1Up8qzaxn87Lns7w1NrBV
         HkUQ==
X-Gm-Message-State: AOAM530Ind4r+D3RWexCHEVvhBbcucW5MApjTZqOIjpR0V0LZzgjY/6b
        wXa0CLgdmqcD/fFnzwIMGt8=
X-Google-Smtp-Source: ABdhPJxfJxPaPZgx5Zokq/Cplk371Fn6Oi9EjWoRwwJVJwvZyj9XKCjxZFA/4EUkVrZ5rm5mM2F8fw==
X-Received: by 2002:a17:902:b098:: with SMTP id p24mr45366plr.255.1598149539171;
        Sat, 22 Aug 2020 19:25:39 -0700 (PDT)
Received: from localhost.localdomain.com ([2605:e000:160b:911f:722f:a74:437d:fd3c])
        by smtp.gmail.com with ESMTPSA id k8sm6177710pgt.54.2020.08.22.19.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2020 19:25:38 -0700 (PDT)
From:   Chris Healy <cphealy@gmail.com>
X-Google-Original-From: Chris Healy <cphealy@gmail.com
To:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        andrew@lunn.ch, philippe.schenker@toradex.com,
        linux@rempel-privat.de, davem@davemloft.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, davidjoshuasim@gmail.com
Cc:     Chris Healy <cphealy@gmail.com>
Subject: [PATCH v2] ARM: dts: imx7d-zii-rmu2: fix rgmii phy-mode for ksz9031 phy
Date:   Sat, 22 Aug 2020 19:25:05 -0700
Message-Id: <20200823022505.196825-1-cphealy@gmail.com>
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

The end result is that network receive behaviour is marginal with lots of
RX CRC errors experienced and NFS frequently failing.

Quoting the explanation from Andrew Lunn in commit 0672d22a19244 
("ARM: dts: imx: Fix the AR803X phy-mode"):
   
"The problem here is, all the DTs were broken since day 0. However,
because the PHY driver was also broken, nobody noticed and it
worked. Now that the PHY driver has been fixed, all the bugs in the
DTs now become an issue"

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

