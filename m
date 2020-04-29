Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF392C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF2B72082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="a2nlCP4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgD2OEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728122AbgD2OD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:03:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13912C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:57 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k1so2697177wrx.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76X/UFv1Q/0+UD4XjTZigIYFIhcVyVy/pGs0yDiv+KI=;
        b=a2nlCP4kujk1JdspGfkSvRMjfAyKHgNcbh7eDZ2YsgnmMhWW8SMQaYeHm3YKbrRGKt
         OyuLq94Sxd0aok+1tgG6swhbvvcYqLrMRtEDd277rIdyChH+nzHZwMxN8bapKTMEHjbo
         1nvS6vLTt6AaVowqe3YLrqci7+9VD1OSyhmjpSytgr9L/w1M6GKPS9+vEHIOauzRYz5Z
         03e3erq/GXuzs3GJr0XzyEgkx4bxLIieEcR/EAXLEo5vxRyEaW7XcZd5Hhfyvd5Rpnq4
         +UvAdvoFaE257ABnFIM63T3Ld6C+pePjL3nQqcZORFqKGUQZMgFcAtmNfyT4l8nss7wh
         ZRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76X/UFv1Q/0+UD4XjTZigIYFIhcVyVy/pGs0yDiv+KI=;
        b=eHfEHpxClKn21Sjug+ymcdsjGLLXzLZseWO2gUM3u0yjhOxWgavMDZfub72zm1KaDf
         l/PdqS8cGDV6+R2GTkoI++VC7ufk0LkP3zZBTATnnPM2rL+/CbehEYaJ899U2y8lvQR1
         VCY2CKrZouFDpyNhoPdaEtrKlZJQdBk5F7tfpO0Hm6VE0r+FdEKlYTqX8mdipe1rVIPD
         UzhU4LfQ4l5r78CqxyQC09pY4hxwAXvg/xFfoIpVCBqI946BUrTn05nGss1f7M6U1bPM
         J7Y968q0gjmOgUmm+Uf39w717KsPI0Dez4N6BXaNBSz2ig+IZkX5jLbB7MClAdKqISm7
         RAfA==
X-Gm-Message-State: AGi0PuZ65EdGA7lslUQ8pvCLImRVjU99ciG5nBnPHqyhIDzrLnxhG/Bn
        pglcpbxW8u9Cyat2K2dG5p9Yug==
X-Google-Smtp-Source: APiQypKa3V4BSnAtNrL9VpaMlBURZo2D72JJgh7YSC6FI2/Dx8zbM4CM5D/LdfbzcQb8QMrT0MHzIg==
X-Received: by 2002:a05:6000:110a:: with SMTP id z10mr39247853wrw.389.1588169035863;
        Wed, 29 Apr 2020 07:03:55 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id d133sm8887008wmc.27.2020.04.29.07.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:03:54 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, kernel-team@android.com,
        maco@google.com, bvanassche@acm.org, Chaitanya.Kulkarni@wdc.com,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martijn Coenen <maco@android.com>
Subject: [PATCH v4 08/10] loop: Rework lo_ioctl() __user argument casting
Date:   Wed, 29 Apr 2020 16:03:39 +0200
Message-Id: <20200429140341.13294-9-maco@android.com>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
In-Reply-To: <20200429140341.13294-1-maco@android.com>
References: <20200429140341.13294-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for a new ioctl that needs to copy_from_user(); makes the
code easier to read as well.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 60ba1ed95d77..f172a64333aa 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1659,6 +1659,7 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
 	unsigned int cmd, unsigned long arg)
 {
 	struct loop_device *lo = bdev->bd_disk->private_data;
+	void __user *argp = (void __user *) arg;
 	int err;
 
 	switch (cmd) {
@@ -1671,21 +1672,19 @@ static int lo_ioctl(struct block_device *bdev, fmode_t mode,
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
2.26.2.303.gf8c07b1a785-goog

