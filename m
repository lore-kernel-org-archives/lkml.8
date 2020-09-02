Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7CFC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3612020767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nuwm7bil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIBWsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBWsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:48:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11426C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:48:19 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t10so1074521wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l80LLYGa/yYmt3H9jqHnhQDWkk8QQ1YTQWwpquPQW8Q=;
        b=nuwm7bilclieGOSY2ZWyaQnC5HjoU7juXZSnF039IugZj8wLuLXsFFqF7YHrQzDJJX
         pKqwXoM9mQrAdmZgV6mPwaelAFb1YUvkZkr565NZZXAQ8Eoha8o1gf/8odXr5OWhHwWm
         aGYN3wplbcEGgf8jXv8nBNjFyjZyrYkMAXNvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l80LLYGa/yYmt3H9jqHnhQDWkk8QQ1YTQWwpquPQW8Q=;
        b=e5k9fe4ZdxSSlU1Lmwjgmdy1s/RExpmglPRASXBc9UgVDT7ntnbYrMW4pwszqaQR/F
         iOXXcnNzE09D9Fwbe7WigdnlXPP6izeTbFdfUvXdqADrx8QIvwKyBNnSayJwtrlVaIa8
         yj+UeQtMBNNb6RsrBgEebg1rezeLiN3+k3agl7wySthdzEr15A/5Gx2OHElzWu9oIc7X
         O++YEnJQ41l79nXbFZieEQP7WzAKYYKoOHvBO67rAGqJyZkSAdm3Z+DHeZxuluOY0+8E
         q/F1gQ2u1BmzhAslJF16bNkyaaPvsFfpJXsnQO4pBdUv5uC5bgcXDReumsNzqhVjJGl8
         QmRg==
X-Gm-Message-State: AOAM5324mIfEydKNxnv1betQgrVTQRDbT0jpQzfGGpLK+oyAnVO72Ncb
        2gOGmyrBatk9B0gxF9x/U+M3Ag==
X-Google-Smtp-Source: ABdhPJyvFaOl5Bp71SygSFaYE7q0D2J9roMhkJJIvfrjHfZdhbmgcAK/3ymTae/CPSE3tuE1xJQZ/Q==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr392900wrm.229.1599086897633;
        Wed, 02 Sep 2020 15:48:17 -0700 (PDT)
Received: from tfiga.c.googlers.com.com (88.140.78.34.bc.googleusercontent.com. [34.78.140.88])
        by smtp.gmail.com with ESMTPSA id m125sm1557568wme.35.2020.09.02.15.48.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:48:17 -0700 (PDT)
From:   Tomasz Figa <tfiga@chromium.org>
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hao He <hao.he@bitland.com.cn>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, drinkcat@chromium.org,
        Xingyu Wu <wuxy@bitland.com.cn>, dongchun.zhu@mediatek.com,
        sj.huang@mediatek.com, darfur_liu@gcoreinc.com, hao.he7@gmail.com,
        Tomasz Figa <tfiga@chromium.org>
Subject: [PATCH v4 0/4] Galaxycore GC5035 sensor driver
Date:   Wed,  2 Sep 2020 22:48:09 +0000
Message-Id: <20200902224813.14283-1-tfiga@chromium.org>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series adds YAML DT binding and V4L2 sub-device driver for
Galaxycore GC5035 5-megapixel 10-bit Bayer CMOS 1/4" sensor, which has a
two-lane MIPI CSI-2 data interface and uses the I2C bus for control

The initial version supports the following features:
 - Manual exposure, analog and digital gain control
 - Vertical blanking interval control
 - Test pattern generator (color bars)
 - Media controller support
 - Runtime PM support
 - Support operating modes:
    o 2592x1944 at 30fps,
    o 1296x972 at 30fps,
    o 1280x720 at 60fps.

A separate patch in the series adds support for loading manufacture-time
configuration from the sensor OTP, which currently includes:
 - register patch table,
 - DPC table.

This is based on Hao He's and Xingyu Wu's v3 series that partially reached
the maling lists:
 - patch 1/3 - equivalent of patch 1/4 of this seres:
 https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1597380295-6297-3-git-send-email-wuxy@bitland.com.cn/
 - patch 3/3 - equivalent of patches 3/4 + 4/4 of this series:
 https://patchwork.ozlabs.org/project/devicetree-bindings/patch/1597380295-6297-5-git-send-email-wuxy@bitland.com.cn/
Patch 2/3 that adds DT bindings was missing so I recreated it from
scratch on my own.

Changes from v3:
 - Require and handle clock-frequency and link-frequencies device
   properties.
 - Separate the driver patch into one for base functionality and another
   for OTP handling.
 - Do not perform OTP initialization on driver probe, since it's a
   costly operation. Instead do it at first streaming time.
 - Fix power sequencing to match the hardware specification.
 - Set system PM ops.
 - Various stylistic changes and general clean-up.
 - Add myself as a maintainer.

Hao He (3):
  dt-bindings: Add a vendor prefix for Galaxycore Inc.
  media: i2c: Add a driver for the Galaxycore GC5035 sensor
  media: i2c: gc5035: Add OTP configuration handling

Tomasz Figa (1):
  media: dt-bindings: media: i2c: Add bindings for GC5035

 .../devicetree/bindings/media/i2c/gc5035.yaml |  142 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    7 +
 drivers/media/i2c/Kconfig                     |   13 +
 drivers/media/i2c/Makefile                    |    1 +
 drivers/media/i2c/gc5035.c                    | 1972 +++++++++++++++++
 6 files changed, 2137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/gc5035.yaml
 create mode 100644 drivers/media/i2c/gc5035.c

-- 
2.28.0.402.g5ffc5be6b7-goog

