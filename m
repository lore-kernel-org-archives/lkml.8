Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E48C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C350A2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ury2i0dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730842AbgCaMki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:40:38 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36716 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730697AbgCaMkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:40:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id 31so25703969wrs.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 05:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrYU4pdXtjoqLSCi1+BzGz0FwfrcT1JORFV6pfBLh/Q=;
        b=ury2i0drH9nc44Mz1FbJHJodHBl7BjEBB+TfLm2H0shisGyjSIgoLGejyEwJte99RI
         mE+AoFJg7DBjBoDsecrIrnzm0bYqbbaCoSEAPt2QLYdt4fJ5HJvuQDf05IhmRoiyi550
         l8S/9wzk5DVeVbqFqnpF7gbL3ebyjMuPG6MHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrYU4pdXtjoqLSCi1+BzGz0FwfrcT1JORFV6pfBLh/Q=;
        b=GPH/F8ORLiUpu2NKJRequh34muI1hoh4JnkOyzIBHGqZbfCViM7mp7y01sY44Oe9UL
         JeV5fKgmX0WY1Mb5fTFURb90PPqlrCSGgtDV/KguG/7v5uQFDK5ztyZ/Nnpl2b2oEX33
         a+4yUz+zZd33PTaNsngO/80Q1kOOgfAVC07B6B2+fK2H4ZYjwCl2Hpfipt4CL56sDIK8
         RbhbmFqmzUytjdZBPRrSsaZgMZjLFEgKS5+oWtMGuCE9vqWRZt5zZmmELLbm2urohbH+
         dO/oLXbIPA3cmxMsbikxUy853lPtqozB460v2PMP5PHhM1CtYNeN64P7Ncu6u1zIf77m
         q3vw==
X-Gm-Message-State: ANhLgQ0HfCQUxtjQUwwyISZsyo2jEMRAQtZnZioNPVk+6OEucBFOJV95
        IunxMl/1cwvyr8zewPiHNOeYy8/d7TvYGQ==
X-Google-Smtp-Source: ADFU+vu8AJDlsBQPYOHqtbggoLh4K9dPV196dmXMNIJ1cefjnuTxTqIgu8wxKorMC2XSWfQm7c5ITQ==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr19484696wrm.279.1585658434518;
        Tue, 31 Mar 2020 05:40:34 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.159])
        by smtp.gmail.com with ESMTPSA id w66sm3819159wma.38.2020.03.31.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 05:40:33 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH v2 1/1] mnt: add support for non-rootfs initramfs
Date:   Tue, 31 Mar 2020 13:40:17 +0100
Message-Id: <20200331124017.2252-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200331124017.2252-1-ignat@cloudflare.com>
References: <20200331124017.2252-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main need for this is to support container runtimes on stateless Linux
system (pivot_root system call from initramfs).

Normally, the task of initramfs is to mount and switch to a "real" root
filesystem. However, on stateless systems (booting over the network) it is just
convenient to have your "real" filesystem as initramfs from the start.

This, however, breaks different container runtimes, because they usually use
pivot_root system call after creating their mount namespace. But pivot_root does
not work from initramfs, because initramfs runs form rootfs, which is the root
of the mount tree and can't be unmounted.

One workaround is to do:

  mount --bind / /

However, that defeats one of the purposes of using pivot_root in the cloned
containers: get rid of host root filesystem, should the code somehow escapes the
chroot.

There is a way to solve this problem from userspace, but it is much more
cumbersome:
  * either have to create a multilayered archive for initramfs, where the outer
    layer creates a tmpfs filesystem and unpacks the inner layer, switches root
    and does not forget to properly cleanup the old rootfs
  * or we need to use keepinitrd kernel cmdline option, unpack initramfs to
    rootfs, run a script to create our target tmpfs root, unpack the same
    initramfs there, switch root to it and again properly cleanup the old root,
    thus unpacking the same archive twice and also wasting memory, because
    the kernel stores compressed initramfs image indefinitely.

With this change we can ask the kernel (by specifying nonroot_initramfs kernel
cmdline option) to create a "leaf" tmpfs mount for us and switch root to it
before the initramfs handling code, so initramfs gets unpacked directly into
the "leaf" tmpfs with rootfs being empty and no need to clean up anything.

This also bring the behaviour in line with the older style initrd, where the
initrd is located on some leaf filesystem in the mount tree and rootfs remaining
empty.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 .../admin-guide/kernel-parameters.txt         |  9 +++-
 fs/namespace.c                                | 47 +++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c07815d230bc..720fd3ee9f8a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3192,11 +3192,18 @@
 	nomfgpt		[X86-32] Disable Multi-Function General Purpose
 			Timer usage (for AMD Geode machines).
 
+	nomodule        Disable module load
+
 	nonmi_ipi	[X86] Disable using NMI IPIs during panic/reboot to
 			shutdown the other cpus.  Instead use the REBOOT_VECTOR
 			irq.
 
-	nomodule	Disable module load
+	nonroot_initramfs
+			[KNL] Create an additional tmpfs filesystem under rootfs
+			and unpack initramfs there instead of the rootfs itself.
+			This is useful for stateless systems, which run directly
+			from initramfs, create mount namespaces and use
+			"pivot_root" system call.
 
 	nopat		[X86] Disable PAT (page attribute table extension of
 			pagetables) support.
diff --git a/fs/namespace.c b/fs/namespace.c
index 85b5f7bea82e..a1ec862e8146 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3701,6 +3701,49 @@ static void __init init_mount_tree(void)
 	set_fs_root(current->fs, &root);
 }
 
+#if IS_ENABLED(CONFIG_TMPFS)
+static int __initdata nonroot_initramfs;
+
+static int __init nonroot_initramfs_param(char *str)
+{
+	if (*str)
+		return 0;
+	nonroot_initramfs = 1;
+	return 1;
+}
+__setup("nonroot_initramfs", nonroot_initramfs_param);
+
+static void __init init_nonroot_initramfs(void)
+{
+	int err;
+
+	if (!nonroot_initramfs)
+		return;
+
+	err = ksys_mkdir("/root", 0700);
+	if (err < 0)
+		goto out;
+
+	err = do_mount("tmpfs", "/root", "tmpfs", 0, NULL);
+	if (err)
+		goto out;
+
+	err = ksys_chdir("/root");
+	if (err)
+		goto out;
+
+	err = do_mount(".", "/", NULL, MS_MOVE, NULL);
+	if (err)
+		goto out;
+
+	err = ksys_chroot(".");
+	if (!err)
+		return;
+out:
+	printk(KERN_WARNING "Failed to create a non-root filesystem for initramfs\n");
+}
+#endif /* IS_ENABLED(CONFIG_TMPFS) */
+
 void __init mnt_init(void)
 {
 	int err;
@@ -3734,6 +3777,10 @@ void __init mnt_init(void)
 	shmem_init();
 	init_rootfs();
 	init_mount_tree();
+
+#if IS_ENABLED(CONFIG_TMPFS)
+	init_nonroot_initramfs();
+#endif
 }
 
 void put_mnt_ns(struct mnt_namespace *ns)
-- 
2.20.1

