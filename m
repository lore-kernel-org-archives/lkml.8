Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40102C47254
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B52E2192A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtRW2QBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgEBNAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 09:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgEBNAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:00:22 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1D7C061A0C;
        Sat,  2 May 2020 06:00:22 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id e17so10084997qtp.7;
        Sat, 02 May 2020 06:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vp9pFOaNAK/bZV4TMm15vSAV9KoRuRCBgnB4GbG7eV8=;
        b=AtRW2QBQjVZqK4pu80aXjEqAkuT5MVq+zFiE6w7FSMt0EUlfKfYXquyiZYb5tfk1rf
         I/4ao3SQbD6713xSca+TcVym9yryLZchj7tk8of/e7FLMc1MQPG2wzPMR5tt8MznBrYt
         Cn//hT9jPNw5R1ijqSSRIojZBVN4oCf3v++vvh2wqMDTPANaH46iNEpe5xlg6VTC7hJp
         4VDRiOeUs1N3mdfPFC848qrejNltWvlCfWQ/IumE4pCBWCAM3FmAkJorhY3ac88e8Guc
         EoO83lTB5FfhDtHdSeD7Dpkmtb0hNyJaXobvjFIUzfYCf9rvNL/90ShhorZPvP+zoPnK
         uBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vp9pFOaNAK/bZV4TMm15vSAV9KoRuRCBgnB4GbG7eV8=;
        b=VzCrGMHl1Xjnx2T0saPaRWze6KUbxe6ryT1wC3beRrTkVvMv+5mDoAOG9+Y74+0pxX
         RXVOsG4ZYyeP3bObS+ozIEWOhdre3FGnMobdJRv1wvf/ZcURgPh2MVARGVF69KbudrTJ
         hYBTJBfMIeZKPweRyZhFFKMrInVD1ohvByfNnbYY+ytkQb1SDtvD76/3qMMgjY1soQ/f
         jLgQgl/si++CXa/k09tsL6ZIale+BmtZN9UDj6USYYTTE+bfY6xAWcV7l1mQeyCm8zFq
         8WC0SOi8tfMgoYxxTXygzLYA8ds0FYRZqvxwCdT5ljxFjgpo5MjfVcFMav0nSusxbKHa
         QBqg==
X-Gm-Message-State: AGi0PuZAzQ5O4L3EwsHUmgse7nAxthyz1wLbTRrPds3gDdEW6ZZEXE+B
        5mYqlFMlZHZNHi5r/9x0FyZwoqQLqus=
X-Google-Smtp-Source: APiQypKm5d8ePdZUSklGoPtSOJFY7y2SdZZOsOKx6ignPtFrthW7vx97HLGQX5+5ikbY5bql7RBiwQ==
X-Received: by 2002:ac8:3713:: with SMTP id o19mr8049899qtb.371.1588424421301;
        Sat, 02 May 2020 06:00:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id l24sm5067668qtp.8.2020.05.02.06.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 06:00:20 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconemedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: defconfig: Enable some audio drivers on i.MX8M Mini
Date:   Sat,  2 May 2020 07:59:47 -0500
Message-Id: <20200502125949.194032-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MX8M Mini has SAI and micfil support but the drivers
are not being loaded.

This patch updates the defconfig to add support
CONFIG_SND_SOC_FSL_SAI and CONFIG_SND_SOC_FSL_MICFIL to support
these drivers.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 366857dfa9de..4e60e8a98b83 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -638,6 +638,8 @@ CONFIG_SND_HDA_TEGRA=m
 CONFIG_SND_HDA_CODEC_HDMI=m
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
+CONFIG_SND_SOC_FSL_SAI=y
+CONFIG_SND_SOC_FSL_MICFIL=y
 CONFIG_SND_MESON_AXG_SOUND_CARD=m
 CONFIG_SND_SOC_SDM845=m
 CONFIG_SND_SOC_ROCKCHIP=m
-- 
2.25.1

