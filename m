Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B039FC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ADA5206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 19:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fmvs/lMC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDFTnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:43:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36366 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgDFTnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 15:43:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id w145so480302lff.3;
        Mon, 06 Apr 2020 12:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Yi76jXrhGzr9w1zwjkk0H648baQNxRmi8nM63MPAiw=;
        b=Fmvs/lMCDBg/kISsqujiqyFF4pLfBTut5EYbkVl8t/ZuZEhuGdQ/iwNjQlKpgwBMvC
         sdLf5exnbnirtv57lf03yMw6IBlzZ94RnfCdEORF3TZAqRPjBQUwrqmVL6z2rhfwLW9f
         gONERjYtFo85nPv8vvOssmVHAeElD50LtvPyzp875CUXmvqOCSTrDYoyZUWuyaSP+Q9A
         s/kFQdpbkGJ8v/4TD3ocx2M6xFzLQBNaY1l1mHl0sts+9bm27etGiaz6TgkPXelxmbDq
         zBQKFX1g7Hk+VFTWgoxFXedXsrbQuUTn2igvW1/KNfKiX8Aswc8cIaKBpB13tul7Gf+z
         KD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3Yi76jXrhGzr9w1zwjkk0H648baQNxRmi8nM63MPAiw=;
        b=RNJZb+WwoHLjNeeeFuw2K56I1cDMbXjFBbxYDiCPiTmFc8wxrNcAZWmcYTE0vv72DS
         i1idKqrpeZQnC+TiuctrM/SC+p2nlG0AEwm8QONddAuNfnRFXvnpFjel/Uqxvi1nVEZp
         g6jygHY//3ySa65sD22vEK4iETW5KpPWKYDjh3h5o2jDgRrk9TOsNfTi2Sw2+Tu7gzik
         iZnfjuMgVdOskt1O+5AUQPkDMeYHD8t7WTy0MG03lHMaxfuIbL5c0F3L0NiVr6rEn5yp
         CL66n8AfZqTzQ4vjy07DfNEPcWASz3JBvUi0WlbImL7vAvAjkd7xoDq/GoF6s/ZG7q9j
         TMLg==
X-Gm-Message-State: AGi0PubPGBiOM7Xxx31uHsXWMiXcUDSOAVIt9ysTJf7/9vUnpdBgqfGr
        st7cl6SqKSEuRsn872BnDns=
X-Google-Smtp-Source: APiQypKpTnzY15WgbOMsxN0r9NnfJmthP2UD2dk7FNkYNu8IicnUT4RX8v+kH0gjQiG6B1kp3Oi0CA==
X-Received: by 2002:ac2:4554:: with SMTP id j20mr6220830lfm.91.1586202223959;
        Mon, 06 Apr 2020 12:43:43 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id r206sm4996233lff.65.2020.04.06.12.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 12:43:43 -0700 (PDT)
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
Subject: [PATCH v2 0/6] Support NVIDIA Tegra-based Acer A500 and Nexus 7 devices
Date:   Mon,  6 Apr 2020 22:41:04 +0300
Message-Id: <20200406194110.21283-1-digetx@gmail.com>
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

v2: - Corrected "volume down" key-label in the grouper's device-tree and
      improved some other names in device-trees.

    - Added optional (upcoming in 5.8) VDD/AVDD regulators to the touchscreen
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
 .../boot/dts/tegra20-acer-a500-picasso.dts    | 1447 +++++++++
 .../tegra30-asus-nexus7-grouper-common.dtsi   | 2646 +++++++++++++++++
 .../boot/dts/tegra30-asus-nexus7-grouper.dts  |  463 +++
 .../boot/dts/tegra30-asus-nexus7-tilapia.dts  |  549 ++++
 arch/arm/configs/tegra_defconfig              |   28 +
 8 files changed, 5148 insertions(+)
 create mode 100644 arch/arm/boot/dts/tegra20-acer-a500-picasso.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper-common.dtsi
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-grouper.dts
 create mode 100644 arch/arm/boot/dts/tegra30-asus-nexus7-tilapia.dts

-- 
2.25.1

