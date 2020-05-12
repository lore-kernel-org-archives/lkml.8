Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21CEC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D06D2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="igssb8Qu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbgELJAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgELJAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:00:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4D7C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:00:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so22345462wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z24jafCl7nBxqPpBfTBC2qyOs+r7mA5F/0neHUey0fs=;
        b=igssb8QuHGML04iloHis5tnnY04ZjIaINqB9XCnUpZujWX95vQOG2XooNZWED5UlM7
         +JukOp1TRMGSKFm0zADXJslDBeE5IaWWucPzHRfjbM3UTCO1U9stqeZEwQUg59RkX3V1
         2pMZi9aEONM7pA2SIsda8GES3xD/wunlcJq3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z24jafCl7nBxqPpBfTBC2qyOs+r7mA5F/0neHUey0fs=;
        b=XWRdBPxT/ggiFI9YIwFtIUcr6Ko8NDr3DDfahktH1aj0V8iBl7+FN28+L3IOhMY9gE
         KxuR8oW3/NNa0JUIk3GmDMfTmwXipjqeaYBoECEZYFRKq25Fzf/5I5+0UDlidiVTnK/k
         CsAQr9qHVll/MWJJ7EAfZcX14EK96sL45guPAsRGqUMPjI8Hccf++cvgRmP/ihWd4yMQ
         PQG4lawqIF1hG+lUiwxR6u0/WHfu8y2/5fE/W0Afc9OZwj54Q7DpLVuV+k01CaqJD5IM
         GKgBltWiBdABl2Ben9cHeu91rx9ye/4MIyr2G42kYD+jDrtMl2xtD7hwQ4PRb+NSXeR3
         wHww==
X-Gm-Message-State: AGi0PuZ4NGfsS+/TOA/TcSaIpEfwujV+LSy9T7/vGleIjXkV+Zopnl5J
        xywB4DILiVeQdsHlrtm+zhnxEw==
X-Google-Smtp-Source: APiQypIrt7GeKZxO1LJQxL9WakNz+jGvu0kVexVIvKusNxir+f0KPfTbonTVhKB0O4boRqtxdkOUNQ==
X-Received: by 2002:a1c:3bc5:: with SMTP id i188mr25545486wma.90.1589274003053;
        Tue, 12 May 2020 02:00:03 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10sm18845457wrd.95.2020.05.12.02.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:00:02 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-rdma@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [RFC 06/17] drm/atomic-helper: Add dma-fence annotations
Date:   Tue, 12 May 2020 10:59:33 +0200
Message-Id: <20200512085944.222637-7-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
References: <20200512085944.222637-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bit disappointing since we need to split the annotations
over all the different parts.

I was considering just leaking the critical section into the
->atomic_commit_tail callback of each driver. But that would mean we
need to pass the fence_cookie into each driver (there's a total of 13
implementations of this hook right now), so bad flag day. And also a
bit leaky abstraction.

Hence just do it function-by-function.

Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
Cc: linux-rdma@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/gpu/drm/drm_atomic_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
index 8ac3aa068261..0a541368246e 100644
--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -1549,6 +1549,7 @@ EXPORT_SYMBOL(drm_atomic_helper_wait_for_flip_done);
 void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
@@ -1560,6 +1561,8 @@ void drm_atomic_helper_commit_tail(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_commit_hw_done(old_state);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
@@ -1579,6 +1582,7 @@ EXPORT_SYMBOL(drm_atomic_helper_commit_tail);
 void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 {
 	struct drm_device *dev = old_state->dev;
+	bool fence_cookie = dma_fence_begin_signalling();
 
 	drm_atomic_helper_commit_modeset_disables(dev, old_state);
 
@@ -1591,6 +1595,8 @@ void drm_atomic_helper_commit_tail_rpm(struct drm_atomic_state *old_state)
 
 	drm_atomic_helper_commit_hw_done(old_state);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	drm_atomic_helper_wait_for_vblanks(dev, old_state);
 
 	drm_atomic_helper_cleanup_planes(dev, old_state);
@@ -1606,6 +1612,9 @@ static void commit_tail(struct drm_atomic_state *old_state)
 	ktime_t start;
 	s64 commit_time_ms;
 	unsigned int i, new_self_refresh_mask = 0;
+	bool fence_cookie;
+
+	fence_cookie = dma_fence_begin_signalling();
 
 	funcs = dev->mode_config.helper_private;
 
@@ -1634,6 +1643,8 @@ static void commit_tail(struct drm_atomic_state *old_state)
 		if (new_crtc_state->self_refresh_active)
 			new_self_refresh_mask |= BIT(i);
 
+	dma_fence_end_signalling(fence_cookie);
+
 	if (funcs && funcs->atomic_commit_tail)
 		funcs->atomic_commit_tail(old_state);
 	else
@@ -1789,6 +1800,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 			     bool nonblock)
 {
 	int ret;
+	bool fence_cookie;
 
 	if (state->async_update) {
 		ret = drm_atomic_helper_prepare_planes(dev, state);
@@ -1811,6 +1823,8 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	if (ret)
 		return ret;
 
+	fence_cookie = dma_fence_begin_signalling();
+
 	if (!nonblock) {
 		ret = drm_atomic_helper_wait_for_fences(dev, state, true);
 		if (ret)
@@ -1848,6 +1862,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	 */
 
 	drm_atomic_state_get(state);
+	dma_fence_end_signalling(fence_cookie);
 	if (nonblock)
 		queue_work(system_unbound_wq, &state->commit_work);
 	else
@@ -1856,6 +1871,7 @@ int drm_atomic_helper_commit(struct drm_device *dev,
 	return 0;
 
 err:
+	dma_fence_end_signalling(fence_cookie);
 	drm_atomic_helper_cleanup_planes(dev, state);
 	return ret;
 }
-- 
2.26.2

