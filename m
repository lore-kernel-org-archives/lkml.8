Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5E3C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A452076A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tieGcHAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgHAStk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAStj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:49:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52398C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 11:49:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t14so6810215wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 11:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MxpRTOZ+a9Yk8BaelNAvYzSAx53X3UQsDpK+3T01PFk=;
        b=tieGcHAUi5zaeQVURRe2RYpMe1e61SVS/e8Cnuf+0wtR7Fk11ZyWKs787++NVY67/7
         hZ+IpG5kTZ7aPOQEQClYgToiGaMQSgYLFa3HKUqKfqtCtkLyTvzqvn/QlkHEyDWutOsy
         tqL8qudVO/2RWkr3/lBBqHQPQeCWpiQ1dQobjYp7zYLw3WFUtjJxrGcpoqKFzx9L/Wqb
         TL2rlGXkGsX9RKa+PfmlYwz3FbEthxjsw72rsF37Kf1n/wLZ0IBy3u8jqTuxMPjmAiFf
         6SsHl5ItKPNGMClsv00zvktKC3uGYFzxgJoCwL+ut41yIcYDk/I3ltxgfgBcteo1WHkl
         HP5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MxpRTOZ+a9Yk8BaelNAvYzSAx53X3UQsDpK+3T01PFk=;
        b=RA7q3jmpZw8T89yPRH2mdy4UPheuUtGgw6ajZNLWgcPAeDkf8dxTRyQliZP/fwE5MH
         b8RLZxhzTWxqIeqHPOmoTG/Sm+9g05sbVl0o1/9BzycRLMeYnzsy+4TZyzjxzr6Q880s
         JoDOiOw0dY6PSOAi9YqZnAxuei1BCxmPVQMMdqPOaCS9IMolLYn9cfp3ODHTdCdeBsXi
         0vRErj5YTsoflt+b6IOy1EeSXMsO2tQ6l3+FwL7TniJ9bwGLdqDNCR2oRmUVjr5KNWpj
         vLBEtjF0p1ideFmj5Kqk8wxHJ6e6ye+QBH2FHhwgCj4XhkgUmtZP2ENNHZFKvmLrhU/3
         LtGw==
X-Gm-Message-State: AOAM5304suznqStXvTHFPbKUkBh4yIafTUE4DpuG8Zr862H2AC5S4E0R
        fqz/QQjVvSIOWmqBlW8Vhak=
X-Google-Smtp-Source: ABdhPJxdXVLKSbEh46C6FdcV3pFdoQMjxG1UfSDRcGPjlrNW6T1XLmE0B9rMRQ7e4vGdfQ1fICHBZQ==
X-Received: by 2002:a1c:484:: with SMTP id 126mr8844477wme.9.1596307778064;
        Sat, 01 Aug 2020 11:49:38 -0700 (PDT)
Received: from smtp.gmail.com (a95-92-181-29.cpe.netcabo.pt. [95.92.181.29])
        by smtp.gmail.com with ESMTPSA id s19sm20089660wrb.54.2020.08.01.11.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 11:49:37 -0700 (PDT)
Date:   Sat, 1 Aug 2020 15:49:29 -0300
From:   Melissa Wen <melissa.srw@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Sidong Yang <realwakka@gmail.com>
Cc:     twoerner@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] drm/vkms: guarantee vblank when capturing crc
Message-ID: <20200801184929.2eaxyoq6fm3nk4ey@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VKMS needs vblank interrupts enabled to capture CRC. When vblank is
disabled, tests like kms_cursor_crc and kms_pipe_crc_basic getting stuck
waiting for a capture that will not occur until vkms wakes up. This
patch ensures that vblank remains enabled as long as the CRC capture is
needed.

It clears the execution of the following kms_cursor_crc subtests:
1. pipe-A-cursor-[size,alpha-opaque, NxN-(on-screen, off-screen, sliding,
random, fast-moving])] - successful when running individually.
2. pipe-A-cursor-dpms passes again
3. pipe-A-cursor-suspend also passes

The issue was initially tracked in the sequential execution of IGT
kms_cursor_crc subtest: when running the test sequence or one of its
subtests twice, the odd execs complete and the pairs get stuck in an
endless wait. In the IGT code, calling a wait_for_vblank on preparing
for CRC capture prevented the busy-wait. But the problem persisted in
the pipe-A-cursor-dpms and -suspend subtests.

Checking the history, the pipe-A-cursor-dpms subtest was successful
when, in vkms_atomic_commit_tail, instead of using the flip_done op, it
used wait_for_vblanks. Another way to prevent blocking was
wait_one_vblank when enabling crtc. However, in both cases,
pipe-A-cursor-suspend persisted blocking in the 2nd start of CRC
capture, which may indicate that something got stuck in the step of CRC
setup. Indeed, wait_one_vblank in the crc setup was able to sync things
and free all kms_cursor_crc subtests.

Besides, other alternatives to force enabling vblanks or prevent
disabling them such as calling drm_crtc_put_vblank or modeset_enables
before commit_planes + offdelay = 0, also unlock all subtests
executions. These facts together converge on the lack of vblank to
unblock the crc capture.

Finally, considering the vkms's dependence on vblank interruptions to
perform tasks, this patch acquires a vblank ref when setup CRC source
and releases ref when disabling crc capture, ensuring vblanks happen to
compute CRC.

Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Co-developed-by: Sidong Yang <realwakka@gmail.com>
Signed-off-by: Sidong Yang <realwakka@gmail.com>
Co-developed-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
---
 drivers/gpu/drm/vkms/vkms_composer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 4af2f19480f4..1161eaa383f1 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -241,6 +241,14 @@ int vkms_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 
 	ret = vkms_crc_parse_source(src_name, &enabled);
 
+	/* Ensure that vblank interruptions are enabled for crc capture */
+	/* Enabling CRC: acquire vblank ref */
+	if (enabled)
+		drm_crtc_vblank_get(crtc);
+	/* Disabling CRC: release vblank ref */
+	if (!src_name)
+		drm_crtc_vblank_put(crtc);
+
 	spin_lock_irq(&out->lock);
 	out->composer_enabled = enabled;
 	spin_unlock_irq(&out->lock);
-- 
2.27.0

