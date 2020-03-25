Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F58C54FD6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE3F206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pgsyudR/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbgCYIuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:50:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54552 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727527AbgCYIui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:50:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id c81so1377826wmd.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ANDOlCT1ZqrnKgx/+UtkXPnR52K04rx8cZE8y2hTCQU=;
        b=pgsyudR/D2KpBB4/CqRb3vU07WoAY4c5vp9glayeMsrR3uDiTPhmtEDK+AWoQqkzHQ
         bvypr/WDimmRzKQ48OxtHMcKAjTT6iIXBdLTWhlFb+93oRxsvpeczFkVeg4aKq/wQ/Je
         rfl4bK1txMY3ppAZIm4afopOmNjNpExwGRpAeB14dZhpkQZNQb4VbGA0ALzAiWLVotmU
         +UiL8ZI9SrjEu3Uucu2dCRVRqDazHya8qIot8dJIp1DRUN6vEj9i3TURcaiYWPdGPb7v
         OTSR7GbpUra2bCrJH7EkC9JQfY3865RiKJi4lJo1XeMHh9yhUeU3NBZvxqC8MdfvsC0R
         pc5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ANDOlCT1ZqrnKgx/+UtkXPnR52K04rx8cZE8y2hTCQU=;
        b=T+OEHowwWGljSmzxjnMeBGTVtV3zmyeGca3pb3BDBzbr8Q9QHom7Hg1RSGfWBg6r9x
         jZnQxAx3pt6lUEhYbA+o/yerpyjxWu3gmBajtX7SGP83XpO/Jryw35YZYa9tiro3hGpI
         jsSLTBNCnJipOUFesouOa360KquWMfPjJzhvDAhUPZ7rmYq8Ci1ubL1sta07fDQhI3iH
         wy6hTcrEaOG62l8yYshK6ouMISJEctsYNwWhctSYl2B2g+hDukCrnj/gj1mnhGHBWi+/
         XkIvuhIsTHzlyj31a3+Jv5ibohi1DC3kDYRZtkz8/IE8zNFWH/hu1/q1IqTQdqSdk3/w
         tICA==
X-Gm-Message-State: ANhLgQ2kVFGSOCkEgworRV4l4bZWmLDitjFlc17n82dqH2bnEQHcR7XO
        1KmdLwpiZiblGA90nLGQ0c78kQ==
X-Google-Smtp-Source: ADFU+vur2MxTtHCjMfpHGxgRx4ZUbLJ6QSkqLw6sapP5tKS8pwjf38c2XDZiJmEAsfp/QTuirs7tBQ==
X-Received: by 2002:a1c:81:: with SMTP id 123mr2218819wma.97.1585126236258;
        Wed, 25 Mar 2020 01:50:36 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5c5f:613e:f775:b6a2])
        by smtp.gmail.com with ESMTPSA id o16sm33892229wrs.44.2020.03.25.01.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:50:35 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Cc:     ppaalanen@gmail.com, mjourdan@baylibre.com, brian.starkey@arm.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH v4 5/8] drm/fourcc: amlogic: Add modifier definitions for Memory Saving option
Date:   Wed, 25 Mar 2020 09:50:22 +0100
Message-Id: <20200325085025.30631-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200325085025.30631-1-narmstrong@baylibre.com>
References: <20200325085025.30631-1-narmstrong@baylibre.com>
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

The layout options starts at the 8th bit, keeping the first 8bits of the
modifiers bits to define the layout.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/uapi/drm/drm_fourcc.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 6564813d2f7a..84edc5d69613 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -819,6 +819,12 @@ extern "C" {
  * per component YCbCr 420, single plane :
  * - DRM_FORMAT_YUV420_8BIT
  * - DRM_FORMAT_YUV420_10BIT
+ *
+ * The first 8 bits of the mode defines the layout, then the following 8 bits
+ * defined the options changing the layout.
+ *
+ * Not all combinations are valid, and different SoCs may support different
+ * combinations of layout and options.
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC(__modes) fourcc_mod_code(AMLOGIC, __modes)
 
@@ -834,6 +840,22 @@ extern "C" {
  */
 #define DRM_FORMAT_MOD_AMLOGIC_FBC_LAYOUT_BASIC		(1ULL << 0)
 
+/*
+ * Amlogic FBC Layout Options
+ */
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

