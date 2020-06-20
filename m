Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF5323ECE
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="L782xA9S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgFTQhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:37:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74C7C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:37:03 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id mb16so13608090ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8AX8R3imm5kx+XT7/W2Ts6hqcoJrB3CcjQBEmxPQ64=;
        b=L782xA9SU2KpF1LK1w+gYtX+Znhse4rPvuuUsFUWseG/ssPmDzHViftMSSWAng6WMH
         i/uElNUm27fnXfL3hbJ3lkVADEYHKMtL5H0C4CmjKju1TI9cTAUjih9BmAfOePTZdC1Y
         stoPUS3Vxw3RVZNYM6quNTVAck3MuwCI/6V1LC2Sq2uQ2ZWGXSCo4k+xVQrkRWo8QZR5
         RF3502jufoSzJ5L+jMCJgxyIlbqPabIbFAbZslW0BZa9UJDP2J19EXh+6d1cKLa5hm8e
         XF1gn1YeJk+iBUM7Vpfn6oqpp47WaQdymYr0248D3Vd++0ET5JEBMcPm0Yfy6HuHyPpn
         0Qew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j8AX8R3imm5kx+XT7/W2Ts6hqcoJrB3CcjQBEmxPQ64=;
        b=Fel5RFzPVWP5X2QkptJFwV0lf2MxlLE9pzsvtJVAsX9nZlq9Ela1FY7lDHtecDTG+C
         ypEI+Ni+/xzeQ1AHq0V+08Kmq7DLEdxDTWTWG2Sv4AuF0fDkZa/ZHedSNs75v1aXgaX8
         rvTT6cA5BAfZK/8SOEqDIcYF8BCnZVMiiPSqH4KQXIK5+CqcrvcyQUzuGJke0WSVFpsY
         /haYz78HGCNEq67Qz/AS4aqR8i5aPlXflc3quFfenLrJFulrJ5dwvUZoOPWcyEa7Gzhz
         ItyQuYYn7YfPHnjkR89CrGYPFdHxjXSw2zfbdJmbcXaDPy8jt/W0tBePLAlb7WHAfVrW
         Cfhg==
X-Gm-Message-State: AOAM530Iw45E0IjQiw8L+pjtxoaGiTRexO/E0vz7qtUFxkBqFLND2gtZ
        c2YDooWYj3EBksGnmMQsWJKqrIp7
X-Google-Smtp-Source: ABdhPJytB0RQ7vP5S1NwhmU5+oyqtM1RLkmVXh+LR/PgeZMXEThswjoXXPc5XI92SlLqVC3pS4MTYw==
X-Received: by 2002:a17:906:3590:: with SMTP id o16mr8358243ejb.506.1592671022449;
        Sat, 20 Jun 2020 09:37:02 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id o90sm7839442edb.60.2020.06.20.09.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:37:01 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] ARM: dts: use the SDHC MMC controller for eMMC
Date:   Sat, 20 Jun 2020 18:36:51 +0200
Message-Id: <20200620163654.37207-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic Meson6/8/8b/8m2 SoCs have two built-in MMC controllers:
- SDIO (which is supported on mainline for a long time now but is
  limited to ~40MHz bus frequency)
- SDHC (which supports up to HS-200 modes at ~100MHz bus frequency but
  for which we didn't have a driver)

Boards with NAND flash will now be able to use the SDIO controller for
SDIO based wifi cards and the SDHC controller for the SD card slot.
Boards with eMMC, SD card and SDIO wifi can only use two out of three
MMC based devices for now until the MMC core and Meson SDIO driver gain
support for multiple "mmc-slots" per controller.

Now that we have a driver for it, add the SDHC controller to meson.dtsi
and wire up the eMMC connection on the Endless Mini EC-100 and the
Odroid-C1.


Martin Blumenstingl (3):
  ARM: dts: meson: add the SDHC MMC controller
  ARM: dts: meson8b: ec100: enable the SDHC controller
  ARM: dts: meson8b: odroidc1: enable the SDHC controller

 arch/arm/boot/dts/meson.dtsi           |  7 +++++++
 arch/arm/boot/dts/meson8.dtsi          | 19 +++++++++++++++++++
 arch/arm/boot/dts/meson8b-ec100.dts    | 25 +++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi         | 20 ++++++++++++++++++++
 arch/arm/boot/dts/meson8m2.dtsi        |  4 ++++
 6 files changed, 101 insertions(+)

-- 
2.27.0

