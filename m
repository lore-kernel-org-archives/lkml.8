Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A6DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6827420838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598271676;
	bh=4/WcGaaY8Ux1J2J6KoV9qunR0ZDORxC37whtgThOILg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CA64mOY8qG58X/QoNdSW6aFgaQ4+QpdUAYqDVBew3CQezwkkWirn5WDLIft3FT95f
	 gMgA1paV84FX2zAX3XxHlKl8Tg4iLIXOAF5Qk7zvquDH7GczQfEPEyPjkTsLchRnHL
	 Nou5ecFUUSbp4ZlZRv/GsKqjGN0V+Ddezs5Uq0+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgHXMVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbgHXMVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:21:14 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:21:12 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 185so9370315ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5NwPvBBQUkH0mEClmzN5wdwQ2Z/fFI9qemgqXbwrLl8=;
        b=d6wAodeTYaNed4PeOl2rgtKgK8h1wmOFU1kmRK0nl8aApodcaM7kwHfh28k2Vok5eR
         xFk1XIdMNyiGqpzTUHoVFnIpB9Ts9V230wOil+Ug5XcFpwLdDcIo/QpwikFoHAeAn0Ne
         vpnsk9AkvooIQgCkzjaQdFOkHcwian0N/FNKTDjR2ZuztLVokETzZbC9YAczCf5J1Pjr
         KZinZVrdW29zNW4IYfPoKWp8Cxm/6o9Bae3+J794+mvUZflXmYHquK713lVgKgmehdXu
         cYUMd4gsEaIwnGJ07kXiCPFBiILz7glEvHYjPYrZ2Mnxhz5nAQBl+9ramu8Mde0kGIvD
         QwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=5NwPvBBQUkH0mEClmzN5wdwQ2Z/fFI9qemgqXbwrLl8=;
        b=qatjRHp0Uv9X55xnFlLQc+GddroCEX442rcLNZGp5QHe10TL0pdFv/sQBziYRw4d41
         z0okb4kFEuNqx2zHpFBqEqmHuy68RwHDcwjLAy9ABIiMByaKjwfpvU3ChTzJHwx3HeJs
         s3CxM0KCGYGUPpJgi/SqSesICYXAC8sqVGjSPaeTgXgKPxb8cFnvrTvU0+vGeOVvBG9n
         6i2bgdLri3v5AFaE/nTOkHEMw7Z0Xp43bPQ/5vEC3UMncMj8hbir29exToLpBw0vQ0uX
         ydgnHF8laVDqq4cCB11579WV8ACXGGL8a/bI57rGYrzxVX04Drn21Mg/PeD1QFFd5jeU
         5adw==
X-Gm-Message-State: AOAM532RwodkohwHnT39wxjfN3Ht6AOfHT3HCQYTMf2iFBws+E73TVnJ
        +UYmwr1fO74NEGLsxA2PUvrV2XI5+Qs=
X-Google-Smtp-Source: ABdhPJwjl8fSehkexpYd0Udf9DopmXcA8ll9d71tpxWiJ8kitq3gx+pBLkA9XqrmPqTJ5i7kCSQktg==
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr2315197ljm.393.1598271671209;
        Mon, 24 Aug 2020 05:21:11 -0700 (PDT)
Received: from rric.localhost (31-208-27-44.cust.bredband2.com. [31.208.27.44])
        by smtp.gmail.com with ESMTPSA id t22sm2255390lfr.12.2020.08.24.05.21.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 05:21:10 -0700 (PDT)
From:   Robert Richter <rric@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Borislav Petkov <bp@alien8.de>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@kernel.org>,
        linux-kernel@vger.kernel.org, Robert Richter <rric@kernel.org>
Subject: [PATCH] MAINTAINERS: Update Cavium/Marvell entries
Date:   Mon, 24 Aug 2020 14:20:49 +0200
Message-Id: <20200824122050.31164-1-rric@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am leaving Marvell and already do not have access to my @marvell.com
email address. So switching over to my korg mail address or removing
my address there another maintainer is already listed. For the entries
there no other maintainer is listed I will keep looking into patches
for Cavium systems for a while until someone from Marvell takes it
over. Since I might have limited access to hardware and also limited
time I changed state to 'Odd Fixes' for those entries.

