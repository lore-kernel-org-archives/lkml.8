Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7206C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 998F8206F1
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lHnY9UVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgC1AEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:04:34 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:60423 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbgC1AEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:04:34 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 87312fee;
        Fri, 27 Mar 2020 23:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=BPXvm8QBjsmfO2gncU0J68R+kso=; b=lHnY9UVPHQV8txCJDSBm
        /qBou90bx9JLt0t32kPkZBBGEybZk6ppAot+UYEZ0daIS/ZNYXnrsvBsuJ4HJPfn
        LfpWFmDgo8tqLIMT1iNLItH9VoM2eLbpMW2iWxyiX4s0KXSWkxPB2VOKUvSamzgO
        fFZEQkLPY8WT6jGtf3UP/tXLT6/HNryWicR6+OO6faN2osiek5NARUqJr0JwZvB+
        wgXDVDt7IHL7wL2n5ecG52dVaHFO/Z7UUiad5D4uTADxfPuyF6uK/tepFZFMdO3e
        xleEYD8fb4ypPR6AVfyvHlijeTLqPLVlqyyotUA5HSzfAbMQdAGNCDhp5G5V0EqQ
        rA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 61147157 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 27 Mar 2020 23:56:58 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        chris@chris-wilson.co.uk, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] drm/i915: check to see if the FPU is available before using it
Date:   Fri, 27 Mar 2020 18:04:22 -0600
Message-Id: <20200328000422.98978-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not safe to just grab the FPU willy nilly without first checking to
see if it's available. This patch adds the usual call to may_use_simd()
and falls back to boring memcpy if it's not available.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/gpu/drm/i915/i915_memcpy.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_memcpy.c b/drivers/gpu/drm/i915/i915_memcpy.c
index fdd550405fd3..7c0e022586bc 100644
--- a/drivers/gpu/drm/i915/i915_memcpy.c
+++ b/drivers/gpu/drm/i915/i915_memcpy.c
@@ -24,6 +24,7 @@
 
 #include <linux/kernel.h>
 #include <asm/fpu/api.h>
+#include <asm/simd.h>
 
 #include "i915_memcpy.h"
 
@@ -38,6 +39,12 @@ static DEFINE_STATIC_KEY_FALSE(has_movntdqa);
 #ifdef CONFIG_AS_MOVNTDQA
 static void __memcpy_ntdqa(void *dst, const void *src, unsigned long len)
 {
+	if (unlikely(!may_use_simd())) {
+		memcpy(dst, src, len);
+		return;
+	}
+
+
 	kernel_fpu_begin();
 
 	while (len >= 4) {
@@ -67,6 +74,11 @@ static void __memcpy_ntdqa(void *dst, const void *src, unsigned long len)
 
 static void __memcpy_ntdqu(void *dst, const void *src, unsigned long len)
 {
+	if (unlikely(!may_use_simd())) {
+		memcpy(dst, src, len);
+		return;
+	}
+
 	kernel_fpu_begin();
 
 	while (len >= 4) {
-- 
2.26.0

