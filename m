Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 580EBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F14B224F4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JghOR3/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgGNTlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729465AbgGNTlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:41:19 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2046DC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:41:19 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id a12so18541544ion.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Yfl627IA+B/fjGximssA/R316mc2EfYtR5UACcyTqEU=;
        b=JghOR3/w/t7Bad3EVRgQFuuTNrxpveb/+pmXcmvRpr8kT3VdS32gz4oS09pbARW9Um
         mHfVM72pqiTz+45kDF631HpsK0xRi4Xx2fK3udA1l6TWZ+lznhGgzu6zP2x0Z7oSMgZW
         y9TYbgPVf4sZ3qrb7BaioB7FbUO73nUsGKGqcxAXuvdf2pEryou31b6sNt+Yh/fiHFbk
         2Mkm6BzFMouPZ0ML54FG1ZxtVydZrETj0xnFK9L2S9F24ILZrHy2PGt7c1MmrS7nqUkd
         apbUxVSu+mEhD5qpWQxugtFUR3oM6cFtP64o3f40pgP99eajZSBJygzlAKTQTpvvmS4e
         0Nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Yfl627IA+B/fjGximssA/R316mc2EfYtR5UACcyTqEU=;
        b=lmKr6Iz+ofGyn2slcj4ILW5HhKBflci/fXrshWifHQmvz6+98MqZ+BKayY38wRhGxb
         dvT/Qtr5lpec2DGpqI0az19LV3Fo+FG4BvmQ6XSv8iELg2lr0oT7WqCzsiCEDgfm0gFP
         xo2MRv7k3In6IUzK2XbY56PlnBohi5VuffCzpPAWA24ouCJDeBkbHHv4KBpdM3c0ye+R
         qhwjUhuyDQNuhG+2+cYDQXa3lVEX3VeHtweFSR81dWUGzaNGyhvpfEyLbSrT5uq/wUMT
         qE/q6CTMZfhyphA9XP8kpDzbVE8yzXHC+w799i/kC6FAighPK3enN9Tie2pHuFp0vY2x
         9xBA==
X-Gm-Message-State: AOAM532svSosEaLaDWk31ma5nifotM2Hn10b+h8H1pdrHNkGaAYKrepk
        mtoDDLSWKOfRObY6Lhhn9APYLuilf68LB1dI7io=
X-Google-Smtp-Source: ABdhPJzDor833Vb6WahOOibHeQiKHiz9rWxuyRputJFLDlfl9uZc37yxhD6huWFISbKt5Knd+/DlitnTLUK68G8OADM=
X-Received: by 2002:a05:6602:1555:: with SMTP id h21mr6451215iow.163.1594755678534;
 Tue, 14 Jul 2020 12:41:18 -0700 (PDT)
MIME-Version: 1.0
From:   Bernd Amend <bernd.amend@gmail.com>
Date:   Tue, 14 Jul 2020 21:41:07 +0200
Message-ID: <CAF31+H5ZB7zn73obrc5svLzgfsTnyYe5TKvr7-6atUOqrRY+2w@mail.gmail.com>
Subject: Regression: squashfs issues since change "squashfs: migrate from
 ll_rw_block usage to BIO"
To:     phillip@squashfs.org.uk, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Bernd Amend <bernd.amend@gmail.com>,
        Stefan Rommel <stefanrommel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With the Linux Kernel version 5.8-rc5/master I am unable to mount some
squashfs filesystems compressed with "-comp lz4".
If I try to mount them I get the following error:
[    1.084246] SQUASHFS error: lz4 decompression failed, data probably corrupt
[    1.084545] SQUASHFS error: Failed to read block 0x873e1001: -5
[    1.084761] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
[    1.084983] SQUASHFS error: Unable to read directory block [873e0fff:1586]
[    1.122564] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
[    1.122708] SQUASHFS error: Unable to read directory block [873e0fff:1586]
[    1.122862] Starting init: /sbin/init exists but couldn't execute
it (error -5)
[    1.123027] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
[    1.123152] SQUASHFS error: Unable to read directory block [873e0fff:1586]
[    1.123279] Starting init: /etc/init exists but couldn't execute it
(error -5)
[    1.123444] SQUASHFS error: Unable to read metadata cache entry [873e0fff]
[    1.123573] SQUASHFS error: Unable to read directory block [873e0fff:1586]
[    1.123713] Starting init: /bin/init exists but couldn't execute it
(error -5)
[    1.123900] SQUASHFS error: Unable to read metadata cache entry [873e0fff]

or

[ 4960.910693] attempt to access beyond end of device
[ 4960.910695] loop0: rw=2048, want=46, limit=40
[ 4960.910696] SQUASHFS error: Failed to read block 0x4001: -5
[ 4960.910697] SQUASHFS error: Unable to read metadata cache entry [3fff]
[ 4960.910698] SQUASHFS error: Unable to read inode 0x20c5000c

I bisected the issue to the commit "squashfs: migrate from ll_rw_block
usage to BIO"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/fs/squashfs?id=93e72b3c612adcaca13d874fcc86c53e6c8da541

The issue can be reproduced by downloading
https://theworldsend.eu/demo.squashfs (20K) and the following command
line.
# mount demo.squashfs mnt && ls mnt && umount mnt

The same squashfs can be mounted using Linux <=5.7.8.
The kernel config is identical to the Arch Linux Kernel configuration,
build using gcc 9 and 10 on x86_64.

Best regards,
Bernd Amend
