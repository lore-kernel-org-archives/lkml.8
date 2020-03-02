Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462F7C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B045246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehow4vu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgCBHpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:45:05 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36876 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:45:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id q23so10606286ljm.4;
        Sun, 01 Mar 2020 23:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=5p7zJr0xKI0vCUUOTcHCNVe4S/T3X0b9SlsPBN2yTzQ=;
        b=ehow4vu90D6zdQlrC08Ydu2TzhYin/mPzAtpOekZKKBQivIp/5rDao00o8W5rhMlsa
         Ks3yCbjNRGWfcF1z/5zmrLlNu2vOuCUt/VFLyp3QJoL0N2iGdS286lWWVF1hBR06BwUL
         54gWuli+mlpv+LZ40r8IAXyLvkpH5gm/qnOsyjnDM0bCTWzpQu3gAhy5fg6hAw7Caf2F
         ZdFWhwj4JnUgEe5v4nqBSHSJgippG+hC4mXPeyVOIPbM5Nw4ZbEEPB2YRl6kA9I/Gmv9
         OZ2alNqk/ivcTUy9UrTZZsQGgqvht/4qPLyK1KR4M5BJtDuCWuAR9RNcnf45xIbcgwxw
         +RiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5p7zJr0xKI0vCUUOTcHCNVe4S/T3X0b9SlsPBN2yTzQ=;
        b=B43Sd3LoY+kFOHL5jhKBs3B0Nb1bHtFbbzBKnD1fOejZZGGV88KffBb1m5iEY29ex9
         abyfZgqH5RxCvjScgxqSNTeGZEi2nhKQsgpuQ9PPlUYPeTn9bERau5XhONYTHwyFLCIQ
         +2nrN8kCjLTrTZ6otF+w1E8o0ZKxk2cDyebBRsuj26wDcTkGr6QqtIXBQuKoarVcmeZj
         ufWOI6pNkhfCE2AeVWBmkDvSkrJxL/GiDia6lIMBgH15IDqsKGP87t1NlDjc9dRau3NP
         dvVCusKw/v3w3vkl7C3lYd9+jGcL8A89U7RUzwZe/biaDowVEeuwVcDTW4z8rUpqoevp
         czTA==
X-Gm-Message-State: ANhLgQ1fkn/g4aLsWZ9fZrv39OHOb8ZUdK+ASCuTnHIUmth35N2QeymH
        k7nhyd1P4F3NXgy/9wYHEUg=
X-Google-Smtp-Source: ADFU+vtCf2T5IdyiTy3s+QtGxhzlCMHPIlG48KMdBxo7gv9WDaTEyFyWSelWEQK+deNOUUF+2srYvg==
X-Received: by 2002:a2e:5357:: with SMTP id t23mr10436559ljd.227.1583135102251;
        Sun, 01 Mar 2020 23:45:02 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id d9sm9862806lfm.16.2020.03.01.23.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Mar 2020 23:45:01 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson-g12b: fix N2/VIM3 audio card model names
Date:   Mon,  2 Mar 2020 11:44:11 +0400
Message-Id: <1583135051-95529-1-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is largely cosmetic, but Odroid N2 and Khadas VIM3 are G12B devices so
correct the card model names to reflect this.

Fixes: aa7d5873bf6e ("arm64: dts: meson-g12b-odroid-n2: add sound card")
Fixes: c6d29c66e582 ("arm64: dts: meson-g12b-khadas-vim3: add initial device-tree")

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
index 5548634..b1fab57 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi
@@ -48,7 +48,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12A-KHADAS-VIM3";
+		model = "G12B-KHADAS-VIM3";
 		audio-aux-devs = <&tdmout_b>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 0e54c1d..8830d38 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -208,7 +208,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12A-ODROIDN2";
+		model = "G12B-ODROID-N2";
 		audio-aux-devs = <&tdmout_b>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
-- 
2.7.4

