Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF0C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5A29206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 21:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="RHS9s6Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgGWVRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 17:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgGWVRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 17:17:51 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22844C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 14:17:51 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id g26so6850322qka.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 14:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCWUi446PADsQ51jtIS8KSzkmHB79NmlflmTv1tu7K8=;
        b=RHS9s6Pnghb5h2/OhXZfIfYtnabBm8/+rsX6DRGtkA2SZOxaw0E77/jsxgoZe+Z1l0
         QrbKhV9UxNJAeKNuoe0BNm0XAXzbqWqoRgw12a4CWgXuaRN2aWcWxlO+yjZiEfw1y641
         AX1CAgtzywyYJTmfgdi8DBm+ybo/2vnWEkedHkV1tkrZ5lPbHiztaDZQzDU/56m1k06u
         OlxSwRN34EKJUH0XPcpbe0R6YWFxGA34fw7T13TD3ybT3UVvLdvmkPuK3/h3LkyNGyV9
         zCkhkKp+cDSA7UUGUFsU441kjy6StmzMkZJAsEW57Bp+EQTqmuDWpUK4rlVMcCETSdkv
         Ioug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OCWUi446PADsQ51jtIS8KSzkmHB79NmlflmTv1tu7K8=;
        b=Vf24dzp+ph0npuqbbNui1T8xKPtFeSPkBa1hYY0az70icmF6AsqccPJJ2kbOYXO8c5
         V5MGGP5dJ1gaFo0ESq7esDELNJAUHGyTLUHVqcU6GsLRMOEcxuaucMHVHTWdh+/pbRRV
         joK5eUbPWroIOlvRxO4MO6gpYW5Ev74jTjUgSXtgZQ+HRSo1s+kiaURRUCkzQsyH46Ey
         ADZux2bK8bcGyuLpoRaxMIMjCHkbeayaccow0W6oyCoc9gkpmt0U72qrlSsMbdc7bmCp
         tBtWkF51VSmO7IxbpTzMZh+V9xuzEPGg+u3wy3YMW4HNkfbztACUTIneFMSHUHZPZna7
         7dFg==
X-Gm-Message-State: AOAM5327i48wBLZYAaCrhUjkLRWWOCSqvP+No3bv2dKBwAM61kpBkE5+
        Ddi0qX7QJz6H9vJ3PbA/7/bdjQ==
X-Google-Smtp-Source: ABdhPJxJLATFfYC0yS6OTkbk2LGV4z78IaPuU4W6ogqlUbvHlxQumspQYlLie6V6M/CBE5hIGua6IQ==
X-Received: by 2002:ae9:e30a:: with SMTP id v10mr7722339qkf.167.1595539070154;
        Thu, 23 Jul 2020 14:17:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id c7sm4165918qta.95.2020.07.23.14.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 14:17:49 -0700 (PDT)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, tyhicks@linux.microsoft.com,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] scale loop device lock
Date:   Thu, 23 Jul 2020 17:17:47 -0400
Message-Id: <20200723211748.13139-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
v2: Addressed Tyler Hicks comments
	- added mutex_destroy()
	- comment in lo_open()
	- added lock around lo_disk in 


===

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

Scaling this lock eliminates this contention entirely, and improves the boot
performance by 2s on our machine.

Pavel Tatashin (1):
  loop: scale loop device by introducing per device lock

 drivers/block/loop.c | 99 ++++++++++++++++++++++++++------------------
 drivers/block/loop.h |  1 +
 2 files changed, 59 insertions(+), 41 deletions(-)

-- 
2.25.1

