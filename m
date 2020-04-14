Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD4F6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE5A12076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 22:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpdUzP76"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634286AbgDNWM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 18:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2634196AbgDNWKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 18:10:03 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3206C061A0E;
        Tue, 14 Apr 2020 15:10:01 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q22so1571203ljg.0;
        Tue, 14 Apr 2020 15:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0XPwxdFCjJHTuSbnS2w6zqorjjc9RWVXqyjiI/jIis=;
        b=dpdUzP76QV7sTI3nok9EmoFs3mfQ1Co9VYbw/a3nyURD6+kqJhVSzly9jO3vV4wqvy
         ssBZrTUThPra2QqU4vWEX67XOAk7/GhHDG2oUY8PaRBNjJ1FDyz69atAKd99SIPhUIvE
         jilM5R8pCrvuWEWk/1Hg9X+udDVYk8BW6CdgJJyG6eap2Fjiq1bUBx76cixcTh9jImJ3
         21sBnI4clZ+HyT0uvnzIBdUaVRw3LkVYDxCJiETJo5Y5Bg8tCxLlbn2MUHLc4fddlFdu
         pfS273xaNWyZxrvOdQCJb5gFWZverpcLzKWs3k6RItrNeIK6dDInuhSsGAjLjMZ3oXQB
         Whjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F0XPwxdFCjJHTuSbnS2w6zqorjjc9RWVXqyjiI/jIis=;
        b=IUwSpA/U7+JxXewBv5v34UzVR/rMLxQeCUcAe9M7Yv3+ARu+oe2fImehZwUpueotZG
         b55JxK8WfWeISt5DISHTzj/PLjAMbuimrpSyIAS951BsScMUlF83LKWYhaGuYKfpJYjc
         2YkrD2UH/2sR7eWVlBDLSPAK98wNP+K9tqnQv+RM1ImWMCbJRH42EJW5zvHKbQwDcBBV
         5erMZzHoUeF8iQE1mOc1s6KsCVRa1ejf9pNQKpFJtdpWJ+VXFtL2OrHeypyNNyzDBeCA
         B8gZXqyyQJujKiq/zY8GJgncvQTi4cbqJF/dsyYQFvM8UPZXwbHSx80HVhqf/3cYQSX9
         xDGQ==
X-Gm-Message-State: AGi0PuZ6vfW8CFsmJONQoib2T0oC+gxd1i8P7tVk9bpSnctwgXWLTyEp
        qzD8Q0eB3zpnk98or+NbYqc=
X-Google-Smtp-Source: APiQypLlrZjm0kkuuIk+cj7F9b+2hImgbX9ulv04uvR3P0Uia+i65n+ywVvG9BUpZuc5iL5d6G3zJA==
X-Received: by 2002:a2e:8e68:: with SMTP id t8mr1407493ljk.20.1586902200388;
        Tue, 14 Apr 2020 15:10:00 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id w27sm13663044lfn.45.2020.04.14.15.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 15:09:58 -0700 (PDT)
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
Subject: [PATCH v4 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7 devices
Date:   Wed, 15 Apr 2020 01:07:53 +0300
Message-Id: <20200414220759.29146-1-digetx@gmail.com>
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
 .../boot/dts/tegra20-acer-a500-picasso.dts    | 1458 +++++++++
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 2680 +++++++++++++++++
 .../boot/dts/tegra30-asus-nexus7-grouper.dts  |  463 +++
 .../boot/dts/tegra30-asus-nexus7-tilapia.dts  |  549 ++++
 arch/arm/configs/tegra_defconfig              |   42 +
 8 files changed, 5207 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dts

-- 
2.26.0

