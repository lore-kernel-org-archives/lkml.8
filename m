Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724CBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37D802065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="GOl1+eFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgEOD6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 23:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726665AbgEOD6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 23:58:13 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649ABC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 20:58:13 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id r25so1078979oij.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 20:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=BIBFbyERYPkI08HE4VPIWbR/OEt3ozO4JwDPfzqYRFI=;
        b=GOl1+eFsIVIkwHUc6cIRr1nJSc5CkL26YUoMMvdskx5/S7ZArCujqOV0+OsH8wkG37
         HXCzN/D6EvfdTPsFdBg6dYmdllXxvgJnZUmVu9mzFPQBzIVOJ+u94SNqXJh7Hg7UN282
         JAO7JaG03LCvYjqewOWdcNayEiUYg+OrQg1E2PFBgH9BnSRjstwE6OQgl9n4hdomSCrI
         ODw6OZqNdJGHV5W7tzV5i3aQlCbihMS3Ok9k2z2BEfq1DiB2DPAWHDRx/vkRgPh8E0gY
         dNwN3UuYzlykZHR1sO/gTnkcd+pwlsGJrcoGYmZFRhxlO+mDAP5EFduInXjwew90rIOZ
         eBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=BIBFbyERYPkI08HE4VPIWbR/OEt3ozO4JwDPfzqYRFI=;
        b=N2IbSlugIb8AattEvpovcqTsKKZzfTzgGWShzq/bjZB3seFk6SPQBP8DE3CbxSu1MY
         EEN3z5twMNGWXMJN4fr+2xtff+Wcj4QyvNLiSrzG6Fx/ZJOPbROsXT1X33yKPIAylcDS
         6vzDc/EmghRnRBr73GfLRc4LiWLKXk0+uxgWXzb2+J7papy7l68a/HCnYKI3EO0Jsz16
         0OUEgU8zO8Msy985Z7i61B2WBYXoCqSkeHlehfzgC8EKwNx9UFIsRWl7dfUloxnpSNh6
         K9ErfNl37voDLCKVVXXCjFmrafKx1OF0cu87k09Eu0QG/DloctpXUeJpIVDVGnInD0ZY
         ZnTw==
X-Gm-Message-State: AOAM530POBpHVx/oBRELnOjbLtVLZIehpsXpvs33k5vbuSCqREGM/mmg
        +l0YXiW8NxedmjLoTepoupDrGEatGzQ=
X-Google-Smtp-Source: ABdhPJxlMFF1lrEufYCjmXUsTNXlevUbIDHu5fFdyk0zu597rv3kFmsgctmiIihKvBDysUKvn78UJg==
X-Received: by 2002:aca:59c4:: with SMTP id n187mr841864oib.1.1589515092625;
        Thu, 14 May 2020 20:58:12 -0700 (PDT)
Received: from [192.168.86.21] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id c25sm278102otp.50.2020.05.14.20.58.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 20:58:10 -0700 (PDT)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Rob Landley <rob@landley.net>
Subject: [PATCH v4] Make initramfs honor CONFIG_DEVTMPFS_MOUNT
Message-ID: <25e7e777-19f9-6280-b456-6c9c782c7901@landley.net>
Date:   Thu, 14 May 2020 23:04:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------BBBC1B60A1217C569003B82E"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------BBBC1B60A1217C569003B82E
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

FYI I dug up my old https://lkml.org/lkml/2017/9/13/651 and ported it to
current, because I needed it for a thing.

From: Rob Landley <rob@landley.net>

Make initramfs honor CONFIG_DEVTMPFS_MOUNT, and move
/dev/console open after devtmpfs mount.

Add workaround for Debian bug that was copied by Ubuntu.

Signed-off-by: Rob Landley <rob@landley.net>

--------------BBBC1B60A1217C569003B82E
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
@@ -2417,7 +2417,21 @@  static int do_add_mount(struct mount *newmnt, struct path *path, int mnt_flags)
 	err = -EBUSY;
 	if (path->mnt->mnt_sb == newmnt->mnt.mnt_sb &&
 	    path->mnt->mnt_root == path->dentry)
+	{
+		if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT) &&
+		    !strcmp(path->mnt->mnt_sb->s_type->name, "devtmpfs"))
+		{
+			/* Debian's kernel config enables DEVTMPFS_MOUNT, then
+			   its initramfs setup script tries to mount devtmpfs
+			   again, and if the second mount-over-itself fails
+			   the script overmounts a tmpfs on /dev to hide the
+			   existing contents, then boot fails with empty /dev. */
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

--------------BBBC1B60A1217C569003B82E--
