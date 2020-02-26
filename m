Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C0AC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81BA21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 07:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHBsDuat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgBZHND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 02:13:03 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:32934 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgBZHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 02:13:03 -0500
Received: by mail-pj1-f67.google.com with SMTP id m7so1918352pjs.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 23:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wIycLtohJzZmgbz8Z9KTZsw/kqKcbNO/JXoVgPdvu5k=;
        b=nHBsDuatJbQdosdW7LvCk7lFzVSx5qBST4bfiBlRhLz/YLONy7ALUeY1N8NsOM3ddi
         ccg3145g8DOq5tDD4Kk6Y2IXGjRLgkoaGgpUPBxjfYQfp9PGONg/cwaKsxTbjTq8lkfJ
         NRJFrxTRFogiqdjs41Drldwj1fTeruCaeArsV8sNr3GeGM4aRH7QFYF/iAaYEqBvDxGE
         vWQWG1fdS5iHFQJECDt/ivKKRqMwmljNqXW5QUs0c/vpy7uJ/rll3Z7gnOy5HDfhcRP5
         4lAYLHe5Xc63mefpieyn7o/5F3Kwo/Xe8B1uigehlVZlvp/67qNFZDphtRp5zpsFV7h4
         bYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wIycLtohJzZmgbz8Z9KTZsw/kqKcbNO/JXoVgPdvu5k=;
        b=qWzV45sopThrhFK/cGvz579Qej4zQ3Ul2CeEz39B3IKNOhSrKdKr2d2vdrwT58msY6
         DYKW86zGjLLHck+ksdOqhXUNilrnsNPtokkRDsA9UUzii9nysU6MnUs25SW0KZNDdA5U
         oj4DN8v2VVaBt4cW+LpGbwqd8TBY/Gg76NqwWO+apnldN7hGiLfGIdwUozIf/wW8PoOJ
         nIGSKbGXVjpYjLFDQ9z2hesbRm2fUvUc2UX5/2h18mPlUh53q6XSNET+QHXVgEvW6lye
         /PZIUsjqDTMIXn7woyHU4OUWCJNQ+NauHOVs6pQ0HksxtjJ9DMGMfSdH+r5cJTiyNBnq
         blUA==
X-Gm-Message-State: APjAAAVYgJPOg8Sf/IEzQ5yK/XKvi1iALd915Is14bM6rsW5Ujnnpgs4
        Jf7/ckFgNuBjLE3CJtWVzZmfzg==
X-Google-Smtp-Source: APXvYqwB2yOYMGKYdF2cDBBA/GEj2xBPMsZ8piwV6gUkwS3YmQ2LmROMVi5lnWOaX8djXcAihN1Nxg==
X-Received: by 2002:a17:902:8688:: with SMTP id g8mr2603545plo.277.1582701182230;
        Tue, 25 Feb 2020 23:13:02 -0800 (PST)
Received: from localhost.localdomain ([240e:362:4c3:8800:a057:bb7f:18d7:2e])
        by smtp.gmail.com with ESMTPSA id b24sm1400707pfo.84.2020.02.25.23.12.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Feb 2020 23:13:01 -0800 (PST)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        grant.likely@arm.com, jean-philippe <jean-philippe@linaro.org>,
        Jerome Glisse <jglisse@redhat.com>,
        ilias.apalodimas@linaro.org, francois.ozog@linaro.org,
        kenneth-lee-2012@foxmail.com, Wangzhou <wangzhou1@hisilicon.com>,
        "haojian . zhuang" <haojian.zhuang@linaro.org>,
        guodong.xu@linaro.org
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2] uacce: unmap remaining mmapping from user space
Date:   Wed, 26 Feb 2020 15:12:06 +0800
Message-Id: <1582701126-5312-1-git-send-email-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When uacce parent device module is removed, user app may
still keep the mmaped area, which can be accessed unsafely.
When rmmod, Parent device driver will call uacce_remove,
which unmap all remaining mapping from user space for safety.
VM_FAULT_SIGBUS is also reported to user space accordingly.

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
---
 v2: Unmap before put_queue, where memory is freed, commented from Zaibo.

 drivers/misc/uacce/uacce.c | 16 ++++++++++++++++
 include/linux/uacce.h      |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index ffced4d..d39307f 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -224,6 +224,7 @@ static int uacce_fops_open(struct inode *inode, struct file *filep)
 
 	init_waitqueue_head(&q->wait);
 	filep->private_data = q;
+	uacce->inode = inode;
 	q->state = UACCE_Q_INIT;
 
 	return 0;
@@ -253,6 +254,14 @@ static int uacce_fops_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+static vm_fault_t uacce_vma_fault(struct vm_fault *vmf)
+{
+	if (vmf->flags & (FAULT_FLAG_MKWRITE | FAULT_FLAG_WRITE))
+		return VM_FAULT_SIGBUS;
+
+	return 0;
+}
+
 static void uacce_vma_close(struct vm_area_struct *vma)
 {
 	struct uacce_queue *q = vma->vm_private_data;
@@ -265,6 +274,7 @@ static void uacce_vma_close(struct vm_area_struct *vma)
 }
 
 static const struct vm_operations_struct uacce_vm_ops = {
+	.fault = uacce_vma_fault,
 	.close = uacce_vma_close,
 };
 
@@ -556,6 +566,12 @@ void uacce_remove(struct uacce_device *uacce)
 
 	if (!uacce)
 		return;
+	/*
+	 * unmap remaining mapping from user space, preventing user still
+	 * access the mmaped area while parent device is already removed
+	 */
+	if (uacce->inode)
+		unmap_mapping_range(uacce->inode->i_mapping, 0, 0, 1);
 
 	/* ensure no open queue remains */
 	mutex_lock(&uacce->mm_lock);
diff --git a/include/linux/uacce.h b/include/linux/uacce.h
index 904a461..0e215e6 100644
--- a/include/linux/uacce.h
+++ b/include/linux/uacce.h
@@ -98,6 +98,7 @@ struct uacce_queue {
  * @priv: private pointer of the uacce
  * @mm_list: list head of uacce_mm->list
  * @mm_lock: lock for mm_list
+ * @inode: core vfs
  */
 struct uacce_device {
 	const char *algs;
@@ -113,6 +114,7 @@ struct uacce_device {
 	void *priv;
 	struct list_head mm_list;
 	struct mutex mm_lock;
+	struct inode *inode;
 };
 
 /**
-- 
2.7.4

