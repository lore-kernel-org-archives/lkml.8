Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8FFC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08AEC20656
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 08:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stapelberg-ch.20150623.gappssmtp.com header.i=@stapelberg-ch.20150623.gappssmtp.com header.b="k0i8T2rN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgBIIJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 03:09:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45182 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgBIIJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 03:09:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id g3so2669868wrs.12
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 00:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg-ch.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ve7K3gNrc6NTnnXrgEcnHzrZU85cAt9Mn5NCLlqs2kg=;
        b=k0i8T2rNRlGWLJ3O9lVIGJlkEWmu7zEidlORdgvGqnO9WAwTiL3kAYu7abpxrZg2X4
         KyThsyPlKtofk+MQh0f6wuHcl+qEDZnqXTgvkoPi+KlHPrJHfz3k6xStaoN1futNxlat
         fmgZrYczgSwqBw6xPgWw98mKJ6AxbLHGoyItl2nY9Ik/5YMVdqvA3zsarRIFdUnu9JgS
         WNBanzsTn+RSSy6GnxCRXSBM6Fxgd5JPBRW2ZZ/N0KHouPXDgtKm4BQ7cinpYSi5pLCg
         CpKurhnki5zcUIP3K2jP+o8zXT3LaLP0pF39XXqGdWXmP+y2HjaViUcOTby8RlMbA6bA
         Iq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ve7K3gNrc6NTnnXrgEcnHzrZU85cAt9Mn5NCLlqs2kg=;
        b=KtXY7p1kmBsLBPdHR43bOMLezqPtP0NaqGDfVRuhh7PhLFTz4fua3PNTc2duVxNCn+
         I11MMt2C/PK7tWNOtnf2BMVY5efOxapmikXLgU/KxVPJdi1jB8/cohLuUNDawgfu5PUe
         3YigkLpXMjeHvNGcKtuynyLhFxbx9V43GGj0TJlPlt//qQZ0Oq05T5FWdQVDZt6ucdi7
         aJz2kvYV4F1XEqqOYz62P49AQguUjJ+TzN14xdK/P4YrdSpPHHN9MFMS9YiyEWayWGFS
         jtWytlgwxLQTKlUgBKUU85ozULoEh6NKhHAO97Zcm8znwUglcGlbzaNEyH4nfGgY7ogo
         4glA==
X-Gm-Message-State: APjAAAXMJttmoP6k0yhKPUxosh2teez/dw4Ax5/b+SSqipJ5fZjlN228
        It11IdwrMkCBrdDrKwIoHJsvhLrLP+djgQ==
X-Google-Smtp-Source: APXvYqwinGVmRBIVozWttZecpD3dR1dpDgtFWdsjqJfK0dQVIp/rS4/C7qWqP5JJtXIk+ICMhgnJEg==
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr9619091wrp.236.1581235761061;
        Sun, 09 Feb 2020 00:09:21 -0800 (PST)
Received: from localhost (midna.zekjur.net. [2a02:168:4a00:0:6d9:f5ff:fe1f:9dcd])
        by smtp.gmail.com with ESMTPSA id j14sm679749wrn.32.2020.02.09.00.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 00:09:20 -0800 (PST)
From:   michael+lkml@stapelberg.ch
To:     miklos@szeredi.hu
Cc:     fuse-devel@lists.sourceforge.net, gregkh@linuxfoundation.org,
        kyle.leet@gmail.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Stapelberg <michael+lkml@stapelberg.ch>
Subject: Re: Still a pretty bad time on 5.4.6 with fuse_request_end.
Date:   Sun,  9 Feb 2020 09:09:18 +0100
Message-Id: <20200209080918.1562823-1-michael+lkml@stapelberg.ch>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
References: <CAJfpegtUAHPL9tsFB85ZqjAfy0xwz7ATRcCtLbzFBo8=WnCvLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Stapelberg <michael+lkml@stapelberg.ch>

Hey,

