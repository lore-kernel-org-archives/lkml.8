Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A15C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D6EB2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="IKVEwUkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgHMQON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgHMQOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:14:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F9C061385
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:14:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id x12so4782557qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 09:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=IaO87JqeLl+O7BlBAJGOZPpEX9UGcCnuKI5svLj4Bs0=;
        b=IKVEwUkSOr1GN4X53RteYy8JlANkTnQcQJ4YkGJWUOfhkQHSPB7I9G1WF9Jh6/pk9J
         Xb+WQrQwRpoLYnlVl3mAmwyCaBySGZUJqad8isejyoLTBcWXA1oLtQvKEozv2DFw01tx
         RvQ3GlDkfjthxSoqI5xTiCTW2h5FVdFxTTuMzLFGCt+jwpFilZSbx05VTyxWJxJAPVXC
         NIz1z2e/q/osLAmsM61LKX88ZpmqTENx3zOk3HwHIXwPXj7BOzfv1Pkx68gtLiHZ3GgA
         C3DP24Lp/5B5W7Kjy9UF365xI0jnPJQVPhMClRPG9m1jPFgkPhGwxYosWn0BkrB5zE+T
         GMSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaO87JqeLl+O7BlBAJGOZPpEX9UGcCnuKI5svLj4Bs0=;
        b=GvXft+CCmkS3WsHzU2YJkrMLNwRJXZAa7wDruCyrO8+HYL7NuoSHdr8npUrwUPzbtO
         88JyOKcHSQTF3PTeNz6PrWkp9RtjF7mMIoXoqg7Zvh7bOxU3ljf7sOasbG1qah3rTY9/
         iNlwUlUn1w71TnvN8g7vh8BBqWJuWMpdSc2Y5LQ3A2CMwWBtrfGWrjcoIRflddu/EYS2
         53OvLuPzIe3BHbzQRG7vhqbj2FFb7XeyOQ5/GXPZIA4q1gBrZLmifQUTsX0vXiwgDiTb
         B5A4XVijzubHf0umfBYu1BoBTtibQ1l90Df+0uSFG5/GiN8tVb/TbreNg3Z1f2z4jr18
         5KFQ==
X-Gm-Message-State: AOAM531+RLz89Pz092I5Y2GT8T6wLEeaoz/OH0PhelQGy7UzSavA37Mb
        BpFk+aEeake/YBmZda43dDHAMA==
X-Google-Smtp-Source: ABdhPJwWfM5hzbMDJRBOt2cpsj6G35F/u7VNLfCx3el5I813MKKeoZhOuTssedmV4ig4uqtNwPkLQw==
X-Received: by 2002:ac8:408f:: with SMTP id p15mr6016574qtl.156.1597335243597;
        Thu, 13 Aug 2020 09:14:03 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id h81sm5999000qke.76.2020.08.13.09.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 09:14:02 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, viro@ZenIV.linux.org.uk, willy@infradead.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 2/2] tree-wide: rename vmemdup_user to kvmemdup_user
