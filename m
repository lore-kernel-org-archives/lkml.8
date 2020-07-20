Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC17DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF3C20709
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="TCF+9afp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgGTIKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTIKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:10:06 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF10EC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:10:05 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u5so8670738pfn.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 01:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5Llg35g7sBXSqXzyCxkQj0m1fxRgQ8z2UJ7AdQEjxI=;
        b=TCF+9afpB9+8EoNRQEQuJtyJ8MCJtBe06cjaHXaEMCovewqmRB+a/ssXUsrABitt5Z
         dOPSPzX/dGYsooThbNXnMegVbPRpN2QDdNjo4tTA3CUji58LARxj76bHInswtyEdPn33
         vGatHzeY7o4ECYycJZPipbGtv1K4zo5l5hS/fbmNSb8bvcKKs+nXdDvWjxam0AA3WPMj
         8aJtvwKYxCBRyUCwDOUmE7bxHAMcKfQ6eH7Nuq7Yni5IP2GVwrk/W9pnmP5mnjNFdtmr
         hO1qlxNKiugZDkmYp9HqMhM6iKwwtlBwey178mVlPGTtq1t6CrmQT5sBoq28jufIOLV7
         C78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q5Llg35g7sBXSqXzyCxkQj0m1fxRgQ8z2UJ7AdQEjxI=;
        b=PXpBU8hRjfHQ+mV8YiFjZLj9ZSJUEtZ8kN4gSDY7aSbi4/Mrmm8tCQVYwYQgTjT8hg
         w51s30fD1JBxng5RH3QtL83qFw041KYzCvMxnuJqQ99hFnPgxjaO5kbiwWiHB/1PJn8P
         V2VeKtbEL5pDJ9TzSNg82QdeXeCYm7ztxqDWgUPwt8ri6u/PrShlkqDOjxlipyvcVUuM
         VJePlKaqgBdtQ93hgIDm5bRIphYz84xjW3AAg2l+4791T6I6et2t5GAUSJGQbB+CpNNP
         5Z3GGGMCfl3a74uEwE7dqJ6xhivNFkvGDrLat39G06l7GS4HPcfBU2Tjx+dEtwPpJ0i8
         AsJg==
X-Gm-Message-State: AOAM531+ArjPZNBUjXENTj/j8SDMqulRQS1DPDr3DO78kLXfFOUtasKU
        ExKKtoTWkwm2wB5jy+y3iyQfvA==
X-Google-Smtp-Source: ABdhPJxU4ydJeQ6G8dR7MD49W92NmbS3ybWjU8IwHzy7MwgoZC12P1LHJvARUkFViuxmOTHhQb3RWA==
X-Received: by 2002:a63:6c49:: with SMTP id h70mr17795412pgc.150.1595232605493;
        Mon, 20 Jul 2020 01:10:05 -0700 (PDT)
Received: from C02ZK051LVCK.local.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id v11sm16961553pfc.108.2020.07.20.01.10.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 01:10:04 -0700 (PDT)
From:   "hexin.op" <hexin.op@bytedance.com>
To:     airlied@linux.ie, kraxel@redhat.com
Cc:     linux-kernel@vger.kernel.org, "hexin.op" <hexin.op@bytedance.com>,
        Liu Qi <liuqi.16@bytedance.com>
Subject: [PATCH] drm/virtio: fixed memory leak in virtio_gpu_execbuffer_ioctl()
Date:   Mon, 20 Jul 2020 16:09:37 +0800
Message-Id: <20200720080937.95874-1-hexin.op@bytedance.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 2cd7b6f08bc4 ("drm/virtio: add in/out fence support for explicit synchronization")
Signed-off-by: Liu Qi <liuqi.16@bytedance.com>
Signed-off-by: hexin.op <hexin.op@bytedance.com>
---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 5df722072ba0..19c5bc01eb79 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -179,6 +179,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
 			      vfpriv->ctx_id, buflist, out_fence);
+	dma_fence_put(&out_fence->f);
 	virtio_gpu_notify(vgdev);
 	return 0;
 
-- 
2.21.1 (Apple Git-122.3)

