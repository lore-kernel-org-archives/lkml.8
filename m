Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3A0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC4E2080C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 11:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pantacor-com.20150623.gappssmtp.com header.i=@pantacor-com.20150623.gappssmtp.com header.b="KU2N9icZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHSLvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 07:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728404AbgHSLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 07:51:11 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E29C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 04:51:11 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id g15so6803047plj.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 04:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pantacor-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=i0tNVSZaTTSBSz1XMN9me4AeE1YySOZOXVNji2is7bI=;
        b=KU2N9icZcino+gt7U3a/eLtnZKkt6AD9RvGBD4MmAH3rtUrB7er2x60jDj15eru501
         n6OUx6p1tBA9eLbeZuReAAzUsCY1Lt/hyfK5uyf6FjzZNwyWQd4kf+pfQ2MM9WpeYuNi
         0l+LF/A4LD1Nj6ac2Pl3HDcV3nweA93RqoQbo8g+vS9ThmMB3z6VxKmnngHpJ5k0Aqjy
         8VKyXgJ1zkFtRPTjWNpaVaTdFypI6MzEC7bisjptgvH08my8JbmcoNvUW3rO/c3ZFpZu
         CTT4FdA3cq10OH5awPwZwmYEJtN9pEymggM3p55bK0LDnrhO7oqtYKLOqBy/fTq+PDoA
         37ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=i0tNVSZaTTSBSz1XMN9me4AeE1YySOZOXVNji2is7bI=;
        b=ps04DIm671uXHQkQCucvCH934av65anB0FBhYme8EITz5OKrIOA8vvtc+sKMgJxDFE
         iyk6jj8Mu0NRvbK8zoHPIHsQZvkf06Xn6fekAQxqaIqaOTX9YA2TzGMSCbImsUiqgyjh
         AswPF8/mXJ++ZHBDm7gKvQktRuOiwviFPvsfI6AgnW/kIFtl5f4yx9XMYFgJAML3GIGx
         oC/CQdVmjQ2OfDzAqd5iA1v+6CemYCf1LuUtf53FADGr2DEc0aKkWd1p2cOtrX3nd3J8
         +Xe3qJRcbKVL1T3BUxV0KXuZ2VblpUftK8PHYO8d+NIYZSTYCxAxOPZGy0C4AVDT4/j5
         OsXQ==
X-Gm-Message-State: AOAM533P2AzikLEVYMG5sjKFIQkIMnkWZh0LbfectuUmskH8wLKPxqOC
        kTIdyY8hhHVKlXJUT1D4MudGe+SyXXSs8TkF6KgA7tigZA0xPu/n
X-Google-Smtp-Source: ABdhPJxJ4K74YGSKKGp+gwdCR/YE8Cu+mBb+YPcVIXoxbrpUVMvtqsoUb6E4GNlLZcIzX1sHI08a1QqXY6O+2ACB0tg=
X-Received: by 2002:a17:90b:1295:: with SMTP id fw21mr3563857pjb.81.1597837870565;
 Wed, 19 Aug 2020 04:51:10 -0700 (PDT)
MIME-Version: 1.0
From:   Pranay Srivastava <pranay.srivastava@pantacor.com>
Date:   Wed, 19 Aug 2020 17:20:59 +0530
Message-ID: <CABfyVHc=oQmZG9NuJgu1G92VQqsxkynE+S9DosQzh9r+9G1Jbg@mail.gmail.com>
Subject: mountinfo contents changed when rootfs is ramfs
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running a system where rootfs is ramfs. For kernel version 5.2.11

# cat /proc/self/mountinfo
0 0 0:1 / / rw - rootfs rootfs rw
%<---snip>%

while for kernel 5.4.58
# cat /proc/self/mountinfo
0 0 0:1 / / rw - rootfs none rw
%<---snip>%

The reason for the above difference is because for kernel 5.2.11 the
parse_param for
rootfs was set to legacy_parse_param which handled the "source" param
instead of
ignoring it.

With kernel 5.4.58 this is set to ramfs_parse_param which ignores any
parameters not
recognized and also returns 0 instead of -ENOPARAM. This causes
vfs_parse_fs_param
to not set the file context  source(fc->source) which results in "none" from
alloc_vfs_mount(fc->source ? : "none")

The commit which introduced the above change was

commit f32356261d44d580649a7abce1156d15d49cf20f
Author: David Howells <dhowells@redhat.com>
Date:   Mon Mar 25 16:38:31 2019 +0000

    vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API

I'm not sure if this is a regression? But if it is, do we handle it like

diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index ee179a81b3da..47a39baa0535 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c

@@ -200,7 +200,7 @@ static int ramfs_parse_param(struct fs_context
*fc, struct fs_parameter *param)
                 * and as it is used as a !CONFIG_SHMEM simple substitute
                 * for tmpfs, better continue to ignore other mount options.
                 */
-               if (opt == -ENOPARAM)
+               if (opt == -ENOPARAM && strcmp(param->key, "source"))
                        opt = 0;
                return opt;
        }

so that mountinfo gives the same information as for earlier kernels.

Thanks!
-- 
Regards,
Pranay Srivastava
