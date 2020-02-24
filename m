Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5031CC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:08:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B6520828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="solSGzyO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgBXPIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:08:24 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55332 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgBXPIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:08:22 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so9307924wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rm7gksVRI42mlVOGy1QSc0Bs/gLhlfgLmvHJ12ilWYc=;
        b=solSGzyOpCALZIol/9eX3klRZa/VQdMYTbQBEm3R2+CXxwHY7ORsZxepUjufVAgr/n
         lPvxwjjkKTf1a4uhuX6XOlCowMpj+tBU3a9kRsfw1+OTt7lyjTotIdKpTipAAeUF+Jf1
         +uuEW2OmCf5iPIKK6pSpCoQvppKws6WbMv/ybweGlPY1YVepgJXpbnHqgEu5f6zI8R2d
         5dtOspEoU1EnQr+M+vo+MkRJ1bPVECvimj2eUJUTLBX/X/m7w3tNYeZ96lKRkAp2Sj80
         Iqjo/kDU3E/1TpsPAkOZLia1fdsIFzo4rjl4kQRbUA4cSyzwF3Xk0p8cfGApk/9PftSk
         1WZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rm7gksVRI42mlVOGy1QSc0Bs/gLhlfgLmvHJ12ilWYc=;
        b=mOk4S9pHRw2i+GwDepF+WNJ8IfCjnrXtkFPUfKMilzK/BGZgp9uLyEcNmrEIJwZjof
         tb4G3z76H/qzKqSPcgMiWjWlUlkg1Rw4/TFGCfOau1RZFoLE5AKqVknmMc18wzMYdsnM
         VOBzvr0ozoqjL12dMRKFLNGnIE4gtpIKvqui4XvY7lwjeB0i5EVUNop7SP+06Ia+m4ga
         OJ+/N9zHASOkZ5AxZVMq/dw1XOtiRlRSefk2cSX4ZvBVfiOKXTKWEzkyqUeFbvRHTXeG
         DQ2nzRGM7L4maKNdVNqBnj9V95lD4aDPIwOj4l6CwhrX7ChofZWAJQSmNodrnm6WrtIU
         Lt5A==
X-Gm-Message-State: APjAAAVrs+K1P7F3VjgOSKhgrhhuj4WfDcdJTrgEYR498QVUHQnEUA43
        DQp0oT2Hng1LBGUPxCIUST07Qw==
X-Google-Smtp-Source: APXvYqxC477Fxo92CZIa3vtqqWrP1cxhxUqPpogpwG0PJda6xORaSel0ea0bHewHcS6+aS7i8BSsEw==
X-Received: by 2002:a1c:6189:: with SMTP id v131mr23600114wmb.185.1582556900435;
        Mon, 24 Feb 2020 07:08:20 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c15sm19074794wrt.1.2020.02.24.07.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:08:19 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson: sei510: fix sound card codec node
Date:   Mon, 24 Feb 2020 16:08:12 +0100
Message-Id: <20200224150812.263980-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200224150812.263980-1-jbrunet@baylibre.com>
References: <20200224150812.263980-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A codec node of the sei510 sound card is numbered with the pattern
codec@XX. This pattern should be used only if there is a reg property in
the node which is not case here. Change this to something acceptable.

This change is only to better comply with the DT spec. No functional
changes expected.

Fixes: 64c10554bf9c ("arm64: dts: meson: sei510: add sound card")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 2ac9e3a43b96..168f460e11fa 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -269,7 +269,7 @@ dai-link-7 {
 			dai-tdm-slot-tx-mask-3 = <1 1>;
 			mclk-fs = <256>;
 
-			codec@0 {
+			codec {
 				sound-dai = <&tohdmitx TOHDMITX_I2S_IN_B>;
 			};
 		};
-- 
2.24.1

