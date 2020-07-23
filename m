Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD60C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1C0020714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dh+hv/l6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgGWJF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWJF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:05:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6AFC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:05:56 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so294333wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YwVwYWTqndxCbsk2H38cWSsg3v3dA5HnwhfyPRdygY=;
        b=Dh+hv/l6NQ3KPAUwJ3pGLveCtOWhIrkufkmB1J+B6iIB43BdLXWcJxxEw2kn1aV+//
         2JduwiOcZylMNxNHMcbMG9ZbOIEHlqKi3fhxPOpIxh10qbgq5XYcYr81SyFIWCdzFHd4
         15yPWQewJKf/16Bt+3N4M4eDj6wXOH2/RBv+0qs8XhfvzmcTQR74kceTWo/9YQOhHdlF
         O7P8bR3q3iUqAML7xw5WsywjG3nrGqFPLPvCJ/RvXDzoddRmu6iIgmgrJk3xL3Lx9OL+
         3Vynunr/OK7U/oZLr+jaCT+zxs/+6mBxrJajTs7hC+4/Ls4HRMdvH9wOOkaPBsOIxr6a
         LgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4YwVwYWTqndxCbsk2H38cWSsg3v3dA5HnwhfyPRdygY=;
        b=QMzsxv4LyD5W4HcUc3aN8QkB5B42ijI2rcDdQ96yXfV70Mjgn8xNn2Z7MM+iF+Ma0y
         /H2up4+ucUHXBOzbF4rxSuAQojbEnjP3JC37uOWQz92iqfdxMlggjYvIyOFIJImlc9OX
         h02PkMjxf+Q42R3BTUwoRIUaoK5+bqDrG/GVPERdXyaBbngFfqSM5wCSRg7a07vt6kjS
         vKnHjXo+cVUvCtP68yzEGFkyzs7sRDvPFTZHyvg+Frh0l0Uo8EtK+rghPNihB1PIBAd1
         y23vjPP2tGYrdJlIFO1+V3lycrfhL6i4kJCLEd5dbyIIpjGg6Y9JPc8T3TRx9ogpGdEV
         5fPA==
X-Gm-Message-State: AOAM5308yPNQBxxq+RY805yrhqTbYv3zt08VuslhWCuTS9XkcKRV586Z
        CMu+5AzFZPK2GetUHl0j+PBdVg==
X-Google-Smtp-Source: ABdhPJzM4ikkmRW1tN1fO+N5OIpr1/NNankXN3WMB2rYpcK0NBtOI2uo45JomMLql69t8i0N0TZePQ==
X-Received: by 2002:a1c:4c16:: with SMTP id z22mr3176646wmf.103.1595495155216;
        Thu, 23 Jul 2020 02:05:55 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5ce9:901f:7444:d44d])
        by smtp.gmail.com with ESMTPSA id 62sm2947397wrq.31.2020.07.23.02.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 02:05:54 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 1/2] drm/fourcc: fix Amlogic Video Framebuffer Compression macro
Date:   Thu, 23 Jul 2020 11:05:50 +0200
Message-Id: <20200723090551.27529-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the Amlogic Video Framebuffer Compression modifier macro to
correctly add the layout options, a pair of parenthesis was missing.

Fixes: d6528ec88309 ("drm/fourcc: Add modifier definitions for describing Amlogic Video Framebuffer Compression")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 include/uapi/drm/drm_fourcc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 4bee7de5f306..82f327801267 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -1004,7 +1004,7 @@ drm_fourcc_canonicalize_nvidia_format_mod(__u64 modifier)
 #define DRM_FORMAT_MOD_AMLOGIC_FBC(__layout, __options) \
 	fourcc_mod_code(AMLOGIC, \
 			((__layout) & __fourcc_mod_amlogic_layout_mask) | \
-			((__options) & __fourcc_mod_amlogic_options_mask \
+			(((__options) & __fourcc_mod_amlogic_options_mask) \
 			 << __fourcc_mod_amlogic_options_shift))
 
 /* Amlogic FBC Layouts */
-- 
2.22.0

