Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4027C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4922073B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438202AbgE2Alx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438137AbgE2Als (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:41:48 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7590C08C5C8;
        Thu, 28 May 2020 17:41:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeT5m-00HFgQ-AA; Fri, 29 May 2020 00:41:46 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH 3/5] i915 compat ioctl(): just use drm_ioctl_kernel()
Date:   Fri, 29 May 2020 01:41:43 +0100
Message-Id: <20200529004145.4111807-3-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529004145.4111807-1-viro@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529004145.4111807-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

compat_alloc_user_space() is a bad kludge; the sooner it goes, the
better...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/gpu/drm/i915/i915_ioc32.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_ioc32.c b/drivers/gpu/drm/i915/i915_ioc32.c
index 8e45ca3d2ede..55b97c3a3dde 100644
--- a/drivers/gpu/drm/i915/i915_ioc32.c
+++ b/drivers/gpu/drm/i915/i915_ioc32.c
@@ -47,20 +47,16 @@ static int compat_i915_getparam(struct file *file, unsigned int cmd,
 				unsigned long arg)
 {
 	struct drm_i915_getparam32 req32;
-	drm_i915_getparam_t __user *request;
+	struct drm_i915_getparam req;
 
 	if (copy_from_user(&req32, (void __user *)arg, sizeof(req32)))
 		return -EFAULT;
 
-	request = compat_alloc_user_space(sizeof(*request));
-	if (!access_ok(request, sizeof(*request)) ||
-	    __put_user(req32.param, &request->param) ||
-	    __put_user((void __user *)(unsigned long)req32.value,
-		       &request->value))
-		return -EFAULT;
+	req.param = req32.param;
+	req.value = compat_ptr(req32.value);
 
-	return drm_ioctl(file, DRM_IOCTL_I915_GETPARAM,
-			 (unsigned long)request);
+	return drm_ioctl_kernel(file, i915_getparam_ioctl, &req,
+				DRM_RENDER_ALLOW);
 }
 
 static drm_ioctl_compat_t *i915_compat_ioctls[] = {
-- 
2.11.0

