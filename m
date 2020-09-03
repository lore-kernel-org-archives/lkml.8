Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B6C2D0A6
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CE1320684
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WyrthnaZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbgICUjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729390AbgICUbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC38C061233;
        Thu,  3 Sep 2020 13:31:01 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so4567558wrn.6;
        Thu, 03 Sep 2020 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=WyrthnaZYSFEr7XddYF7H50hOI5GPE+Pd6cDfZvu4PnQF0Psq5EF8p+RpdbuBXkK+/
         ia3x8aYxZm6VnrBWzUiTkhyelVCLcQW3ICV9JNF8XvdMaiJwwHeUBWuBZxOJuJyXQIVn
         HhvWKkZ5sWEyp98yw1kWt3E/1d0jRChRYpYnldSHC+UnvXRdQ/I4wol3ON/0QxcN94TY
         dyWN2ySMCsNUQW7ZFFHhOcReTI+ZP8TrNDygFxNr3QQiEKQ15O0+x7qaxJsPfuU2T5/0
         3FuDrAg/+zCRQcmevfiqKs+bir8srVfRPxrJeSaYahVPrXe5JLRwdukunX2sHHpszb16
         b3zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HdI15SBEuyVNQNB+e23d+K5pgBDpyUoqfbF257aXR4=;
        b=jR06hg6ZUXfObAYDGz4HXsg8GSjkI6LFsDISht6Jaoiyyx9VI0ml4sA3MPn74PQLAK
         OomA6U6Sw5GqIY5fVfggZNVbefQyIQaKjyE4Y4+AZ9fqLhCnq88spoofbYvCuvWyYvdZ
         mudVwX+phoP9UbWZQnmToGZI0XUsgcQDSQOGC/U0Z8W9WSZjCBtlkmT74N/wSEvzD6YG
         lja+E7jFS9hvpuAr7gb3BBsB0rB/PjICLYs68a6xT0f9Cg3WI/nPj7nr30o2dm0JtlG/
         TLl8Bc9Y+tuo7Zl+5APxlvLNXe1xuufUpzCpS8qk7RNNvLvjkXpBfGJVWGgOKOZTlqNH
         yFOQ==
X-Gm-Message-State: AOAM533aCgD6Sc0jtntN9RS9dkpMEurRZsEjurmpczAY/77scl6/1tI4
        s83ToEJPHXqGqCgMxRXBep8=
X-Google-Smtp-Source: ABdhPJyRYKqLTYuj65U35HowZN4mMgwJQgbTH6FKusmQCLCKBfVDNA7p4bBA6gxOvKQPOqkec1Ho9w==
X-Received: by 2002:a5d:4ccb:: with SMTP id c11mr4175622wrt.159.1599165059655;
        Thu, 03 Sep 2020 13:30:59 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:58 -0700 (PDT)
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
Subject: [PATCH v2 14/20] arm: sun8i: h3: Add HDMI audio to Orange Pi 2
Date:   Thu,  3 Sep 2020 22:30:28 +0200
Message-Id: <20200903203034.1057334-15-peron.clem@gmail.com>
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

