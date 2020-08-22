Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5522BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 06:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350AC208DB
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 06:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCgaeya9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHVG2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 02:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgHVG2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 02:28:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D75DC061573;
        Fri, 21 Aug 2020 23:28:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so1753905pjb.3;
        Fri, 21 Aug 2020 23:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQI488BrcB8qD1B9NlTAL4gkA6IWdB3NounvZNqZgYY=;
        b=FCgaeya984VKdCM+2KstvfplT8gaAoSerdRk+HR6MksXfxMbUz3HZvATzhujEd+HcP
         3UvS9g94w4a0mIe9M7mB7YSvHT2ZJfsWVtyco7m66/4ipZBEcQ2tbC4D8RcH3uwUJm3K
         kstxXWQCJJKpvklkkdX1/B5eZJeg8Idv+bbKFcwFP9KjOEwBzzEoN2OfiIB1oZFD851N
         RRebQ+l72Y13B2w6cE26hcSvPNoE5v2YfuLyKsWFCHKXDrX6vvYjk0CLOYBhLXYBKaSW
         ll1d1fTeDd5yZkaVmZwNJCJvHe3R4RgVJkDdhnnko7OUe7rZ/IXRN/bPjFnZpdMwpkJT
         VJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQI488BrcB8qD1B9NlTAL4gkA6IWdB3NounvZNqZgYY=;
        b=l7Wxph1tioxt08cSNtOx6CMHtiOA8gi6SqXgldHKaPPuaxJO2cOr6ZIKuWn4Pb8Pzr
         mOfPsXX9LuK7Xa/UKSmRjDXismwguyYUNKmahCKbS0Ngk9qxsfe6snYBMdnqGZUvKVYQ
         K/kuf2TYafPfgKbhddxVE3fmUU9r9BmQWt2M/ANGx7B284VhCl8BCFLocWIZ6zy2Y0ck
         ZuDhiGdJCeX/NcPSCXqwG/ZfTrgam6YRvK6OJmrknjD5kMqAabUQJz3P0oj422YJeHPv
         IvnwAAg7+GmGIshJKs4c1MOSaSYUypHvVgTpPCJDsD8Ql7ltyBlSbg2Ow8eeIuwZrAVA
         ka9A==
X-Gm-Message-State: AOAM531Rj8t4D905mwr4u58RjNIus4mmfP/azZZ4UmWxL4Tvzl1Rw1u3
        Z1oN5OMgrX4TnHH/TyCs/6U=
X-Google-Smtp-Source: ABdhPJyAICcO3t1zkI9mYFDcEnGnYaysRuuM/lOwwTPFccyNqQg9fF+WirMrLf3bJ2TxSSirTnZyZQ==
X-Received: by 2002:a17:902:ff0c:: with SMTP id f12mr5196096plj.326.1598077701802;
        Fri, 21 Aug 2020 23:28:21 -0700 (PDT)
Received: from localhost.localdomain ([67.229.29.178])
        by smtp.gmail.com with ESMTPSA id u8sm3450715pjy.35.2020.08.21.23.28.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 23:28:20 -0700 (PDT)
From:   Qiang Yu <yuq825@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-sunxi@googlegroups.com, lima@lists.freedesktop.org,
        Qiang Yu <yuq825@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: h5: remove Mali GPU PMU module
Date:   Sat, 22 Aug 2020 14:27:55 +0800
Message-Id: <20200822062755.534761-1-yuq825@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H5's Mali GPU PMU is not present or working corretly although
H5 datasheet record its interrupt vector.

Adding this module will miss lead lima driver try to shutdown
it and get waiting timeout. This problem is not exposed before
lima runtime PM supoprt is added.

Fixes: bb39ed07e55b ("arm64: dts: allwinner: h5: Add device node for Mali-450 GPU")
Signed-off-by: Qiang Yu <yuq825@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
index 6735e316a39c..6c6053a18413 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi
@@ -139,8 +139,7 @@ mali: gpu@1e80000 {
 				     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+				     <GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "gp",
 					  "gpmmu",
 					  "pp",
@@ -151,8 +150,7 @@ mali: gpu@1e80000 {
 					  "pp2",
 					  "ppmmu2",
 					  "pp3",
-					  "ppmmu3",
-					  "pmu";
+					  "ppmmu3";
 			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
 			clock-names = "bus", "core";
 			resets = <&ccu RST_BUS_GPU>;
-- 
2.25.1

