Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752EEC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE3332077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:44:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=flowbird.group header.i=@flowbird.group header.b="FUCgx68/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgAJPoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:44:18 -0500
Received: from mail-ed1-f98.google.com ([209.85.208.98]:34945 "EHLO
        mail-ed1-f98.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728265AbgAJPoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:44:17 -0500
Received: by mail-ed1-f98.google.com with SMTP id f8so1951157edv.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flowbird.group; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e7IY92TT8uEF1NqXhkjC9P1gwmK8Iq+uyMae8G1wu4o=;
        b=FUCgx68/is4pxqg92nv61jUbkTdzo7UjMjbOPg7uwlk8n2Gt2GVhB904yxL4u5c7WO
         tbdNKo7sZge/WzCQINHfef2PEFf1pokkHHFEBv2xpXXl/3jvg7HR0bndzbZPCm38e2R1
         ch9ARMK9LxRWzWdZV4QDlliHWTS1CF6OQE2fmaaJzIUvahOkrQPviF+5B1T+0Ja662ha
         HSUeEkz1Zj88aTAzUeaPyNT/hIZEQ9P4/s53JFzJwkqS6Gzadp88bMCSCqyePdOq24Ey
         Dkm/wobCC7ExErApoIYNihReiU7ZwjU8b8hzfMdB0xSz5rMDBBB5/8I2aKoADmAH9DgV
         b6Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e7IY92TT8uEF1NqXhkjC9P1gwmK8Iq+uyMae8G1wu4o=;
        b=OCWMtPU1NQkzrWr7tOZt/gM+vfC1a7Fv54dDnxNSERnZ7KmTVlU8IZv4/nxFkE+llk
         E44fRXgZv9Cv7i5M5MXQIfCgmYp7L3Z/Mq3fzglf+uHMF0BNwFifmkqJQiBPuYTx8rFA
         blSSZzX1792UAbglt6mtS8V3eemG6mP/OBgeOU9G2Ot8XFV6gbd5qY+E8xAXcJ+utpF6
         ZyIBOToLNaVZZqucExdDqTCESjZNdLi1/2OgqrfeT1WTkaKw0TIy1bDxA1aHN/ljANoH
         0RX5mY73/d2rhd8OlLOG3EsXOQAB20ePLJceYvceKHaVtLYsNBlCkh8yf3Fh0FtK+Wsq
         QH+g==
X-Gm-Message-State: APjAAAUDpNFy8iHSmJNwv2sqatRLWIQ6SqIB/1OT3Mh+CPsv4Sghvgh2
        dIqeOme9iO3FpfFKaVYNHD03msIxJoMizrkgbqJkxpA6ArrS
X-Google-Smtp-Source: APXvYqzMRumwo2uvpDhr+iKaD3AejHl5zpPhGuDb7wB6fttAGLh6LSvevyEaSIoBaVn7n1CjFdBc18rQs2wN
X-Received: by 2002:a17:906:27cb:: with SMTP id k11mr3662493ejc.301.1578671055111;
        Fri, 10 Jan 2020 07:44:15 -0800 (PST)
Received: from mail.besancon.parkeon.com ([185.149.63.251])
        by smtp-relay.gmail.com with ESMTPS id x1sm17444ejs.70.2020.01.10.07.44.14
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 10 Jan 2020 07:44:15 -0800 (PST)
X-Relaying-Domain: flowbird.group
Received: from [10.32.51.181] (port=36758 helo=PC12445-BES.dynamic.besancon.parkeon.com)
        by mail.besancon.parkeon.com with esmtp (Exim 4.71)
        (envelope-from <martin.fuzzey@flowbird.group>)
        id 1ipwSM-00031I-K5; Fri, 10 Jan 2020 16:44:14 +0100
From:   Martin Fuzzey <martin.fuzzey@flowbird.group>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] binder: fix log spam for existing debugfs file creation.
Date:   Fri, 10 Jan 2020 16:44:01 +0100
Message-Id: <1578671054-5982-1-git-send-email-martin.fuzzey@flowbird.group>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 43e23b6c0b01 ("debugfs: log errors when something goes wrong")
debugfs logs attempts to create existing files.

