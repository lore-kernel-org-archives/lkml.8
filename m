Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E237C55194
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8E02071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIyo/Bmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgDZME6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgDZMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:04:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88586C061A0E;
        Sun, 26 Apr 2020 05:04:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so16387229wmc.0;
        Sun, 26 Apr 2020 05:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FIu0CKz6K8bw/qZHzUU/qulO7p9niPo12Ocs6dso3A=;
        b=nIyo/Bmb96CC41r6Cn6/hrDqIswZRgvihoA+YRaXmQpSvcBkYcnyPwLW2/6T5WF8io
         cXrL4Rm4RhQh3end54PK+wBCPqD5dSt3wcuYZy66eNomHHqXU+j4bTqcRRyJZsjAxy2Y
         9ooxBEr9GdYVuHV5/MFH/p5LnjRA8cb5ujnTdYt+JfpxuwX+qo1YxKZoxOD3aWnAzGnL
         yyRD4lmWbx2EL+XvU+IhUtRQve3Rlwc52e6PE23EGibGfmAd9IJdEcW/7KAldSYOE3zE
         FPxYcXB6fwitkkAFGF2T1ltqCuMQrqN6fUeFmF9UKzFnxEbN2gp4YF3PtoYNjOMOJ0d3
         DqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FIu0CKz6K8bw/qZHzUU/qulO7p9niPo12Ocs6dso3A=;
        b=nxgk1BEdRavuIQ5gaid94e4WEv/jvo7F4XDWzyEL30Cj9PwnLHSSmfHfv/HoiHGQuG
         3yivuzgusy97EH5oPVqWBGFFFNqDRj2C/YvmADUwU1TOE2NKUa7dQV05+kaVDXyYLV3b
         d+iwQlmMkQqXlIywJsNHfWur52yHJq/oBTlXRqYlXyCa7kXVZDCcy6IxHtAVhEb04nyq
         yl/p7NMcVBMCy1acDGG4y4W9U5i0kDrClYJz+pK3T7MX7yH/NvLc+RsexwmNuGiaIMRA
         l50wLzUsm9prBRvOwbl0UAt7JF0gbvgTw5pX9SRMQp0z0fgmnoCrZnSboQw+flC1mbvo
         1jUQ==
X-Gm-Message-State: AGi0PuZPnLd+4vUEgEG67UrZFNKUqBUydkvV4g+crWS/OQrUgnHMYB7i
        YNXHxviqBonG4E8vgVYQXTU=
X-Google-Smtp-Source: APiQypKbb8aW5E+I7IyMgkie3hkD0SZYHTn0fzk6KclUGwkr2OlHTf3t7+jC+BpE8W2ywJWC9lgZ7w==
X-Received: by 2002:a1c:6a0b:: with SMTP id f11mr20743750wmc.123.1587902692186;
        Sun, 26 Apr 2020 05:04:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id s24sm11120026wmj.28.2020.04.26.05.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:04:51 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 5/7] arm: sun8i: h3: Add HDMI audio to Orange Pi 2
Date:   Sun, 26 Apr 2020 14:04:40 +0200
Message-Id: <20200426120442.11560-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426120442.11560-1-peron.clem@gmail.com>
References: <20200426120442.11560-1-peron.clem@gmail.com>
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
@@ -144,6 +144,14 @@
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
2.20.1

