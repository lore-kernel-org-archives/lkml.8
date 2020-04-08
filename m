Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F15C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D803A20771
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 20:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rzvt9if/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgDHUlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 16:41:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37890 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgDHUlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 16:41:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id v16so9183828ljg.5;
        Wed, 08 Apr 2020 13:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9w5E+HapWonCQjMtyDC8375wQXju054hOLV5mQ/Whw=;
        b=Rzvt9if/5nk0Qrd5E0KcoJCDmJgJ0Wu4kwxrxBJOse89mVEYHlpHYTLac4I2hMmuHl
         K0dMhP6Yz4FmhnJvM902dtWOspE24NP8nHmtLu316qYdxIgQs+BDROp+jKdxGNQJzSh5
         sGy7stXPE5D63XeYgAW90LK32nhR8j5t5IPNQbQVNAA5sMj9V1oF9oe5Kdq0fB793jAp
         VyJoqYJtaR8Yivjg6zO0v30D41T5r6HWlvb16QunPx4jXHaI1Dd/UN1EQqP9lvtXbzM7
         l31N3K2J0D1dZI6kPBde6l2r0Dmzyp0iVnrIMM15mHZVoJ0cGdCnWCPAgqGXQWgH9YJk
         SBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9w5E+HapWonCQjMtyDC8375wQXju054hOLV5mQ/Whw=;
        b=b+MV5TxZIsD0mgYIkmx83Qvp2q9Rt6DxHQ+VS0QfP9sHWR5ClMOwNQTDaJC8Qi3TME
         /mnUCZBWZAUwaDSyUzZauUiPJE6WPDzHsKcypQ/lJF5rTL2AmfbmP2OY7cmfhg42iECB
         YbyPrkjoq0PdsTx970Nz3qyi/RewOM1JrhiVmNIEIFlr/wMQtPycPetiU33FYD2kEKCx
         5oOJu8OFC7rUtAOTa/j7xSAfzI1p+t5lO+uuXetfRTw2wVYWbufXl+oeQO46hA+KqjiJ
         jkipiPDzKYMAiOCVU1yPnmaJUdRWbM/00zJtJ0Roz1Xz86wlG07rd6kWWjZOfjdSxAkh
         8tug==
X-Gm-Message-State: AGi0PuZ5b1V9xlCe+pxRYxodq67I/zwoTnVMnpAtm54JlYenwpkm6Ogo
        oaCKnrCmZzX0qunLHlnGlHY=
X-Google-Smtp-Source: APiQypLADbDn1KWbppW6sBYUPcYJ0zUtbrTZcXK4qNKB0fjRrSA/DLxVwT5/hElXOYQxCz9rYu+MGQ==
X-Received: by 2002:a2e:7a0b:: with SMTP id v11mr5753748ljc.120.1586378463530;
        Wed, 08 Apr 2020 13:41:03 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id p14sm13189727lfe.87.2020.04.08.13.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 13:41:02 -0700 (PDT)
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
Subject: [PATCH v3 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7 devices
Date:   Wed,  8 Apr 2020 23:39:39 +0300
Message-Id: <20200408203945.10329-1-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
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
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 2646 +++++++++++++++++
 .../boot/dts/tegra30-asus-nexus7-grouper.dts  |  463 +++
 .../boot/dts/tegra30-asus-nexus7-tilapia.dts  |  549 ++++
 arch/arm/configs/tegra_defconfig              |   38 +
 8 files changed, 5169 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dts

-- 
2.25.1

