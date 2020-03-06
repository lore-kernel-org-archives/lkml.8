Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C3C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4382072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX2u3qOR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgCFKjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:39:00 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38504 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgCFKi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:38:57 -0500
Received: by mail-yw1-f66.google.com with SMTP id 10so1760812ywv.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NwT39Zmrk5nf0V1VVwAqtLl1QXPiCL2V82aJAhi4vfA=;
        b=jX2u3qORktW5XuoKIWqnswVt8lzwsLlC4j1h4zXn3Q+LLavs4g4sU0uQ7Rr1I9Ax01
         vRvys6knfWqQZRPt4slBnu8jjtFkqpAE6WoYSrJqLLfCLsNnCMb2qJ3eHRLJcg9GT14F
         +kmdE+VF/yACRq6Zib2eKyMOHhsR9m7KscLM3i90s4vdN1J0PC9+HngvqDHNkla8zCHa
         SImeyM9jcJVpAKOTrxtK0LKNkKCfSvj76kCBxBiKQx4BfCF9evsdlukNrySFcn397d7o
         Od6zQEdAR5aUFPmac1hU3XQGWCXAfP5C2zS1Q73apy4ymSh7FMxwMQbQ187sd2Zsl+We
         jo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NwT39Zmrk5nf0V1VVwAqtLl1QXPiCL2V82aJAhi4vfA=;
        b=cAcEV6LPb1yEMKsY+g4gyuSrSMkhKlVAnJAz1WMiYKlGjzJQJ63C3j8Xys4IddvFH/
         GAP18KsuXP3Ggc+KTMv10SOhaIGkaAC/cjFKOh5q10wj9YpqqExOe/hwMN+2hySy5gnI
         3QzNSS5BIyRJkXfW2mTB9jDr7XImOn/UqPEXHI7XJH++0GxrHbhGuQA9YTBm9Zdruv8b
         0qE+e49z5enOLEX/XyoWiNAafD23Mr2CEnlvtURnyMJboFlyJp2QKhWE/+O4nqTiwu5G
         Bzs/hVMX7LOd96S2pxpgwUkL5CbnW8uBVAZcfLyxaXsIvTiAUdfKOmQnMJDwTfoyXraB
         Vi3g==
X-Gm-Message-State: ANhLgQ3EB+WtrZ2dLkP42FwczWI6uZLe1EvP/EBZAqE9++GRx8LmebZG
        u0ZH7iRWhisp2c2c7YXI9ec=
X-Google-Smtp-Source: ADFU+vt2Wodk6ZZipaUnakhUniHCN5Q8WvcLQuqEGAxC4+KijtJXNOtuyVZky/tgzET7m383AchW4A==
X-Received: by 2002:a25:6902:: with SMTP id e2mr3171907ybc.349.1583491135617;
        Fri, 06 Mar 2020 02:38:55 -0800 (PST)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id w132sm13345575ywc.51.2020.03.06.02.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:38:55 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable IMX/FSL Audio Support for WM8962
Date:   Fri,  6 Mar 2020 04:38:38 -0600
Message-Id: <20200306103839.1231057-2-aford173@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200306103839.1231057-1-aford173@gmail.com>
References: <20200306103839.1231057-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Beacon EmbeddedWorks i.MX8M Mini kit has a WM8962 audio codec.
This patch enables the required drivers as modules to enable sound.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d19ca82b3c40..ab71a407288f 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -601,6 +601,9 @@ CONFIG_SND_HDA_TEGRA=m
 CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
+CONFIG_SND_IMX_SOC=m
+CONFIG_SND_SOC_FSL_ASOC_CARD=m
+CONFIG_SND_SOC_IMX_AUDMIX=m
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_SOC_ROCKCHIP=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
@@ -614,6 +617,7 @@ CONFIG_SND_SOC_ES7134=m
 CONFIG_SND_SOC_ES7241=m
 CONFIG_SND_SOC_PCM3168A_I2C=m
 CONFIG_SND_SOC_TAS571X=m
+CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SIMPLE_CARD=m
 CONFIG_SND_AUDIO_GRAPH_CARD=m
 CONFIG_I2C_HID=m
-- 
2.25.0

