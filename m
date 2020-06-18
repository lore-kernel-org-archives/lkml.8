Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64ACC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B11207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 13:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hIGjX7h4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgFRNi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 09:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgFRNiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 09:38:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40E7C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:38:23 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d128so5693592wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 06:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwhiK4RhjFtcOdjK6HryhHeUuPTC4xHkMOd8pTbbj6k=;
        b=hIGjX7h4Ed1aDRIN8UX7il9ILTJaATXT2LwE1e9A+0Ttl1p93wik5BtfFvtdvm58Iy
         A4VRKDcRzoev7Krg3Cc+TpN1ZPcwQR1ahuc7rE7qJMYKav6VGORhEcNYUNtgiJ8htn0a
         2MjtDZSe4HhO9uH02//oio7CVGAV3FCf3Qr2fipRHVL7M5YXT/O8p774+V3c3iKfm78K
         cQhd1YkMZAzZ3bMtoxWCMFDXp5vtiXza1///NKM30bIftKHZ7s3M7WmMeKGW0cw4z7Wu
         WfsajUcRsp6vCocvj6gm8VHUrrMIhsTSB/hq3epoobz/wf15csEEEudniOiC6pG6A4OP
         fxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YwhiK4RhjFtcOdjK6HryhHeUuPTC4xHkMOd8pTbbj6k=;
        b=lVBwvSwaJSeKOMmUkIz6Ue6SXxOfw4qDTOj8RY0Sf3IRu0V7seplj2Og+hSfyUWcD9
         rjtxD3FYgb07mANrNw/e15Xq+Rniq7ztVOGZI/hCrXm0cijNVAn54fW4dHuFpktblHyg
         pv2x8Gk2iqut0jFKUdgg0BIJy4AK/3KkyW/ukPGwsGzvcTZ3njCJDOHd978YOb05mXd7
         FgP0TBhDLGwsbLmTkp1bIRe3PmMJ2dy50Imz2/BkqRBHIMoFvHAx4L8ub8twlow7Q81N
         btm6GzIUP7aPJRyDcFMah44nMTv5TFZUz27CTlhOeftxIYu85Zuj7kYmjMEbQIvGOvBb
         SKaQ==
X-Gm-Message-State: AOAM533t9ip6IHV28ddx1DhsKgVBUwaAxXlapHGAskj5bCXInX31Q9Qa
        LyygcBJZRdLoR8Nd2oUyD9VRNQ==
X-Google-Smtp-Source: ABdhPJxM1M3oFBMHiRXgEOIQ+T9TXk+NQLLWwxlZklKGkaqQUZVzMOTHIzXFfi0wTEV5dRjIqEAhdQ==
X-Received: by 2002:a7b:c8d6:: with SMTP id f22mr4157067wml.188.1592487502207;
        Thu, 18 Jun 2020 06:38:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:9902:c1f0:76c7:9dbc])
        by smtp.gmail.com with ESMTPSA id o82sm3707956wmo.40.2020.06.18.06.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 06:38:21 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, lee.jones@linaro.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        amit.kucheria@verdurent.com
Subject: [PATCH v4 0/2] mfd: Add support for Khadas Microcontroller
Date:   Thu, 18 Jun 2020 15:38:16 +0200
Message-Id: <20200618133818.15857-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new Khadas VIM2, VIM3 and Edge boards embeds an on-board microcontroller
connected via I2C.

This Microcontroller is present on the Khadas VIM1, VIM2, VIM3 and Edge
boards.

It has multiple boot control features like password check, power-on
options, power-off control and system FAN control on recent boards.

Thie serie adds :
- the Thermal Cooling cell driver
- add support into the Khadas VIM3/VIM3L DT

Changes since v3 at [4]:
- Removed Applied patches 1, 2 & 4
- Added reviewed-by tags for patch 3 & 5

Changes since v2 at [3]:
- Removed NVMEM driver for separate submission
- fixed MFD driver, header and Kconfig
- fixed Thermal Kconfig
- fixed MAINTAINERS files and path

Changes since RFC v1 at [2]:
- moved hwmon driver to thermal-only
- moved the SM1 thermal nodes in a separate serie
- added the bindings review tag from rob

[1] http://lore.kernel.org/r/20200512093916.19676-1-narmstrong@baylibre.com
[2] http://lore.kernel.org/r/20200421080102.22796-1-narmstrong@baylibre.com
[3] http://lore.kernel.org/r/20200512132613.31507-1-narmstrong@baylibre.com
[4] http://lore.kernel.org/r/20200608091739.2368-1-narmstrong@baylibre.com

Neil Armstrong (2):
  thermal: add support for the MCU controlled FAN on Khadas boards
  arm64: dts: meson-khadas-vim3: add Khadas MCU nodes

 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 +++
 drivers/thermal/Kconfig                       |  11 ++
 drivers/thermal/Makefile                      |   1 +
 drivers/thermal/khadas_mcu_fan.c              | 174 ++++++++++++++++++
 4 files changed, 209 insertions(+)
 create mode 100644 drivers/thermal/khadas_mcu_fan.c

-- 
2.22.0

