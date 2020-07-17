Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D24DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5436C2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JMp4YhPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgGQUx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgGQUx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:53:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3011C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:53:25 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x62so8693195qtd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0lyHoK43hN4cDd36fR30aBsfsjpWFSili5oOrrjQGw=;
        b=JMp4YhPhX2BOIq5T9z/+RqMxUO9j8D3Vzgaod/I5xxCSsAubANIyH7vgHDnFaQ7UyR
         lgg6q8PlVeb5rzoUIG5Uhp5mHjClldmmfBUguGZ5CbY7DT9aw6uSzB/r5Sj9aNK6cZRR
         45uQ8QF6e2Ivb/qotjjT5SKXPBf7ajM/e2JtXrss1BbphJpTIOFTQU6D58E2OhW3x+Ej
         tTchcGIQA+S9pnkAqz/gPJ/0o/F4yJccT4p1XLXws5qcGp7e9bzk44ZejxMBIfdQMpKp
         zDm37LpIl/knod+bmBLeLxS6V7+3LpraNiSdUQGHoKBpVxGiqh+APPzNxDE6LPxRqqes
         zEGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z0lyHoK43hN4cDd36fR30aBsfsjpWFSili5oOrrjQGw=;
        b=LQldIrZ+HV4P1mPYr3T9x/wPwArevy5yZskLwJOjE9yoUID0ht0kOnBENLT6owKLkx
         0f7S3X/ECk4KEnDxh1EAyc6BoKPRfDWrxmNW/3BvyU7VIF7Aj43G+Bhn+GZ3ND/N6oXR
         cBiV2XXaBFo0/lIYY9mfoqJer00v8ggl0svLAlarRdoj4Crs6FK9rUmP/4o3SK14xWpT
         jcKgyCZcjvswGA20g46IJuyPeI+P7gxEvu5DWAxJDTmo2nj3hzPBPmW/5qjBO99eo7AX
         /E7X5qliJwfibAiRgddLubQWlG3xJonVy2pl7sR/0Vj2hPWKQAHuinwwFB9rC9O7sKRt
         B6ZQ==
X-Gm-Message-State: AOAM532ErQn8vYBn32QJRhGlfUuzUBEhljD1KdVpgk4APWnBLQDqzIJl
        ciCQ0Z7NyTXxx87DLX/t58BFmzIJYic=
X-Google-Smtp-Source: ABdhPJwpSsm++s0Zuf+nkOJqYeeWPyr6Sm7eiS8p/5vaiD45aJ1mGeGKgmx+4o5e6uNxzOLn9xImKA==
X-Received: by 2002:ac8:478f:: with SMTP id k15mr12526417qtq.287.1595019204907;
        Fri, 17 Jul 2020 13:53:24 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id d14sm10576733qkl.9.2020.07.17.13.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 13:53:24 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/1] scale loop device lock
Date:   Fri, 17 Jul 2020 16:53:21 -0400
Message-Id: <20200717205322.127694-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In our environment we are using systemd portable containers in
squashfs formats, convert them into loop device, and mount.

NAME                      MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINT
loop5                       7:5    0  76.4M  0 loop
`-BaseImageM1908          252:3    0  76.4M  1 crypt /BaseImageM1908
loop6                       7:6    0    20K  0 loop
`-test_launchperf20       252:17   0   1.3M  1 crypt /app/test_launchperf20
loop7                       7:7    0    20K  0 loop
`-test_launchperf18       252:4    0   1.5M  1 crypt /app/test_launchperf18
loop8                       7:8    0     8K  0 loop
`-test_launchperf8        252:25   0    28K  1 crypt app/test_launchperf8
loop9                       7:9    0   376K  0 loop
`-test_launchperf14       252:29   0  45.7M  1 crypt /app/test_launchperf14
loop10                      7:10   0    16K  0 loop
`-test_launchperf4        252:11   0   968K  1 crypt app/test_launchperf4
loop11                      7:11   0   1.2M  0 loop
`-test_launchperf17       252:26   0 150.4M  1 crypt /app/test_launchperf17
loop12                      7:12   0    36K  0 loop
`-test_launchperf19       252:13   0   3.3M  1 crypt /app/test_launchperf19
loop13                      7:13   0     8K  0 loop
...

We have over 50 loop devices which are mounted  during boot.

We observed contentions around loop_ctl_mutex.

The sample contentions stacks:

Contention 1:
__blkdev_get()
   bdev->bd_disk->fops->open()
      lo_open()
         mutex_lock_killable(&loop_ctl_mutex); <- contention

Contention 2:
__blkdev_put()
   disk->fops->release()
      lo_release()
         mutex_lock(&loop_ctl_mutex); <- contention

With total time waiting for loop_ctl_mutex ~18.8s during boot (across 8
CPUs) on our machine (69 loop devices): 2.35s per CPU.

Scaling this lock eliminates this contention entirly, and improves the boot
performance by 2s on our machine.

Pavel Tatashin (1):
  loop: scale loop device by introducing per device lock

 drivers/block/loop.c | 86 ++++++++++++++++++++++++--------------------
 drivers/block/loop.h |  1 +
 2 files changed, 48 insertions(+), 39 deletions(-)

-- 
2.25.1

