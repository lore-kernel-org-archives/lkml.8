Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B049C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1412146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="IkPXgpK4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbgCDJqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:46:40 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35697 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbgCDJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:46:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id m3so1145918wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 01:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jIQVieVu7UoENPR4ohx8RO9hyM5Q2LpZgT/s7fhmTzY=;
        b=IkPXgpK4xQ3HN1/lwVgetOzEh4UKm3I+9vyeCcCPhYG1sgxmm/ZFGWaEZKCICJssig
         w3q97QiB8Uqqxfw515+wbeZRdtgSkKczNxTt5VK260CBa/OIyFD5LgXhPlbWMHlkSaxp
         zH3P9zMqOTvIe35eja5Mr64XZgKTgp1EC7Kph8B6J6PMWq19RaTgiFzMKEe+fBdepN4E
         bUmZay3pi3XOLqH6dM8Esz+Of29D57PB93+lRseLxicDlW4Tdberxde1nVkX+qLwEBKv
         oeCeoI5RyPCWOgbD5aazF7HM5AC4Q+y0MfZxEoTTdO5mnsYsI6jQKoVdemXxk0mKXcSZ
         9jsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jIQVieVu7UoENPR4ohx8RO9hyM5Q2LpZgT/s7fhmTzY=;
        b=BlacABzQVNpqr3thsOgUNguVdTaWgEYLKwmIyGuC/b6SEh7tG4BQ4RBDW2fNZ1FJEn
         ShZgIIcZN/m+RMCYhsiCyHSsV8ZDjvS2cmuWlo4luTByuls8KR3tBoP5v2xMUFqVWP9g
         fh43+lotLE7RSpbBIIonSLfHn+kRPuQ2YVwqUrKdwpRxE7mjzv672VLNo+Fh50M1pt2d
         NEpPJQaxrEkEudm+TNh5HmRSHMfYB1a7RGmjYfqHOJ/AMJ7f6xiNwrTkSOB6v6P2gsDK
         VUncpK66q/TYIVfcx3vQgpxDAVNg9me/e3wdQSWEY8dB+ZPHamc4AUz4s5xW3+ya5Rs3
         tFlg==
X-Gm-Message-State: ANhLgQ33QPJo2NqbBkJPHvAaQqhZ6yAiqxqycEDzxcfJFH7kIo27A5w4
        rKIOYxJo9EFWdQM2KiAK++W0DA==
X-Google-Smtp-Source: ADFU+vtiBXyp3FrhG2ndaye+3pwo2YmBsb9/Ig1njs7KOUzdF8wkPe/vUfOi1SiSTAHUZP5TDGVuSQ==
X-Received: by 2002:a05:600c:2241:: with SMTP id a1mr2786991wmm.59.1583315194019;
        Wed, 04 Mar 2020 01:46:34 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b10sm38696107wrw.61.2020.03.04.01.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 01:46:33 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v7 2/5] media: meson: vdec: add helpers for lossless framebuffer compression buffers
Date:   Wed,  4 Mar 2020 10:46:22 +0100
Message-Id: <20200304094625.2257-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200304094625.2257-1-narmstrong@baylibre.com>
References: <20200304094625.2257-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Jourdan <mjourdan@baylibre.com>

Add helpers to support the lossless framebuffer compression format that
will be used in HEVC & VP9 decoders when decoding 10bit content for
downsampling to 8bit NV12 and later proper compressed buffer support.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 .../staging/media/meson/vdec/vdec_helpers.c   | 27 +++++++++++++++++++
 .../staging/media/meson/vdec/vdec_helpers.h   |  4 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index 3f7929c54dc6..caec0fb60338 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -50,6 +50,33 @@ void amvdec_write_parser(struct amvdec_core *core, u32 reg, u32 val)
 }
 EXPORT_SYMBOL_GPL(amvdec_write_parser);
 
+/* 4 KiB per 64x32 block */
+u32 amvdec_am21c_body_size(u32 width, u32 height)
+{
+	u32 width_64 = ALIGN(width, 64) / 64;
+	u32 height_32 = ALIGN(height, 32) / 32;
+
+	return SZ_4K * width_64 * height_32;
+}
+EXPORT_SYMBOL_GPL(amvdec_am21c_body_size);
+
+/* 32 bytes per 128x64 block */
+u32 amvdec_am21c_head_size(u32 width, u32 height)
+{
+	u32 width_128 = ALIGN(width, 128) / 128;
+	u32 height_64 = ALIGN(height, 64) / 64;
+
+	return 32 * width_128 * height_64;
+}
+EXPORT_SYMBOL_GPL(amvdec_am21c_head_size);
+
+u32 amvdec_am21c_size(u32 width, u32 height)
+{
+	return ALIGN(amvdec_am21c_body_size(width, height) +
+		     amvdec_am21c_head_size(width, height), SZ_64K);
+}
+EXPORT_SYMBOL_GPL(amvdec_am21c_size);
+
 static int canvas_alloc(struct amvdec_session *sess, u8 *canvas_id)
 {
 	int ret;
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.h b/drivers/staging/media/meson/vdec/vdec_helpers.h
index 165e6293ffba..cfaed52ab526 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.h
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.h
@@ -27,6 +27,10 @@ void amvdec_clear_dos_bits(struct amvdec_core *core, u32 reg, u32 val);
 u32 amvdec_read_parser(struct amvdec_core *core, u32 reg);
 void amvdec_write_parser(struct amvdec_core *core, u32 reg, u32 val);
 
+u32 amvdec_am21c_body_size(u32 width, u32 height);
+u32 amvdec_am21c_head_size(u32 width, u32 height);
+u32 amvdec_am21c_size(u32 width, u32 height);
+
 /**
  * amvdec_dst_buf_done_idx() - Signal that a buffer is done decoding
  *
-- 
2.22.0

