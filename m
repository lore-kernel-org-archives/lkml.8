Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70159C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 01:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD6B2065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 01:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="a7SUoP8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgEPBH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 21:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgEPBH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 21:07:59 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63F4C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 18:07:58 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c3so3431255otr.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 18:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language;
        bh=1sRNnCzBHQYL/m9vUFvr4KkCtN/uYbETWkwItpFlyWI=;
        b=a7SUoP8ZGaVD5IHIMrBz+K8LWmGi1JLCqeb4vw1Zs9QzbMaE7nPaWzTihOsVgZ6nuJ
         xViQcrhVhGdUKkF5wzGHpuR1Y08FUikzYk9FyMK870YQW2V022Pk9d8WyUCg+KpYHPV1
         w2XeLIBcBnI07q+MYlbrhLZnfSbc2MSCzucF1N9qj/CBy/yfYLA9r59rL9qitZDr91QL
         PxdMFdH18+6mWHaHqktk4woKuCllWptmBohTkV5z6PT5J3r3TkaIRiNQwFySITAbEVfx
         mqZ64uKkFLUEBDSHx3C9FZJb/SvXLlOpEOe2x+7kYiNXfYT4NuCYPvkqEpgzRDxwhDk9
         J/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=1sRNnCzBHQYL/m9vUFvr4KkCtN/uYbETWkwItpFlyWI=;
        b=SNVwBkde4r2hWYkjzPrG8f0wzxJw9pKXPVl+pUO0CKkVHOEP8GXh15/gRA2G26UcQz
         cPi5jRAt6gYjzRNRydByUIbJSFj6SxXLEuXkpsiAA31zO9SBvuglxj6Ax8jqi5LrhR2p
         7i4ipyZjzQQ7VSOVXpcXRPIxHPwj0a+O5PaC94OS9hc0s6CgOxyfN6xTeyG7JtSMoIdJ
         ul+0k1lZm+TnNKGtsUi4dLRbrKjhMX8TCYHRBIyuaePzikHrswQvMbQxU1kwLgkorQdn
         6kNtrEA7fa5FkVjnln0RZYX7rmvazXgWHS4C4bzV8VZTOlGZQQk9HTMmjzKT2vil5LR9
         Uo9Q==
X-Gm-Message-State: AOAM532hufdL1y+wAGeFGqS4/MR31e9jt2i3TZs79sHvb8HhIF3BEr/P
        kdy6DxuYcj/8R3H/84q/dJ1k+LQ6fKM=
X-Google-Smtp-Source: ABdhPJzTV6H+yszh4AMqJTMKM5xfKD9WjOfZA0FME1UDrAhNpMuKqK1Z3mr3t8Vo6BVMKYvLRTtJZg==
X-Received: by 2002:a9d:883:: with SMTP id 3mr4218642otf.344.1589591277211;
        Fri, 15 May 2020 18:07:57 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id i2sm1016897oto.56.2020.05.15.18.07.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 18:07:56 -0700 (PDT)
Subject: Re: [PATCH v4] Make initramfs honor CONFIG_DEVTMPFS_MOUNT
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <25e7e777-19f9-6280-b456-6c9c782c7901@landley.net>
 <e522825e-b2da-3cfe-7655-20c1c1975be4@infradead.org>
From:   Rob Landley <rob@landley.net>
Message-ID: <5c597b68-4946-56ae-f5f8-a5f87bb22b44@landley.net>
Date:   Fri, 15 May 2020 20:14:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <e522825e-b2da-3cfe-7655-20c1c1975be4@infradead.org>
Content-Type: multipart/mixed;
 boundary="------------65A4C91D7482DC2F6A89CC50"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------65A4C91D7482DC2F6A89CC50
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 5/14/20 11:50 PM, Randy Dunlap wrote:
> Hi Rob,

Um, hi.

> You need to send this patch to some maintainer who could merge it.

The implicit "if" is "you expect the kernel bureaucracy to merge anything Not
Invented Here", and the 3 year gap since the last version is because I stopped:

  https://landley.net/notes-2017.html#14-09-2017

To be honest I didn't think anyone would notice this. They don't usually:

  http://lkml.iu.edu/hypermail/linux/kernel/2002.2/00083.html
  https://www.spinics.net/lists/linux-sh/msg56844.html

It just seems polite to post things that got shipped to customers.

> And it uses the wrong multi-line comment format.

Offending comment removed.

Rob

--------------65A4C91D7482DC2F6A89CC50
Content-Type: text/x-patch; charset=UTF-8;
 name="initramfs-devtmpfs.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="initramfs-devtmpfs.patch"

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index f046d21..97352d4 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -48,16 +48,10 @@  config DEVTMPFS_MOUNT
 	bool "Automount devtmpfs at /dev, after the kernel mounted the rootfs"
 	depends on DEVTMPFS
 	help
-	  This will instruct the kernel to automatically mount the
-	  devtmpfs filesystem at /dev, directly after the kernel has
-	  mounted the root filesystem. The behavior can be overridden
-	  with the commandline parameter: devtmpfs.mount=0|1.
-	  This option does not affect initramfs based booting, here
-	  the devtmpfs filesystem always needs to be mounted manually
-	  after the rootfs is mounted.
-	  With this option enabled, it allows to bring up a system in
-	  rescue mode with init=/bin/sh, even when the /dev directory
-	  on the rootfs is completely empty.
+	  Automatically mount devtmpfs at /dev on the root filesystem, which
+	  lets the system come up in rescue mode with [rd]init=/bin/sh.
+	  Override with devtmpfs.mount=0 on the commandline. Initramfs can
+	  create a /dev dir as needed, other rootfs needs the mount point.
 
 config STANDALONE
 	bool "Select only drivers that don't need compile-time external firmware"
diff --git a/fs/namespace.c b/fs/namespace.c
index f8893dc..06057d7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2417,7 +2417,16 @@  static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
 	err = -EBUSY;
 	if (path->mnt->mnt_sb == newmnt->mnt.mnt_sb &&
 	    path->mnt->mnt_root == path->dentry)
+	{
+		if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT) &&
+		    !strcmp(path->mnt->mnt_sb->s_type->name, "devtmpfs"))
+		{
+			printk(KERN_WARNING "Debian bug workaround for devtmpfs overmount.");
+
+			err = 0;
+		}
 		goto unlock;
+	}
 
 	err = -EINVAL;
 	if (d_is_symlink(newmnt->mnt.mnt_root))
diff --git a/init/main.c b/init/main.c
index 0ee9c686..0d8e5ec 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1065,12 +1065,6 @@  static noinline void __init kernel_init_freeable(void)
 
 	do_basic_setup();
 
-	/* Open the /dev/console on the rootfs, this should never fail */
-	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
-		pr_err("Warning: unable to open an initial console.\n");
-
-	(void) ksys_dup(0);
-	(void) ksys_dup(0);
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
@@ -1082,8 +1076,17 @@  static noinline void __init kernel_init_freeable(void)
 			ramdisk_execute_command, 0) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
+	} else if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT)) {
+		sys_mkdir("/dev", 0755);
+		devtmpfs_mount("/dev");
 	}
 
+	/* Open the /dev/console on the rootfs, this should never fail */
+	if (ksys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+		pr_err("Warning: unable to open an initial console.\n");
+	(void) ksys_dup(0);
+	(void) ksys_dup(0);
+
 	/*
 	 * Ok, we have completed the initial bootup, and
 	 * we're essentially up and running. Get rid of the

--------------65A4C91D7482DC2F6A89CC50--
