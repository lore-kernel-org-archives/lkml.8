Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5F8C2D0FC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C51B72242B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="vq2w2pJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388657AbgEMNjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388387AbgEMNjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:39:02 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADA5C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:01 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id k12so26539120wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=73y2EkDX2Dlo8B8Rg2AO0hZwVG6UoIFuwEH7MmnfvIk=;
        b=vq2w2pJBraCI2zP4u8/588HjpEAoDfIH0FZKaHxdyRonCuEfO683f7KTY2yLjJGUlM
         gOXQBdQ0eWCv6MF492fCviR57ZNLYFhTwqgZYPQDNuNoS9WEZIPQ9b2UvGARh2BqvvhJ
         aRc43kp0XLknxr4aWOdzc6E1LOflni8eDsTaG3f597SMVZMcVHcBBq37hIjU4Qya+Q+h
         sZrTWs5UHsg6zKBXf32OF5dz+3wDFyGkSnP4RzYHSYY9RtPxxHvc7Kuvh+3eYMlazV24
         T/IbHPUaqX7uKFWcbEOrbYkzOsqk4jeBYrTBGdpnO9TAkuSjwFadeByWhgnZJcqcOvxk
         UKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=73y2EkDX2Dlo8B8Rg2AO0hZwVG6UoIFuwEH7MmnfvIk=;
        b=MfR3eYaN2jKPyeWefMD33MGOsQZIHj6t+zTjJtlNjefHoM/lQrx/XREwOFvsD2CKo+
         8nBqRi0wWPZ7Eqzu2aWn5OBjOXzK8lHjO21ASxzQ8rv2w/50UnjE2WXxHbq56AHPbH4H
         dt5nF1lhT8+KKZUmk9yxh/5Yj5vCL0KtFw9XkN4S++jan0Ml/ymb79yXYOQn05rMp9Ks
         gnyqp6/c0Qob0sVAfcJIzPYZfceX23RZtLa5KoWozHE1PYRqvAeep1/4jqAUZ3RtrlaJ
         QDTbqQJGDmQ5hx/CyYmkZc+j1A9B/BIBISMQL41tBEdIuDAsz7VFC/IidG9PejS5uUx2
         ygMQ==
X-Gm-Message-State: AGi0PuYt2ybj9eH9p3RRkz+ScBYQ0i/uP5X5f0XceLubYvAp73HOf24o
        2sKyBEKW5kDLciempbGZuoktyQ==
X-Google-Smtp-Source: APiQypJKNnonUlim7ZOi25FTphWD9VrUisBBoAjjUOwOam2+35TMRzU9Zm7owMB+f9WKPUwv0LlXnA==
X-Received: by 2002:a1c:3581:: with SMTP id c123mr32474479wma.150.1589377140295;
        Wed, 13 May 2020 06:39:00 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:59 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 09/11] loop: Rework lo_ioctl() __user argument casting
Date:   Wed, 13 May 2020 15:38:43 +0200
Message-Id: <20200513133845.244903-10-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for a new ioctl that needs to copy_from_user(); makes the
code easier to read as well.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4dc11d954169..31f10da4945e 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1634,6 +1634,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
+	void __user *argp = (void __user *) arg;
 	int err;
 
 	switch (cmd) {
@@ -1646,21 +1647,19 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_STATUS:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status_old(lo,
-					(struct loop_info __user *)arg);
+			err = loop_set_status_old(lo, argp);
 		}
 		break;
 	case LOOP_GET_STATUS:
-		return loop_get_status_old(lo, (struct loop_info __user *) arg);
+		return loop_get_status_old(lo, argp);
 	case LOOP_SET_STATUS64:
 		err = -EPERM;
 		if ((mode & FMODE_WRITE) || capable(CAP_SYS_ADMIN)) {
-			err = loop_set_status64(lo,
-					(struct loop_info64 __user *) arg);
+			err = loop_set_status64(lo, argp);
 		}
 		break;
 	case LOOP_GET_STATUS64:
-		return loop_get_status64(lo, (struct loop_info64 __user *) arg);
+		return loop_get_status64(lo, argp);
 	case LOOP_SET_CAPACITY:
 	case LOOP_SET_DIRECT_IO:
 	case LOOP_SET_BLOCK_SIZE:
-- 
2.26.2.645.ge9eca65c58-goog

