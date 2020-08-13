Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56C9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B057F20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 14:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="OU0ZUnoL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMOxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 10:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMOxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 10:53:09 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D69C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:53:09 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b2so2732111qvp.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuYyyEUf06CmnNYAz7kwB5OeYF/6966Caycqxe7vEQ0=;
        b=OU0ZUnoLeM1DwRoOITnt86qC2+PnWCy+k9kfNjiMlfeaWL7l+d4UxDzgQAHqy3dBQD
         hovu5kZyylIbQoPzZ5FbnD4BgRo10pRkjiN/X6IckpchwJ3ILFXxJXBybLaHdEtW4+jd
         vbsR3bzIh6eXQ0yE7t88x5wbKq4K0JKg2P+1qMROTgnbaa7V89sx1FJPrxzjzbJEp9rI
         fvNEf9j7zojY4EwizrI3rdhZnLCqcLMk5uYsdIClc9feasQPHkt55dYaf3kWaRAlJvNC
         MUa981mSnEfuc6kaCxX39Yw/l7ugpQnjZGW7QrSyL1bTDXVwNCTPsonJXeqJEZs4zTT8
         l5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QuYyyEUf06CmnNYAz7kwB5OeYF/6966Caycqxe7vEQ0=;
        b=h9khAMGnH7EqOjxlVhndaqXOjvjp3fAKRgCq2GGtAPT5NHy7V5+ITjvHqaKmLlJcNo
         IfqgoBOTQLs0ebRN+5fJSxL8o+prya/O/TSHYOevzl6cxZkXw+CkwQ7iZReOE46QrSCs
         e5lVZDr8U/HY7/81RiFXm6pXDvxQ7iLpXv1jSqxBa1NKKnsxZ0CvpHnZG8Ratu+qbAmJ
         Nsl1mjnS92+SpMR8Ehjc85oO59gBd/FwXZEGgU+7vVMZWLr539MwkiIZalTBOzY7MSQX
         Qv2HDIIRPcMX465ACPW09Vddlv3dowgU9Fr1ph5UTdM6iZviv77VfXiTdvBvbJdoDVF5
         sPSg==
X-Gm-Message-State: AOAM530PFrHVDzdiI7zehyWneN7X43xIOZImwro6rpgqoY1q/Xx44zzO
        Sn7Vwx9HxxWSGk7OHxK2oMH8dg==
X-Google-Smtp-Source: ABdhPJwVQph4UB/Lye91a1yKRdFfpibnEOA2suh+gJICEklsFUB5lOQIhhQ3OhNt9t405rUTR0aWNw==
X-Received: by 2002:ad4:4a27:: with SMTP id n7mr5048422qvz.184.1597330387282;
        Thu, 13 Aug 2020 07:53:07 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 9sm6559668qtg.4.2020.08.13.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 07:53:06 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] proc: use vmalloc for our kernel buffer
Date:   Thu, 13 Aug 2020 10:53:05 -0400
Message-Id: <20200813145305.805730-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since

  sysctl: pass kernel pointers to ->proc_handler

we have been pre-allocating a buffer to copy the data from the proc
handlers into, and then copying that to userspace.  The problem is this
just blind kmalloc()'s the buffer size passed in from the read, which in
the case of our 'cat' binary was 64kib.  Order-4 allocations are not
awesome, and since we can potentially allocate up to our maximum order,
use vmalloc for these buffers.

Fixes: 32927393dc1c ("sysctl: pass kernel pointers to ->proc_handler")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/proc/proc_sysctl.c  |  6 +++---
 include/linux/string.h |  1 +
 mm/util.c              | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 6c1166ccdaea..207ac6e6e028 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -571,13 +571,13 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 		goto out;
 
 	if (write) {
-		kbuf = memdup_user_nul(ubuf, count);
+		kbuf = vmemdup_user_nul(ubuf, count);
 		if (IS_ERR(kbuf)) {
 			error = PTR_ERR(kbuf);
 			goto out;
 		}
 	} else {
-		kbuf = kzalloc(count, GFP_KERNEL);
+		kbuf = kvzalloc(count, GFP_KERNEL);
 		if (!kbuf)
 			goto out;
 	}
@@ -600,7 +600,7 @@ static ssize_t proc_sys_call_handler(struct file *filp, void __user *ubuf,
 
 	error = count;
 out_free_buf:
-	kfree(kbuf);
+	kvfree(kbuf);
 out:
 	sysctl_head_finish(head);
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 9b7a0632e87a..aee3689fb865 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -12,6 +12,7 @@
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t);
 extern void *vmemdup_user(const void __user *, size_t);
+extern void *vmemdup_user_nul(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
 /*
diff --git a/mm/util.c b/mm/util.c
index 5ef378a2a038..4de3b4b0f358 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -208,6 +208,32 @@ void *vmemdup_user(const void __user *src, size_t len)
 }
 EXPORT_SYMBOL(vmemdup_user);
 
+/**
+ * vmemdup_user - duplicate memory region from user space and NUL-terminate
+ *
+ * @src: source address in user space
+ * @len: number of bytes to copy
+ *
+ * Return: an ERR_PTR() on failure.  Result may be not
+ * physically contiguous.  Use kvfree() to free.
+ */
+void *vmemdup_user_nul(const void __user *src, size_t len)
+{
+	void *p;
+
+	p = kvmalloc(len, GFP_USER);
+	if (!p)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(p, src, len)) {
+		kvfree(p);
+		return ERR_PTR(-EFAULT);
+	}
+
+	return p;
+}
+EXPORT_SYMBOL(vmemdup_user_nul);
+
 /**
  * strndup_user - duplicate an existing string from user space
  * @s: The string to duplicate
-- 
2.24.1

