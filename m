Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463EEC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BF63207DE
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIDLXekW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgIGRDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgIGRDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:03:51 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7566BC061573;
        Mon,  7 Sep 2020 10:03:51 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 67so8253472pgd.12;
        Mon, 07 Sep 2020 10:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBoeCpJIsgMagxrNvwqBCO9DZhUD6cpLapF30icLvGY=;
        b=rIDLXekWW5zsnDsZr9rwwnGh7AcQsXpJmtxOGLnaYEaXJ/7Sz6Ets68fQu6vR6NDRT
         bwJ03F4A8BzzUQbMMGeTQxqkNxfwrAgutSh4utFVl1D1DE9A/ODV+mnBppSqgNlzb+FR
         XZ8eLkzwbRQ6piUSbAQELVuV5vVJ43hENOahvDVxXil873iSxkXI0UgDW4XNZEF2SHo8
         LTC2bYDGLqTqPy1+T1ebpGf4nMO1sUv2+QHOBzQV+PtBW6eOBk4FMgGOm1sFnlmbKhvr
         hwD0P3TADu3J7n7WZ4MP+3cmlYiqrgsUaiFdWTmDuiIU8Bl9dAuJTGcfZi/0u7J8FYXE
         F3EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cBoeCpJIsgMagxrNvwqBCO9DZhUD6cpLapF30icLvGY=;
        b=JTuDFue2MZ00VWM2ZRzhTQ8BGFAaE0gjJ4rWP3v/ojekCS2SXzfQYRdTrLe+LAO5h2
         +0Dnd66yiE4PEV+pxfXQrh8+agbeU1KmNDNDno3p6+SCleYTFVA7O40MoGzEZkLXE1kN
         ygQfTQg760OfwOh/boT9xGIi0RO699huB1fNrygiDmctqRO0z7TuDfUroeEss3xrFN05
         efHzbO4yXEQhMTc4om08zhPaC16SIQyLZVXMIRXPWFaQ6pa1tAqRyWgS17/Bd3j+BMNa
         2IcpP2jNxUWDKyENyQ/nOrl0Eo89hGUwUnIJTaFVEWSXVt5ZriMuoEjqzjZIXDN4X+8E
         LR3Q==
X-Gm-Message-State: AOAM533mA6d+i+kanquUvr4qo42amfqi6pmmN7LpsGYm/YLxUg4j3uQA
        2MeGOqDq+RzZ15RKqjjl8yw=
X-Google-Smtp-Source: ABdhPJxYfflcUtF+3SNgySp6Wk6HAI2DtYQFui4BIRaT7wEocOLQuuQWImDHVlvC2fujq7/dzSgg9Q==
X-Received: by 2002:a63:6e01:: with SMTP id j1mr17237015pgc.147.1599498230690;
        Mon, 07 Sep 2020 10:03:50 -0700 (PDT)
Received: from localhost (c-73-25-156-94.hsd1.or.comcast.net. [73.25.156.94])
        by smtp.gmail.com with ESMTPSA id j18sm13027030pgm.30.2020.09.07.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 10:03:49 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Drew Davenport <ddavenport@chromium.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Hongbo Yao <yaohongbo@huawei.com>, Bernard <bernard@vivo.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm/dpu: move vblank events to complete_commit()
Date:   Mon,  7 Sep 2020 10:04:47 -0700
Message-Id: <20200907170450.370122-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

We could get a vblank event racing with the current atomic commit,
resulting in sending the pageflip event to userspace early, causing
tearing.  On the other hand, complete_commit() ensures that the
pending flush is complete.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index c2729f71e2fa..89c0245b5de5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -297,7 +297,6 @@ void dpu_crtc_vblank_callback(struct drm_crtc *crtc)
 		dpu_crtc->vblank_cb_time = ktime_get();
 	else
 		dpu_crtc->vblank_cb_count++;
-	_dpu_crtc_complete_flip(crtc);
 	drm_crtc_handle_vblank(crtc);
 	trace_dpu_crtc_vblank_cb(DRMID(crtc));
 }
@@ -402,6 +401,7 @@ static void dpu_crtc_frame_event_cb(void *data, u32 event)
 void dpu_crtc_complete_commit(struct drm_crtc *crtc)
 {
 	trace_dpu_crtc_complete_commit(DRMID(crtc));
+	_dpu_crtc_complete_flip(crtc);
 }
 
 static void _dpu_crtc_setup_lm_bounds(struct drm_crtc *crtc,
-- 
2.26.2

