Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA09C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C9332077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbgDBV7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:59:40 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:60284 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726963AbgDBV7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:59:40 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from build.alporthouse.com (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP id 20781929-1500050 
        for multiple; Thu, 02 Apr 2020 22:59:26 +0100
From:   Chris Wilson <chris@chris-wilson.co.uk>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] drm/legacy: Fix type for drm_local_map.offset
Date:   Thu,  2 Apr 2020 22:59:26 +0100
Message-Id: <20200402215926.30714-1-chris@chris-wilson.co.uk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200402203317.GA34560@ubuntu-m2-xlarge-x86>
References: <20200402203317.GA34560@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_local_map.offset is not only used for resource_size_t but also
dma_addr_t which may be of different sizes.

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Fixes: 8e4ff9b56957 ("drm: Remove the dma_alloc_coherent wrapper for internal usage")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Dave Airlie <airlied@gmail.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/drm/drm_legacy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/drm/drm_legacy.h b/include/drm/drm_legacy.h
index dcef3598f49e..aed382c17b26 100644
--- a/include/drm/drm_legacy.h
+++ b/include/drm/drm_legacy.h
@@ -136,7 +136,7 @@ struct drm_sg_mem {
  * Kernel side of a mapping
  */
 struct drm_local_map {
-	resource_size_t offset;	 /**< Requested physical address (0 for SAREA)*/
+	dma_addr_t offset;	 /**< Requested physical address (0 for SAREA)*/
 	unsigned long size;	 /**< Requested physical size (bytes) */
 	enum drm_map_type type;	 /**< Type of memory to map */
 	enum drm_map_flags flags;	 /**< Flags */
-- 
2.20.1

