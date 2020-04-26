Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DC6C54FD0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5030F2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 12:05:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pShhOnlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgDZMFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 08:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgDZME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 08:04:56 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99870C061A0E;
        Sun, 26 Apr 2020 05:04:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v8so13717741wma.0;
        Sun, 26 Apr 2020 05:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9HRQH21sjnH214q9XNZxwKqQbpfMImzTXqPykucLUEM=;
        b=pShhOnlmWPoYXwtI7svu9Gkn0lqpZ/bj+bp16sYHcB+J+6SmDLIQRlOrmx4nwK47Hw
         8yz8EbV0XefUllxTBINE1PMV4qLftxO4nM+zHMZnKL+08QyomXVyHUahRjowx3eHauqi
         uKyDYgBlZbQ8vzvyL1B3ouK2g4XCsMM5mKbAG15z5Ty3sMJILGNCrYuTIKOwSLNXZdjy
         KONr5WZDL65AtDYUeydesSkCaajICba6JguBf8HULRHgUa0nxp9yX+Kepc45irwEFEHd
         76e1uZZbiUWjh3/xsYjw1yYhkIuzKaP2CAmAynvOcbOQiDB+58JJtueKVBid24A3RZrq
         pzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9HRQH21sjnH214q9XNZxwKqQbpfMImzTXqPykucLUEM=;
        b=tN5EqmB6gT04Uv3nIBE9qB1wz+VXKlIQBXhNn95XbJnaaTWJ35kc7aGY72astUkitW
         CafokKpTJyBJVDetZXYhIzjMjSpIfE/15Xgqgk2qlaWow/oRV7dj97N/LLGSjvQfv+lp
         Ul4SziuUmPUglLcqZ9ovKkQAB0/MX+tNOR3YjkDaGGXKCTteIMkiP9q3iF9KLG3GSb95
         taEEzkhCRc13AbmpNIPGraicPj1/ugeYpTcr7tSqF1kHSVEHxGZW31uqPEBc+Aor/+9k
         TDkeEIAlAQiqrwEoGfEGBlUvEXXBnLxanxM0lhfseZq1631wRCqukuFIKzFw45S7r/xX
         PweA==
X-Gm-Message-State: AGi0Pua5VglXULrqc+REkkqglOVLbzSVTG4pxHYANyYZXeVSo7lNwMld
        G/ytO/fCHvLDMqPtocM62tk=
X-Google-Smtp-Source: APiQypIu+g4/wwMFCZy1TJKiDdgrbhdng4uU6Go4ZSBkM4nLAOTBSTggxG+2rj3Jejua2K4t3jZ1QA==
X-Received: by 2002:a1c:2042:: with SMTP id g63mr20587018wmg.70.1587902693276;
        Sun, 26 Apr 2020 05:04:53 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id s24sm11120026wmj.28.2020.04.26.05.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 05:04:52 -0700 (PDT)
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
Subject: [PATCH 6/7] arm: sun8i: h3: Add HDMI audio to Beelink X2
Date:   Sun, 26 Apr 2020 14:04:41 +0200
Message-Id: <20200426120442.11560-7-peron.clem@gmail.com>
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
@@ -142,6 +142,14 @@
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
2.20.1

