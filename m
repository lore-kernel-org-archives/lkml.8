Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B1DC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C0520B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:01:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pt5x0o+F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgDUIBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgDUIBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:01:08 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70ACC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k11so15353197wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 01:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBv83Opptndn2jdIJyA6t7FILIlZmdOYex4CsUwqmNQ=;
        b=pt5x0o+FSwY0eW4M36QP7Qu/0mEXdNl9eRQzQt1YLuknSOtQaMwUeXjppkFtvacSYH
         2l9rbyHQBVVzLz8SdnFXc0R2tnf9T1dxyjbjDg1/moFCMVmD8Sgq9wDhlZEllEGTl2gG
         My5sG9HTAR/p3XzFKEwVltOKCwzBSotoYW74GLD7g11seGLF278ocBsNWMksG+OjTu5T
         sn7mTCplD7/5iFY1Nmd6sh7dKZ7cIjRRtgQDAvQ6HLMpvvnspbm5bwFBjPRPir9bBDgg
         LTq+sro56EUOk2da/pALgphV8CjCnfsNBQuHe25I9nVTGwqEYqdVxhakKyGMrA4BOCct
         ehmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KBv83Opptndn2jdIJyA6t7FILIlZmdOYex4CsUwqmNQ=;
        b=NhYvJkNpB7HXQpsNeELM9vDwyob7ryNwTHuEqLKMqEK2vXxuHdnz5VzS+Jw+ms/VbF
         IEgiMvK1QLNp3lIoQKxbvF37JSJ7XNYE6Fbk0coDqh5O+5UHbQK5CiL88Jspb39DYOGs
         MKuvqjanWGvM1ynFlBQ27N3662D40mLlOCZl5S+Msqxku8sTAW9RI9Udp2LU3FHadYUM
         Z5AvP8hx8TMNLc8rF1GWMREahctOrBYSLow5JF6nPL6Xj5mgSJ8qXiv+zPacu7wLycSK
         cbCbWHiQ2gg5CBPBfNyFP0X21BmJ3HqZZtnvxEqH9+2odLy3qcokNwpIcAlnW+/6DBdM
         8Guw==
X-Gm-Message-State: AGi0Puala5ROBCpha1JFDhkwgTC8GtMYaEK6jTjeYLdcJUVjzsXVc9Kw
        9npgF2GYWRyMsfBDQC2g6Ma+Bg==
X-Google-Smtp-Source: APiQypKTi6JDVYSaT1z2mVhN2/bDq93mvCWZgHVF5JFa9trwb10pl44CHnxvZAwdqrksgM/Q+RQvdw==
X-Received: by 2002:a5d:62cc:: with SMTP id o12mr22278772wrv.75.1587456066485;
        Tue, 21 Apr 2020 01:01:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id x132sm2561552wmg.33.2020.04.21.01.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 01:01:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     lee.jones@linaro.org, jdelvare@suse.com, linux@roeck-us.net,
        srinivas.kandagatla@linaro.org
Cc:     nick@khadas.com, art@khadas.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC 0/8] mfd: Add support for Khadas Microcontroller
Date:   Tue, 21 Apr 2020 10:00:54 +0200
Message-Id: <20200421080102.22796-1-narmstrong@baylibre.com>
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
- the bindings
- the MFD driver
- the HWMON cell driver
- the NVMEM cell driver
- updates MAINTAINERS
- add support into the Khadas VIM3/VIM3L DT

Neil Armstrong (8):
  dt-bindings: mfd: add Khadas Microcontroller bindings
  mfd: add support for the Khadas System control Microcontroller
  hwmon: add support for the MCU controlled FAN on Khadas boards
  nvmem: add support for the Khadas MCU Programmable User Memory
  MAINTAINERS: add myself as maintainer for Khadas MCU drivers
  arm64: dts: meson-g12b: move G12B thermal nodes to meson-g12b.dtsi
  arm64: dts: meson-sm1: add cpu thermal nodes
  arm64: dts: meson-khadas-vim3: add Khadas MCU nodes

 .../devicetree/bindings/mfd/khadas,mcu.yaml   |  44 ++++
 MAINTAINERS                                   |  11 +
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi    |  23 --
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  22 ++
 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   |  23 ++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    |  24 ++
 drivers/hwmon/Kconfig                         |   9 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/khadas-mcu-fan.c                | 230 ++++++++++++++++++
 drivers/mfd/Kconfig                           |  14 ++
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/khadas-mcu.c                      | 143 +++++++++++
 drivers/nvmem/Kconfig                         |   8 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/khadas-mcu-user-mem.c           | 128 ++++++++++
 include/linux/mfd/khadas-mcu.h                |  91 +++++++
 16 files changed, 751 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
 create mode 100644 drivers/hwmon/khadas-mcu-fan.c
 create mode 100644 drivers/mfd/khadas-mcu.c
 create mode 100644 drivers/nvmem/khadas-mcu-user-mem.c
 create mode 100644 include/linux/mfd/khadas-mcu.h

-- 
2.22.0

