Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A71C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C05020578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHjNDM1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgHYOnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHYOnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:43:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FAAC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:43:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id t9so3352694pfq.8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=QbtdkMQ2OQK8ma+2g5/vN4Ht1Ck+Q+wWJoRTIeRkMdI=;
        b=YHjNDM1AlN+oZrQkZvw00RplLB7+Wy/qmjndtc60SzaHIG1/qt6VUHpyBmOv7pXSVz
         ihuUoNZxgsTMBdx/zsiLr3hq/24i5ZjE0x//qVmbhFFnI23QPcAZjS+SL0bwRfDjn9dr
         uGt81xBEqZYgR/5TMMI4pgjcEsu19YRwVA0yNoKBh4g992wvAGv6HfyAgLAbSyDmhgkS
         GuRZc+BjP7lzXdIwpYkYK8x48e7CSKXYsSLHno9yOjzQND2+l8lvLFUlYK3OiEb7V7Me
         yb8l+FjeyVeXR4I3lwqWZczvqYcC07/OCegqsY5p/P8OLrlxXS8PWbLCzwVKZP/A1rvv
         YvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QbtdkMQ2OQK8ma+2g5/vN4Ht1Ck+Q+wWJoRTIeRkMdI=;
        b=et6kpDSNxmD+oK8YWfac7my3HV+0KfZeZzy/L1qErId9PcrEXB9AjuJ0iCc8eEZHMs
         jLpcZkMugRHexX05x5boWH1zJwU7EP6joOeBAez4Sv4MRamk/NpDndObZqSkPt3W0GqF
         dLSC555Aisr9vbmOyj6hYE7qUiUCBXdNlVlXi32bMlz9Y6S2CNuJ7WVMqGGW3cfKvtne
         zzTdSyYWjU3A6oOFbDdBY3wBBwqABiIVscxXBruJSUNZJwB89XbZKvhQg0156Rk6GnI8
         zUreauMwb88j2RfqhP7uL+MYzhIxCy3+QM7ogMwJbHIZ6IX0+H0BAG4forfeSGxkFBY3
         2m4A==
X-Gm-Message-State: AOAM530XcQenWE84c0cm0eHQSv8pX8awp+xw4UEsAzt6EtfuJuvP79sl
        q2BGz1Gv8BYnXg+gNFjytJ8=
X-Google-Smtp-Source: ABdhPJwmFySP9vkbH3EZ1nzMfACkyEkiDEGzdcqk37zRMfzRs+srjVE3+pFgnFFRPpMX1rzaiWMYQw==
X-Received: by 2002:a63:f44b:: with SMTP id p11mr6831402pgk.324.1598366581203;
        Tue, 25 Aug 2020 07:43:01 -0700 (PDT)
Received: from realwakka.navercorp.com ([61.83.141.80])
        by smtp.gmail.com with ESMTPSA id f13sm15087959pfd.215.2020.08.25.07.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 07:43:00 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        melissa.srw@gmail.com, Emil Velikov <emil.l.velikov@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/vkms: fix warning in vkms_get_vblank_timestamp
Date:   Tue, 25 Aug 2020 14:42:48 +0000
Message-Id: <20200825144248.1751-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sidong Yang <realwakka@gmail.com>, Haneen Mohammed <hamohammed.sa@gmail.com>

When vkms_get_vblank_timestamp() is called very first time without
enabling vblank before, vblank time has just intial value and it makes
warning message. this patch prevents warning message by setting vblank
time to current time.

Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Melissa Wen <melissa.srw@gmail.com>

Signed-off-by: Sidong Yang <realwakka@gmail.com>
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

