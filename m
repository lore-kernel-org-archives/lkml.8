Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3110C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C342075F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 03:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkNPpMGz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbgEYDlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 23:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388397AbgEYDlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 23:41:15 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48375C061A0E;
        Sun, 24 May 2020 20:41:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n15so8298856pfd.0;
        Sun, 24 May 2020 20:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=STuSyGO/SfkcGFSauy0QHw5IqCNUH9D9huZMTiB2y2k=;
        b=fkNPpMGzjaKpCW8iTYQCQix1C73P0vGeCYEgEBtczSwFoYfS6ni4XDVWMbiLhqvrO+
         YQj1kVsq45Hc7FyzZIQdm03WipH/XllIaDcseSWpV/0g8Dh5ICZ411BaDbDHMWQSa4/f
         0SZsJz3GhwaxVeJopKZG7Wr9Udxdp7O5jxlUFebkd5DVx+GUCmFSnusnoEtRoAeJoN6b
         1PPD3ek7v1TS/KhPcSh6Cd8UCWgt+Ml2QlTTMP/Zn+LAFKaiE7+6Z+D7BUwhr9wPfmmB
         v51sXUdOj/KwHwZ+bMdKThHsEWDk4MrX533ednxTMem3JkkuUJgODw6aLxV/+tjZJPAV
         3poA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=STuSyGO/SfkcGFSauy0QHw5IqCNUH9D9huZMTiB2y2k=;
        b=cacH5UFxSZdWF8GBjfF5RHzsJtLw5WyEqqbY2wk33Th8G3zz6AeALf59w1z7Ym0vrF
         YBvWfNb06ZTwj1BnGJqAjjEORE5pMgVvnj7aNMusSj2TQ8VqB47Lrw0cfvfIy65sDh6U
         MXThHjbX+ODNVo11MOIvb2pMVSMMcMwLwp4cJGCe/qqL9wPZmyjPkfMjqzFTEaUQ5XVa
         IMhkOlabfLDweysJsgzA1FD0vduJePXJrtLJuZoRtwAduVX4Q9lKZ1fVdO63cyiTObWk
         tAYiGqzFTc+8KLd45Gs0b8a+6tH9sWhvDbfvxNI+t95v6jg2pgHleinSH4yPWvhd4CZg
         fERw==
X-Gm-Message-State: AOAM5322HIo4pGsFbixv2+rYSqX81+/vrXhCnKGlDSW1QrK1vO6Z2pDY
        Z91MvosKG9jL4xu+EFttUcA=
X-Google-Smtp-Source: ABdhPJweb2OFp89IGu0IqbpvrgVH1AIHqBr5JqD5/OxEMbC2D64IA8gZsH2OyXyZNWnB5ONkhP2T9g==
X-Received: by 2002:a62:1407:: with SMTP id 7mr15471826pfu.103.1590378074875;
        Sun, 24 May 2020 20:41:14 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.191.44])
        by smtp.gmail.com with ESMTPSA id 7sm11981695pfc.203.2020.05.24.20.41.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 May 2020 20:41:14 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, p.zabel@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v5 1/8] ARM: dts: stm32: Add dma config for spi5
Date:   Mon, 25 May 2020 11:40:55 +0800
Message-Id: <1590378062-7965-2-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
References: <broonie@kernel.org>
 <1590378062-7965-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Enable spi5's dma configuration. for graphics data output to
ilitek ili9341 panel via mipi dbi interface

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---
 arch/arm/boot/dts/stm32f429.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
index d777069..5820b11 100644
--- a/arch/arm/boot/dts/stm32f429.dtsi
+++ b/arch/arm/boot/dts/stm32f429.dtsi
@@ -660,6 +660,9 @@
 			reg = <0x40015000 0x400>;
 			interrupts = <85>;
 			clocks = <&rcc 0 STM32F4_APB2_CLOCK(SPI5)>;
+			dmas = <&dma2 3 2 0x400 0x0>,
+				<&dma2 4 2 0x400 0x0>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
-- 
2.7.4

