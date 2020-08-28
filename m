Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2191C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2922086A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWFJgGfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgH1MqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729052AbgH1MqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:46:07 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5513C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:46:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so396388plk.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LV/s2CXjmyhaK0LBWgRhhTyeIospCDq6TJzHGpvnT6g=;
        b=LWFJgGfDyKBtY5lmHYWRLbRndAjD016GbhtAM2jdvCP4MpD96uhACFDW2/tC1qgetI
         pjEg1cuwysDRp1hauaUd0PV+OvjYYdFqtA/0rCnWwvh2HsY8NkP4Nk2wXw3UqQjqdHi0
         rzfFtqxxfhcIQdKSfxc+Njr+rdFD/efrWPaCsZBYp5mtG2dQsfgCimHs0K9nVIMuZrbc
         kvzpgq8orLyx1gVegYmLbXhBrxpP2vCpcVsnfN9nW7dFUnEPezCW4QCyOMPjr15I6iJ+
         CZyhml0+ucHExmV+BVrpipGTkMX7psbPiH/Z4+oSE9Xu7RsJ4NtiAvcZBcCmOBjtMmjA
         XrTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LV/s2CXjmyhaK0LBWgRhhTyeIospCDq6TJzHGpvnT6g=;
        b=sL4wjkHtNGX2Ho8Hh5UCfFSHnrS+sIPOlh7/bd2uW0/7q3CCAhYeyWwt5dY2museC8
         eC2fffjrErVhUGsBIW/rAzCkyNC5md6RWz+/CqvuN8Ke7/khFOCDwyMt24VCecIVqAJ6
         fdVe0y1394yik73afXNUPRlj3lgvGEzNXnwVNNS4f9LsUxFeU+t8h1rUzK9tlgEpJCO6
         I/S1KiATjY9SXmzn8jhDdepVPBPgceV2kNtddmIeasK3BWVEtkmSCMWo62bs/o4whToI
         z+CskCyHMOUZuQfEdVRIm/6MwIVNPQVeArpljEhCgwM7VjX855Tw66WKegXOQosPGVVE
         WQAw==
X-Gm-Message-State: AOAM533IhIsH5SYiedR94dAdl2EglJxiI+IGXdS2xpw6iwK3mLm15iTs
        QYIupnk77ntlwCLf+u0beDY=
X-Google-Smtp-Source: ABdhPJxp/41vncbzOQ0/ckQNO2o3dIOncvs0wTo348fYMlDIw0uCdLBHSseAdneK28/TWPC3VOwyDA==
X-Received: by 2002:a17:90a:de89:: with SMTP id n9mr1090213pjv.50.1598618765344;
        Fri, 28 Aug 2020 05:46:05 -0700 (PDT)
Received: from realwakka.navercorp.com ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id 79sm1665930pfw.97.2020.08.28.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 05:46:04 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v3] drm/vkms: avoid warning in vkms_get_vblank_timestamp
Date:   Fri, 28 Aug 2020 12:45:53 +0000
Message-Id: <20200828124553.2178-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoid the warning in vkms_get_vblank_timestamp when vblanks aren't
enabled. When running igt test kms_cursor_crc just after vkms module, the
warning raised like below. Initial value of vblank time is zero and
hrtimer.node.expires is also zero if vblank aren't enabled before. vkms module
isn't real hardware but just virtual hardware module. so vkms can't generate a
resonable timestamp when hrtimer is off. it's best to grab the current time.

[106444.464503] [IGT] kms_cursor_crc: starting subtest pipe-A-cursor-size-change
[106444.471475] WARNING: CPU: 0 PID: 10109 at
/home/realwakka/git/linux/drivers/gpu/drm/vkms//vkms_crtc.c:91
vkms_get_vblank_timestamp+0x42/0x50 [vkms]
[106444.471511] CPU: 0 PID: 10109 Comm: kms_cursor_crc Tainted: G        W  OE
5.9.0-rc1+ #6
[106444.471514] RIP: 0010:vkms_get_vblank_timestamp+0x42/0x50 [vkms]
[106444.471528] Call Trace:
[106444.471551]  drm_get_last_vbltimestamp+0xb9/0xd0 [drm]
[106444.471566]  drm_reset_vblank_timestamp+0x63/0xe0 [drm]
[106444.471579]  drm_crtc_vblank_on+0x85/0x150 [drm]
[106444.471582]  vkms_crtc_atomic_enable+0xe/0x10 [vkms]
[106444.471592]  drm_atomic_helper_commit_modeset_enables+0x1db/0x230
[drm_kms_helper]
[106444.471594]  vkms_atomic_commit_tail+0x38/0xc0 [vkms]
[106444.471601]  commit_tail+0x97/0x130 [drm_kms_helper]
[106444.471608]  drm_atomic_helper_commit+0x117/0x140 [drm_kms_helper]
[106444.471622]  drm_atomic_commit+0x4a/0x50 [drm]
[106444.471629]  drm_atomic_helper_set_config+0x63/0xb0 [drm_kms_helper]
[106444.471642]  drm_mode_setcrtc+0x1d9/0x7b0 [drm]
[106444.471654]  ? drm_mode_getcrtc+0x1a0/0x1a0 [drm]
[106444.471666]  drm_ioctl_kernel+0xb6/0x100 [drm]
[106444.471677]  drm_ioctl+0x3ad/0x470 [drm]
[106444.471688]  ? drm_mode_getcrtc+0x1a0/0x1a0 [drm]
[106444.471692]  ? tomoyo_file_ioctl+0x19/0x20
[106444.471694]  __x64_sys_ioctl+0x96/0xd0
[106444.471697]  do_syscall_64+0x37/0x80
[106444.471699]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Melissa Wen <melissa.srw@gmail.com>

Signed-off-by: Sidong Yang <realwakka@gmail.com>

---

v3:
 - add cc.

v2:
 - modify commit message to make it a bit easier to understand.

---
 drivers/gpu/drm/vkms/vkms_crtc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/vkms/vkms_crtc.c b/drivers/gpu/drm/vkms/vkms_crtc.c
index ac85e17428f8..09c012d54d58 100644
--- a/drivers/gpu/drm/vkms/vkms_crtc.c
+++ b/drivers/gpu/drm/vkms/vkms_crtc.c
@@ -86,6 +86,11 @@ static bool vkms_get_vblank_timestamp(struct drm_crtc *crtc,
 	struct vkms_output *output = &vkmsdev->output;
 	struct drm_vblank_crtc *vblank = &dev->vblank[pipe];
 
+	if (!READ_ONCE(vblank->enabled)) {
+		*vblank_time = ktime_get();
+		return true;
+	}
+
 	*vblank_time = READ_ONCE(output->vblank_hrtimer.node.expires);
 
 	if (WARN_ON(*vblank_time == vblank->time))
-- 
2.17.1

