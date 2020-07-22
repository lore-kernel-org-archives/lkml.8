Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276B120792
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 05:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="fZW1F7Dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgGVFTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 01:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgGVFTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 01:19:16 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A65AC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:19:16 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id md7so558487pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 22:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dmd/Tm2NKIlPmtmf250Rr5po/tBi+tVL5ukErGpu6/M=;
        b=fZW1F7DltafThR0vBDMpn78I1muDP0lGZn3RhT1ELTFKpoeX8LXcT8AlQBpWyexuw0
         SaOCdrpFD6Btz0PYfdejP8xgqBzdxb6cIwiEbUkCsix7k0RPv/Rqxd+khvFbANg8mvEu
         Tf8EX+3Fg/sG2aUMJ23I+Lve68oOIld2MKKXqsC3M3Ou35QKn6jaI/Ml3moPaK6lgPTB
         V8xSL3NXBlulAaqHu/8dvSZlaVfJNh+HyBQSe2ZHB+fL6eMRyMb9UT2Ci4ITKksV1gA4
         k8vTH33euyrNNE+FsnGAByJLOlZfWdtTdfhh/9CAv6S5K3f9M8SIRJeRgu4ux08/UjKn
         3xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dmd/Tm2NKIlPmtmf250Rr5po/tBi+tVL5ukErGpu6/M=;
        b=frl5WoG8f9vY+GBY5twtPBxqWtse/fPtIQ4cYxZ4VNGBaUD6QOLvcABMFVeq+xPVPN
         yJ9Vh27NSVuh/bAvj1keCTBz4VPBZz5YLWYAFmuZM2CKmA1UaL34OxMTVSBmT2fAXeeV
         YVFDiQX4UYbw5FDg6sOwvw4QB4YelFDA6jDhWEPuu1Hi77XWzbMdpZu5nyihBdZP465+
         1+8ZCAPrCqVb8XCheq/acXhBtlaXyq+tu2w82RMCmJxdF8+q28pS92YtoUEDtU+rvgaJ
         tq0W7vpo/HR9J4gGIMtftpEBnENkcECSJwgZQzU+u0RDyReeTgraYGOgr31D9VWlPUeO
         OmCw==
X-Gm-Message-State: AOAM532p8jYK0+FUCkchSemcXeu7IzWfPbgzJi7PLUFrGt4QA4RqiBqW
        P/62pbltzk9uN09V7rHAM3shlA==
X-Google-Smtp-Source: ABdhPJyXyJC/r6TNRCFBvIm4BOX5hZWyrt2U6MzGfh0U8fNwL8IQsJTk6C62jeiorB+OWFvXacBrQw==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr26310498pln.16.1595395155749;
        Tue, 21 Jul 2020 22:19:15 -0700 (PDT)
Received: from C02ZK051LVCK.local.net ([61.120.150.77])
        by smtp.gmail.com with ESMTPSA id h3sm4971462pjz.23.2020.07.21.22.19.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 22:19:12 -0700 (PDT)
From:   Xin He <hexin.op@bytedance.com>
To:     airlied@linux.ie, kraxel@redhat.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Xin He <hexin.op@bytedance.com>,
        Qi Liu <liuqi.16@bytedance.com>
Subject: [PATCH] drm/virtio: fix memory leak in virtio_gpu_cleanup_object()
Date:   Wed, 22 Jul 2020 13:18:51 +0800
Message-Id: <20200722051851.72662-1-hexin.op@bytedance.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before setting shmem->pages to NULL, kfree() should
be called.

Signed-off-by: Xin He <hexin.op@bytedance.com>
Reviewed-by: Qi Liu <liuqi.16@bytedance.com>
---
 drivers/gpu/drm/virtio/virtgpu_object.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_object.c b/drivers/gpu/drm/virtio/virtgpu_object.c
index 6ccbd01cd888..703b5cd51751 100644
--- a/drivers/gpu/drm/virtio/virtgpu_object.c
+++ b/drivers/gpu/drm/virtio/virtgpu_object.c
@@ -79,6 +79,7 @@ void virtio_gpu_cleanup_object(struct virtio_gpu_object *bo)
 			}
 
 			sg_free_table(shmem->pages);
+			kfree(shmem->pages);
 			shmem->pages = NULL;
 			drm_gem_shmem_unpin(&bo->base.base);
 		}
-- 
2.21.1 (Apple Git-122.3)

