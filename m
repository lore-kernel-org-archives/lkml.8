Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202C6C2D0E1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E17F1215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OL+plDQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgICUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgICUbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:12 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EF2C061244;
        Thu,  3 Sep 2020 13:31:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so4134457wmi.1;
        Thu, 03 Sep 2020 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s1wxiSXb6FjGblsvKrZYztMSCVGGVQHB+0DmuQ/lyxA=;
        b=OL+plDQh20KZVwoejg2KN9X8Hq8GnRM55YHAPi2BYf4c8ALvLa7S3EudTejkposcwT
         eMojv4lnaCgJ+oxKEaQQPQ5jdKhnHG6ScRtydzpzxok6b3Y70tWKSpHJ5rdil5Av/p1L
         CWnagXRlwS4nPowKltK66LMVDCtEa/1CgxCuC09qMce/jwOohzIoJLXv/gy284vD6YE4
         9rK+KuZMkHvR8yKRw7UpNyZAeyiBFpzF5tFtJCSNKcBvW4Zj843GrYfySVwBOwdqT3Q/
         GSdSHcBx698Y6NltRrlmRAeCZzY0Jcpnl07q8IS9WvnXb4Xg8OLk5HRSTarBW1pRgpOI
         i2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s1wxiSXb6FjGblsvKrZYztMSCVGGVQHB+0DmuQ/lyxA=;
        b=IeD9Lshkejhskn2Gk6w1pMHniKOLCrt5wJ2m0bxGk2I0zKomKIWtGXC3u8y7if/2/A
         un1bZoiPHGsdzT0vu/MtmJyLX0/PCNtZO0OENOOp+8MmV6bfi/+/FpqP8JbaHtamT/Cs
         iP8NFDtp2VUt4SExKLDc0UuQQehL6i5G8ZoHif62kLT5xva8ii8wTVTPmEDN9CP15As8
         GqqNu67ygK/+4st/KiZfmZ1hRfg3NNziMe/FVE8vUXdOFj+YjECvTYdMDF2vJYTr2M4s
         Psv+HU3t5AZqyo5CaLPRzRQokQA71UKc5bbz5pf7dcTAKtq8GsVC8Gvriino8mzDEf+f
         tN1Q==
X-Gm-Message-State: AOAM532zXtPZVDXhKbPLyYeVd26TktxOaTOfQzbq2CyYIyeqPuOb6Ai7
        liNrqjiDidFlfpHdmPWYXSM=
X-Google-Smtp-Source: ABdhPJzkXCUBILkMkPYop6qSrxQHWedhn7UttMrdppk/1h8lrO7MVqPiA9PFSyj4oQrk9Zgvnb+jzw==
X-Received: by 2002:a1c:f30f:: with SMTP id q15mr4187654wmq.60.1599165062201;
        Thu, 03 Sep 2020 13:31:02 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:31:01 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 16/20] arm64: dts: allwinner: a64: Add HDMI audio to Pine64
Date:   Thu,  3 Sep 2020 22:30:30 +0200
Message-Id: <20200903203034.1057334-17-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Enable HDMI audio on Pine64.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 2165f238af13..c5939ba52f19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -99,6 +99,10 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 };
@@ -107,6 +111,10 @@ &i2c1_pins {
 	bias-pull-up;
 };
 
+&i2s2 {
+	status = "okay";
+};
+
 &mdio {
 	ext_rmii_phy1: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

