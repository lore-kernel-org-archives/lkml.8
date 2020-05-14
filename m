Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB76C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1144220709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWJz6WHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgENViI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgENViH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:38:07 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7989C061A0C;
        Thu, 14 May 2020 14:38:06 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so48666lfd.7;
        Thu, 14 May 2020 14:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9HYoTTU1s30zg6bL6JtBY9Z8hAi6CvJKOl/+ZoviD0=;
        b=TWJz6WHQlphEahO4dhwXDX/YWltwSmy4qOCw1nmOuuDwCrIs7Qxl4w3XTEKJ4K/Snb
         fHhRTzbW+HEZizZ3nBh+Y7Vl9ZwTRw/vbqPGAZcwJEcWwoJOD84dPM/PKfxKs9iaSJar
         K0wPalT6HmKJtL6a3qG3yD5dkw8BZvKA0PjozqUWBDhuM3HodloBf2EJwvONaavSldkK
         MbtPGDFFvBBT5RRpUrINaBz8ZAcfHLhZAP+OMMdaF4Bln2fmPxaqasy0qGB+AL198UNQ
         m+xSbxd0z3/v633vXDaRN8dvXc9m0QOL4o8JIBaXAJeWQmYsdrLrzXhWosoiUKEAPHSq
         8SJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h9HYoTTU1s30zg6bL6JtBY9Z8hAi6CvJKOl/+ZoviD0=;
        b=baSYgFyOiZhfnwANI/ILiNeKwpbH7YAmyj/ErXJZb7/qNqrhVI0HFFoz88iWz/DLlV
         EePPuHxVNvbqf0IkWFn85g9PZRGQjl31GRa8sKWP5QhDkPNMJ/rQF/5xhVQp0HhaHpsL
         8OZzZV7Ath7IZssC5pMHek5rKp/9HayomjlAKdwIRmaPvBdt1armQ3bae8so693hnE7X
         4GRSetw2WGO/vdxG04DaM0PDJlTRnqjcUioEtYXKjNZ5+d03OoGDNh/7vnF3O3dfrq6V
         hsfJfMmTrYuQtFe9IDP2Ybiemi5yq3lpHaMunmvf72JI7HcY66YNDj6PhwrI5B0srXGw
         E6Mg==
X-Gm-Message-State: AOAM532RkW+RmEvku28oK2o2p1IKQNf5pkBqTnTKyElDNsFqU36KV28/
        lK8b9tuLX/ZbHx08QHd6yBk=
X-Google-Smtp-Source: ABdhPJwv7gdARFHR5/0hIyk52NNhzPrKG9Vo/S2djbKnPThCCmIo2KlTPdYrhMbQGhQaPD9s/ShcjA==
X-Received: by 2002:ac2:5496:: with SMTP id t22mr151050lfk.0.1589492285363;
        Thu, 14 May 2020 14:38:05 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a12sm63628ljj.64.2020.05.14.14.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:38:04 -0700 (PDT)
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
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7 devices
Date:   Fri, 15 May 2020 00:36:48 +0300
Message-Id: <20200514213654.12834-1-digetx@gmail.com>
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

v8: - The eMMC voltage regulator is now marked as always-ON in all
      device-trees because turned out that some bootloader versions have
      assumption about the enabled regulator at a boot time. This fixes
      machine hanging on a warm reboot, it's also matching the downstream
      kernel regulator configuration.

    - The core regulator of the Ti PMIC Nexus 7 variant is now limited
      to a 1.35V, which is a more realistic limit than 1.5V that was borrowed
      from the Cardhu device-tree. Now both Maxim and Ti variants have the
      common limits.

    - Added acks from Rob Herring.

v7: - This version brings support for a Nexus 7 variant that uses Ti PMIC
      instead of the Maxim PMIC. Previously we assumed that variant with
      the Ti PMIC doesn't exist in a wild, but turned out that it was a
      wrong assumption. In a result the device-trees are separated into
      more DTSI pieces, which combined together form the final device-tree.
      Thanks to Zack Pearsall for testing the Ti version!

    - The camera voltage regulator is now preset to a correct 1.8v in the
      Nexus 7 device-tree.

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
 arch/arm/boot/dts/Makefile                    |    4 +
 .../boot/dts/tegra20-acer-a500-picasso.dts    | 1458 ++++++++++
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |    9 +
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |    9 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 2503 +++++++++++++++++
 ...egra30-asus-nexus7-grouper-maxim-pmic.dtsi |  188 ++
 .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi  |  151 +
 .../boot/dts/tegra30-asus-nexus7-grouper.dtsi |  462 +++
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |    9 +
 .../boot/dts/tegra30-asus-nexus7-tilapia.dtsi |  548 ++++
 arch/arm/configs/tegra_defconfig              |   42 +
 13 files changed, 5395 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-PM269.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-E1565.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi

-- 
2.26.0

