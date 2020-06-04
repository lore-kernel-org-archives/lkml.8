Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52505C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ED77208A7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EtRF99ZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgFDRRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729999AbgFDRRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:17:50 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F65C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:17:50 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id e125so4097491lfd.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TGj9a9TUKfy7t4uQkBrlCQFOK2AZWtuEUI6gC8S8EE4=;
        b=EtRF99ZLTpO9+9wIofReF0QI8Pav+aXc4nhoe1/jhwqqEfGKSOxlMZprc0qNvSiap5
         PP7fibUw1C4IVLn77mG36xirbdd8o7/87P0P4G2HUXUi4LWrBCPCrHRx+KwKfKpwJQlw
         PzFOBu05rNbepO+TmuajTTI5gwJppEzRRGuy6mW0pmSKOLvVetQwd56sSlxf0jNXhXZ7
         LpSvZEwMU5RABQTfWEWGUfmS06dyYLbE+ZpO2CrNZJU/6BbJs4YG+2bOyd8si5PU7fWa
         5PLExYCVAu6LXGxtn277I5fXBuk3HbAJIvv8j7EJEtVVje5qykJU0tRjDRJ8AA5RRTXF
         te7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TGj9a9TUKfy7t4uQkBrlCQFOK2AZWtuEUI6gC8S8EE4=;
        b=AI3pDE0lr7Aj5CfXGFLMOfviL6Y8F+94hrPeuIU5RdMG9Ak+y7KMa74743WvVMCsvP
         J2V3gdwyPXjKtJOYR0IVYU6fPRLRlOaiSB2M/xHw2FtejwK70iwdeJwakq2MgOOGHoxq
         nr0m9tGlgT++xtm55n5hb+DT1FlUBeRZWmcer1vRiDUfdvDMGeb3py/41CT6sASkeoGf
         akkrMl2ZUHHt8EH8BDVSznYfwU+HC/LpX6dMACadNUnPW2XLH3+b671oDUUcNfHMO9gs
         K/CLVQG/zUFedha1EqykptOGiJQPirf9lNqZ4CU4h6Ve3tLRFRu5gh+y0QUNjVc8+EV2
         weRw==
X-Gm-Message-State: AOAM533WLfOTwnR+dqpO16Pm5Wwl0JKJmck/SCr3w04mN9oClV6mIKU2
        NQOkOPFt5Isd4RMTCbs/jnQcwvzfXW3gQXrV4ZtpMCaPIJJXsw==
X-Google-Smtp-Source: ABdhPJx2fVqgmxqQSn7zNeoD7sYRjfqs/7aDGMxuyc/KYvJjxtXDv+GG9/3tZKvUdlueTEd5FWMvp5H6jmyMwvlqsi0=
X-Received: by 2002:a19:8453:: with SMTP id g80mr3085619lfd.167.1591291068584;
 Thu, 04 Jun 2020 10:17:48 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 4 Jun 2020 22:47:36 +0530
Message-ID: <CA+G9fYuGwcE3zyMFQPpfA0CyW=4WOg9V=kCfKhS7b8930jQofA@mail.gmail.com>
Subject: LTP: syscalls: regression on mainline - ioctl_loop01 mknod07 setns01
To:     LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        inux-block@vger.kernel.org
Cc:     chrubis <chrubis@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        maco@android.com, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>,
        Jan Stancek <jstancek@redhat.com>,
        Yang Xu <xuyang2018.jy@cn.fujitsu.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        Richard Palethorpe <rpalethorpe@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following three test cases reported as regression on Linux mainline kernel
on x86_64, arm64, arm and i386

  ltp-syscalls-tests:
    * ioctl_loop01
    * mknod07
    * setns01

git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git branch: master
GOOD:
  git commit: b23c4771ff62de8ca9b5e4a2d64491b2fb6f8f69
  git describe: v5.7-1230-gb23c4771ff62
BAD:
  git commit: 1ee08de1e234d95b5b4f866878b72fceb5372904
  git describe: v5.7-3523-g1ee08de1e234

kernel-config: https://builds.tuxbuild.com/U3bU0dMA62OVHb4DvZIVuw/kernel.config

We are investigating these failures.

