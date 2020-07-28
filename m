Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256EFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02295206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tebaVCGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgG1Lxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729183AbgG1Lxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:53:38 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D06FC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:53:38 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ed14so8965972qvb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9b0/x+SNOsArF0QozJjz6aJQuh2KJ70gscVHnalujy4=;
        b=tebaVCGFtEwcxHEM2mSMLHj+/y/YIqY5F9PfjQr+R28mNZgbYk25oEbZZId/XZ0s3P
         tyGFy7H5tAKQH/KcvFG7RcKLdtt/qqcX2osS0vTQJ/3rUpnTnbtfiDJ18KDKt9nZIzGb
         jioEWFF54X/RJ4UBRAI9O+jT36f7HD+T/xOTD9lKZ+UDK636bylzcmIRkD7DOA9185ON
         jJG7VOHFIS3KDo49DOPfTt8B8gh1BvSt7q/oevhavy3mNdL7jkhDMD98eP3cCfzNmA6a
         4JHhj/cTKGPEzg0ULWSgB+t3qfMc0wvywvSPhcRbk49lv6ar4UEgPv6Ss42pOY9LvMo+
         N4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9b0/x+SNOsArF0QozJjz6aJQuh2KJ70gscVHnalujy4=;
        b=jcQwQih0c/nlc1Kn/kTHL8B+24CKvKi9t6lGyIryHltZTPTPCJ26gEd9LJsPs/gBHv
         gH4q8sLcN65ncEOVWcf5R5xW8g1CygVGV4iM5AHING1w7HgwLwSk9FDLeJ2oi7NwUdKL
         jrtgoC36mlp0H9pXRGfqFzKbFAaJEs12psV/ULOs96mDIZt/RJ3BY0p93H0zAkStEojH
         mXazQOffXKgwZQDFXbOOvQzD5C813Mlo8NZFhEuTKdtItwmBWbaUG15kZ/+PGxmG9jG5
         HH8ZYEHTIoHuU56Y2zR50n3hJmfR4HqBHrlSuKqX1+7EXz12nrBhumn0rkZEI2aaoqIw
         HRKA==
X-Gm-Message-State: AOAM532gjR34hjPLZ86PgvgZCiBqsMGF/rDqfo3CaaVHQl4AonZtDTyb
        IbnzDkRePVxpg1og5WYJIA==
X-Google-Smtp-Source: ABdhPJytWHbSuKSgdqrZHnoY6Cfo5vrUorIiwqfDq+wpVnip+5M/a1iy0umq4my1/dRXaNveQev4oQ==
X-Received: by 2002:ad4:4152:: with SMTP id z18mr154690qvp.42.1595937217951;
        Tue, 28 Jul 2020 04:53:37 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id t65sm21273750qkf.119.2020.07.28.04.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 04:53:37 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Peilin Ye <yepeilin.cs@gmail.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [Linux-kernel-mentees] [PATCH v2] drm/bufs: Prevent kernel-infoleak in copy_one_buf()
Date:   Tue, 28 Jul 2020 07:52:10 -0400
Message-Id: <20200728115210.408486-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728014343.341303-1-yepeilin.cs@gmail.com>
References: <20200728014343.341303-1-yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently `struct drm_buf_desc` is defined as follows:

struct drm_buf_desc {
	int count;
	int size;
	int low_mark;
	int high_mark;
	enum {
		_DRM_PAGE_ALIGN = 0x01,
		_DRM_AGP_BUFFER = 0x02,
		_DRM_SG_BUFFER = 0x04,
		_DRM_FB_BUFFER = 0x08,
		_DRM_PCI_BUFFER_RO = 0x10
	} flags;
	unsigned long agp_start;
};

copy_one_buf() is potentially copying uninitialized kernel stack memory
to userspace, since the compiler may leave such "holes" (around `.flags`
and `.agp_start` fields) in this statically allocated structure. Prevent
it by initializing `v` with memset().

Cc: stable@vger.kernel.org
Fixes: 5c7640ab6258 ("switch compat_drm_infobufs() to drm_ioctl_kernel()")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v2:
    - Improve commit description. (Suggested by Arnd Bergmann
      <arnd@arndb.de>)

 drivers/gpu/drm/drm_bufs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index a0735fbc144b..f99cd4a3f951 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -1349,10 +1349,14 @@ static int copy_one_buf(void *data, int count, struct drm_buf_entry *from)
 {
 	struct drm_buf_info *request = data;
 	struct drm_buf_desc __user *to = &request->list[count];
-	struct drm_buf_desc v = {.count = from->buf_count,
-				 .size = from->buf_size,
-				 .low_mark = from->low_mark,
-				 .high_mark = from->high_mark};
+	struct drm_buf_desc v;
+
+	memset(&v, 0, sizeof(v));
+
+	v.count = from->buf_count;
+	v.size = from->buf_size;
+	v.low_mark = from->low_mark;
+	v.high_mark = from->high_mark;
 
 	if (copy_to_user(to, &v, offsetof(struct drm_buf_desc, flags)))
 		return -EFAULT;
-- 
2.25.1

