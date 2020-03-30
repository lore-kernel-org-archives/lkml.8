Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F28EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A4520757
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B4aNZ73V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgC3NPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:15:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56088 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgC3NPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 09:15:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id r16so2055020wmg.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LfIlxScnHZVuwjqrv90OqAsj+bqUS/oDr+dehBCUUOE=;
        b=B4aNZ73V9a79klahCoUBEKpxTe/HnntTbwiZqmpuAo4qgAHAUzTCFZ4D6yHiPwSNKV
         jPBfQm07NAzxWJbLkqdCN3/wxHjspIn3NqLgCPaMTbAromtv4JcAHh8gNtFR3yUu5svT
         /oX/k2OtIo4ilqDa5C3hr39bVL2yMEMkD/lJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LfIlxScnHZVuwjqrv90OqAsj+bqUS/oDr+dehBCUUOE=;
        b=MwBNFsMKGsakzdqFCTmudtLoMk9qfQo6sLhDU6tag12Ee1GVAI7cVPHedfX1QumZMG
         MQ9n3utOApbt0Wzzy2BofM2jX2HBR/s0q3QyBBjQAH1/aPdx3TzaObb0RBKHRzhelmA+
         n/rpE5LTr362iDkJLFbBe2ll8o45gUfQHkkwYB3UAIEVNVvhhnKqwQvo7VJ7XmPTak8W
         Ge4dkLxGa51MWXHAOMkneQoimAz8fWU4wRdM7jvRveI9QneSbDbc+bi/7/qXdFJgOTJv
         y9oWHY21e83keECrzbrXY3ImPyBIVgROcFwMPNnHpGVcwsuzKP76gJ4SuDuY5psgdPYB
         DNYg==
X-Gm-Message-State: ANhLgQ2gaGk3I+5Qpxl4pL0dxQYRwBJp5Qzli0HjO+JhHSoDZx0j+Ur+
        jrbff6WaBwENjJT7KxpEikqFHw==
X-Google-Smtp-Source: ADFU+vumPgVA6fYAO89ld7mY2LICwGYoTdIgxIq7yRImL486GrHWvdr4NKBcCMXpVevsCknNpP5F+g==
X-Received: by 2002:a7b:c842:: with SMTP id c2mr13931018wml.154.1585574133896;
        Mon, 30 Mar 2020 06:15:33 -0700 (PDT)
Received: from localhost.localdomain ([88.144.89.159])
        by smtp.gmail.com with ESMTPSA id f14sm21135398wmb.3.2020.03.30.06.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 06:15:33 -0700 (PDT)
From:   Ignat Korchagin <ignat@cloudflare.com>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ignat Korchagin <ignat@cloudflare.com>, kernel-team@cloudflare.com
Subject: [PATCH 1/1] mnt: add support for non-rootfs initramfs
Date:   Mon, 30 Mar 2020 14:14:39 +0100
Message-Id: <20200330131439.2405-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200330131439.2405-1-ignat@cloudflare.com>
References: <20200330131439.2405-1-ignat@cloudflare.com>
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
 fs/namespace.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

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

