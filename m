Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6033C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB5B20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:46:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2SE/62ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387722AbgCDJqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:46:37 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38651 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbgCDJqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:46:36 -0500
Received: by mail-wr1-f65.google.com with SMTP id t11so1537995wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 01:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K5hjg1G3VFJLeuZ62RXxBnJp53DPSao1yCpZ+ZBtBN8=;
        b=2SE/62ffNoNovHiDs1k+u5cTld9gBWOVjpxlimiyMzuGDcXNO7DUxt9Y14hP9n3+eL
         NH+9A+7QJG3kGP10lLckXdEVA97WpRjF9zy0NHjXZmq7Jc4bmR3ep3dxqbaMwqx7CHRU
         usGM+s3jBF5hjJA11vy0AStb7wZVycGK89BWs8Pqqs0InWE3NVc5febUgjUoOo4lRCcj
         +LxhnmvycnOEXSWQf57tEgS0Q4nn8FMOhSDh4vwtVXySqWhzaS1mZB7NSDyea7/Q8+Yy
         6DIqNuLQwsNnqxuD0BT0LZWAZWKogGUIAS3hvuN0Daa6hf4lk0GPyxZygHBsYWv6GZrG
         VnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K5hjg1G3VFJLeuZ62RXxBnJp53DPSao1yCpZ+ZBtBN8=;
        b=b2PIEOr3bZuwR5gXQzAxoHANmqDYHX1Ejp71x/053q7mqk0H6lj4kM1Knacvisq5Wj
         BndCehZ1dKmWc1EUJMnQiWnn+6XdlbneKecXhJTYuNq25DaqAQJQQUXAkVC7MntQRR1C
         mzEZsmxjN9zWaibI2+EHCXDABy1w/nyJ7g3BnzyZeVdQW43yzRZbtjz3UzKFmDf4WVoq
         H9lqFa01sRYODdVyxeE7mgoYNk0c2GRQIYc1oHHCoZ4+FEDU4LQ71fDNjzQNAgIKC4b6
         2xSOBXuJyeKTgfhYr5i6efFwWK6cATrhrf5jRyG8Om3nDt9F54Qpd1XVYZbEYy3GaO1v
         MwlA==
X-Gm-Message-State: ANhLgQ1mLF3pUsQWAYUq21eMxKornJ8OmzRuoXG5UkTk66mPl5XQDLEJ
        a9YkGiGxO412OVam4VSO/7YmvQ==
X-Google-Smtp-Source: ADFU+vsmHI8XwQXXfnDZR562BoFU7zrqmPglShefMhkAEPAr3dqW+fmq4C1hsmjfc+4oVh7WFI4DFQ==
X-Received: by 2002:adf:f604:: with SMTP id t4mr3308460wrp.96.1583315192881;
        Wed, 04 Mar 2020 01:46:32 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b10sm38696107wrw.61.2020.03.04.01.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 01:46:32 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v7 1/5] media: meson: vdec: align stride on 32 bytes
Date:   Wed,  4 Mar 2020 10:46:21 +0100
Message-Id: <20200304094625.2257-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200304094625.2257-1-narmstrong@baylibre.com>
References: <20200304094625.2257-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HEVC/VP9 aligns the plane stride on 32, so align the planes stride
for all codecs to 32 to satisfy HEVC/VP9 decoding using the "HEVC" HW.

This fixes VP9 decoding of streams with following (not limited) widths:
- 264
 -288
- 350
- 352
- 472
- 480
- 528
- 600
- 720
- 800
- 848
- 1440

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
---
 drivers/staging/media/meson/vdec/vdec.c         | 10 +++++-----
 drivers/staging/media/meson/vdec/vdec_helpers.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 92f0258868b1..bfca4c82aa56 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -528,20 +528,20 @@ vdec_try_fmt_common(struct amvdec_session *sess, u32 size,
 		memset(pfmt[1].reserved, 0, sizeof(pfmt[1].reserved));
 		if (pixmp->pixelformat == V4L2_PIX_FMT_NV12M) {
 			pfmt[0].sizeimage = output_size;
-			pfmt[0].bytesperline = ALIGN(pixmp->width, 64);
+			pfmt[0].bytesperline = ALIGN(pixmp->width, 32);
 
 			pfmt[1].sizeimage = output_size / 2;
-			pfmt[1].bytesperline = ALIGN(pixmp->width, 64);
+			pfmt[1].bytesperline = ALIGN(pixmp->width, 32);
 			pixmp->num_planes = 2;
 		} else if (pixmp->pixelformat == V4L2_PIX_FMT_YUV420M) {
 			pfmt[0].sizeimage = output_size;
-			pfmt[0].bytesperline = ALIGN(pixmp->width, 64);
+			pfmt[0].bytesperline = ALIGN(pixmp->width, 32);
 
 			pfmt[1].sizeimage = output_size / 4;
-			pfmt[1].bytesperline = ALIGN(pixmp->width, 64) / 2;
+			pfmt[1].bytesperline = ALIGN(pixmp->width, 32) / 2;
 
 			pfmt[2].sizeimage = output_size / 2;
-			pfmt[2].bytesperline = ALIGN(pixmp->width, 64) / 2;
+			pfmt[2].bytesperline = ALIGN(pixmp->width, 32) / 2;
 			pixmp->num_planes = 3;
 		}
 	}
diff --git a/drivers/staging/media/meson/vdec/vdec_helpers.c b/drivers/staging/media/meson/vdec/vdec_helpers.c
index a4970ec1bf2e..3f7929c54dc6 100644
--- a/drivers/staging/media/meson/vdec/vdec_helpers.c
+++ b/drivers/staging/media/meson/vdec/vdec_helpers.c
@@ -154,8 +154,8 @@ int amvdec_set_canvases(struct amvdec_session *sess,
 {
 	struct v4l2_m2m_buffer *buf;
 	u32 pixfmt = sess->pixfmt_cap;
-	u32 width = ALIGN(sess->width, 64);
-	u32 height = ALIGN(sess->height, 64);
+	u32 width = ALIGN(sess->width, 32);
+	u32 height = ALIGN(sess->height, 32);
 	u32 reg_cur = reg_base[0];
 	u32 reg_num_cur = 0;
 	u32 reg_base_cur = 0;
-- 
2.22.0

