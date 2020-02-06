Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A931EC3F68F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3BC21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:42:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="j+ac5GUs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgBFImA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:42:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35498 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBFIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:41:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id w12so6091565wrt.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxgSke1xqqIbUm6aWbWsjJ4dv5wN++i4U64IM8ckXcg=;
        b=j+ac5GUsSJeMY/OOO6WKioMdvPzDHAK7Sst7e7SM62udReqc3+qm8W7/AS/Y6j7Msy
         KbdrwcRRRj0zMRpvvPFf/hmM7mg96Rfdf0VhoEQJcYuIsKEz7gh5J+pIENHYykkH64gK
         VrSQaGwLJQ3Yr+WmJ+DCP0fJB/LnhnX3OKZdAS37B1DlaSX7AnnS4Z47YpdmTUHgDt8r
         Vtfg1kWP0sNYd1HkEhuL+5LzwDgoxLl90wkWrPN2VpeuyLZoSAlisD0Y6q4QBGH35bxt
         X9SlOl/+fZ9JZhcWQH6io9NScUbnAKo6Zj6NRguQeavLFmgL96CPhb4MSIxe9iMiyLUf
         Ep6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxgSke1xqqIbUm6aWbWsjJ4dv5wN++i4U64IM8ckXcg=;
        b=iANlGvjPGZv3iVAWseYEdFouK/W0TI4lxDVKiZ8MF9c3gXrPqVC3SORHcNrcQ0phJd
         pYPGJZbM/toPD0g0WBz3i7LkGT+/4NC1H8bZSlbo517x6No/Fh6Y3ZkPZ05oeDambWS5
         7UWIZXSnHQeOaGlhX4fvD8ZuybPurWrHTcZnE3YUXWvXXQC5WOVy6Ym1ysLBgVoSZDdr
         5wqiLi0nQm/F9ktcm3bhrYfy1ej9hKxCgAfPsn6aSFL2i8j3BDA2bs+909NswkODwPFp
         CuRgAgtfUZ+mwZtrktw2yoIQGVVQH4n7IjGMKeIeInoCcH2TEAjRqhI5/GC/ySqVfj+n
         p6kg==
X-Gm-Message-State: APjAAAX4NBJxGmkGNSX6QFZyc8niVCQkH6UCQ1/J1cif4kYeoivCuw8C
        8S4lcecDVMkrYZBxjt0enSH8WQ==
X-Google-Smtp-Source: APXvYqxIG6LmzTQJJxqzCkbGhckXZWo6a952zpdZN5OJLly594iVnWzcsvf4srp9zXlz5Jbm13mIpQ==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr2490205wrj.261.1580978517085;
        Thu, 06 Feb 2020 00:41:57 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id r1sm3222760wrx.11.2020.02.06.00.41.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:41:56 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 2/5] media: meson: vdec: add helpers for lossless framebuffer compression buffers
Date:   Thu,  6 Feb 2020 09:41:49 +0100
Message-Id: <20200206084152.7070-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200206084152.7070-1-narmstrong@baylibre.com>
References: <20200206084152.7070-1-narmstrong@baylibre.com>
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

