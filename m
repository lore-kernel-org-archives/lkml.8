Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66EEC4724C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1729206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 02:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOFP+W5/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgEEC0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 22:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726531AbgEEC0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 22:26:41 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BE0C061A0F;
        Mon,  4 May 2020 19:26:40 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id j14so56097lfg.9;
        Mon, 04 May 2020 19:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcIkCmWkoTfy7mqsrBUUk3No3cWlCFkSHw7yETwn04Y=;
        b=oOFP+W5/M9c0EuZYQRGX4zjoh4+cJpC8Vk6fgLmrAy9ITNLXPMKUdPp7Pp9yiiFOan
         Y2b40mEWD5OB47dvfKsBvbSnpHZevZqza0PtmS6Zr7hlPC2ifypnY6XhSzsBbUjH9JdL
         vjHjnBzyewiEMr3RLpEFwdCfIOsyVsB6Vfu1xf/G7qFIC3zWqd7xO1jluytlw0O/P8wF
         m1gOub1tBBm30gijhNyI+OMIuyNVlpGmN+jHoW7xeDTK4/wVowRs9enMxCDlhLh/QRnw
         30bJ7SGYss1OiHmcPaKqhUzztvRrzgKrMultT+WBKgLY61G/lqSE7b4tCQpbSjEWVaQO
         7ZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YcIkCmWkoTfy7mqsrBUUk3No3cWlCFkSHw7yETwn04Y=;
        b=ONqxZnBdZaENDQlVgZKqG9FuLRSgHS/EmI2TgYiMg9mp1bKDuj3QHvn527havNAXiX
         F3tHUDWVLGLRKlHZSF1K0c5YrkX2GyO5mZs0J9ugYkm9JrzRo0JCvTaX3bMILKIqklAI
         Q749BVD0RrYKGjB/nvFWuBpUXE6kA+L5/TY7dboDEaDiM4sQIygZSi78I7gGYKsBkKlZ
         TkOw7E+KXuvbIsynffMi688wAVnzKvbUGyfbM1SjwEvkWvW3n8uinuv1aLpy6OM9v4Xl
         D90cqsRpbijmOwKQVmy5zBc3ivJw1H+f4bjw4tGtr/k3Xp3QeVWIRiPWfA/M2H1I3cu7
         0rWg==
X-Gm-Message-State: AGi0PuYQbOdzAqD8ncLhseZRWqvajUHr4jtWmCDKNx4BcvDhjtb0t7y4
        dFXJLlmL8UNSjzsyTka9sjlB1faQ
X-Google-Smtp-Source: APiQypIPv6SXgJ5HUKNj0zKasf8Xc++I4Cn8dYYRJlY9C/L7gql1ai+ZbI5lgwjN5XSTObZlnDfxQA==
X-Received: by 2002:a19:8809:: with SMTP id k9mr57600lfd.151.1588645598986;
        Mon, 04 May 2020 19:26:38 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id l25sm449251lfh.71.2020.05.04.19.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 19:26:38 -0700 (PDT)
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
Subject: [PATCH v7 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7 devices
Date:   Tue,  5 May 2020 05:25:11 +0300
Message-Id: <20200505022517.30523-1-digetx@gmail.com>
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
 .../boot/dts/tegra20-acer-a500-picasso.dts    | 1457 ++++++++++
 .../dts/tegra30-asus-nexus7-grouper-E1565.dts |    9 +
 .../dts/tegra30-asus-nexus7-grouper-PM269.dts |    9 +
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 2503 +++++++++++++++++
 ...egra30-asus-nexus7-grouper-maxim-pmic.dtsi |  187 ++
 .../tegra30-asus-nexus7-grouper-ti-pmic.dtsi  |  150 +
 .../boot/dts/tegra30-asus-nexus7-grouper.dtsi |  462 +++
 .../dts/tegra30-asus-nexus7-tilapia-E1565.dts |    9 +
 .../boot/dts/tegra30-asus-nexus7-tilapia.dtsi |  548 ++++
 arch/arm/configs/tegra_defconfig              |   42 +
 13 files changed, 5392 insertions(+)
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