I recently ran into this, too. The symptom for me is that processes using the
affected FUSE file system hang indefinitely, sync(2) system calls hang
indefinitely, and even triggering an abort via echo 1 >
/sys/fs/fuse/connections/*/abort does not get the file system unstuck (there is
always 1 request still pending). Only removing power will get the machine
unstuck.

I’m triggering this when building packages for https://distr1.org/, which uses a
FUSE daemon (written in Go using the jacobsa/fuse package) to provide package
contents.

I bisected the issue to commit
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2b319d1f6f92a4ced9897678113d176ee16ae85d

With that commit, I run into a kernel oops within ≈1 minute after starting my
batch build. With the commit before, I can batch build for many minutes without
issues.

…and just in case it matters, building linux from HEAD
(f757165705e92db62f85a1ad287e9251d1f2cd82) with that commit reverted results in
a working kernel, too.

Find below a backtrace full from kgdb, with fs/fuse/dev.c compiled with -O0:

(gdb) bt full
#0  0xffff888139a36600 in ?? ()
No symbol table info available.
#1  0xffffffff8137b368 in fuse_request_end (fc=0xffff888139a36600,
req=0xffff8880b7f333b8) at fs/fuse/dev.c:328
        fiq = 0xffff888139a36648
        async = true
#2  0xffffffff8137f488 in fuse_dev_do_write (fud=0xffff888139a36600,
cs=0xffffc9000dd7fa58, nbytes=4294967294) at fs/fuse/dev.c:1911
        err = 0
        fc = 0xffff888139a36600
        fpq = 0xffff8881390e5148
        req = 0xffff8880b7f333b8
        oh = {len = 16, error = -2, unique = 2692038}
#3  0xffffffff8137f569 in fuse_dev_write (iocb=0xffffc9000093be48,
from=0xffffc9000093be20) at fs/fuse/dev.c:1933
        cs = {write = 0, req = 0xffff8880b7f333b8, iter =
0xffffc9000093be20, pipebufs = 0x0 <fixed_percpu_data>, currbuf = 0x0
<fixed_percpu_data>, pipe = 0x0 <fixed_percpu_data>, nr_segs = 0,
          pg = 0x0 <fixed_percpu_data>, len = 0, offset = 24, move_pages = 0}
        fud = 0xffff8881390e5140
#4  0xffffffff811fe4de in call_write_iter (file=<optimized out>,
iter=<optimized out>, kio=<optimized out>) at
./include/linux/fs.h:1902
No locals.
#5  new_sync_write (filp=0xffff888123800800, buf=<optimized out>,
len=<optimized out>, ppos=0xffffc9000093bee8) at fs/read_write.c:483
        iov = {iov_base = 0xc00082a008, iov_len = 16}
        kiocb = {ki_filp = 0xffff888123800800, ki_pos = 0, ki_complete
= 0x0 <fixed_percpu_data>, private = 0x0 <fixed_percpu_data>, ki_flags
= 0, ki_hint = 0, ki_ioprio = 0, ki_cookie = 0}
        iter = {type = 5, iov_offset = 0, count = 0, {iov =
0xffffc9000093be20, kvec = 0xffffc9000093be20, bvec =
0xffffc9000093be20, pipe = 0xffffc9000093be20}, {nr_segs = 0, {head =
0,
              start_head = 0}}}
        ret = <optimized out>
#6  0xffffffff811fe594 in __vfs_write (file=<optimized out>,
p=<optimized out>, count=<optimized out>, pos=<optimized out>) at
fs/read_write.c:496
No locals.
#7  0xffffffff81200fa4 in vfs_write (pos=<optimized out>, count=16,
buf=<optimized out>, file=<optimized out>) at fs/read_write.c:558
        ret = 16
        ret = <optimized out>
#8  vfs_write (file=0xffff888123800800, buf=0xc00082a008 "\020",
count=16, pos=0xffffc9000093bee8) at fs/read_write.c:542
        ret = 16
#9  0xffffffff81201252 in ksys_write (fd=<optimized out>,
buf=0xc00082a008 "\020", count=16) at fs/read_write.c:611
        pos = 0
        ppos = <optimized out>
        f = <optimized out>
        ret = 824642281480
#10 0xffffffff812012e5 in __do_sys_write (count=<optimized out>,
buf=<optimized out>, fd=<optimized out>) at fs/read_write.c:623
No locals.
#11 __se_sys_write (count=<optimized out>, buf=<optimized out>,
fd=<optimized out>) at fs/read_write.c:620
        ret = <optimized out>
        ret = <optimized out>
#12 __x64_sys_write (regs=<optimized out>) at fs/read_write.c:620
No locals.
#13 0xffffffff810027f8 in do_syscall_64 (nr=<optimized out>,
regs=0xffffc9000093bf58) at arch/x86/entry/common.c:294
        ti = <optimized out>
#14 0xffffffff81e0007c in entry_SYSCALL_64 () at arch/x86/entry/entry_64.S:175
No locals.
#15 0x0000000000000000 in ?? ()
No symbol table info available.

