Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F26C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB3620801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="cQecad2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgBSOKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:10:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43991 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727855AbgBSOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:10:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so671169wrq.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 06:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WxgSke1xqqIbUm6aWbWsjJ4dv5wN++i4U64IM8ckXcg=;
        b=cQecad2r6kPfGlZxEE39qCCU7kFN4oA7oUWh5y+PgdsQzPhqzKEJL9e/qmlNZLD4gU
         PxXSLbvl59PjnFaGXIB7HLvSCub08dqePDgCdwQIHZI7u5gpls9I9bNGSguOFr1nnBMs
         Wt77dMf22WAaaanEA52eva9HSLPfDcrW7m0bLawoH0FcYHtShFBaZbIhMFcvLVSukPTC
         AIvZ6X6lI1OsYkh1pU+vgO/XMQ3ZXMaz1Zwmr3o19ORkUCyPQAnqMBo/3ntu6JIX6z6C
         OGYRDlbFB7jCiWWcJGcQWz3H1546cod0PUCz77rBC3h6Tr2z//dWo06mmkYFqEZS/jHT
         geOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WxgSke1xqqIbUm6aWbWsjJ4dv5wN++i4U64IM8ckXcg=;
        b=bAjOl8Oe38zRJsxxRCOZlwMcdXGj/K3vLtgxceG5pKUAWfbYZkJuuAoSb03oEPMWbM
         RdV0g0FTpkKnzIlBXt+sBVciKVg+rkeXqxE59rZ+ckD/bpvatpPqEJ6deYAyRWx1qW5Y
         fweaueaFiB0tGY6vXNT8tyaE3ToikyzK/9aIz7Q39JxeytlzEjE8lH6K2IQoPi/xSyal
         5iLQByHaEqmyeEp1Zi2eL7Atxd3XX669kYMAor79v7VoX85cLhVqJ4SOTyJ0b6Bi+N4/
         wWafQgGcCerfkEuBXiCg3PnSzea5FZafc5gY63M6tz2Fr8L8/JHn3yFxTvpRWoIww8j4
         q9pQ==
X-Gm-Message-State: APjAAAWc2CL0a7CgbuUVqiZiDLSmNzHBDcmCuMvf2qMD5UsWEVfGuwQF
        hbdkqZcbJVfrA6dAYKS3dxdzCA==
X-Google-Smtp-Source: APXvYqxQYcrHP4DtfOJSIB4qclkpgmBXqO7WgESiSsSsVuhHumDrXVD7VhC0jXnO/QtvKP4HqctzvQ==
X-Received: by 2002:adf:f491:: with SMTP id l17mr38900219wro.149.1582121405593;
        Wed, 19 Feb 2020 06:10:05 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:4ca8:b25b:98e4:858])
        by smtp.gmail.com with ESMTPSA id m68sm3182789wme.48.2020.02.19.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 06:10:04 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     Maxime Jourdan <mjourdan@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v5 2/5] media: meson: vdec: add helpers for lossless framebuffer compression buffers
Date:   Wed, 19 Feb 2020 15:09:55 +0100
Message-Id: <20200219140958.23542-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200219140958.23542-1-narmstrong@baylibre.com>
References: <20200219140958.23542-1-narmstrong@baylibre.com>
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

