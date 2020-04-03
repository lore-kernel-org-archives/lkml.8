Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B090C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFF9206F8
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q6T7oC/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404578AbgDCQgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:36:40 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41174 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbgDCQgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:36:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id i3so6946768qtv.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uNJOzrhb8UMrZausRKOSk/HuCYXHueLDrltVnxQ2LKY=;
        b=q6T7oC/5c7rpSP05CKUFoQPNuHnnIIUTKa9aP/IrigVCcBtfUzZfODnLL/AsyePKti
         9/1q1+daIFxc9Jw/2O4xBvLvSD3bKu0nUNgBDVcH2c1Wo01PA0alHVn1DLLk6Xgz+Ti6
         f3CdRI4TSgxPBhFOxYsz3ED0s6P2YQZK4LbIq4yfLVeJNxieL6IPaU1XGYpJ7tnaf5Qu
         gjG+E/rPqjGPwbfd5cUTZsGa2O+8PXyeB5R8m2Vx5l/bbhgvvngoFuBVINBS1xYnOr5d
         BckIGp9tiiQNYja6PMobG4+AVyhOh7SPdckBEdLAvCaXjKilltXGEJVVELX+lHOSW5oe
         iO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uNJOzrhb8UMrZausRKOSk/HuCYXHueLDrltVnxQ2LKY=;
        b=q6B9AP4UF+JjjCGyjyMmuM45lYAf+y9Aimt2SKHGoCITTgYfnG09UZokfLfs2PhO6j
         lYHi46Ztms2e9fRxYMSIi+ljOw2C3qQC1CGBRSddOHzp5Cl9Bg5TvM55cTzBPpSgzxDi
         oAIzkUYWI+PGwccefkjc1m1RtlPxD+OAMoGiMC409AJvrFGdwIx5lbHZ1Rtox26OgDH9
         6WX85VLDrWRQT3nF/tMzjNv0GGpjyYTqX9kqolrdW9DqH4PxxzqITx1mr3xBOKZPmN7V
         7mW2m95t8F6+cinzO7MGMGdfoAxeiV3Qpu4CKRj2NVVf1UqA3D9XZq6jhvc7sL97qtNA
         fwDg==
X-Gm-Message-State: AGi0PuaJ3Hb5dEQjZqaBXLIfTw68jnB6eUdSEv4qjI7TwxWDw4xJ8oig
        vKTvTMJlqLHCvybWItb0Qon/EJsB95tQnmMD0AjKtw==
X-Google-Smtp-Source: APiQypK8ppWCh4EUsDC0f6x4IZVSgBRztMCKf2owVG6v4uMfpKXN8CvuMmoeAQlWtGiryHxw7QR6a++7dvZj0SIn1mE=
X-Received: by 2002:aed:2591:: with SMTP id x17mr9150623qtc.380.1585931797664;
 Fri, 03 Apr 2020 09:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000000cfff005a26226ce@google.com> <874ku0sncc.fsf@mail.parknet.co.jp>
In-Reply-To: <874ku0sncc.fsf@mail.parknet.co.jp>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 3 Apr 2020 18:36:26 +0200
Message-ID: <CACT4Y+YaM9Qj9V9G7G+aQrmfxfdtyBX4WXXsBamUjyMMpEeEdg@mail.gmail.com>
Subject: Re: KCSAN: data-race in __fat_write_inode / fat12_ent_get
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     syzbot <syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com>,
        Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 3:36 PM OGAWA Hirofumi
<hirofumi@mail.parknet.co.jp> wrote:
>
> syzbot <syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com> writes:
>
> > syzbot found the following crash on:
> >
> > HEAD commit:    40959e34 kcsan: Avoid blocking producers in prepare_rep=
ort()
> > git tree:       https://github.com/google/ktsan.git kcsan
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1201d5a3e00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1ab2c758651=
b11f6
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D6f1624f937d9d=
6911e2d
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com
> >
> > FAT-fs (loop1): error, clusters badly computed (876 !=3D 875)
> > FAT-fs (loop1): error, clusters badly computed (877 !=3D 876)
> > FAT-fs (loop1): error, clusters badly computed (878 !=3D 877)
>
> Hm, looks like the race between a directory entry vs a FAT entry.  This
> bug was happened with the corrupted image? Or the image passes the check
> of dosfsck?
>
> If the corrupted image, it may be hard to prevent the all races. Well,
> anyway, the corrupted image of the report will help to detect this
> corruption.

Hi OGAWA,

From the log, it's this program.
My bet on a corrupted image. syzkaller does not have format
descriptions for fat, so it's just random bytes.

