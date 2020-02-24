Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F1DC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86C7D20828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wBY/3vVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgBXPIW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:08:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38021 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBXPIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:08:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id a9so9782239wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWfBy6ev6bbSxjpQcvH0AV343qtHu4C4U0cUi6UfZnU=;
        b=wBY/3vVubkI7wxLcoajaYhVvS0G5LexVcmABjQthWDix3gsSnXfBj57nUUKNiAdOZI
         ApytnEuNGJdnemV7SgbbXHVI29sskaIY5Sp71/cGYPVtRutWuzjnZHEI41duu8JmINSD
         BsefERmeChNIxs17rlV5BrsRcKPqRoeQXB4NASw88ZC0tlTGK3eD0wdDIBdYGUO5pXtn
         /KlIZQQ63kYj/ATt0gQMlltG/BwYGJ3h57mK12AJcbkomZw/gIShztQVjxWdJuH+wDYG
         A2yxvRv+BK5kvKdGXe2IZVUGtAnOuLFRzRA+aJ3VNAQhFR57pvJ6suNb0Xyaz3fpre4Q
         alvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWfBy6ev6bbSxjpQcvH0AV343qtHu4C4U0cUi6UfZnU=;
        b=bRennurKxkKdObDzgGEZ2I7BA2j9pRPGsG8LV6OexwFoqZ7h4iGGSkxYmXtUvEzMl2
         h/TZhW8kje5rxwJImxMYWJA621My20aH849IjQ6qQfYUwkmDSE6NMUfxsLXUMtPnHgkL
         smvE54ScIDfomwU/oygX7tObJhkMA42Xmd+qCfepa7CVaKaMFTMFLcsiTBeufc0sYeWr
         mVv+Xc1RNJSaB2dnYuVj/fX2jZK62CpeJy85zgPyumsUyo9ZyMuW6suFsZ5kCPoBg4xZ
         2TU5zwrR2puoDxkY2y7bT572cngfl3tdN+eNMu7BGfKsP+veNBFSgsHQhoTGKr/NnRxN
         ZgfA==
X-Gm-Message-State: APjAAAWxC51SDpIAO5gBVGm5CZAFX/+EWOHoXMkafXKR5KTB43lgRzcb
        y3HLuW+UkkUX0W4XkVGvJaI9fg==
X-Google-Smtp-Source: APXvYqzDcFZ2YpuRUbGwu9xnZqepU2+kvnw7xrdYxp4hFRnTqNy7SXx1rJu4+siAQs7rix6lsB+m4w==
X-Received: by 2002:a05:600c:3d1:: with SMTP id z17mr23480791wmd.90.1582556899192;
        Mon, 24 Feb 2020 07:08:19 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id c15sm19074794wrt.1.2020.02.24.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:08:18 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] arm64: dts: meson: s400: fix sound card codec nodes
Date:   Mon, 24 Feb 2020 16:08:11 +0100
Message-Id: <20200224150812.263980-3-jbrunet@baylibre.com>
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

Some codec nodes of the s400 sound card are numbered with the pattern
codec@XX. This pattern should be used only if there is a reg property in
the node which is not case here. Change this to something acceptable.

This change is only to better comply with the DT spec. No functional
changes expected.

Fixes: 6f59dc1afbb2 ("arm64: dts: meson-axg: s400: add sound card")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 4cd2d5951822..cb1360ae1211 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -313,15 +313,15 @@ dai-link-6 {
 			dai-tdm-slot-rx-mask-1 = <1 1>;
 			mclk-fs = <256>;
 
-			codec@0 {
+			codec-0 {
 				sound-dai = <&lineout>;
 			};
 
-			codec@1 {
+			codec-1 {
 				sound-dai = <&speaker_amp1>;
 			};
 
-			codec@2 {
+			codec-2 {
 				sound-dai = <&linein>;
 			};
 
-- 
2.24.1

