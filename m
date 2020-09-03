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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B542FC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947DA2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AofMPUlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729645AbgICUlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729311AbgICUaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB32C061246;
        Thu,  3 Sep 2020 13:30:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so4529388wrn.13;
        Thu, 03 Sep 2020 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=AofMPUlqcs0dd76rChwiMRdo55Jcj6y71Rgpbc1aNwUqPS7DJdK51GnxB3YwpAb3NG
         XtTZ5r4ef8N99rsLokQQfNWhGMHgv1hPPsvOKTAjMhGYLZFjBpS8pyEFV/Go+VCyZh2N
         XriN57ox1KygKYA7FmKA6+iR/Yd6Jcp5WL0f1h5lPc1uFbng6IRcCtbOkiH9tUbnt0os
         ZJcUA6vMaY2lWQnz443ZTh3jmJTIy2+s9VKV6ZojBHp04MTpQo1ypxsAvA4r3WcX+JIL
         9/QLQsAdGvaLC1VdhzQ7PeDD20Uewfys34XP3q3m1Gw8oY3P68FB0TCMsztZSGAFEEVZ
         1mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x/iq/UaybIFP5fVA6Ln+hpouuRJu9kADukrtHp3BLVg=;
        b=Osvc8ktqkNMJHhtFgZT5OV3t+WUYPMcefxGVVOeC0/FszQETyhhrZuphoqN0xK7j9P
         lsNacLSQH5UwO7C0p4b7pum8GI82UpmSPKJ0VXuGl1XziIleMvajFGMzbazG/6kl1i78
         77gLCW+k6cVK3sNIRuZRqIFsktWaCbeDQJ+METkweUBZjt6APQ9/uX7rHRXLAYkAGSmW
         w1dXq59n0/FFOzqpqDp7YX4p0sM/a3ZiuDOu/znLH9FBAoAJ2HhCer0215kN2+uKYwf3
         HaiZoAo73io2dosAot3U4qSB35s/DMX2dXA3UPdrfnbia55gfJphkSHcoitutsLdWhBm
         Db2Q==
X-Gm-Message-State: AOAM532MXZFyBeSVpjcAYy7Tw1TJDYqS9yTcJxMGYrRc/NOr25sUj/pQ
        8seCad2hSbhEKIphgv4m0ToYmvGwoFYu1g==
X-Google-Smtp-Source: ABdhPJxM+s4BW/s05DxzE1Osvppd5Q7WAI8huiPFbLd4i9SxR7Berw2c2tV53IyuNTsJi9Q8xKfLAA==
X-Received: by 2002:adf:91c2:: with SMTP id 60mr4577028wri.292.1599165054048;
        Thu, 03 Sep 2020 13:30:54 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:53 -0700 (PDT)
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
Subject: [PATCH v2 09/20] arm64: dts: allwinner: h6: Enable HDMI sound for Beelink GS1
Date:   Thu,  3 Sep 2020 22:30:23 +0200
Message-Id: <20200903203034.1057334-10-peron.clem@gmail.com>
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

Now that HDMI sound node is available in the SoC dtsi.
Enable it for this board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 3f7ceeb1a767..049c21718846 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -118,6 +118,14 @@ hdmi_out_con: endpoint {
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
 &mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-- 
2.25.1

