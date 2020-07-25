Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 089A4C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DABFE2070C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tfz-net.20150623.gappssmtp.com header.i=@tfz-net.20150623.gappssmtp.com header.b="YMwNAYIX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgGZCE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgGZCE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:04:27 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069BC08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 19:04:27 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dm12so5910437qvb.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 19:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Omdab1nC5MtSModjV2PS7fPsUJ+lDgcnp0n1JPTjxRo=;
        b=YMwNAYIX8mFOI7SAohY0EXyneQkLsbKI/55OHSL4POy90WKjrWT7T0bEST+X/H+3wV
         tz3rPlwfeABkbiKw+Lwilgn4o61YnXv/xm9/E38LQWujC0vkdC4Zg0QvRWDTFGyNvadd
         QjZoIoz9146mbVyAwiCce/zNKtBIwPQ7JjXqu6+f9gIohhOpIS4KylfUZWwVKY7tm8vJ
         ItP44HhvNmiinuTlfGdKWkLokGamprvTZW0iB8ryznQsvv5FrVglV4x5nNA/6b17A88n
         tE34iMJTwoFnKXsNXRI+gQRBQKGPUzu8pMT6lEMt0S+j8EZOST8WEu/oDJY4t0CpeIYz
         u1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Omdab1nC5MtSModjV2PS7fPsUJ+lDgcnp0n1JPTjxRo=;
        b=B8KCEBpHSMJ33iX5Joo39mHsrbEanJoviUk/rYg7vFkQNSMARnkygKkbZ8zSl2FrEA
         1TG0vxM/6n9WSyTUboaNI/KtOrbE91XeaSKwyGe/m70B7JmT16o5wESoL1hVYsqv9poE
         ooTULPzxR3BXPRoJkuWM419/1/H/63ElrRerH3gotLp9V8Kn5tz8kynV1XjBpsm5RNd0
         4IFaE5yMGwo3ZfQGdA9CHx0h3j+DV0Rf8k77SUSC2S3N5cnU4YoU+uZhtO2RvaVyqJGS
         CLNHks75LVX3loP0c7deuKk8Frs/rtRc7H5Fl4Na7GTFSnfETmqhxydFKLZQKF4xR7Ly
         Z6hw==
X-Gm-Message-State: AOAM532FT9E7IDcaHhlJlsmI2im26H9UJ4sDR+nHQ/xRzabLgBSg5q+s
        2JnGL71L1LsAqcs5S+kyTCpA3WY8GOjcNQ==
X-Google-Smtp-Source: ABdhPJyu2yaYA5YqCBXbtUuWqfBWJxFzSIYLeivhZi6g24tvrR/LD6i0Lr1beQ4D7FQtBVIz3jVCQQ==
X-Received: by 2002:a0c:a2c1:: with SMTP id g59mr16889122qva.138.1595729066049;
        Sat, 25 Jul 2020 19:04:26 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id p17sm12624093qkj.69.2020.07.25.19.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 19:04:25 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     Pascal Bouchareine <kalou@tfz.net>, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jeff Layton" <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH v3] This command attaches a description to a file descriptor for troubleshooting purposes. The free string is displayed in the process fdinfo file for that fd /proc/pid/fdinfo/fd.
Date:   Fri, 24 Jul 2020 22:15:47 -0700
Message-Id: <20200725051547.3718-1-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200725045921.2723-1-kalou@tfz.net>
References: <20200725045921.2723-1-kalou@tfz.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One intended usage is to allow processes to self-document sockets
for netstat and friends to report

Signed-off-by: Pascal Bouchareine <kalou@tfz.net>
---
 Documentation/filesystems/proc.rst |  3 +++
 fs/fcntl.c                         | 19 +++++++++++++++++++
 fs/file_table.c                    |  2 ++
 fs/proc/fd.c                       |  5 +++++
 include/linux/fs.h                 |  3 +++
 include/uapi/linux/fcntl.h         |  5 +++++
 6 files changed, 37 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 996f3cfe7030..ae8045650836 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -1918,6 +1918,9 @@ A typical output is::
 	flags:	0100002
 	mnt_id:	19
 
+An optional 'desc' is set if the process documented its usage of
+the file via the fcntl command F_SET_DESCRIPTION.
+
 All locks associated with a file descriptor are shown in its fdinfo too::
 
     lock:       1: FLOCK  ADVISORY  WRITE 359 00:13:11691 0 EOF
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 2e4c0fa2074b..c1ef724a906e 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -319,6 +319,22 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 	}
 }
 
+static long fcntl_set_description(struct file *file, char __user *desc)
+{
+	char *d;
+
+	d = strndup_user(desc, MAX_FILE_DESC_SIZE);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	spin_lock(&file->f_lock);
+	kfree(file->f_description);
+	file->f_description = d;
+	spin_unlock(&file->f_lock);
+
+	return 0;
+}
+
 static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 		struct file *filp)
 {
@@ -426,6 +442,9 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_SET_FILE_RW_HINT:
 		err = fcntl_rw_hint(filp, cmd, arg);
 		break;
+	case F_SET_DESCRIPTION:
+		err = fcntl_set_description(filp, argp);
+		break;
 	default:
 		break;
 	}
diff --git a/fs/file_table.c b/fs/file_table.c
index 656647f9575a..6673a48d2ea1 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -272,6 +272,8 @@ static void __fput(struct file *file)
 	eventpoll_release(file);
 	locks_remove_file(file);
 
+	kfree(file->f_description);
+
 	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d..60b3ff971b2b 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -57,6 +57,11 @@ static int seq_show(struct seq_file *m, void *v)
 		   (long long)file->f_pos, f_flags,
 		   real_mount(file->f_path.mnt)->mnt_id);
 
+	spin_lock(&file->f_lock);
+	if (file->f_description)
+		seq_printf(m, "desc:\t%s\n", file->f_description);
+	spin_unlock(&file->f_lock);
+
 	show_fd_locks(m, file, files);
 	if (seq_has_overflowed(m))
 		goto out;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f5abba86107d..09717bfa4e3b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -980,6 +980,9 @@ struct file {
 	struct address_space	*f_mapping;
 	errseq_t		f_wb_err;
 	errseq_t		f_sb_err; /* for syncfs */
+
+#define MAX_FILE_DESC_SIZE 256
+	char                    *f_description;
 } __randomize_layout
   __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
 
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 2f86b2ad6d7e..f86ff6dc45c7 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -55,6 +55,11 @@
 #define F_GET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 13)
 #define F_SET_FILE_RW_HINT	(F_LINUX_SPECIFIC_BASE + 14)
 
+/*
+ * Set file description
+ */
+#define F_SET_DESCRIPTION	(F_LINUX_SPECIFIC_BASE + 15)
+
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
  * used to clear any hints previously set.
-- 
2.25.1

