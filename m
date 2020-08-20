Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21E5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8735A2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J6C7ICzF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHTDlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHTDlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:41:05 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF683C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:41:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p37so515920pgl.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B9EvtRMB5UVF86YnoHZC/uHFJ9AM6zutWYeLdC0SWPo=;
        b=J6C7ICzFYJGV3tWZk5soVRVxCRF4eadzc/OAyuvKSnyBUVeWXBJufUSp5SrId1XKLj
         6r8wz5IPJFIHX0hv0Wcz3JhYOlDMDmjjvsYRvUIi9AvCpajh4gxxFFK0oTZ40OErAzvJ
         f+6KcTMpbTTJYB31y7uvlnnh0BWMfpBEFWYAZ+0czMfx7bY9/uzn6Z1Clf70GKetDBlG
         XD9018HxSAbapSc9yzX4y2kX8+LEnZuLQu3B+K28eZJAwtBKLALb8UhkI7rsm9x78qae
         JuNYMBjzUhSe8+1cnTN0L9cAdrvRNRHgAgnB41Zy7/htCDlJKnQG5p1JjhX/4saRcFsK
         wE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B9EvtRMB5UVF86YnoHZC/uHFJ9AM6zutWYeLdC0SWPo=;
        b=dMeb+BxaROM32ZTvF86+3/SINGoY9jH6anKLkY9EifBzNsCyaJTmigYLIuz6a+og66
         tLDPlddMz3i77dJyfOpcMWsc9nMjjGDG6C5quYtUyNpe4oSz2iaiX2fiBrAVoKSfBCDc
         HBoQxJkaZ9JO6KsO/vCFTqax7+ZOKWgr7qhv1xXaWtdtw3j7Ba67+YPi7UFTlQ9o6lSQ
         BPF70h5sW2RmrL6/ClPBMJLJgqdNM4l4u/dKKasP9p2NkDKzXUr5z2VSP0qEQY5Fiff6
         1DdLyevZ6uqFmGvaZ4i/qw5auy+AAWHN1+sCTdPXs3S5FTH30kd5C3Nz9FX+JUP3K9St
         aMBQ==
X-Gm-Message-State: AOAM532nvjZEVE78QCqMeaSSi5Vvz+Qzrt4L4RryxD/LNYzE0sIfzc8V
        dKSZ4PO7ygdc0D3ROHM0bgjlgGIkMxFDXA==
X-Google-Smtp-Source: ABdhPJw4A1teuRlyb1TkMhqLDkqloYQulBKDv393Chr/svrFg49o9APmr8NElPKuIMXNWDkeTvOLiA==
X-Received: by 2002:a63:5552:: with SMTP id f18mr1054188pgm.298.1597894864955;
        Wed, 19 Aug 2020 20:41:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y126sm786477pfy.138.2020.08.19.20.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 20:41:04 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Xinliang Liu <xinliang.liu@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Chen Feng <puck.chen@hisilicon.com>
Subject: [PATCH 3/3] drm: hikey9xxx: Fix null pointer crash on reboot
Date:   Thu, 20 Aug 2020 03:41:00 +0000
Message-Id: <20200820034100.128062-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200820034100.128062-1-john.stultz@linaro.org>
References: <20200820033939.127932-1-john.stultz@linaro.org>
 <20200820034100.128062-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is against Mauro's tree here:
https://gitlab.freedesktop.org/mchehab_kernel/hikey-970/-/commits/master/

On reboot we see the following crash:

[  608.746787] Unable to handle kernel read from unreadable memory at virtual address 00000000000000a8
...
[  608.822101] CPU: 3 PID: 234 Comm: kworker/3:2 Not tainted 5.8.0-00183-g03481a190c60-dirty #32
[  608.830626] Hardware name: HiKey960 (DT)
[  608.834571] Workqueue: events drm_mode_rmfb_work_fn
[  608.839454] pstate: 80400005 (Nzcv daif +PAN -UAO BTYPE=--)
[  608.845031] pc : drm_gem_fb_get_obj+0x10/0x28
[  608.849390] lr : drm_fb_cma_get_gem_obj+0x10/0x20
[  608.854093] sp : ffffffc012f63b10
[  608.857404] x29: ffffffc012f63b10 x28: ffffff8212282e00
[  608.862716] x27: 0000000000000000 x26: ffffff8217501800
[  608.868027] x25: 0000000000000000 x24: ffffffc012f63d60
[  608.873339] x23: 0000000000000001 x22: ffffff8217504080
[  608.878652] x21: ffffffc0119b9000 x20: ffffff8212282e00
[  608.883963] x19: ffffff82175047c0 x18: ffffffffffffffff
[  608.889275] x17: ffffff8219c97708 x16: ffffff8219c97728
[  608.894586] x15: ffffffc0119b9d08 x14: 0000000000000000
[  608.899898] x13: 0000000000000000 x12: 0000000000000000
[  608.905209] x11: 0000003c00000000 x10: 0000046500000441
[  608.910519] x9 : ffffffc0119b9d08 x8 : ffffffc011bf7000
[  608.915830] x7 : 0000000000000898 x6 : ffffff8217504080
[  608.921142] x5 : ffffff8212282e00 x4 : ffffffc0111935e0
[  608.926454] x3 : 0000000000000000 x2 : ffffffc0119b9d08
[  608.931764] x1 : 0000000000000000 x0 : 0000000000000000
[  608.937079] Call trace:
[  608.939531]  drm_gem_fb_get_obj+0x10/0x28
[  608.943547]  hisi_fb_pan_display+0x50/0x1f8
[  608.947736]  dss_plane_atomic_update+0x10/0x20
[  608.952183]  drm_atomic_helper_commit_planes+0xe0/0x228
[  608.957412]  drm_atomic_helper_commit_tail+0x34/0x80
[  608.962377]  commit_tail+0x150/0x180
[  608.965955]  drm_atomic_helper_commit+0x164/0x178
[  608.970665]  drm_atomic_commit+0x4c/0x60
[  608.974591]  drm_framebuffer_remove+0x3f4/0x440
[  608.979123]  drm_mode_rmfb_work_fn+0x48/0x68
[  608.983398]  process_one_work+0x1ec/0x4b0
[  608.987408]  worker_thread+0x208/0x478
[  608.991160]  kthread+0x140/0x150
[  608.994390]  ret_from_fork+0x10/0x30
[  608.997972] Code: d503233f 71000c3f 540000a8 8b214c01 (f9405420)
[  609.004069] ---[ end trace a837c42fc434e1a4 ]---

Which is due to the plane->state->fb value being null.

Fix this with a solution used in a different version of this
patch series.

Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Cc: dri-devel <dri-devel@lists.freedesktop.org>
Cc: Liwei Cai <cailiwei@hisilicon.com>
Cc: Xinliang Liu <xinliang.liu@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
index f2e99c766927..7adbd924bec2 100644
--- a/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
+++ b/drivers/staging/hikey9xx/gpu/kirin9xx_drm_dss.c
@@ -702,6 +702,13 @@ static int dss_plane_atomic_check(struct drm_plane *plane,
 static void dss_plane_atomic_update(struct drm_plane *plane,
 				    struct drm_plane_state *old_state)
 {
+	struct drm_plane_state *state = plane->state;
+
+	if (!state->fb) {
+		state->visible = false;
+		return;
+	}
+
 	hisi_fb_pan_display(plane);
 }
 
-- 
2.17.1