tst_test.c:906: CONF: btrfs driver not available
tst_test.c:1246: INFO: Timeout per run is 0h 15m 00s
tst_device.c:88: INFO: Found free device 1 '/dev/loop1'
ioctl_loop01.c:49: PASS: /sys/block/loop1/loop/partscan = 0
[ 1073.639677] loop_set_status: loop1 () has still dirty pages (nrpages=1)
ioctl_loop01.c:50: PASS: /sys/block/loop1/loop/autoclear = 0
ioctl_loop01.c:51: PASS: /sys/block/loop1/loop/backing_file =
'/scratch/ltp-mnIdulzriQ/9cPtLQ/test.img'
ioctl_loop01.c:63: FAIL: expect 12 but got 17
ioctl_loop01.c:67: FAIL: /sys/block/loop1/loop/partscan != 1 got 0
ioctl_loop01.c:68: FAIL: /sys/block/loop1/loop/autoclear != 1 got 0
ioctl_loop01.c:79: FAIL: access /dev/loop1p1 fails
[ 1073.679678] loop_set_status: loop1 () has still dirty pages (nrpages=1)
ioctl_loop01.c:85: FAIL: access /sys/block/loop1/loop1p1 fails

HINT: You _MAY_ be missing kernel fixes, see:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=10c70d95c0f2

mke2fs 1.43.8 (1-Jan-2018)
[ 1264.711379] EXT4-fs (loop0): mounting ext2 file system using the
ext4 subsystem
[ 1264.716642] EXT4-fs (loop0): mounted filesystem without journal. Opts: (null)
mknod07     0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
mknod07     0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
mknod07     1  TPASS  :  mknod failed as expected:
TEST_ERRNO=EACCES(13): Permission denied
mknod07     2  TPASS  :  mknod failed as expected:
TEST_ERRNO=EACCES(13): Permission denied
mknod07     3  TFAIL  :  mknod07.c:155: mknod succeeded unexpectedly
mknod07     4  TPASS  :  mknod failed as expected:
TEST_ERRNO=EPERM(1): Operation not permitted
mknod07     5  TPASS  :  mknod failed as expected:
TEST_ERRNO=EROFS(30): Read-only file system
mknod07     6  TPASS  :  mknod failed as expected:
TEST_ERRNO=ELOOP(40): Too many levels of symbolic links


setns01     0  TINFO  :  ns_name=ipc, ns_fds[0]=6, ns_types[0]=0x8000000
setns01     0  TINFO  :  ns_name=mnt, ns_fds[1]=7, ns_types[1]=0x20000
setns01     0  TINFO  :  ns_name=net, ns_fds[2]=8, ns_types[2]=0x40000000
setns01     0  TINFO  :  ns_name=pid, ns_fds[3]=9, ns_types[3]=0x20000000
setns01     0  TINFO  :  ns_name=uts, ns_fds[4]=10, ns_types[4]=0x4000000
setns01     0  TINFO  :  setns(-1, 0x8000000)
setns01     1  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(-1, 0x20000)
setns01     2  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(-1, 0x40000000)
setns01     3  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(-1, 0x20000000)
setns01     4  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(-1, 0x4000000)
setns01     5  TPASS  :  invalid fd exp_errno=9
setns01     0  TINFO  :  setns(11, 0x8000000)
setns01     6  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
errno=EBADF(9): Bad file descriptor
setns01     0  TINFO  :  setns(11, 0x20000)
setns01     7  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
errno=EBADF(9): Bad file descriptor
setns01     0  TINFO  :  setns(11, 0x40000000)
setns01     8  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
errno=EBADF(9): Bad file descriptor
setns01     0  TINFO  :  setns(11, 0x20000000)
setns01     9  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
errno=EBADF(9): Bad file descriptor
setns01     0  TINFO  :  setns(11, 0x4000000)
setns01    10  TFAIL  :  setns01.c:176: regular file fd exp_errno=22:
errno=EBADF(9): Bad file descriptor

Full test log link,
https://lkft.validation.linaro.org/scheduler/job/1467931#L8047

test results comparison shows this test case started failing from June-2-2020
https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/ioctl_loop01/history/

https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/setns01/history/

https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.7-4092-g38696e33e2bd/testrun/2779586/suite/ltp-syscalls-tests/test/mknod07/history/


-- 
Linaro LKFT
https://lkft.linaro.org
