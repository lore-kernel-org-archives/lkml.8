Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE3BC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C5E215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 08:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VNiAEN4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIIIis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIIIil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 04:38:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FAFFC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 01:38:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id m6so2013493wrn.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 01:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHQkjp+Ul8wul3YrlRDrBucDkyHt0QKEfdiQK6HCyts=;
        b=VNiAEN4udfbH4+C0R/M2mp5yFUqGIJP2zhlm05WWisyOSOFH8hDUZB7/EKeG2LMjtT
         CSfsKPwjr1Qb092qdjEVwoLDwNpPcxSfrYME4Gq8kZ3ellS0OnyCUSsf9IKqjs9GlCbL
         UdVFVkacXEiQl/Bj46MK+uGD5tUD/iJkOzAFy7IM3TofGDGH4XidqiJmcRFbhSqaZje5
         bElHkdzvMC+h94i2zrlnHdfLI+YQtRo+e0E4CyRazv5X/FXhS+EUyojN9d94cVLo6iWc
         EJxv7dIP7k9ioorDHKv7wOk3RBPKAUq4GjZkaDRAbrjy4OuCwuIAm0WZ3Nl7GOwKH0Ms
         JvPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHQkjp+Ul8wul3YrlRDrBucDkyHt0QKEfdiQK6HCyts=;
        b=dLzqJhO8tFus9GhkAS9YqQ0kLMfm2/31xDcZgbytiMb8dOh0vH5JUd7Bun/o5eU7Qd
         5V8AMDi9mH3uQMv81/bBe2i1o43BJXfdpL1vYCKJPkKbuCgfmZKWAIeszQil/RKllvmO
         CAt61kncDsWvg6KW0mC1SDZRcOJW7EYymn+nKk0a5my+tkxfNAP6Z4MJmhZ43dfRN5kv
         Xn73f9JwoWr9XYhxK61ry8At/3eDdAHzCBp3B42ZTRZY8FAawfN4q1AMaDGIhbLx6bVq
         8dA45MqUFIw7HXILUYtXDfTPeLppar1S+GLaiiUGMA8JmW85tTcMlQmVLqVr7zrKeRbT
         q1/w==
X-Gm-Message-State: AOAM533H/8uZcFe3JyxNQm97w/mgCU6N/krgIxk8GJ5Xt3cXwZqeo3i4
        /uq5rlYuoSQmuFjINF6iSKucHQ==
X-Google-Smtp-Source: ABdhPJy715CrU6E8EgLhwBkVRe15wumZzEjDxPVMrDaTPbg4r8wwa1dSrjfVxSI7XmOReFGD8GkYoQ==
X-Received: by 2002:a5d:634e:: with SMTP id b14mr2568628wrw.190.1599640719478;
        Wed, 09 Sep 2020 01:38:39 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id g12sm2909022wro.89.2020.09.09.01.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 01:38:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     alyssa.rosenzweig@collabora.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] drm/meson: osd-afbcd: enable XRGB/ARGB8888 on GXM
Date:   Wed,  9 Sep 2020 10:38:35 +0200
Message-Id: <20200909083835.8240-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows XRGB/ARGB8888 on GXM following AFBC support in panfrost.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_osd_afbcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/meson/meson_osd_afbcd.c b/drivers/gpu/drm/meson/meson_osd_afbcd.c
index f12e0271f166..f8399e795d3f 100644
--- a/drivers/gpu/drm/meson/meson_osd_afbcd.c
+++ b/drivers/gpu/drm/meson/meson_osd_afbcd.c
@@ -58,7 +58,9 @@
 static int meson_gxm_afbcd_pixel_fmt(u64 modifier, uint32_t format)
 {
 	switch (format) {
+	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_XBGR8888:
+	case DRM_FORMAT_ARGB8888:
 	case DRM_FORMAT_ABGR8888:
 		return OSD1_AFBCD_RGB32;
 	/* TOFIX support mode formats */
-- 
2.22.0

