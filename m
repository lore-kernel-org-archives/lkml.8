Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68298CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5603D223E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="Kg9qJJ1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbgEMNi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbgEMNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:38:53 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF01C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:53 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f134so14416834wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0D6BkdLn12sF+QPBQ9DDFZok3hDXQNtAmE1mTHFkes=;
        b=Kg9qJJ1o9t8EF/BBzAGeSYZEi/IVzeB/gtMvBV3ykUZcYKhBQJTacySLMWhotnuumL
         kaa1fEmfVhNVHZToCs0GVKJcFAJduQJBeWBU/PAINkcgzkZT8S/JJGcY/ts+BR9gkdt0
         J+Ioo5EnFFigVarmb50yOe1/CFOfStep9MaGkmB30NcEplHVv9abRmrLG9xyYkwp+phD
         4HkQID2tLdB3roHkDx4GCPiax4+Jbqk4rotVnmP9kNVcnMqVQrH/3E3meAnsVpLEC0zV
         HRnuVBnp6u9L+4CEgqTr6FyzQ/LG0oocgDekKw+2cFwClUBjLoLk5sbBsUQ59MFkV+lc
         HIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0D6BkdLn12sF+QPBQ9DDFZok3hDXQNtAmE1mTHFkes=;
        b=kt4Oq5KlrO68NKZcBuWrGK5bRL71In+LZ0WeKhqLM9gZo6Ysxh8at31va3au+tV3SG
         yOrPu5Z5TXaYOATPfGhB3BIoE7zxp56gmqCNbWUr8c4kG4yMhUFSofkeFipD2yIyx7MC
         jwiUkN9dXAiATxAWBEeHaE6/yP9j209BXBjdfyWbXnGDKWUUmJ+kmgEyiLoOap3pwX5P
         FKuRDnxGQJM7cSlbbUle8SsDF7hkv1pO5oWNeGIDkS2kIgLfE/+cGDhylUxsbypi3KGg
         ggpCY3GytNJ3WVgBZI+az4NneqaZVJBKtry9lkD2sKekDaokykIZGuUqmnfn66ui7zTl
         M2bQ==
X-Gm-Message-State: AGi0PuaTq3KtFgod6MEG5IFtwhJMgEm6koBDWHy7hFZG1LiUlBU3Bf+z
        Ls7T6Oj6ltpFrMmedNUZS6q/kw==
X-Google-Smtp-Source: APiQypL2vNZ1Uo3ORB7H30R0+fCegEqQ56XS8YTx7EIhM/40krnBpL7pemSe51y129kmdwDXRg33MQ==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr29616989wml.117.1589377132142;
        Wed, 13 May 2020 06:38:52 -0700 (PDT)
Received: from maco2.ams.corp.google.com (a83-162-234-235.adsl.xs4all.nl. [83.162.234.235])
        by smtp.gmail.com with ESMTPSA id m6sm26202653wrq.5.2020.05.13.06.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:38:51 -0700 (PDT)
From:   Martijn Coenen <maco@android.com>
To:     axboe@kernel.dk, hch@lst.de, ming.lei@redhat.com
Cc:     narayan@google.com, zezeozue@google.com, maco@google.com,
        kernel-team@android.com, bvanassche@acm.org,
        Chaitanya.Kulkarni@wdc.com, jaegeuk@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martijn Coenen <maco@android.com>
Subject: [PATCH v5 02/11] loop: Remove sector_t truncation checks
Date:   Wed, 13 May 2020 15:38:36 +0200
Message-Id: <20200513133845.244903-3-maco@android.com>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513133845.244903-1-maco@android.com>
References: <20200513133845.244903-1-maco@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sector_t is now always u64, so we don't need to check for truncation.

Signed-off-by: Martijn Coenen <maco@android.com>
---
 drivers/block/loop.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index f1754262fc94..00de7fec0ed5 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -228,24 +228,20 @@ static void __loop_update_dio(struct loop_device *lo, bool dio)
 		blk_mq_unfreeze_queue(lo->lo_queue);
 }
 
-static int
+static void
 figure_loop_size(struct loop_device *lo, loff_t offset, loff_t sizelimit)
 {
 	loff_t size = get_size(offset, sizelimit, lo->lo_backing_file);
-	sector_t x = (sector_t)size;
 	struct block_device *bdev = lo->lo_device;
 
-	if (unlikely((loff_t)x != size))
-		return -EFBIG;
 	if (lo->lo_offset != offset)
 		lo->lo_offset = offset;
 	if (lo->lo_sizelimit != sizelimit)
 		lo->lo_sizelimit = sizelimit;
-	set_capacity(lo->lo_disk, x);
+	set_capacity(lo->lo_disk, size);
 	bd_set_size(bdev, (loff_t)get_capacity(bdev->bd_disk) << 9);
 	/* let user-space know about the new size */
 	kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
-	return 0;
 }
 
 static inline int
@@ -1003,10 +999,8 @@ static int loop_set_fd(struct loop_device *lo, fmode_t mode,
 	    !file->f_op->write_iter)
 		lo_flags |= LO_FLAGS_READ_ONLY;
 
-	error = -EFBIG;
 	size = get_loop_size(lo, file);
-	if ((loff_t)(sector_t)size != size)
-		goto out_unlock;
+
 	error = loop_prepare_queue(lo);
 	if (error)
 		goto out_unlock;
@@ -1328,10 +1322,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 				lo->lo_device->bd_inode->i_mapping->nrpages);
 			goto out_unfreeze;
 		}
-		if (figure_loop_size(lo, info->lo_offset, info->lo_sizelimit)) {
-			err = -EFBIG;
-			goto out_unfreeze;
-		}
+		figure_loop_size(lo, info->lo_offset, info->lo_sizelimit);
 	}
 
 	memcpy(lo->lo_file_name, info->lo_file_name, LO_NAME_SIZE);
@@ -1534,7 +1525,9 @@ static int loop_set_capacity(struct loop_device *lo)
 	if (unlikely(lo->lo_state != Lo_bound))
 		return -ENXIO;
 
-	return figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+	figure_loop_size(lo, lo->lo_offset, lo->lo_sizelimit);
+
+	return 0;
 }
 
 static int loop_set_dio(struct loop_device *lo, unsigned long arg)
-- 
2.26.2.645.ge9eca65c58-goog

