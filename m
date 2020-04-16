Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEBDC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86650206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WhOJRALY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395224AbgDPP01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442486AbgDPPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:25:18 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D24DC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:17 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d77so5034525wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DzaSKn4cSSk3k+NN0i6pGCPn8vqE61m//mTImjLqruU=;
        b=WhOJRALYh24x37/GjVj9Zd9bfz3f/KUeQQrju/ctwcoa/3SdbeZoJf5HHRF+xv8u8I
         CBScgJnoMMs+kI3bS5XlCxMaqGGLVaQgjyqxYNqQ27vLL2/h1/XlWP6212Y5/3+4/YeH
         qu53cPfcioCAb2Z772lwuoyf16sGAxRYn+QRFcbkdfSsocBM7izk25GEFRTVKKdCX0CZ
         0wWoLh8MZTN4Euk3OPB5hHS5NsFRSEufZvhXKucOistUQdMennsoN6PuLN4uzCl/8MxV
         6X3KOXwVmVoTKmbf+WCJKhcgKcTbzjNovBgTGWUkOeOFbG4j9B/K2/0p9Ez2QROiy1w4
         i/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DzaSKn4cSSk3k+NN0i6pGCPn8vqE61m//mTImjLqruU=;
        b=VCcv8crg8xgA845TQemeGAWSYgX2/TDNvchI8gHd3HwI8wyeywnd1DB33OWoDAfnfg
         ttJmUvUF2tTFagUeJeHAJdkMvp5NdzI5lcODlImUSBDZSIOxm/oSoouEj1rDeFDXf6Sw
         bwldSJBaPrCwkXQsj3UKwsv5sU8TPQwfPolZcBz6Jh1v5qqSthJ4OW7SfAvtnAUFZCG3
         0PpEBjeuct3mcGdk3z7ZVbtNQsiQc0XA7H3w1bK5Q3FwdWcC455enqSegrYsU7GVKOkI
         gBpjWYO6+NNam05EK7dFMM0W+sIyQi3gV0r9+XXvU7qbJVOZZlF+H04YYtEM8vkTZWzh
         sG8g==
X-Gm-Message-State: AGi0PubQsZ+36fqKeO5w409u51+mkY6jbDAghUAyMe8E3SG3Ji28/AK6
        lY7dmGBEBh+5KF/hCgivkG3VXSxR/RuZCw==
X-Google-Smtp-Source: APiQypLaZFDZc8S5mgnDvOeQEVBVo+Ns/ShJ+crrWMRHJL15JEjj44C7VXY4PkyqeskL3CNTJD4UKQ==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr5340614wmh.107.1587050715289;
        Thu, 16 Apr 2020 08:25:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:39cc:a07:8b48:cc56])
        by smtp.gmail.com with ESMTPSA id i17sm18019489wru.39.2020.04.16.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:25:14 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v5 5/8] drm/fourcc: amlogic: Add modifier definitions for Memory Saving option
Date:   Thu, 16 Apr 2020 17:24:57 +0200
Message-Id: <20200416152500.29429-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200416152500.29429-1-narmstrong@baylibre.com>
References: <20200416152500.29429-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic uses a proprietary lossless image compression protocol and format
for their hardware video codec accelerators, either video decoders or
video input encoders.

An option exist changing the layout superblock size to save memory when
using 8bit components pixels size.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/uapi/drm/drm_fourcc.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index a1b163a5641f..664dd238574a 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -843,6 +843,21 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC		(1ULL << 0)
 
+/* Amlogic FBC Layout Options */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC_OPTIONS_MASK		(0xf << 8)
+
+/*
+ * Amlogic FBC Memory Saving mode
+ *
+ * Indicates the storage is packed when pixel size is multiple of word
+ * boudaries, i.e. 8bit should be stored in this mode to save allocation
+ * memory.
+ *
+ * This mode reduces body layout to 3072 bytes per 64x32 superblock with
+ * the basic layout.
+ */
+#define DRM_FORMAT_MOD_AMLOGIC_FBC_MEM_SAVING	(1ULL << 8)
+
 #if defined(__cplusplus)
 }
 #endif
-- 
2.22.0

