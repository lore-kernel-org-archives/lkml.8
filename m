Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C856C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCB820678
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5vk9jAu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgICUi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729447AbgICUbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD70C061258;
        Thu,  3 Sep 2020 13:31:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so4132585wme.3;
        Thu, 03 Sep 2020 13:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
        b=K5vk9jAuMg+7u4ZOKCzRhzqDjr3f7Qc8HprHbYh4Y+5TVknoECOVpj0q2LEw4rSYUw
         NFp9jVoFOx/WNltsI3+i5YlWvLBV5wYXhf9KTrXPITe4lMKTvJRHCEoXF2NPPlEbF/LN
         RNK3E3jc5Tcqp5tp7CrGybxG7OuPpGXQXBB1pkmzjHGxrsDQuFSMAXn61NxGqKLHdWIv
         TU46VFL1X19Tg4phIRMZIDRBn6jO5c5QrlSuLDcFt5wH7GEBcVHIGEXO1rKRMTht4F39
         16CfA5wDD3fdRhnmckByJn3bRx2LocdtnnVDmxB68FD2p/VVXhAFZnolcAZuqngmEziB
         pcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRfXBGFiqY7c/El7z89zWfrRGF9fF+u62x7PKZnaUzI=;
        b=HxOTFdUzCZzSRqdlLC69OXT/PxcWHOLZbO2qwrIjoJ/8oE/pDljtzmetr1GxbIykV7
         xtmTkBfmZSzkSU/8kms+KlZKvZc0yXBv51o27zMtO1AFEkcWqT69RoQ7RWe97/YaeIsJ
         um/dVUGAKQjjE1218TNxBq3iJrbKv4R2nLDswTjpSd64pJ6vMRYFz1f+aWqTkS1K7Rum
         bjjiq/u7qwRR21DF9O2GoS50bzaBip7IybEF04D9/DgOn3r5Ji6laaCBN5sHi0rkx7ya
         p5EmcUTmcwkOnBVjsIB6QKAQGm6Y8t2iIv9mwcKCqqPtJM/7CJ+2M5cUh79X6IvckEJN
         Xdqg==
X-Gm-Message-State: AOAM5319hUw5QIqe+9nKXdm/oGsnvJFjtpOkEL03REfatjHffNHI2GWE
        WigpxArfeKavt3G7aD+cGCw=
X-Google-Smtp-Source: ABdhPJxs+lMWm9287ep2HEvwgo5E2HLax3EG19m3cXREGOmgBv7K/F0wW+lCpLavoAx8uLTvvIBc2g==
X-Received: by 2002:a1c:bcd4:: with SMTP id m203mr4202979wmf.75.1599165065932;
        Thu, 03 Sep 2020 13:31:05 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:31:05 -0700 (PDT)
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
        Ondrej Jirman <megous@megous.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 19/20] arm64: dts: sun50i-h6-orangepi-3: Enable HDMI audio
Date:   Thu,  3 Sep 2020 22:30:33 +0200
Message-Id: <20200903203034.1057334-20-peron.clem@gmail.com>
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

From: Ondrej Jirman <megous@megous.com>

The board has HDMI output, enable audio on it.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 15c9dd8c4479..193587e78031 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -128,6 +128,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s1 {
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.25.1