Date:   Thu, 13 Aug 2020 12:13:59 -0400
Message-Id: <20200813161359.904275-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200813161359.904275-1-josef@toxicpanda.com>
References: <20200813161359.904275-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This helper uses kvmalloc, not vmalloc, so rename it to kvmemdup_user to
make it clear we're using kvmalloc() and will need to use kvfree().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 arch/x86/kvm/cpuid.c                   | 6 +++---
 drivers/gpu/drm/virtio/virtgpu_ioctl.c | 2 +-
 drivers/tty/vt/consolemap.c            | 2 +-
 include/linux/string.h                 | 2 +-
 mm/util.c                              | 6 +++---
 sound/core/control.c                   | 4 ++--
 virt/kvm/kvm_main.c                    | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3fd6eec202d7..22834ea499ee 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -200,9 +200,9 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
 	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
 		goto out;
 	if (cpuid->nent) {
-		cpuid_entries = vmemdup_user(entries,
-					     array_size(sizeof(struct kvm_cpuid_entry),
-							cpuid->nent));
+		cpuid_entries = kvmemdup_user(entries,
+					      array_size(sizeof(struct kvm_cpuid_entry),
+							 cpuid->nent));
 		if (IS_ERR(cpuid_entries)) {
 			r = PTR_ERR(cpuid_entries);
 			goto out;
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 7a2430e34e00..c2f973aa3680 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -147,7 +147,7 @@ static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 		bo_handles = NULL;
 	}
 
-	buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
+	buf = kvmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
 	if (IS_ERR(buf)) {
 		ret = PTR_ERR(buf);
 		goto out_unused_fd;
diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index 5947b54d92be..2cffa8b3c74b 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -542,7 +542,7 @@ int con_set_unimap(struct vc_data *vc, ushort ct, struct unipair __user *list)
 	if (!ct)
 		return 0;
 
-	unilist = vmemdup_user(list, array_size(sizeof(struct unipair), ct));
+	unilist = kvmemdup_user(list, array_size(sizeof(struct unipair), ct));
 	if (IS_ERR(unilist))
 		return PTR_ERR(unilist);
 
diff --git a/include/linux/string.h b/include/linux/string.h
index 21bb6d3d88c4..a6f7218124a0 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -11,7 +11,7 @@
 
 extern char *strndup_user(const char __user *, long);
 extern void *memdup_user(const void __user *, size_t);
-extern void *vmemdup_user(const void __user *, size_t);
+extern void *kvmemdup_user(const void __user *, size_t);
 extern void *kvmemdup_user_nul(const void __user *, size_t);
 extern void *memdup_user_nul(const void __user *, size_t);
 
diff --git a/mm/util.c b/mm/util.c
index cf454d57d3e2..f434634b6ba3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -183,7 +183,7 @@ void *memdup_user(const void __user *src, size_t len)
 EXPORT_SYMBOL(memdup_user);
 
 /**
- * vmemdup_user - duplicate memory region from user space
+ * kvmemdup_user - duplicate memory region from user space
  *
  * @src: source address in user space
  * @len: number of bytes to copy
@@ -191,7 +191,7 @@ EXPORT_SYMBOL(memdup_user);
  * Return: an ERR_PTR() on failure.  Result may be not
  * physically contiguous.  Use kvfree() to free.
  */
-void *vmemdup_user(const void __user *src, size_t len)
+void *kvmemdup_user(const void __user *src, size_t len)
 {
 	void *p;
 
@@ -206,7 +206,7 @@ void *vmemdup_user(const void __user *src, size_t len)
 
 	return p;
 }
-EXPORT_SYMBOL(vmemdup_user);
+EXPORT_SYMBOL(kvmemdup_user);
 
 /**
  * kvmemdup_user_nul - duplicate memory region from user space and NUL-terminate
diff --git a/sound/core/control.c b/sound/core/control.c
index aa0c0cf182af..b712f4d261de 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1297,7 +1297,7 @@ static int replace_user_tlv(struct snd_kcontrol *kctl, unsigned int __user *buf,
 	if (size > 1024 * 128)	/* sane value */
 		return -EINVAL;
 
-	container = vmemdup_user(buf, size);
+	container = kvmemdup_user(buf, size);
 	if (IS_ERR(container))
 		return PTR_ERR(container);
 
@@ -1365,7 +1365,7 @@ static int snd_ctl_elem_init_enum_names(struct user_element *ue)
 	if (ue->info.value.enumerated.names_length > 64 * 1024)
 		return -EINVAL;
 
-	names = vmemdup_user((const void __user *)user_ptrval,
+	names = kvmemdup_user((const void __user *)user_ptrval,
 		ue->info.value.enumerated.names_length);
 	if (IS_ERR(names))
 		return PTR_ERR(names);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 737666db02de..1111780ccefd 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3814,8 +3814,8 @@ static long kvm_vm_ioctl(struct file *filp,
 			goto out;
 		if (routing.nr) {
 			urouting = argp;
-			entries = vmemdup_user(urouting->entries,
-					       array_size(sizeof(*entries),
+			entries = kvmemdup_user(urouting->entries,
+						array_size(sizeof(*entries),
 							  routing.nr));
 			if (IS_ERR(entries)) {
 				r = PTR_ERR(entries);
-- 
2.24.1

