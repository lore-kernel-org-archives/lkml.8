Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653D5C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA492082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEGjpnrs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgBKMlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:41:21 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44467 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbgBKMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:41:20 -0500
Received: by mail-pl1-f193.google.com with SMTP id d9so4222959plo.11;
        Tue, 11 Feb 2020 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=drrsRBzj4RiwpiBW9ey8iRTvmpIMivo93MnlfeZUAvY=;
        b=IEGjpnrs+ud3FKZxjAeWy+ZMsuPBJVltdD5jjB6tkPT7+74b06q9HkrLZpyMQVigT3
         0H0Wqysbe8Z4Y8/5gP5YQXVR4/NBM39KPSKUvJ6CnSDAbZulxO31ZiFs1uRxz2NdHmrc
         BGb12U5MlE0ve46kxM9PG068WC3Q26/uMMPaqw+PEmJ7MVjbCoTu2C9P/4Tf/3RS00uK
         Gm3iCZjcocwzEoy21c99SPmYOGScL/SEGIA0kKibnXWqC6BGuwCtzHZ5FTOBozPKCe0p
         0GunEaf9fDE9CZwwA3MY20h2ORRHIsNSZZLk14s2K51J+7fkWsgz9Sdu8rLIIIsHK0E8
         YDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=drrsRBzj4RiwpiBW9ey8iRTvmpIMivo93MnlfeZUAvY=;
        b=AYwsC5k6Egwo5/qBMJvRPIjOz7GgejmFeAcHQD1Sf0LXgyMKPEkqzVbE7eSOETiIEW
         PbFNkzOyoCTlaG7YJFD7zxMsDltZuwAEK8kpsxxQS2cYE8xXeK0Gt3c0WpOToCVrUKpj
         U3XmyoPnml1gh0HMZZAb5aFj4y8mcbEitkUoBzc3ToUIRoAZbZSdqd01X9yBizrqLgYJ
         JETpB5tOAnOY/UXvfYa4KVW731Y3QfAH5ZKFyAz2sUDx8h9xtv8StADZScCoQ7yCGhUa
         1RiIy6u1usI70iN+uoEBHkNSoqMVwB4OFwIHudFVKiHTMK05cBbq+9JrqziSpefS1nbw
         nSig==
X-Gm-Message-State: APjAAAVGztDfcd72qA2TWMIzL9J3gN+J5gvjjvDEoMyThieV6JdQtSQi
        7vfv0MiTgT/xZ6QZ2S+l/NqG8gTFNTo=
X-Google-Smtp-Source: APXvYqytWIydk0fxK+306Zof47c7NDMYqtQimBpZ3pEPaeFI2uhGuxlG7EmH4VvXbTH7AzPFaVhFxA==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr3586183pjz.116.1581424879524;
        Tue, 11 Feb 2020 04:41:19 -0800 (PST)
Received: from localhost.localdomain ([2409:4041:69c:214f:144f:bb39:afc3:51b0])
        by smtp.gmail.com with ESMTPSA id d1sm3876789pgj.79.2020.02.11.04.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 04:41:18 -0800 (PST)
From:   Pragat Pandya <pragat.pandya@gmail.com>
To:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.or, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, linux-fsdevel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Pragat Pandya <pragat.pandya@gmail.com>
Subject: [PATCH 11/18] staging: exfat: Rename function "ffsRemoveFile" to "ffs_remove_file"
Date:   Tue, 11 Feb 2020 18:08:52 +0530
Message-Id: <20200211123859.10429-12-pragat.pandya@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211123859.10429-1-pragat.pandya@gmail.com>
References: <20200211123859.10429-1-pragat.pandya@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch warning: Avoid CamelCase
Change all occurrences of function "ffsRemoveFile" to "ffs_remove_file"
in source.

Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 51893f8c3e92..05a4012c5c62 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -1296,7 +1296,7 @@ static int ffs_move_file(struct inode *old_parent_inode, struct file_id_t *fid,
 	return ret;
 }
 
-static int ffsRemoveFile(struct inode *inode, struct file_id_t *fid)
+static int ffs_remove_file(struct inode *inode, struct file_id_t *fid)
 {
 	s32 dentry;
 	int ret = 0;
@@ -2399,7 +2399,7 @@ static int exfat_unlink(struct inode *dir, struct dentry *dentry)
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
 
-	err = ffsRemoveFile(dir, &(EXFAT_I(inode)->fid));
+	err = ffs_remove_file(dir, &(EXFAT_I(inode)->fid));
 	if (err)
 		goto out;
 
@@ -2449,7 +2449,7 @@ static int exfat_symlink(struct inode *dir, struct dentry *dentry,
 	err = ffs_write_file(dir, &fid, (char *)target, len, &ret);
 
 	if (err) {
-		ffsRemoveFile(dir, &fid);
+		ffs_remove_file(dir, &fid);
 		goto out;
 	}
 
-- 
2.17.1

