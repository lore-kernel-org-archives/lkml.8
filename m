Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ADEC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFEFA20890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI4QP/0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgGDLjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728163AbgGDLjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09F5C08C5DF;
        Sat,  4 Jul 2020 04:39:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id o11so35448804wrv.9;
        Sat, 04 Jul 2020 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=RI4QP/0XowcZZZEDfaP14OZ79HPFwfYVqgUSVRFlOnoryDvXSQafpUzHdc2WU6Kw4t
         XVuI6DZmX7EW4EM3aG01vz5tdAdgmTZqrZSfO6KNeGEZX21l7HNbqjtqvZ4ecB5AGe9s
         bUzUX9U0y67YXncfQGuqiJ7Nmut7udl6JMkIMDF1cYPDQdHnauXv7wUf6bC3VTytZrEz
         Lxwp/KCUKCW+I518HMSD+qxajA+fHvvdawHodcY4Ug6s1IQ3tCuVrAVqxUP2+PozffUr
         fSL2k5nS6N9tCRmTcTvVP09+EgrXSSaB76cSXcyBHBcRHPWQ1oYGTJhhYXyER/CMkkL1
         vmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=X5HkfNJeRDxcJKLvixPf96gap1rX3WdNGSRmTMl9f5oyLh2/YvjUbnwhxL81Ov5mM0
         kQeMLp758GQCog9UYxQvnypl86W9xDyTtTh/OGG38yuCsSn35VUMHO0NEUEXzrArRFAc
         LuBnA1jEgvui/PA7tiG7h7TpnqVckB/X5/5361XCLxnzb2nir38AVmuidmLu91ZBOuKK
         P0iwD9Hz297+a0bna3B2SQtSgv4ly76KcmNY80zQB8x6vBBPfO0v7qx2BRzSb9jsUA96
         AVFw7bPiZb6f14MVi0Prz9EXqwaaPivm62idXGeNiQ/qUESCPsQ36rjLP0zJy73c6cqT
         OiJg==
X-Gm-Message-State: AOAM531761uAljsXlN9goE0UQGWdz05TxtCNrkZayjm1ucSYWt5jbfp3
        23UndkLPR8MM5jUDIQke72Y=
X-Google-Smtp-Source: ABdhPJymBfXZFsmvWSHG5QSNMx02/m8Q0qDAvFCTHckrezx23s/7LON5l3N2fWHpcKtWyxY8Kl7msQ==
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr39545017wrt.119.1593862762417;
        Sat, 04 Jul 2020 04:39:22 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:21 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 14/16] arm: sun8i: h3: Add HDMI audio to Orange Pi 2
Date:   Sat,  4 Jul 2020 13:39:00 +0200
Message-Id: <20200704113902.336911-15-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcus Cooper <codekipper@gmail.com>

Enable HDMI audio on the Orange Pi 2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
index 597c425d08ec..64e8e2829f27 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-2.dts
@@ -144,6 +144,14 @@ hdmi_out_con: endpoint {
 	};
 };
 
+&hdmi_sound {
+	status = "okay";
+};
+
+&i2s2 {
+	status = "okay";
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_ir_rx_pin>;
-- 
2.25.1

