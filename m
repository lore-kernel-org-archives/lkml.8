Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4C5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AADB20890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEzPlgsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgGDLjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728167AbgGDLjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:25 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0097BC08C5E0;
        Sat,  4 Jul 2020 04:39:24 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a6so35436876wrm.4;
        Sat, 04 Jul 2020 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=nEzPlgsjcg8TByHn1C+qEUDkohx5ASytPn5nARE3P5jp1RlLAap0qoF2tksdXKE5mF
         zCvOBIHPewVwWvPkuUniNCzwwIZppzy3sKiP38/kR5TRFRYyzL2ZPktCM1K6pIPz0vmK
         VRm7CkHPsmFQxXblNks+kKVp7OFrTVQwtRkkMuilgp2gmQsiR7eG1L95kzN3N2HawTBl
         pIipXNBnZ33YdT+9fq7+qEvE9psc+DTLjtp1cPg9ZFuPDT3LkmZ618o7E+ZLEVuelT/Q
         Pf4wjiKqGkNSODmQQ1D7jb0ev5fXBRDbeTix+kf5/oVIqDWen+0otg7UD1SqU9KU5PYA
         R1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKqv9b9ye6nXeHQ0sv780xJ1tkZxHw2igrPZLKbetcg=;
        b=IuBU4K/vGHT6u4e754x8/eijQ3di8kMQGceywP9OVqXY/Wo3/CY8yhTfJMEKCFMYt0
         Ge1P6ujGDoFfaDclgDhlHgr2RAgiFhK7zDPbYZ7bZAt74/L4OOsfNirhP0L5AaD1+lCm
         sMXEjoOma0Ut6ph7Ca0fVg4l0Xz8wLczWxJePYdrmIBacCJNv9coEcN3+GFsec/uObWi
         iXMDZZsy1rchtFvbPAXT5O4bTBtlBZ1tONl60dCGx441NACsmR6m2Y4j7MD3kuZnjoKh
         z4cJtt1VOLyqwdP+0GuHla8ntuGsz1FbfjNdpeozS0UqnDk5Gpthrv6kWAy9oSr5RSCX
         L6iQ==
X-Gm-Message-State: AOAM530hGaxRotsG8vNE1oCbWBf2SPfjXzZ93wxhywOakhSkAplAX9Di
        HnTr5u5dxPMupi2HBBA+mhE=
X-Google-Smtp-Source: ABdhPJxkbXBecC8xZ3jMYSVWuATOoIm0zg8F41kgzvWYqvmLuAB3pUiqkI1KwEUJaHuj04G4OuoShA==
X-Received: by 2002:adf:f608:: with SMTP id t8mr41463663wrp.308.1593862763538;
        Sat, 04 Jul 2020 04:39:23 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:23 -0700 (PDT)
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
Subject: [PATCH 15/16] arm: sun8i: h3: Add HDMI audio to Beelink X2
Date:   Sat,  4 Jul 2020 13:39:01 +0200
Message-Id: <20200704113902.336911-16-peron.clem@gmail.com>
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

