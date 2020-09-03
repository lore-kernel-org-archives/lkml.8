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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33741C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1662520722
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0aIAKeZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgICUcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgICUbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:31:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FEEC06123A;
        Thu,  3 Sep 2020 13:31:02 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e11so6105693wme.0;
        Thu, 03 Sep 2020 13:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=O0aIAKeZyRNk7s9q8EZqQBEC/clHIDc8DdK7q9xpLt4BdmEh5sK9RmICcgAEITQigF
         IjzCcyi0HtNrESluB8FrQS36PWGA5qUgjamBvc35j2hh37RYxg0PF2EmgMxN9mkRbx1s
         hRwQ8y+6iMxrUOduNrhX6aTGkgSc+663j5tTNlAc7iM+rF9afhNH5cpkOxfpN8YaAV2j
         FynxtTlWPmvEJ39aOTTFJ4fBbGrkDWP3xbKsZt2H07yOzd4zkA4zc+yemiP90EkDAVfj
         gmV6c/KRgxIMO8mM36+4DOG1gfa+YTfswGvilmcURlve/J41Jw0OqFq+N0XOD4SE4Yis
         VNpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=ag02h4XSmUWohJh0ZMKm0xFKTj+I1uANiMVtlSoFK4vkfvRZMtX+JC+CYjGkxtBkss
         539nOk6ECaWfuJiPQrhPOgBu44FiSDKSKigA4UTeIB+lkC3Mx9oWddNUVQ1SJzkVk4bF
         ZPaE8nk6On/pnVMbq69sn/QGOJj6KfwEtBC+ImCI4Fgu8AdnW7wMEQlmvvCpcIyCG71X
         vsbYWTE5E90cDrUlSS9LxWlDmqA0pt5vDPb+/4OlOCqBvEJNbDVsoIRQ1KhifkHeYQKP
         lwlwZulIh0UhK+/WPI/9dJyBrKpP/wTrnDQY+JZhKWKq7xKV3rD1nItssyaFVPvOqVHg
         Wq7w==
X-Gm-Message-State: AOAM533C3kDRV00k60B6GW1pjzO8Z1pcUVJf/9kBzN0OkWeYLHmBCJje
        YPJD8wa3A3t33cEAVfHHjSI=
X-Google-Smtp-Source: ABdhPJxa1EVUcgTCV2q8x5mnFjfUNgDGgjSILnbXs8nPpEpQiRI50TKDBegx1b73F86O67npyqTcCA==
X-Received: by 2002:a1c:8003:: with SMTP id b3mr4498954wmd.121.1599165060920;
        Thu, 03 Sep 2020 13:31:00 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:31:00 -0700 (PDT)
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
Subject: [PATCH v2 15/20] arm: sun8i: h3: Add HDMI audio to Beelink X2
Date:   Thu,  3 Sep 2020 22:30:29 +0200
Message-Id: <20200903203034.1057334-16-peron.clem@gmail.com>
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

Enable HDMI audio on the Beelink X2.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
index 45a24441ff18..f9bec6935120 100644
--- a/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
+++ b/arch/arm/boot/dts/sun8i-h3-beelink-x2.dts
@@ -142,6 +142,14 @@ hdmi_out_con: endpoint {
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
 	linux,rc-map-name = "rc-tanix-tx3mini";
 	pinctrl-names = "default";
-- 
2.25.1