03:07:45 executing program 1:
syz_mount_image$vfat(&(0x7f0000000080)=3D'vfat\x00',
&(0x7f00000002c0)=3D'./file0\x00', 0xfffffffffffff57a, 0x1,
&(0x7f0000000140)=3D[{&(0x7f0000000040)=3D"eb3c906d6b66732e66617400020401ed=
01000270fff8",
0x16}], 0x0, 0x0)
r0 =3D open(&(0x7f0000000180)=3D'./file0\x00', 0x0, 0x0)
fchdir(r0)
r1 =3D open(&(0x7f00000000c0)=3D'./file0\x00', 0x14107e, 0x0)
write$binfmt_elf32(r1,
&(0x7f0000000cc0)=3DANY=3D[@ANYBLOB=3D"7f454c460000000000000000000000000000=
000000000000000000003400000020000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
e997eba191fdbf47fe0c67ef95c198d20000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000ff0f00000000000000000000000000000000000000000000aeb2=
ca6a00000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000001=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000010000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000008000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000000000000000000000f4ff=
ffff00000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000e3ffffff00010400000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000001e00=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000000000000000000be050000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000033930000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000004000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000f4ffffffffffffff0000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00100000000000000000000000000000000fcffffffffffffff000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000008000000000000=
000000000000000000000000000000000000000000000000000000000546fde79d700000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000e90f"],
0x801)
r2 =3D socket$inet6(0xa, 0x2, 0x0)
r3 =3D dup(r2)
r4 =3D creat(&(0x7f0000000240)=3D'./bus\x00', 0x0)
lseek(r4, 0x7ffffc, 0x0)
write$binfmt_elf64(r4, &(0x7f0000000100)=3DANY=3D[@ANYRESDEC], 0x14)
ioctl$PERF_EVENT_IOC_ENABLE(r3, 0x8912, 0x400200)
sendfile(r1, r1, &(0x7f00000001c0), 0x8080fffffffe)



> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in __fat_write_inode / fat12_ent_get
> >
> > write to 0xffff8881015f423c of 4 bytes by task 9966 on cpu 1:
> >  __fat_write_inode+0x246/0x510 fs/fat/inode.c:877
> >  fat_write_inode+0x67/0xe0 fs/fat/inode.c:909
> >  write_inode fs/fs-writeback.c:1312 [inline]
> >  __writeback_single_inode+0x722/0x910 fs/fs-writeback.c:1511
> >  writeback_single_inode+0x219/0x2f0 fs/fs-writeback.c:1565
> >  sync_inode fs/fs-writeback.c:2602 [inline]
> >  sync_inode_metadata+0x75/0xa0 fs/fs-writeback.c:2622
> >  __generic_file_fsync+0x117/0x180 fs/libfs.c:1081
> >  fat_file_fsync+0x54/0x120 fs/fat/file.c:190
> >  vfs_fsync_range+0x7c/0x150 fs/sync.c:197
> >  generic_write_sync include/linux/fs.h:2867 [inline]
> >  generic_file_write_iter+0x31c/0x38e mm/filemap.c:3452
> >  call_write_iter include/linux/fs.h:1901 [inline]
> >  do_iter_readv_writev+0x4a7/0x5d0 fs/read_write.c:693
> >  do_iter_write fs/read_write.c:998 [inline]
> >  do_iter_write+0x137/0x3a0 fs/read_write.c:979
> >  vfs_iter_write+0x56/0x80 fs/read_write.c:1039
> >  iter_file_splice_write+0x530/0x830 fs/splice.c:760
> >  do_splice_from fs/splice.c:863 [inline]
> >  direct_splice_actor+0x97/0xb0 fs/splice.c:1037
> >  splice_direct_to_actor+0x22f/0x540 fs/splice.c:992
> >  do_splice_direct+0x152/0x1d0 fs/splice.c:1080
> >  do_sendfile+0x396/0x810 fs/read_write.c:1520
> >  __do_sys_sendfile64 fs/read_write.c:1575 [inline]
> >  __se_sys_sendfile64 fs/read_write.c:1567 [inline]
> >  __x64_sys_sendfile64+0xb8/0x140 fs/read_write.c:1567
> >  do_syscall_64+0xc7/0x390 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > read to 0xffff8881015f423d of 1 bytes by task 9960 on cpu 0:
> >  fat12_ent_get+0x5e/0x120 fs/fat/fatent.c:125
> >  fat_ent_read+0x3de/0x560 fs/fat/fatent.c:370
> >  fat_get_cluster+0x52b/0x920 fs/fat/cache.c:266
> >  fat_bmap_cluster fs/fat/cache.c:299 [inline]
> >  fat_get_mapped_cluster+0x105/0x230 fs/fat/cache.c:320
> >  fat_bmap+0x146/0x28e fs/fat/cache.c:384
> >  __fat_get_block fs/fat/inode.c:165 [inline]
> >  fat_get_block+0x244/0x4f0 fs/fat/inode.c:190
> >  __block_write_begin_int+0x306/0xf80 fs/buffer.c:2008
> >  __block_write_begin fs/buffer.c:2058 [inline]
> >  block_write_begin+0x76/0x160 fs/buffer.c:2117
> >  cont_write_begin+0x3bd/0x660 fs/buffer.c:2466
> >  fat_write_begin+0x69/0xc0 fs/fat/inode.c:236
> >  pagecache_write_begin+0x67/0x90 mm/filemap.c:3106
> >  cont_expand_zero fs/buffer.c:2393 [inline]
> >  cont_write_begin+0x176/0x660 fs/buffer.c:2456
> >  fat_write_begin+0x69/0xc0 fs/fat/inode.c:236
> >  generic_perform_write+0x13a/0x320 mm/filemap.c:3287
> >  __generic_file_write_iter+0x240/0x370 mm/filemap.c:3416
> >  generic_file_write_iter+0x294/0x38e mm/filemap.c:3448
> >  call_write_iter include/linux/fs.h:1901 [inline]
> >  new_sync_write+0x303/0x400 fs/read_write.c:483
> >  __vfs_write+0x9e/0xb0 fs/read_write.c:496
> >  vfs_write fs/read_write.c:558 [inline]
> >  vfs_write+0x189/0x380 fs/read_write.c:542
> >  ksys_write+0xc5/0x1a0 fs/read_write.c:611
> >  __do_sys_write fs/read_write.c:623 [inline]
> >  __se_sys_write fs/read_write.c:620 [inline]
> >  __x64_sys_write+0x49/0x60 fs/read_write.c:620
> >  do_syscall_64+0xc7/0x390 arch/x86/entry/common.c:294
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 9960 Comm: syz-executor.1 Not tainted 5.6.0-rc1-syzkaller #=
0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/874ku0sncc.fsf%40mail.parknet.co.jp.
