Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0902DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D931820759
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 12:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKSq1rTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHHMJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 08:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgHHMJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 08:09:09 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C08C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 05:09:09 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r4so3966608wrx.9
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 05:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aFE2vApEsxGQPxJ2aaE7mn5V0vaQd/4mHqKbbWgPqtI=;
        b=UKSq1rTl+v6j+60J1gtJbhNyrGzjwlgfuv7WmJujW6i/buxfIA8hgC+uIBSzb/7wUJ
         b9YH/41e3teu0+udooD+ijZr9c5DwzWZd+ohCxkoslP9GAgpXhKAsRIf4lklitSK4h/R
         zVZPT7xzV2e7pJezmLpO3C54cyjZ8MkSZ0I6jiZAjKiQNaPGMMvkuyIeNGxvuC2AhLpS
         ZDCFRY0ylhGCNsmigBd+xEEfUwSdIo3Ni12NHNWas09317QcvVvAXB2bgl8WAHQXe1HG
         e9++bxO/i1tMDWoLwTTuKBCAs7pK0WiusPa/4sE+Os+KbV30QR+YjgVxmsvkqhOMxSZT
         nIkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aFE2vApEsxGQPxJ2aaE7mn5V0vaQd/4mHqKbbWgPqtI=;
        b=q8HW6QReU8oTv/VFCLj3cfwmOOyGEhsLeZOExEbG8HoCJuTdXq3wXWO7q4DwPSi8Uv
         xmpImTdgFLVHiuj5vJUF9KP/J1ICxPZL+J0aNyQzlDcT6zlDStPatu4FC+GxuehJl7HK
         N/CPEIJFv8wzViw6a90Igi06yDJRomSQymp4RJSJ9RYUF/yIwiAdt2AtVw+KmgmtR2MK
         o/jPQ9DEe8xEb3hprxvMFNgprm/jYFLWAKeG+k16GRwQSRIJVaUQp+0PVMTZIYwTGSSf
         V8jaR6VvdYPp/Snf8mEzrFXPuo5aDHLTDfcDrDS5p5BIvBxe5CIxLRbkrnJgkZPvROw1
         tvOg==
X-Gm-Message-State: AOAM530CU7RV4OTGVoocaRH2b6Q0okXBz9GQqY2FcymPBrPDjaR2cGhg
        VJJMA8/j08vEQMIQBfpbZDoa4Fjk8l8=
X-Google-Smtp-Source: ABdhPJznJpm2SKrLDMOzCjP88RLwwdWp6GpZHViUanWb11iiB13gKCZxUE0DV0sR8IR/Z93MQG8SKg==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr16023674wrc.257.1596888547801;
        Sat, 08 Aug 2020 05:09:07 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id v15sm14328847wrm.23.2020.08.08.05.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 05:09:07 -0700 (PDT)
Date:   Sat, 8 Aug 2020 09:09:00 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Sidong Yang <realwakka@gmail.com>
Cc:     twoerner@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3] drm/vkms: guarantee vblank when capturing crc
Message-ID: <20200808120900.pudwwrfz44g3rqx7@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VKMS needs vblank interrupts enabled to capture CRC. When vblank is
disabled, tests like kms_cursor_crc and kms_pipe_crc_basic getting stuck
waiting for a capture that will not occur until vkms wakes up. This patch
adds a helper to set composer and ensure that vblank remains enabled as
long as the CRC capture is needed.

It clears the execution of the following kms_cursor_crc subtests:
1. pipe-A-cursor-[size,alpha-opaque, NxN-(on-screen, off-screen, sliding,
random, fast-moving])] - successful when running individually.
2. pipe-A-cursor-dpms passes again
3. pipe-A-cursor-suspend also passes

The issue was initially tracked in the sequential execution of IGT
kms_cursor_crc subtests: when running the test sequence or one of its
subtests twice, the odd execs complete and the pairs get stuck in an
endless wait. In the IGT code, calling a wait_for_vblank on preparing for
CRC capture prevented the busy-wait. But the problem persisted in the
pipe-A-cursor-dpms and -suspend subtests.

Checking the history, the pipe-A-cursor-dpms subtest was successful when,
in vkms_atomic_commit_tail, instead of using the flip_done op, it used
wait_for_vblanks. Another way to prevent blocking was wait_one_vblank when
enabling crtc. However, in both cases, pipe-A-cursor-suspend persisted
blocking in the 2nd start of CRC capture, which may indicate that
something got stuck in the step of CRC setup. Indeed, wait_one_vblank in
the crc setup was able to sync things and free all kms_cursor_crc
subtests. Besides, other alternatives to force enabling vblanks or prevent
disabling them such as calling drm_crtc_put_vblank or modeset_enables
before commit_planes + offdelay = 0, also unlock all subtests executions.

Finally, due to vkms's dependence on vblank interruptions to perform
tasks, this patch uses refcount to ensure that vblanks happen when
enabling composer and while crc capture is needed.

Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>

Co-debugged-by: Sidong Yang <realwakka@gmail.com>
Signed-off-by: Sidong Yang <realwakka@gmail.com>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

---

v2:
- extract a vkms_set_composer helper
- fix vblank refcounting for the disabling case

v3:
- make the vkms_set_composer helper static
- review the credit tags

---
 drivers/gpu/drm/vkms/vkms_composer.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index b8b060354667..4f3b07a32b60 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -233,6 +233,22 @@ int vkms_verify_crc_source(struct drm_crtc *crtc, const char *src_name,
 	return 0;
 }
 
+static void vkms_set_composer(struct vkms_output *out, bool enabled)
+{
+	bool old_enabled;
+
+	if (enabled)
+		drm_crtc_vblank_get(&out->crtc);
+
+	spin_lock_irq(&out->lock);
+	old_enabled = out->composer_enabled;
+	out->composer_enabled = enabled;
+	spin_unlock_irq(&out->lock);
+
+	if (old_enabled)
+		drm_crtc_vblank_put(&out->crtc);
+}
+
 int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 {
 	struct vkms_output *out = drm_crtc_to_vkms_output(crtc);
@@ -241,9 +257,7 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	ret = vkms_crc_parse_source(src_name, &enabled);
 
-	spin_lock_irq(&out->lock);
-	out->composer_enabled = enabled;
-	spin_unlock_irq(&out->lock);
+	vkms_set_composer(out, enabled);
 
 	return ret;
 }
-- 
2.27.0

