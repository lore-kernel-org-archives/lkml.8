Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363EBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05DFB20760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1K849gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgFJIdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726424AbgFJIdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:33:43 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD00FC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:33:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y18so697010plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=viTnGVmiLyU57YRhDhN8zDuiG6dPY/rXax8ClQE3VoA=;
        b=W1K849gsI1lcFSTB6RepoxDrdXeWXaq0G9ZXRaizv5Xh+XgQ/C+aBDCr+Lxx3C7h4y
         Vo25apgtLyuhLzGSMUs+Fy1iJmYpwqcxZ4/dAMVYUWOpe1xfThgrSJzr+MMKEm0eNdAU
         gakVOHPK4Gg6cpkKhqYdj+ls4TpFbzvpKv8qzN6x8MOM+C3ojLHAEb1my8N1Wjlhltuq
         xHHla5tPWw329KPgQHTAKdZ0upvMyblU44f3ZxHoi/Q16BUHaxbNIzoE79xuvjVfG7ke
         OBJOvIvRzLuqpyAoPZXHM/ZS5OWKV8XRTZ5ftFnxGkSlegROCIe4wey93YwW98cK34OJ
         I/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=viTnGVmiLyU57YRhDhN8zDuiG6dPY/rXax8ClQE3VoA=;
        b=GTlDSG4Yt6933NYMtNH6VUEZYYhZLpZ/ynhU4ThRtINjHUz0Jh+NojhJ4hyn+xF7sL
         FnA0w6kO4kRHomD+tfS6I02WrPPuP22qcNL7QLDD1oCGfBYCP/MRZE57YVOyPhckhhPG
         QEptIK0ICzq2KqHxhr3zif27eJD4+7p1uMbw2Onm4copno5z7RSKNVF0+r1I6/LaB1oI
         Kakaq/KK50RpL3Yr9CkWE0QDSggx1kmrlrYiwrNYfz7b77szIO+dbA4AqKcAjyaQSpX/
         z851avOTGqB0yrBDMQZIH6cE83fhbZP5gTKERmeIxrunxzbBxSGG+HnhlmHZOhVNhpuw
         1yeg==
X-Gm-Message-State: AOAM533tPQ8MfyF94eVidG459PNUFwyWy3pe2HOHodoeGHLzYU/CCRhq
        gcTUgwf2031bqkQ1GpYWIfSuhQ==
X-Google-Smtp-Source: ABdhPJwfZ7TDmgfra7WP8ts+VSQ6aJltH1PLOXX3lLF1IcXFnAO/Bem91V9zrOxF2Zp3LKeY29dLIw==
X-Received: by 2002:a17:90b:190e:: with SMTP id mp14mr1931900pjb.198.1591778023046;
        Wed, 10 Jun 2020 01:33:43 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id w18sm12231562pfq.121.2020.06.10.01.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 01:33:42 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Chenbo Feng <fengc@google.com>, linux-kernel@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org,
        Charan Teja Reddy <charante@codeaurora.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        syzbot+3643a18836bce555bff6@syzkaller.appspotmail.com,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dma-buf: Move dma_buf_release() from fops to dentry_ops
Date:   Wed, 10 Jun 2020 14:03:33 +0530
Message-Id: <20200610083333.455-1-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Charan Teja reported a 'use-after-free' in dmabuffs_dname [1], which
happens if the dma_buf_release() is called while the userspace is
accessing the dma_buf pseudo fs's dmabuffs_dname() in another process,
and dma_buf_release() releases the dmabuf object when the last reference
to the struct file goes away.

I discussed with Arnd Bergmann, and he suggested that rather than tying
the dma_buf_release() to the file_operations' release(), we can tie it to
the dentry_operations' d_release(), which will be called when the last ref
to the dentry is removed.

The path exercised by __fput() calls f_op->release() first, and then calls
dput, which eventually calls d_op->d_release().

In the 'normal' case, when no userspace access is happening via dma_buf
pseudo fs, there should be exactly one fd, file, dentry and inode, so
closing the fd will kill of everything right away.

In the presented case, the dentry's d_release() will be called only when
the dentry's last ref is released.

Therefore, lets move dma_buf_release() from fops->release() to
d_ops->d_release().

Many thanks to Arnd for his FS insights :)

[1]: https://lore.kernel.org/patchwork/patch/1238278/

Fixes: bb2bb9030425 ("dma-buf: add DMA_BUF_SET_NAME ioctls")
Reported-by: syzbot+3643a18836bce555bff6@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org> [5.3+]
Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: Charan Teja Reddy <charante@codeaurora.org>
Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
---
 drivers/dma-buf/dma-buf.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 01ce125f8e8d..92ba4b6ef3e7 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -54,8 +54,11 @@ static char *dmabuffs_dname(struct dentry *dentry, char *buffer, int buflen)
 			     dentry->d_name.name, ret > 0 ? name : "");
 }
 
+static void dma_buf_release(struct dentry *dentry);
+
 static const struct dentry_operations dma_buf_dentry_ops = {
 	.d_dname = dmabuffs_dname,
+	.d_release = dma_buf_release,
 };
 
 static struct vfsmount *dma_buf_mnt;
@@ -77,14 +80,14 @@ static struct file_system_type dma_buf_fs_type = {
 	.kill_sb = kill_anon_super,
 };
 
-static int dma_buf_release(struct inode *inode, struct file *file)
+static void dma_buf_release(struct dentry *dentry)
 {
 	struct dma_buf *dmabuf;
 
-	if (!is_dma_buf_file(file))
-		return -EINVAL;
+	if (dentry->d_op != &dma_buf_dentry_ops)
+		return;
 
-	dmabuf = file->private_data;
+	dmabuf = dentry->d_fsdata;
 
 	BUG_ON(dmabuf->vmapping_counter);
 
@@ -110,7 +113,6 @@ static int dma_buf_release(struct inode *inode, struct file *file)
 	module_put(dmabuf->owner);
 	kfree(dmabuf->name);
 	kfree(dmabuf);
-	return 0;
 }
 
 static int dma_buf_mmap_internal(struct file *file, struct vm_area_struct *vma)
@@ -412,7 +414,6 @@ static void dma_buf_show_fdinfo(struct seq_file *m, struct file *file)
 }
 
 static const struct file_operations dma_buf_fops = {
-	.release	= dma_buf_release,
 	.mmap		= dma_buf_mmap_internal,
 	.llseek		= dma_buf_llseek,
 	.poll		= dma_buf_poll,
-- 
2.27.0