However binder attempts to create multiple debugfs files with
the same name when a single PID has multiple contexts, this leads
to log spamming during an Android boot (17 such messages during
boot on my system).

Fix this by checking if we already know the PID and only create
the debugfs entry for the first context per PID.

Do the same thing for binderfs for symmetry.

Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
---
 drivers/android/binder.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 976a694..254f87b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5203,10 +5203,11 @@ static int binder_mmap(struct file *filp, struct vm_area_struct *vma)
 
 static int binder_open(struct inode *nodp, struct file *filp)
 {
-	struct binder_proc *proc;
+	struct binder_proc *proc, *itr;
 	struct binder_device *binder_dev;
 	struct binderfs_info *info;
 	struct dentry *binder_binderfs_dir_entry_proc = NULL;
+	bool existing_pid = false;
 
 	binder_debug(BINDER_DEBUG_OPEN_CLOSE, "%s: %d:%d\n", __func__,
 		     current->group_leader->pid, current->pid);
@@ -5239,19 +5240,24 @@ static int binder_open(struct inode *nodp, struct file *filp)
 	filp->private_data = proc;
 
 	mutex_lock(&binder_procs_lock);
+	hlist_for_each_entry(itr, &binder_procs, proc_node) {
+		if (itr->pid == proc->pid) {
+			existing_pid = true;
+			break;
+		}
+	}
 	hlist_add_head(&proc->proc_node, &binder_procs);
 	mutex_unlock(&binder_procs_lock);
 
-	if (binder_debugfs_dir_entry_proc) {
+	if (binder_debugfs_dir_entry_proc && !existing_pid) {
 		char strbuf[11];
 
 		snprintf(strbuf, sizeof(strbuf), "%u", proc->pid);
 		/*
-		 * proc debug entries are shared between contexts, so
-		 * this will fail if the process tries to open the driver
-		 * again with a different context. The priting code will
-		 * anyway print all contexts that a given PID has, so this
-		 * is not a problem.
+		 * proc debug entries are shared between contexts.
+		 * Only create for the first PID to avoid debugfs log spamming
+		 * The printing code will anyway print all contexts for a given
+		 * PID so this is not a problem.
 		 */
 		proc->debugfs_entry = debugfs_create_file(strbuf, 0444,
 			binder_debugfs_dir_entry_proc,
@@ -5259,19 +5265,16 @@ static int binder_open(struct inode *nodp, struct file *filp)
 			&proc_fops);
 	}
 
-	if (binder_binderfs_dir_entry_proc) {
+	if (binder_binderfs_dir_entry_proc && !existing_pid) {
 		char strbuf[11];
 		struct dentry *binderfs_entry;
 
 		snprintf(strbuf, sizeof(strbuf), "%u", proc->pid);
 		/*
 		 * Similar to debugfs, the process specific log file is shared
-		 * between contexts. If the file has already been created for a
-		 * process, the following binderfs_create_file() call will
-		 * fail with error code EEXIST if another context of the same
-		 * process invoked binder_open(). This is ok since same as
-		 * debugfs, the log file will contain information on all
-		 * contexts of a given PID.
+		 * between contexts. Only create for the first PID.
+		 * This is ok since same as debugfs, the log file will contain
+		 * information on all contexts of a given PID.
 		 */
 		binderfs_entry = binderfs_create_file(binder_binderfs_dir_entry_proc,
 			strbuf, &proc_fops, (void *)(unsigned long)proc->pid);
@@ -5281,10 +5284,8 @@ static int binder_open(struct inode *nodp, struct file *filp)
 			int error;
 
 			error = PTR_ERR(binderfs_entry);
-			if (error != -EEXIST) {
-				pr_warn("Unable to create file %s in binderfs (error %d)\n",
-					strbuf, error);
-			}
+			pr_warn("Unable to create file %s in binderfs (error %d)\n",
+				strbuf, error);
 		}
 	}
 
-- 
1.9.1

