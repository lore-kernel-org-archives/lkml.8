Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4EDC54E8F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC46F2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XSlecak9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgEKJL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgEKJL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:11:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC7FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:11:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s8so9928972wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q7OJr2fNjgGIcJIqqF9ej5dw8+vyB2iSNpGREcUJdJ8=;
        b=XSlecak9WF0+12diZ+csclqCd6URlr2zAoK8NqOOevNyeI615JACkJ6RVjZvHhQMm/
         cZGgYTHh6V8wa/pbt1dwPjKLdID/v2MfGPl4KhtWRCcVKYJfw4ylih3zuyirqJGbi73q
         mJOsRI5Mf796KuLVu06LlUNBFr7NHZpM8jVno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q7OJr2fNjgGIcJIqqF9ej5dw8+vyB2iSNpGREcUJdJ8=;
        b=cnCS3/tGKhig0DQPkZcD8RlehQsEqQCZVKcpX2TNT+SV6q3UNVpsqNBEzYp1ef8r9C
         rI+DD4U1x4vrhXIEJqrpjHLofnzWUNIucm6/8lUumNSZKGpzAvypyV+jz6mXMSMXMSIw
         u/m64pZyJJxNstcfll/eBmdMSrHTq1WKOGbdL25Ws4gL/XBGCcjGNaM00fBa/RobNzIR
         aD3qz4RejBuCHqaRu/aEwiy0XRb/bZl6TmIkNVcNvdkT95PaCyrYepCUZY9hAd46ZDWV
         q4x0mKztpA5qt1Gqjd1dCW2KmedrA+X4j/puoMhO2q3Ks4GmcVf9HE+3mybK7hkIG+3v
         fVsw==
X-Gm-Message-State: AGi0PuZSrDQd3ByD+n/UEfgwiKde8ZkEtYgpyrOcPAXUr40u6oOt4wyu
        DgNZX1tPvezMaXarT5m1YzQxGOXIQG0=
X-Google-Smtp-Source: APiQypKTOisFnohd+WRO0Z88W2Yg66YiWX7rj46BoIw2L57BnjAgP/PH17CP0/qQS37ikw0XH2izsw==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr6637314wrp.427.1589188314245;
        Mon, 11 May 2020 02:11:54 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t4sm17506299wri.54.2020.05.11.02.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 02:11:53 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org
Subject: [PATCH 2/3] dma-fence: use default wait function for mock fences
Date:   Mon, 11 May 2020 11:11:41 +0200
Message-Id: <20200511091142.208787-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
References: <20200511091142.208787-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No need to micro-optmize when we're waiting in a mocked object ...

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: linux-media@vger.kernel.org
Cc: linaro-mm-sig@lists.linaro.org
---
 drivers/dma-buf/st-dma-fence.c | 41 ----------------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index e593064341c8..8166d2984702 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -33,50 +33,9 @@ static void mock_fence_release(struct dma_fence *f)
 	kmem_cache_free(slab_fences, to_mock_fence(f));
 }
 
-struct wait_cb {
-	struct dma_fence_cb cb;
-	struct task_struct *task;
-};
-
-static void mock_wakeup(struct dma_fence *f, struct dma_fence_cb *cb)
-{
-	wake_up_process(container_of(cb, struct wait_cb, cb)->task);
-}
-
-static long mock_wait(struct dma_fence *f, bool intr, long timeout)
-{
-	const int state = intr ? TASK_INTERRUPTIBLE : TASK_UNINTERRUPTIBLE;
-	struct wait_cb cb = { .task = current };
-
-	if (dma_fence_add_callback(f, &cb.cb, mock_wakeup))
-		return timeout;
-
-	while (timeout) {
-		set_current_state(state);
-
-		if (test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &f->flags))
-			break;
-
-		if (signal_pending_state(state, current))
-			break;
-
-		timeout = schedule_timeout(timeout);
-	}
-	__set_current_state(TASK_RUNNING);
-
-	if (!dma_fence_remove_callback(f, &cb.cb))
-		return timeout;
-
-	if (signal_pending_state(state, current))
-		return -ERESTARTSYS;
-
-	return -ETIME;
-}
-
 static const struct dma_fence_ops mock_ops = {
 	.get_driver_name = mock_name,
 	.get_timeline_name = mock_name,
-	.wait = mock_wait,
 	.release = mock_fence_release,
 };
 
-- 
2.26.2

