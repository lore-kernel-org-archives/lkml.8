Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24D4C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CD7206BF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uw9ndpoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgA0X41 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:56:27 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:43832 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgA0X41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:56:27 -0500
Received: by mail-pf1-f201.google.com with SMTP id x199so7449358pfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dRo8BvIKoRhSD2Tn9OfOhx2I4O53vRoQo3RBdWWB7eE=;
        b=Uw9ndpoLPLVM3Cb40YS7MHZg7Y4O9skGXttW8XbPWDLLxAteeFE7drT1tLrpPPaQsI
         bZEVdNVizBQmdzyxz/rcBZfQL7Kjg/iV5kJRlP8AJmOsDvs7nHGQrmKj4p9giBwu4kHT
         0E7xh8ZTLk0nQPUuMGp9wt/mWAdev1sz+7QRIgYGhxRlhjQneEFOuokB3v9RyXXLz6pp
         G31wPOoFFSDHz2FIFeSUupUc7GtKVv2bN+lIn8HzwO4kXJSLK++wGduZroloS9CHphd/
         ZiqHyvK5tg2zw1+NbIUDE8tw7R0JeZDnnccNFJzAVU8W4JIPbVUc4icJnHbKdeQ7d9MC
         BNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dRo8BvIKoRhSD2Tn9OfOhx2I4O53vRoQo3RBdWWB7eE=;
        b=kBmNEcL3LP4hBTKJL+21zmtqCkwIileQxTI+0vTcnCK+2XnwzK4xt+QnO2BXe/2CMX
         SKph1LL0hO8wwSk2BAErHLxUAOtTQSr4bHwUtUyhrCtQGy5zbIg6JPaEF874wYwUWNm+
         D+9TzBTPaZG37uEPIrPDF8tK8XXZso8RVbjbxKEc/Z0B/94PoujQLOjkCjdW21pkA1+6
         gOoav/dkOFnYKxZySbZLnlFXL+Iaymn214hOqvn9xBZCl3mW5TcpcGcmZg397O6U76oH
         15GSnoCnIKwf5fmCvbNioBQdOK9lPFkekhVTdtk1Hg7QhTky69HkaDibJ6bm9qDjeFOF
         NADQ==
X-Gm-Message-State: APjAAAUxH+tM+y+XTXJwIyH2NyCBajnveQhgbduxv73wallH75eiOWiB
        uQnoi5xE94ODJV1QG+Q6uFLm0aGwYQ==
X-Google-Smtp-Source: APXvYqwz2z0aFgThZxhvv3L6SvsHVrydMHnFK5ay+ILi5QybHwC3uagUqAF2vWJs7qoiwmhLBLKiXgYFZQ==
X-Received: by 2002:a63:bc01:: with SMTP id q1mr23355022pge.442.1580169386231;
 Mon, 27 Jan 2020 15:56:26 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:56:16 -0800
Message-Id: <20200127235616.48920-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v2] staging: android: ashmem: Disallow ashmem memory from
 being remapped
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, surenb@google.com, gregkh@linuxfoundation.org,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com,
        Jann Horn <jannh@google.com>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suren Baghdasaryan <surenb@google.com>

When ashmem file is mmapped, the resulting vma->vm_file points to the
backing shmem file with the generic fops that do not check ashmem
permissions like fops of ashmem do. If an mremap is done on the ashmem
region, then the permission checks will be skipped. Fix that by disallowing
mapping operation on the backing shmem file.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable <stable@vger.kernel.org> # 4.4,4.9,4.14,4.18,5.4
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/staging/android/ashmem.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

v2: update commit message as suggested by joelaf@google.com.

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index 74d497d39c5a..c6695354b123 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -351,8 +351,23 @@ static inline vm_flags_t calc_vm_may_flags(unsigned long prot)
 	       _calc_vm_trans(prot, PROT_EXEC,  VM_MAYEXEC);
 }
 
+static int ashmem_vmfile_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	/* do not allow to mmap ashmem backing shmem file directly */
+	return -EPERM;
+}
+
+static unsigned long
+ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
+				unsigned long len, unsigned long pgoff,
+				unsigned long flags)
+{
+	return current->mm->get_unmapped_area(file, addr, len, pgoff, flags);
+}
+
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	static struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
@@ -393,6 +408,19 @@ static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 		}
 		vmfile->f_mode |= FMODE_LSEEK;
 		asma->file = vmfile;
+		/*
+		 * override mmap operation of the vmfile so that it can't be
+		 * remapped which would lead to creation of a new vma with no
+		 * asma permission checks. Have to override get_unmapped_area
+		 * as well to prevent VM_BUG_ON check for f_ops modification.
+		 */
+		if (!vmfile_fops.mmap) {
+			vmfile_fops = *vmfile->f_op;
+			vmfile_fops.mmap = ashmem_vmfile_mmap;
+			vmfile_fops.get_unmapped_area =
+					ashmem_vmfile_get_unmapped_area;
+		}
+		vmfile->f_op = &vmfile_fops;
 	}
 	get_file(asma->file);
 
-- 
2.25.0.341.g760bfbb309-goog

