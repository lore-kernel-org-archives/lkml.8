Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0E0C433F8
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A443204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 16:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595001689;
	bh=HCMMe4fMnT5S7T6Y9hA0e8QN+UlZn1sl4i+208DYvE8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G4+14uD7BrtHS9BWpQ1HjVuJ/qb6624P9pN/5VQG1tc3By4NomQiZtGrwntCdAkgd
	 DaJ9q72vOiq9AByGU3ir3ONR+9OWk46aqSoLvAGaV1IVk3hKFWKCcRQJucjtsi9BW3
	 KdBElLOgwXMwdvR/F8O7jZlW22RNcDyC5yoarg/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGQQB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 12:01:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgGQQA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 12:00:58 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C5D3204EA;
        Fri, 17 Jul 2020 16:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595001658;
        bh=HCMMe4fMnT5S7T6Y9hA0e8QN+UlZn1sl4i+208DYvE8=;
        h=From:To:Cc:Subject:Date:From;
        b=S53KSg/dyvjJKWabCVGGpfh7QsjKPd9eC320JUlH221vVIoge3owNoT+VBdWR1Sio
         epLG1hlpJ7tO2DbT2Hpdu+NNG8lp8MTqfR4GGUTOSuOz7DbUx+oMLKJ0p3tEsw9xPT
         L8Hw143Fu01YyMZWYIgNJRolKXsFKAhKGR2Nyw/E=
Received: by wens.tw (Postfix, from userid 1000)
        id 0CE4B5FC63; Sat, 18 Jul 2020 00:00:55 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] arm64: dts: allwinner: h5: Enable CPU DVFS (cpufreq)
Date:   Sat, 18 Jul 2020 00:00:45 +0800
Message-Id: <20200717160053.31191-1-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v2 of my Allwinner H5 SoC cpufreq support series from way
back [1]. The series enables DVFS for the CPU cores (aka cpufreq)
on the Allwinner H5 SoC. The OPP table was taken from Armbian, with
minor tweaks to the maximum voltage to account for slightly increased
voltage on some of the boards.

In this version, the OPP table and tie in to the CPU cores has been
split out into a separate file, like what was done for the H6. The
patches adding CPU regulator supplies for all the boards that I don't
have have been removed. The series now only enables cpufreq for Libre
Computer ALL-H3-CC and ALL-H5-CC, and Bananapi M2+ v1.2.

For the original Bananapi M2+, if I add the fixed regulator with the
enable pin, it ends up causing some sort of glitch or lock up on the
v1.2, which includes the original dts file. Since I haven't been able
to sort it out yet, I've left it out for now.

Patch 1 assigns the CPU regulator supply to all the CPU cores on the
Libre Computer ALL-H3-CC.

Patch 2 assigns the CPU regulator supply to all the CPU cores on the
Bananapi M2+ v1.2.

Patch 3 fixes the voltages specified for the GPIO-controlled regulator
on the Bananapi M2+ v1.2. The voltages are slightly higher than what
was originally written.

Patch 4 ties the CPU clock to the CPU cores.

Patch 5 adds trip points and cooling maps to the CPU thermal zones.

Patch 6 adds the OPP table, based on the one from Armbian.

Patch 7 hooks up the CPU regulator supply for the Libre Computer
ALL-H3-CC H5 variant, and by extension, the ALL-H5-CC.

Patch 8 hooks up the CPU regulator supply for the Bananapi M2+ v1.2.

Changes since v1:

  - Re-ordered patches
  - Added patches to set regulator supply for all CPU cores
  - Added thermal trip points and cooling maps
  - OPP table and assignment split into separate file
  - Added patches to tie in OPP table file for the boards I have

Please have a look.


Regards
ChenYu


[1] https://patchwork.kernel.org/cover/10787869/


Chen-Yu Tsai (8):
  ARM: dts: sunxi: libretech-all-h3-cc: Add regulator supply to all CPU
    cores
  ARM: dts: sunxi: bananapi-m2-plus-v1.2: Add regulator supply to all
    CPU cores
  ARM: dts: sunxi: bananapi-m2-plus-v1.2: Fix CPU supply voltages
  arm64: dts: allwinner: h5: Add clock to CPU cores
  arm64: dts: allwinner: h5: Add trip and cooling maps to CPU thermal
    zones
  arm64: dts: allwinner: h5: Add CPU Operating Performance Points table
  arm64: dts: allwinner: h5: libretech-all-h3-cc: Tie in CPU OPPs
  arm64: dts: allwinner: h5: bananapi-m2-plus-v1.2: Tie in CPU OPPs

 .../boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 18 ++++-
 .../boot/dts/sunxi-libretech-all-h3-cc.dtsi   | 12 +++
 .../sun50i-h5-bananapi-m2-plus-v1.2.dts       |  1 +
 .../boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi | 79 +++++++++++++++++++
 .../sun50i-h5-libretech-all-h3-cc.dts         |  1 +
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  | 38 +++++++++
 6 files changed, 146 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-cpu-opp.dtsi

-- 
2.27.0

