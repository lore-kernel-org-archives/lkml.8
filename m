Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0979C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8020120716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="aDOAbtc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729440AbgA0PUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:20:03 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35684 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgA0PUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:20:03 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so7475654wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 07:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=En0JbNAeh+yumfKq8CWnMC3jR47TxQKPk/LGIgV7R10=;
        b=aDOAbtc9h0S7iEJDuTx0Gg6OSiL6dZ/j+20HDGy+6zpvRgnGp/orQDlLvZlYPl4EM3
         gro5xii7lOJxQMc/GaxZModUzELMyTn6onXaqfpE0ybt+kNgXOqoqYvTEnzSAeFE2Fd4
         uH/ZgBbHvIQE2WuV/JjgBnzgC5ZpGevJJAVTwE17xB9Vb5q1kUOE4X5M3VUgcWHB+fwG
         SxW+jCXrshXWjFdGRN3yV5voBnP84okChqSdovF4uRUBOmUMzJdyhqfzhHs9WJb/E3P5
         2sFONZddu5RvLIzfU+h6P+W/ONk3x/fkMue5BGtH/ZLL4U+FOi243DvNFfmNSUdaTyEU
         KHww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=En0JbNAeh+yumfKq8CWnMC3jR47TxQKPk/LGIgV7R10=;
        b=VkAI4Zf5Unsh0hBOMHpIh/lZBDbNHlxeOWeS2YItmwzaJIoJdvKTry4D+y3JBQQZxW
         tqOvHZTAR8qOfklXDeF3oTMKTHbXS3u742lkOEe0ODw4P3727nocu6qi5ElqKQTMp54R
         5F4SU8SpAMb2rmm+/0WTnmQW2RyNrx3Jd39YhS34c7rxO5chkM+Lq7CMagI6s62gC/qH
         Z0IZaoz/VSuhOLvTLRCyFVT8NB9iJVCgf4zOPi50aeR/5IT589lDuQAefI+RK5W7dgUR
         ez9tS5F7UJeLymV+NAtBrz3LVxhcMSaWtDHfvUW/zT5G+UYyuY8RvopzgLENuGeCxEUT
         EchA==
X-Gm-Message-State: APjAAAUJkYmGbZdR3F4Z/Hgr0HipxriS62Uj8ZbKG6qBQGL1qTSGfMDQ
        hJE03Qg9zek2tKnbRP4COi1YLA==
X-Google-Smtp-Source: APXvYqzpKOfTyFLY6VOq5KtGC62kLroh1Nc6zA17Lq0ZUvWCNZIVoSKCi6v+KZMY/0AYGVDAa4tGCQ==
X-Received: by 2002:a7b:c190:: with SMTP id y16mr14547744wmi.107.1580138402052;
        Mon, 27 Jan 2020 07:20:02 -0800 (PST)
Received: from localhost.localdomain (195-132-149-87.rev.numericable.fr. [195.132.149.87])
        by smtp.gmail.com with ESMTPSA id d12sm21013531wrp.62.2020.01.27.07.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:20:01 -0800 (PST)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     mchehab@kernel.org, hans.verkuil@cisco.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: meson: vdec: fix OUTPUT buffer size configuration
Date:   Mon, 27 Jan 2020 16:19:53 +0100
Message-Id: <20200127151953.10592-1-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a bug currently where we always override the OUTPUT buffer size
in try_fmt to the default value (1M), preventing userspace from setting
a higher or lower size.

Now, only update the size in try_fmt if userspace passed 0.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
---

Note: this patch depends on Neil's series:
media: meson: vdec: Add compliant H264 support
https://patchwork.kernel.org/cover/11336953/

 drivers/staging/media/meson/vdec/vdec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/media/meson/vdec/vdec.c b/drivers/staging/media/meson/vdec/vdec.c
index 1be67b122546..2f30945ce916 100644
--- a/drivers/staging/media/meson/vdec/vdec.c
+++ b/drivers/staging/media/meson/vdec/vdec.c
@@ -519,7 +519,8 @@ vdec_try_fmt_common(struct amvdec_session *sess, u32 size,
 	output_size = get_output_size(pixmp->width, pixmp->height);
 
 	if (f->type == V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
-		pfmt[0].sizeimage = sess->src_buffer_size;
+		if (!pfmt[0].sizeimage)
+			pfmt[0].sizeimage = sess->src_buffer_size;
 		pfmt[0].bytesperline = 0;
 		pixmp->num_planes = 1;
 	} else if (f->type == V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
-- 
2.25.0

