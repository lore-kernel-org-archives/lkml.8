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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37AAC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5E920672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPuGtMvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgG1Bpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgG1Bpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:45:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04700C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:45:32 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l23so17332737qkk.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YjnA1D1K7ElpFXMn7MlHX1aExmoTvW00G3z3st5LogM=;
        b=qPuGtMvXjFKTqPMP4hVzimuIwTZQ1FlTw4vqUKaNSKU99KqaO6Im988hL6y6XkP5V2
         qVOFVZeATU9MV0hSUENBapGZ7GLtyN/Zblmf/4fCo1UH9ehlDGFpi9aqTjRKGiQ6zRBU
         ZnBAzkC5VY3aa0sUUqOhdrf+7j42xFbvu//GIiSzF9TiQsOp/yfcYIX1oGvGIKFyxM9S
         k6HkJu8JFS6URc1k9uYTJoCOa4PJ5UY0inf+26gI6iMl69ihRgNzPEzBeVcRFFJQcV9I
         jbLBMpuzcqx06gqVV3mMyG3T5p5MGCTM/NG7cd9z8NytqeSC9Ht4zrrYiKX3jZsT64Y/
         p3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YjnA1D1K7ElpFXMn7MlHX1aExmoTvW00G3z3st5LogM=;
        b=C16gzsBZGpXES8XKv/d+b5CcLMNNTq5HjHibJWiE9qKny+TztyWvhtJTnjRxsNbxWJ
         c/CReLYeow3CHwt506hxamqaLGBnN8w4DD+YvsjUMHII98qFwffjKykMRCGDTnaEHwLO
         VDOC+6RokWp9R4+FLqYmx6wPfMfUqu9ozHUu3+lFNFL+AxhlPBo8x38R3MmCGrPPbJRR
         OPSiGVV0sGbOEwTBbVsmTPgCxFovrbY34WWvTE83yVXW/b6UnNOzy4muAbr6frMjrkxa
         s0oXE2xBDcDZemQiMeOsCtisf9lartHG1BM8MzLa5gipJYep2B1YCKFw0vxYZXJQ+Rct
         +i2A==
X-Gm-Message-State: AOAM532BifX0QJlmcuT4JxPeOOab+y6g8n+I38uPUkhk/B65Aur+1LMs
        sCfEaxqkIDoSH6Esnso4Hg==
X-Google-Smtp-Source: ABdhPJxbAIs557upvT1yY+aGvvScvjxCli+NZkmPpkJ7H5akQf1y/Q9yw/gGLnLoqu78WGuR11jD5A==
X-Received: by 2002:a05:620a:553:: with SMTP id o19mr24583291qko.46.1595900731268;
        Mon, 27 Jul 2020 18:45:31 -0700 (PDT)
Received: from localhost.localdomain (c-76-119-149-155.hsd1.ma.comcast.net. [76.119.149.155])
        by smtp.gmail.com with ESMTPSA id d14sm16585473qti.41.2020.07.27.18.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 18:45:30 -0700 (PDT)
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
Subject: [Linux-kernel-mentees] [PATCH] drm/bufs: Prevent kernel-infoleak in copy_one_buf()
Date:   Mon, 27 Jul 2020 21:43:43 -0400
Message-Id: <20200728014343.341303-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

copy_one_buf() is copying uninitialized stack memory to userspace due to
the compiler not initializing holes in statically allocated structures.
Fix it by initializing `v` with memset().

Cc: stable@vger.kernel.org
Fixes: 5c7640ab6258 ("switch compat_drm_infobufs() to drm_ioctl_kernel()")
Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
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

