Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63222C54FCC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ECA9206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 00:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Is5s9jR7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDVABY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgDVABY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 20:01:24 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36D4C0610D5;
        Tue, 21 Apr 2020 17:01:23 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so371086ljg.5;
        Tue, 21 Apr 2020 17:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXcBXN5qYaxx1xKt4iyFGahtDr9mQmZjgcjMz4L8BrI=;
        b=Is5s9jR7rJ+eiBB53FBXlc7NxdrXy1sE0u4FzVMbeoRBSIRH1cCs1EDqqCYHeZ2QAA
         ++M7v1DoG2y7BPbFBlyZ7nsDs9BgaIchM9Wo+xTgp/4ZVjTTPIoJ2JM5AUFCo3FTZV2G
         DB0o1PoFt1m9QTPIs6yDaE0ROjzt+GgK5N7PcUeJIdslX6tAUK0FuGaW0/WMVgJZ5DzT
         j/XbKJCJSZWmR+gHHeB6ThCUW+Ukr3gi0amE8eboLjDwvrkjlW7Gsxujqr8+cXDgGy+9
         PZ7kopsiv3HIhMHCjXPdctrEyYG+Vf16xldyXbUZ/CoDt7t++nPIcyMYifVYmZ5Ochpl
         Lw0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tXcBXN5qYaxx1xKt4iyFGahtDr9mQmZjgcjMz4L8BrI=;
        b=hd0YZipYAzqPYjt0kYx7ady9OO9zSkdxuyHfWfrLTdsXx2YrKnDRPlmbpKZ2pPzl2z
         eOVJCWlOQd8PJ1TsLLsLwWnMzfZ4f+cim2+hpiHaGWzBJ3sNj9d+JiPJB6GBd0VpL4R1
         siQaf5A1PcdtoLtJoI/ftDhC00e5YVCPp0ybxMA2cLvUtmNKxlVYWeWtMySHTxqbX/XL
         Zy0l9t0+CIbVS2TLxw6/J5wXxXJag2XV/rcDJHDUCHA/aBCze1nMEVbZenkigzIzAgyS
         6LIDrmn853/meWXrfA4uq5j3+VYJCNLzso8T5e17vvQYaUEHRJCpRmjjzqV0vKrcFCaE
         Y6YQ==
X-Gm-Message-State: AGi0PubqAV8obdvRDoC+hR4P+ZCgAyz7b4XYbSpGG+Ea2uxYQTjOopbp
        GQoZt8zfDfaK6XW/Pv/7hQQ=
X-Google-Smtp-Source: APiQypLoxHIupQzEPhA799FGgqpwdVtDAru/ZoOpydAYUPZHy9F+GNUCw7nqSKHW9OKWmQVQGAThgQ==
X-Received: by 2002:a2e:8645:: with SMTP id i5mr13586747ljj.56.1587513682075;
        Tue, 21 Apr 2020 17:01:22 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id y9sm2933425ljm.11.2020.04.21.17.01.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 17:01:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7 devices
Date:   Wed, 22 Apr 2020 02:59:37 +0300
Message-Id: <20200421235943.13627-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series introduces upstream kernel support for Acer Iconia Tab A500
and ASUS Google Nexus 7 tablet devices. Please review and apply, thanks
in advance.

Changelog:

v6: - Corrected PMIC's RTC alias in the DTs. Sometime ago I renamed the
      PMIC's node to match the modern upstream styling, but forgot to change
      the RTC alias. Now PMIC RTC alias uses node's handle instead of string.

    - Removed "panel: " handle from device trees, which became unused after
      v5 and I just missed to remove it.

v5: - After spending some more time on adding LVDS encoder bridge support
      to the Tegra DRM driver, I'm now having a second thought and agree
      with Thierry Reding that in a longer run it should be better not to
      mix old nvidia,panel with new output graph in device-tree. So the
      nvidia,panel phandle is removed now in both A500 and Nexus 7 DTs.

v4: - Corrected CPU's thermal zone on both A500 and Nexus 7, which
      should use the remote thermal sensor (Tegra chip) instead of the
      local ("skin" temperature).

    - Added default PMIC pinmux state on Nexus 7, for completeness.

    - Added PMIC cpu_pwr_req GPIO hog on Nexus 7, for completeness.

    - Renamed thermal sensor node label to NCT72 on Nexus 7 to match the
      actual hardware (NCT72 is compatible with NCT1008). For completeness.

    - Added always-on USB AVDD regulator on Nexus 7, which is controlled by
      the PMIC GPIO. For completeness.

    - Added PMIC GPIO enable-control to the 3v3_sys regulator on Nexus 7,
      for completeness.

    - Added CONFIG_NAMESPACES, CONFIG_USER_NS, CONFIG_SECCOMP and
      CONFIG_PINCTRL_MAX77620 to the tegra_defconfig. The first three
      options are must-have for the modern userspace, the last is somewhat
      actual now since the default PMIC pinmux state is added to the N7 DT.

v3: - Improved device-tree node-names in accordance to review comments that
      were made by Thierry Reding to v2.

    - Corrected LVDS encoder powerdown-GPIO polarity on both A500 and Nexus 7
      because I implemented the DRM bridges support in the Tegra DRM driver
      and found that there was a mistake in the device-trees. The updated
      polarity also matches the boards schematics. Now DRM bridges support
      becomes mandatory since LVDS is getting disabled during of the encoder
      driver probing. I'll send the DRM patch separately from this series.

    - Replaced recently deprecated CONFIG_DRM_LVDS_ENCODER with the new
      CONFIG_DRM_LVDS_CODEC in tegra_defconfig.

    - Added more config options to tegra_defconfig, like pstore and thermal.

    - Added atmel,cfg_name to the A500 DT, which is a new upcoming property
      in 5.8+ that allows to specify the per-board hardware config file name.

v2: - Corrected "volume down" key-label in the grouper's device-tree and
      improved some other names in device-trees.

    - Added optional (upcoming in 5.8+) VDD/AVDD regulators to the touchscreen
      node in A500 device-tree.

Dmitry Osipenko (6):
  ARM: tegra: Add device-tree for Acer Iconia Tab A500
  ARM: tegra: Add device-tree for ASUS Google Nexus 7
  dt-bindings: Add vendor prefix for Acer Inc.
  dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
  dt-bindings: ARM: tegra: Add ASUS Google Nexus 7
  ARM: tegra_defconfig: Enable options useful for Nexus 7 and Acer A500

 .../devicetree/bindings/arm/tegra.yaml        |   10 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 arch/arm/boot/dts/Makefile                    |    3 +
 .../boot/dts/tegra20-acer-a500-picasso.dts    | 1457 +++++++++
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 2679 +++++++++++++++++
 .../boot/dts/tegra30-asus-nexus7-grouper.dts  |  463 +++
 .../boot/dts/tegra30-asus-nexus7-tilapia.dts  |  549 ++++
 arch/arm/configs/tegra_defconfig              |   42 +
 8 files changed, 5205 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dts

-- 
2.26.0

