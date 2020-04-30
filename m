Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB37C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CE82072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zvIhEeo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgD3TZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgD3TZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:25:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9EC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:25:04 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so342528pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LWzoBfWYBplb188JYPfec8yiO1FAiglsQQs7ha7y6zc=;
        b=zvIhEeo6o5Oci/1eDGxIxa70cqZyoYJPXylX1Jz8dm4uPN+VdUMi5dd63F1duzrKjf
         RbDbL4orJsgYwq7Nj0UTh3yQbN4K0xHm3MIzvy5ZD3vZU2dEZ4WTK5ZSvBz/KhNhDNRi
         iq4ZR0E2/FCU5UX9o2YRqOluF3k9408xQAXoHNf8e9LxoECnH5HXqwOJ0rv7LjXnhyyW
         yS/J0pcItyBpgwidW4/F9usyFm2BZPVgghgNjxRdQThOIQoH0bSYmBNCHOuxLIXuzZaE
         8kNRwr8BxYU8I87WPqhv6VIAhcrOvoocf9qPGC8gtHNJf58mlCE62qWRAmVLrpUHxnod
         A6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LWzoBfWYBplb188JYPfec8yiO1FAiglsQQs7ha7y6zc=;
        b=ZYh36Gqtnce6+4By/45rkJJo50e9ulpj+/DY667ydsYRqIEcTroya/G5qGdhEi0vHi
         1Y7+ZxrhS4oYv6IcpvTR2AqkeZ5EutPhp6GIy3qK25D7Mtv+KqgTIm2Wyz1K+6IpVR7h
         FsPsQtI9JDMzecK3XRIWHNU8jvyNKvQnkLxuEkkJVGUFJl1JHnjUL7jJXf1dwt8EFOtP
         Mw4PblJYL1P33nmcmeyS1E2jpE6faCgPu1i4dQT8iG9yTgHiaVHKyTSyD4UOD0gNEep3
         comhDP+bG9iiWF8h+zCGqKOPOd3mqFr3kfpw3NUTfiGktOarc/yiM2ZHlAb8bsu3w2no
         XDMw==
X-Gm-Message-State: AGi0PuaGTemGRV4wSemo9MHgaT/P12yu5ytS5FFIxYpUzBoUsFxTJAG/
        JO5bS5breEznGpjV3ZwrYh+s8g==
X-Google-Smtp-Source: APiQypLCsVX9Nh3B0wNo8iNCW3Dh7d+/91P/QFHKJM1aSTI3VdeXI7wM5INe9jYGfLmdFCvuIRM2Ow==
X-Received: by 2002:aa7:8b12:: with SMTP id f18mr271949pfd.81.1588274704103;
        Thu, 30 Apr 2020 12:25:04 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v26sm463594pfe.121.2020.04.30.12.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:25:03 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jordan Crouse <jcrouse@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] drm/msm: Fix undefined "rd_full" link error
Date:   Thu, 30 Apr 2020 12:24:27 -0700
Message-Id: <20200430192427.4104899-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rd_full should be defined outside the CONFIG_DEBUG_FS region, in order
to be able to link the msm driver even when CONFIG_DEBUG_FS is disabled.

Fixes: e515af8d4a6f ("drm/msm: devcoredump should dump MSM_SUBMIT_BO_DUMP buffers")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/gpu/drm/msm/msm_rd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index 732f65df5c4f..fea30e7aa9e8 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -29,8 +29,6 @@
  * or shader programs (if not emitted inline in cmdstream).
  */
 
-#ifdef CONFIG_DEBUG_FS
-
 #include <linux/circ_buf.h>
 #include <linux/debugfs.h>
 #include <linux/kfifo.h>
@@ -47,6 +45,8 @@ bool rd_full = false;
 MODULE_PARM_DESC(rd_full, "If true, $debugfs/.../rd will snapshot all buffer contents");
 module_param_named(rd_full, rd_full, bool, 0600);
 
+#ifdef CONFIG_DEBUG_FS
+
 enum rd_sect_type {
 	RD_NONE,
 	RD_TEST,       /* ascii text */
-- 
2.24.0