Cc: Ganapatrao Kulkarni <gkulkarni@marvell.com>
Cc: Sunil Goutham <sgoutham@marvell.com>
Signed-off-by: Robert Richter <rric@kernel.org>
---
 MAINTAINERS | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a45fe1a6251e..1b7b0c1a24c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1693,7 +1693,6 @@ F:	arch/arm/mach-cns3xxx/
 
 ARM/CAVIUM THUNDER NETWORK DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
-M:	Robert Richter <rrichter@marvell.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	drivers/net/ethernet/cavium/thunder/
@@ -3930,8 +3929,8 @@ W:	https://wireless.wiki.kernel.org/en/users/Drivers/carl9170
 F:	drivers/net/wireless/ath/carl9170/
 
 CAVIUM I2C DRIVER
-M:	Robert Richter <rrichter@marvell.com>
-S:	Supported
+M:	Robert Richter <rric@kernel.org>
+S:	Odd Fixes
 W:	http://www.marvell.com
 F:	drivers/i2c/busses/i2c-octeon*
 F:	drivers/i2c/busses/i2c-thunderx*
@@ -3946,8 +3945,8 @@ W:	http://www.marvell.com
 F:	drivers/net/ethernet/cavium/liquidio/
 
 CAVIUM MMC DRIVER
-M:	Robert Richter <rrichter@marvell.com>
-S:	Supported
+M:	Robert Richter <rric@kernel.org>
+S:	Odd Fixes
 W:	http://www.marvell.com
 F:	drivers/mmc/host/cavium*
 
@@ -3959,9 +3958,9 @@ W:	http://www.marvell.com
 F:	drivers/crypto/cavium/cpt/
 
 CAVIUM THUNDERX2 ARM64 SOC
-M:	Robert Richter <rrichter@marvell.com>
+M:	Robert Richter <rric@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
+S:	Odd Fixes
 F:	Documentation/devicetree/bindings/arm/cavium-thunder2.txt
 F:	arch/arm64/boot/dts/cavium/thunder2-99xx*
 
@@ -6156,16 +6155,15 @@ F:	drivers/edac/highbank*
 
 EDAC-CAVIUM OCTEON
 M:	Ralf Baechle <ralf@linux-mips.org>
-M:	Robert Richter <rrichter@marvell.com>
 L:	linux-edac@vger.kernel.org
 L:	linux-mips@vger.kernel.org
 S:	Supported
 F:	drivers/edac/octeon_edac*
 
 EDAC-CAVIUM THUNDERX
-M:	Robert Richter <rrichter@marvell.com>
+M:	Robert Richter <rric@kernel.org>
 L:	linux-edac@vger.kernel.org
-S:	Supported
+S:	Odd Fixes
 F:	drivers/edac/thunderx_edac*
 
 EDAC-CORE
@@ -6173,7 +6171,7 @@ M:	Borislav Petkov <bp@alien8.de>
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 M:	Tony Luck <tony.luck@intel.com>
 R:	James Morse <james.morse@arm.com>
-R:	Robert Richter <rrichter@marvell.com>
+R:	Robert Richter <rric@kernel.org>
 L:	linux-edac@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git edac-for-next
@@ -13394,10 +13392,10 @@ F:	Documentation/devicetree/bindings/pci/axis,artpec*
 F:	drivers/pci/controller/dwc/*artpec*
 
 PCIE DRIVER FOR CAVIUM THUNDERX
-M:	Robert Richter <rrichter@marvell.com>
+M:	Robert Richter <rric@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Supported
+S:	Odd Fixes
 F:	drivers/pci/controller/pci-thunder-*
 
 PCIE DRIVER FOR HISILICON
@@ -17125,8 +17123,8 @@ S:	Maintained
 F:	drivers/net/thunderbolt.c
 
 THUNDERX GPIO DRIVER
-M:	Robert Richter <rrichter@marvell.com>
-S:	Maintained
+M:	Robert Richter <rric@kernel.org>
+S:	Odd Fixes
 F:	drivers/gpio/gpio-thunderx.c
 
 TI AM437X VPFE DRIVER
-- 
2.20.1

