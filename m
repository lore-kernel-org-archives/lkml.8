Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1CBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0942020716
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 14:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V94+StGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732801AbgFWOVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732769AbgFWOVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 10:21:41 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EC3C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:21:40 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id x6so13756623qtq.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 07:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=u1DDKlY4raUnYKBkmaNYPdbNtcYQKCadD73iqEHJ/Ig=;
        b=V94+StGWnc22eutcWvOiDbMPO3aIFCF/x/97/cKQYwcL/WynS+RlBLbo/0jwE0o2VA
         nvcw+BSjvTbunQrZHWvIddiZGzLt+QE7fYwP2NJT85uIfNyhClMJ0GenQppRmjarze6z
         2hnxUwvjgKD1htigvr+jaLAzk5YWbRZazVdI5VsbCUZcBW5zbKBLmcIYmXECYtvgsdFh
         TeOvh+Mk+8ghcMYmeyMi+EaoYPyYRwGQ6dgf4tTU5PfGW12EanP3QAbZCAItTuSvaN1/
         Pl5gtcWsGbr8nibe1a6JsDp9rUVV3xzkqErQBK1KEXyWT79IpUnkrtRyqmMJM8VDJumM
         FZ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=u1DDKlY4raUnYKBkmaNYPdbNtcYQKCadD73iqEHJ/Ig=;
        b=kLikGAR8/LNNaOA+Q+tRLTp7wSvQPePWlSaCGDGw6keuw3JqMhMYjHgAD8E/hKNWxb
         2cWYq85mk5n3jwlE54adFvRE2Cc5Z/8FHiu0x3SXJnjQMpxYyXgXBUN0vdhfWXhrkVyk
         60AX909Xo55hcq2JzPMUOCh1MruyueBORWhnNApf1tgCY8vrIKcI/i7B6+x11wFRFEig
         Ucvl3yJdFhVI2XeBwegIH91HdS0VUkNhgS/Xs2NVbPIhVCn/KfWJRw6JNkDPGH7xtCQV
         LJL2n+ovkNNxqm+WI06us1aOSqFe5BF/zFFx2+l3fQeq1Btdm0sEyzWmojAwxA5g7NUT
         b5lw==
X-Gm-Message-State: AOAM530S2SYjvNUF7JHI5GBNIpNfMl0Jl9/EP90pzvkb6PC2qUx8ViYO
        FcDJbIt7vIXqXD/fF7mSE+7ZyNmrp0vp
X-Google-Smtp-Source: ABdhPJw/yysC+TJ6IjitCFw5yaXajcA+uMBI+rTC2wq1jjbjHR0l6X9AqIpGAMm6egmgBJibg/HvOHK7IZay
X-Received: by 2002:ad4:56ac:: with SMTP id bd12mr26923271qvb.139.1592922099906;
 Tue, 23 Jun 2020 07:21:39 -0700 (PDT)
Date:   Tue, 23 Jun 2020 15:21:36 +0100
Message-Id: <20200623142138.209513-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH v2 0/2] cpufreq: Specify the default governor on command line
From:   Quentin Perret <qperret@google.com>
To:     rjw@rjwysocki.net, rafael@kernel.org, viresh.kumar@linaro.org
Cc:     arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        qperret@google.com, tkjos@google.com, adharmap@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series enables users of prebuilt kernels (e.g. distro kernels) to
specify their CPUfreq governor of choice using the kernel command line,
instead of having to wait for the system to fully boot to userspace to
switch using the sysfs interface. This is helpful for 2 reasons:
  1. users get to choose the governor that runs during the actual boot;
  2. it simplifies the userspace boot procedure a bit (one less thing to
     worry about).

To enable this, the first patch moves all governor init calls to
core_initcall, to make sure they are registered by the time the drivers
probe. This should be relatively low impact as registering a governor
is a simple procedure (it gets added to a llist), and all governors
already load at core_initcall anyway when they're set as the default
in Kconfig. This also allows to clean-up the governors' init/exit code,
and reduces boilerplate.

The second patch introduces the new command line parameter, inspired by
its cpuidle counterpart. More details can be found in the respective
patch headers.

Changes in v2:
 - added Viresh's ack to patch 01
 - moved the assignment of 'default_governor' in patch 02 to the governor
   registration path instead of the driver registration (Viresh)

Thanks,
Quentin

Quentin Perret (2):
  cpufreq: Register governors at core_initcall
  cpufreq: Specify default governor on command line

 .../admin-guide/kernel-parameters.txt         |  5 ++++
 Documentation/admin-guide/pm/cpufreq.rst      |  6 ++---
 .../platforms/cell/cpufreq_spudemand.c        | 26 ++-----------------
 drivers/cpufreq/cpufreq.c                     | 23 ++++++++++++----
 drivers/cpufreq/cpufreq_conservative.c        | 22 ++++------------
 drivers/cpufreq/cpufreq_ondemand.c            | 24 +++++------------
 drivers/cpufreq/cpufreq_performance.c         | 14 ++--------
 drivers/cpufreq/cpufreq_powersave.c           | 18 +++----------
 drivers/cpufreq/cpufreq_userspace.c           | 18 +++----------
 include/linux/cpufreq.h                       | 14 ++++++++++
 kernel/sched/cpufreq_schedutil.c              |  6 +----
 11 files changed, 62 insertions(+), 114 deletions(-)

-- 
2.27.0.111.gc72c7da667-goog

