Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA8CDC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD02D2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ItYxyQOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgCZRAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:00:06 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:38268 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbgCZRAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:00:06 -0400
Received: by mail-wm1-f48.google.com with SMTP id f6so1289160wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPcQG3YcrnLLher/nefYLUs5pU6e5WyIQ5KkZW8zJhU=;
        b=ItYxyQOPWpfIwx5id98fE1SRSt1cmLdSSkB5lgTxde8+2UMNwtZm5//pKOziYaxWnz
         5+2cxSZCfOm/Co62Re/eJIdbYw4UfCISJQ2pMi7V7cRGerae+khQtC1Bo3N9/hZHeZp/
         N1YngF5NBPAEdGTHZqox/NF2I/0dggkG4WZryMZfzh4I5ajCh2CCnnIu6z+/AobO9p/G
         44CoqqYhll10X9SV/1enmd+rZawXZj5Mdu3oqD6lHfInBkUUA2kSWF7CpX4lEamLaNsR
         8IX3ET6Q1k7H6h0n7Oajtskuu64CrCp4+N5DCG78KzSUb3AHa0uJ7xIE/ngHqzhsoaaG
         q//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IPcQG3YcrnLLher/nefYLUs5pU6e5WyIQ5KkZW8zJhU=;
        b=eQYyh/8RBKcdIXBmdXarbITF/8hd4ZMqKgCmeQHr8AKj8L+FbyF117N0fMJRg6m45C
         LiggEfDwOdKrSBDpaTnoPwOcr0l4AK5b8oVowfoIyGhtx+AvIY/6PddcBDTsS5nTawcE
         B467Hbre27hNd55F7Nrf9RYl5QnBwPbiWXaLrLyKgamsFSNmkj3rXApwFxTb/HMKLplC
         8pwUfiqb9S4TV4k6nodi1cnXEogleWnToQc+5lFhG8Q751aCEU2lcKIjojfuFreyNy3Q
         dMvUqXv4DdT9IQni/Aw0xfEmk+ftHjJDd71Cd1GLVJr8pZoMA0HusLbb9cA835uflS6X
         f6nQ==
X-Gm-Message-State: ANhLgQ1qWPXRK3AT0qIu10sP0FNQ3KiyaKZsG4KDkbMZe32WLY5qprbZ
        Bq/tdNTUwGY2BF9m+zRZUW+FxA==
X-Google-Smtp-Source: ADFU+vtnT6Qi76wMfnjs4e0l9MJUiPRD/pUzToCuVWV2nVYKoGqgcAcvwfcWiAoDJIJIOj62HUDmQw==
X-Received: by 2002:a1c:408b:: with SMTP id n133mr819774wma.182.1585242003353;
        Thu, 26 Mar 2020 10:00:03 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id r15sm4609823wra.19.2020.03.26.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 10:00:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/5] arm64: dts: meson: dtbs_checks fixups
Date:   Thu, 26 Mar 2020 17:59:53 +0100
Message-Id: <20200326165958.19274-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another round of DT fixups of dtbs_checks on Amlogic DT files.

Neil Armstrong (5):
  dt-bindings: sram: Add Amlogic SCP SRAM compatibles
  arm64: dts: meson: fixup SCP sram nodes
  arm64: dts: meson-g12b-ugoos-am6: fix board compatible
  arm64: dts: meson-gxbb-kii-pro: fix board compatible
  arm64: dts: meson: fix leds subnodes name

 Documentation/devicetree/bindings/sram/sram.yaml       |  2 ++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi             |  6 +++---
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi              | 10 +++++-----
 arch/arm64/boot/dts/amlogic/meson-gxbb-kii-pro.dts     |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts    |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi      |  2 +-
 .../boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts  |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts     |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi     |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts       |  2 +-
 16 files changed, 28 insertions(+), 26 deletions(-)

-- 
2.22.0

