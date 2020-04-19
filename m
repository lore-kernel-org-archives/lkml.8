Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AADEC54F70
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ED3A21D94
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 13:50:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ric5TG71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDSNuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgDSNuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 09:50:15 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260A3C061A0C;
        Sun, 19 Apr 2020 06:50:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u127so7078073wmg.1;
        Sun, 19 Apr 2020 06:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywX5jmEdgUGdYZJoKeCHIfxzoctUJK2EGaT9uQR5yUI=;
        b=Ric5TG71Fc9oUWNkk1jXMM2unUeX9InPu5dQ8r6RkQ81f0chX+LchTMRA3QXtuVUJM
         3G2s3NKPHIDwzmZ7er1u6lYFHiJO5hD5mXnlhgMb6EgDtGHbndCaApZ2+Mj/GXFYNCJV
         G/LIlfmuBcp47y4RI8OzZeSKEsCV/qEhMbvDRO1KtTxWIWYpMHVVIHZHz9dXV59rAaML
         vNorgGbnoFj0E42KJhc67WmfylKni1S6RobeJ35bbaFXeuNKVKvWVrJTr6alINB6mcPz
         gsYdR73896v/7xAajRvvV0G5vWwadWcmj2hn3CT5Z+kmBoM068c3fHgFhxXlDKVTmquR
         Vzeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ywX5jmEdgUGdYZJoKeCHIfxzoctUJK2EGaT9uQR5yUI=;
        b=pAfVGr2eq2+budZUJUYj8QrXCSIW2SCOUGS8UAlyNQ80o0Gd3xLpNKdlcxLsiWDrWR
         wZxajgcH3HMN6014UXYeGgHsQzbIjY4ASy01uihHd+BCAL+hBvnKl5AOiU/gykVYsCZ0
         VhSE7nZkdeIC90vUbzoaL4TXYjyOmyb3fXLJvToTPIxkd6IV1mfH5OALx7pgOtS8+zRG
         s0cRqeszr0UWI/u8tASVZwUvT+IeE20cgfY/ur5no1Iu4u3F0W3vusNScgl8ixBX5X7S
         he6p5qSaej6hpe5ag2z9Ap/hZl43wwWYyX7yB2Fko/QcSG0BVD30+RwAZpHFndbhSJSE
         A3jA==
X-Gm-Message-State: AGi0PuZiB0vtwPeJhtTx0nAAbrRZcQdZspZQmrdKrPbsvOMH61arxRbC
        QKUfoGNNXUMGt8GMjEkmF60=
X-Google-Smtp-Source: APiQypIZkJhJRdyWTJqDq+zn7KccNN0bDpj0/VApnNkzRCZzgzG+PBt1t00uywmzxJhZsiOS1j8KwQ==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr13421207wmg.32.1587304213635;
        Sun, 19 Apr 2020 06:50:13 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id z8sm20183940wrr.40.2020.04.19.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2020 06:50:13 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 0/7] Add support for Allwinner H6 DVFS
Date:   Sun, 19 Apr 2020 15:50:04 +0200
Message-Id: <20200419135011.18010-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sunxi maintainers and members,

Now that required drivers are merged we can contibute on DVFS
support for Allwinner H6.

This serie is based on Yangtao Li serie[0] and Ondřej Jirman work[1].

Most of the OPP tables are taken from original vendor kernel[2].
Plus there are new CPU frequencies at 1.6GHz, 1.7GHz and 1.8GHz.

I wrote a simple script to randomly set a frequency during
a random time[3]. This script is quite stressfull and set some high
frequency without checking temperature. This can result on behavior
that whould not occurs with the real cpufreq framework.
As Maxime point out I also tested with cpufreq-ljt-stress-test
(found here https://github.com/ssvb/cpuburn-arm).
This script doesn't trigger any issue.
I also test that that offlining CPU0 and doing DVFS on other CPUs
works. As CPU regulator is only set for CPU0.

The GPU devfreq was drop as the regulator is still not properly
drive by panfrost driver[4].
I will re-introduce it later.

Ondřej Jirman has an Orange Pi 3, Jernej has a PineH64 and a Tanix
TX6 boards and I have a Beelink GS1 board so I have enable these
boards. But CPU Devfreq is really touchy has it depends on:
board design, SoC speed_grade and environement which can affect
thermal cooling and have different behavior for different user.

If people can test this serie and give feedback, I will try to
introduce this in LibreElec tree, so LE community can test it.

Thanks,
Clément

0: https://patchwork.kernel.org/cover/10815117/
1: https://megous.com/git/linux/log/?h=ths-5.7
2: https://github.com/orangepi-xunlong/OrangePiH6_Linux4_9/blob/master/arch/arm64/boot/dts/sunxi/sun50iw6p1.dtsi#L345-L517
3: https://gist.github.com/clementperon/55a055dae3f13bbd14fb39c0069fe2e2
4: https://patchwork.kernel.org/patch/11486893/

Changes since v2 (thanks to Maxime Ripard):
  - Change Orange Pi boards to Orange Pi 3
  - Change soc speed nvmem node name
  - Fix device tree warnings
  - Drop GPU opp tables

Changes since v1 (thanks to Ondřej Jirman):
  - Remove Polling thermal
  - Add Orange Pi boards
  - Remove minimal voltage change for Beelink GS1
  - Add ramp-deplay for GPU and CPU regulators
  - Push to thermal point to 85°C (Allwinner set them to 100°C and 115°C)
  - Added 1.6GHz and 1.7GHz to OPP table.

Clément Péron (6):
  arm64: configs: Enable sun50i cpufreq nvmem
  arm64: dts: allwinner: h6: Enable CPU opp tables for Beelink GS1
  arm64: dts: allwinner: h6: Enable CPU opp tables for Orange Pi 3
  arm64: dts: allwinner: h6: Enable CPU opp tables for Tanix TX6
  arm64: dts: allwinner: Sort Pine H64 device-tree nodes
  arm64: dts: allwinner: h6: Enable CPU and GPU opp tables for Pine H64

Ondrej Jirman (1):
  arm64: dts: allwinner: h6: Add CPU Operating Performance Points table

 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   9 +-
 .../boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi | 121 ++++++++++++++++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |   3 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  41 +++---
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     |  13 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |   4 +
 arch/arm64/configs/defconfig                  |   1 +
 7 files changed, 174 insertions(+), 18 deletions(-)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-cpu-opp.dtsi

-- 
2.20.1

