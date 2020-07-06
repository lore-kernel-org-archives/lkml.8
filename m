Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEDFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC4DA20722
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:53:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdufQKBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgGFMxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbgGFMw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:52:59 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9135C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 05:52:59 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id b92so16988277pjc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=63n3eu1019qDhV1WWLoaFPneo8+UWo7KAHMy1cAG4Hs=;
        b=pdufQKBL4z9O6THKiOF3HGNnAs9TtM0d4Y2XbvddCwlRLItqWYoV/nXuo4wWySYEcT
         Iw5As1tNsTWI3Ov8PurlLmM+REIRrgM5fhr4oLF2uaBcrWpY3ldbLbZvggkYusFXT92Y
         nBgR/aYy6dOo8ZfbhcTAsXXc5J+Enid4Q6tWwfvaSP8LtnubQyVUZhbiYz2Y6c96TuaF
         1VM/DomPKqxsbIVH/yZ3JABytyPlSdtTRAk/YFufh8rpWYuBhVaGMrhMJ+jP0MMsESmH
         b/M1DuLoGfB3DRdYFAIRk6xIs5D6MkkhXDyUs+eZ0aTmH1v6yBqazXPJEH5M7xg7mVxF
         a6UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=63n3eu1019qDhV1WWLoaFPneo8+UWo7KAHMy1cAG4Hs=;
        b=o80xFTbv3PZOtjRs3ZUApRntuyD4wXwUKn5op79Tkqq9y/9AyuA0dA8zXNdquyzT5x
         t1ae9bT3Dbk6UqC0fF3Z7iB6St87DYblLER0YiHU56tDofBZOc0SZv6UnDgdUU2UWHz2
         AHSTNHJOq6IedYIEOU8taIUD1cpt8XKk1iNp9TPxgu8X/5IiAU6T4FK11ECI5jnBFSzp
         Ipu5Ajr5jgM/BpVTb4VShBldQzOtgVRwncpAdJVJ3wjNwzZp8Bfmk3cO5E0MXgRcIV0D
         G75J4nfxM4nmEkNqwcXWt3e/vf8Rhil9JGGMFmjXRkds/OmjgM8dUxkuVDdn3M805hxT
         eGdQ==
X-Gm-Message-State: AOAM5307aI5dsGBE/eHxc5SlKbpxfDvKvNfbRDB8U4z8VuihpSZInA91
        IseAzFY6zxXCXt/vQMeXxfXtzXz2
X-Google-Smtp-Source: ABdhPJw1dqpt6oCO4C46Jh1fR3buvobCMZgz4vEV9P426VnKbvny6+RPA7bdVo36G9FfKFKKJ15czA==
X-Received: by 2002:a17:90a:c28f:: with SMTP id f15mr38433803pjt.72.1594039979421;
        Mon, 06 Jul 2020 05:52:59 -0700 (PDT)
Received: from cosmos ([122.166.128.47])
        by smtp.gmail.com with ESMTPSA id q29sm19016939pfl.77.2020.07.06.05.52.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2020 05:52:59 -0700 (PDT)
Date:   Mon, 6 Jul 2020 18:22:55 +0530
From:   Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
To:     christian@brauner.io
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pidfd: fix memory leak in pidfd_getfd()
Message-ID: <20200706125250.GA2828@cosmos>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmemleak backtrace:

comm "pidfd_getfd_tes", pid 1406, jiffies 4294936898 (age 8.644s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 90 da d8 f6 80 d5 6f f2  ..............o.
    b8 fb 9b ea c0 91 99 d1 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<8da987ad>] kmem_cache_alloc+0x199/0x4c0
    [<8ff6a575>] __alloc_file+0x1e/0xe0
    [<e1479798>] alloc_empty_file+0x45/0x100
    [<727fe6eb>] alloc_file+0x23/0xf0
    [<457148ef>] alloc_file_pseudo+0x98/0x100
    [<c104ed3d>] __shmem_file_setup.part.67+0x66/0x120
    [<5edc3e9b>] shmem_file_setup+0x4c/0x70
    [<9c446684>] __ia32_sys_memfd_create+0x122/0x1c0
    [<e129fc9c>] do_syscall_32_irqs_on+0x3d/0x260
    [<62569441>] do_fast_syscall_32+0x39/0xb0
    [<3c515b7e>] do_SYSENTER_32+0x15/0x20
    [<69819a3a>] entry_SYSENTER_32+0xa9/0xfc

comm "pidfd_getfd_tes", pid 1406, jiffies 4294936898 (age 8.644s)
  hex dump (first 16 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<8da987ad>] kmem_cache_alloc+0x199/0x4c0
    [<b67faec5>] security_file_alloc+0x20/0x90
    [<ed849d41>] __alloc_file+0x40/0xe0
    [<e1479798>] alloc_empty_file+0x45/0x100
    [<727fe6eb>] alloc_file+0x23/0xf0
    [<457148ef>] alloc_file_pseudo+0x98/0x100
    [<c104ed3d>] __shmem_file_setup.part.67+0x66/0x120
    [<5edc3e9b>] shmem_file_setup+0x4c/0x70
    [<9c446684>] __ia32_sys_memfd_create+0x122/0x1c0
    [<e129fc9c>] do_syscall_32_irqs_on+0x3d/0x260
    [<62569441>] do_fast_syscall_32+0x39/0xb0
    [<3c515b7e>] do_SYSENTER_32+0x15/0x20
    [<69819a3a>] entry_SYSENTER_32+0xa9/0xfc

This is because in pidfd_getfd(), the file->f_count is incremented twice
1) __pidfd_fget() gets file ref by incrementing f_count in __fget_files()
2) f_count is incremented While installing fd in __fd_install_received()
   i.e. get_file().

Memory leak occurs because the refs count do not match, the struct file
object is never freed.

Secondly the error validity check (ret < 0) after the call to
fd_install_received() is not needed since this function cannot return
negative number after incrementing f_count. So it is wrong to call fput
on condition (ret < 0).

Change pidfd_getfd() to call fput() on file reference once its installed
as new_fd in target process.

Signed-off-by: Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>
---
 kernel/pid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index 5799ae5..d00139c 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -653,8 +653,8 @@ static int pidfd_getfd(struct pid *pid, int fd)
 		return PTR_ERR(file);
 
 	ret = fd_install_received(file, O_CLOEXEC);
-	if (ret < 0)
-		fput(file);
+
+	fput(file);
 	return ret;
 }
 
-- 
2.7.4

