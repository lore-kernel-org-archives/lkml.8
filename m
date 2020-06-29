Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA8EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DB8206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlkoCiFV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgF2CzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgF2CzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:55:17 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D3BC03E979;
        Sun, 28 Jun 2020 19:55:17 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so8242604lfb.0;
        Sun, 28 Jun 2020 19:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZgvg6VTx/OYNw/SBxtHXYMWJKGqM98+4zuIx26hEHs=;
        b=TlkoCiFVwfEtobe28tfVpoSkBz0dVxsv0skDeWICeI05IZUYYVjQAHXk9TyTrfy+tp
         F9d4s/5x9jAJM64/v79T4yA9dA4iZfMe7BbiS+BISnNa0wfUsrvynuaYPATgtqJBoXFc
         fOsXb5PjyZNkgLLJ30bpfGpvW6WMc+TO8LwefdXPRzBnn/iMyULVY9kcLMCpCHCjbjjh
         tP7lauZLoeF9I7/rty6MaVFtqNGlWQaf6CLz04+9Q7/MdXIDbRrkV2GEHepJd+roWwJ3
         4OCTIvhsFN04BX51bjj0DIGvA6iGMDPfyBR43/xHL4VRcZ1X/Oq533jLAhFeNiqn+d4R
         bLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vZgvg6VTx/OYNw/SBxtHXYMWJKGqM98+4zuIx26hEHs=;
        b=gdWgzO3Gz4y/RDVv8V/f5J+XoRxUt+jjdAPtHsCuwx7ZnzEOMGQQQlOc/susN8ltcz
         qw3rFpOaffTN0Gwx7NtWgRbnPDhaaASz8sO3ljFVrffpwp6CtnbnOVFnWoEVglgtOUdC
         6EaacmL8O9wpwaB+WklLTeceb1eylW1LhdQZd7kbLwEr6IucVAKEx+YRqRVHaPr3baxu
         a7W7mrQN05fdMQ6pMjAPXXT3T6Q5aUNH7PXuw+x+wxLa6nsD5q0C8w1IUKr/ZQRqigwd
         pp+L02h86ETsRdrA/e2xPzypOtQk0/OW7Mta581ntJ6NRsy8v2VKj6scZrBbxzPPQnJ4
         GPYQ==
X-Gm-Message-State: AOAM533Qdoqjv9anR1xqZl7h+itWZDz2YqcrHNZTAaSWgzHjBIr/eak6
        HVS6LeBj9s3Fn7aI0dISEyw=
X-Google-Smtp-Source: ABdhPJxoq5khVBUhEr1XsPmPITR8dLHo2zpGSz6IlFIS3WeUwHVw7eNI2XL+GwNBUY1rKdrP25O7bQ==
X-Received: by 2002:ac2:4295:: with SMTP id m21mr7959178lfh.186.1593399315930;
        Sun, 28 Jun 2020 19:55:15 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id o4sm8820527lfb.52.2020.06.28.19.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 19:55:15 -0700 (PDT)
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
Subject: [PATCH v10 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7 devices
Date:   Mon, 29 Jun 2020 05:54:50 +0300
Message-Id: <20200629025456.28124-1-digetx@gmail.com>
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

v10:- Rebased on a recent linux-next which got some device-tree changes:

        - Renamed sdhci@ DT nodes to mmc@
        - Removed simple-busses from DTs
        - Checked DTBs using upcoming YAML bindings from Thierry Reding

v9: - Nexus 7 memory timings are moved out to a separate dtsi file to ease
      reviewing of the device-trees since the sparse definition of the timings
      within multiple DT files created some unnecessary confusion.
      Thanks to Michał Mirosław for the suggestion.

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
 .../boot/dts/tegra20-acer-a500-picasso.dts    | 1438 +++++++++++++++
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |    9 +
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |    9 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 1232 +++++++++++++
 ...egra30-asus-nexus7-grouper-maxim-pmic.dtsi |  185 ++
 ...30-asus-nexus7-grouper-memory-timings.dtsi | 1565 +++++++++++++++++
 .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi  |  149 ++
 .../boot/dts/tegra30-asus-nexus7-grouper.dtsi |  149 ++
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |    9 +
 ...30-asus-nexus7-tilapia-memory-timings.dtsi |  325 ++++
 .../boot/dts/tegra30-asus-nexus7-tilapia.dtsi |  235 +++
 arch/arm/configs/tegra_defconfig              |   42 +
 15 files changed, 5363 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-E1565.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-PM269.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-maxim-pmic.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-memory-timings.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-ti-pmic.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-E1565.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia-memory-timings.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dtsi

-- 
2.26.0

