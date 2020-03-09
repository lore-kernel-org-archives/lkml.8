Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B2C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D0D20674
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIEHJnHD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCIIQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:16:11 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38396 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIIQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:16:11 -0400
Received: by mail-wm1-f67.google.com with SMTP id n2so2071654wmc.3;
        Mon, 09 Mar 2020 01:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=21vOxRxDjKqcfrgbiaoQAsuWSgoqLHAftWopA3ShZhI=;
        b=oIEHJnHDukzw19P80JbWF7J3wp/aDWOpD/frO9t4Av3oqEH1wlFFAKDwbw7ZxK5hdt
         ovZKGRwTYKxENfkzlsCflHhjRJ4uX/8hyJ23ArR/BuaB8zyE6Cf75hA4tG8vbaPg4F7N
         al6blJrPk47C5cwgWlf0P1Z161QWjiy8iJNQJsFUYPwA0O1iGNPleIa2v6YiWjF8aBN8
         RhxEJz5dnfzgjMNqzmqAa4P3iIAo8yhtt2aukcdDJeYAxHFGO5G1RvJCGbCPfnI+4Jf8
         V+GY5ch26FATDwdb3BTivgWx+EFi2pylYXY9MD5vSng24iNw1EsUbZVLd0SgBsVW9njh
         DEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=21vOxRxDjKqcfrgbiaoQAsuWSgoqLHAftWopA3ShZhI=;
        b=pAaW79Z7f2uVn2kt24QBKVtipy590hbd0jJPlGaZIne8XibZQORwhEmlw2Ql8nqUKz
         Q6E44vwmtvhwFyVkjwK/bGPNh06qVbe/ZqMjM9/eAjWmDzY7enRrF3A3AlN0H3ZCl/1L
         9e18i8D3IecgKDGqv3TDKMTbV6OfOlwTaoiRyt+5MO5R0nmZhEacuqvk+DHmABgbNBSQ
         y+0GwA299bc1DthUgmXorGlvMBC7cpTcKU9P90yj33P5eGdiTudy2KIq+vG3kh7BJKWS
         oPBc/djz2aRaATAOxMNNPFqvaHZbGSRs5g5Gh9oI1CFhkPEqxgnJkQkHQyH+CR8MVzRp
         xVnw==
X-Gm-Message-State: ANhLgQ28s0AVFne6Okq4V5p0qgzJ+yPeoQWVjve/bNhB66aAiyssynCr
        /NMaWKl0Zhq23DzsqtsPsCA=
X-Google-Smtp-Source: ADFU+vt3Yqf7ZPutJlxBROOJKc49aGfr7tYraWP+grvURFzG5aqwAEF03ai0VObc3auLb7YasfTsDg==
X-Received: by 2002:a7b:c770:: with SMTP id x16mr4736819wmk.159.1583741769115;
        Mon, 09 Mar 2020 01:16:09 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q2sm1097096wrv.65.2020.03.09.01.16.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Mar 2020 01:16:08 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: remove rockchip,grf from vop nodes for px30
Date:   Mon,  9 Mar 2020 09:16:00 +0100
Message-Id: <20200309081600.3887-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An experimental test with the command below without
additional properties in 'rockchip-vop.yaml' gives this error:

arch/arm64/boot/dts/rockchip/px30-evb.dt.yaml: vop@ff470000:
'power-domains', 'rockchip,grf'
do not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm64/boot/dts/rockchip/px30-evb.dt.yaml: vop@ff460000:
'power-domains', 'rockchip,grf'
do not match any of the regexes: 'pinctrl-[0-9]+'

'rockchip,grf' is not used by the Rockchip VOP driver,
so remove it from 'vop' nodes in 'px30.dtsi'.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/display/
rockchip/rockchip-vop.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 215515ccb..1bbed660f 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1030,7 +1030,6 @@
 		reset-names = "axi", "ahb", "dclk";
 		iommus = <&vopb_mmu>;
 		power-domains = <&power PX30_PD_VO>;
-		rockchip,grf = <&grf>;
 		status = "disabled";
 
 		vopb_out: port {
@@ -1072,7 +1071,6 @@
 		reset-names = "axi", "ahb", "dclk";
 		iommus = <&vopl_mmu>;
 		power-domains = <&power PX30_PD_VO>;
-		rockchip,grf = <&grf>;
 		status = "disabled";
 
 		vopl_out: port {
-- 
2.11.0

