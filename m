Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F0EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E35E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BBxgUldU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgFOQz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729628AbgFOQz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:55:58 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD58C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:55:58 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id y2so13536682qvp.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xbDm2rIeE4s6AcLj4uHfUqAXvLAtlmUfof9kDGDNf38=;
        b=BBxgUldUHKuA2KJSpz9pj8p/Z+mffn8sj+QDHWbHacoBsLGhSYybHKP/D/agragbF8
         t0vIGiE87Z/7/gsMDFaKs+dvf2nU5UQadkPgIrqXr7MdWoeLYPk9WLLqsOku1xmUO5f5
         9e2hb/bCQUmxAQ5RYnNb+YVYW45yO0wopsfEER5dDMtJ6wpvMp1SCS9QYZGQPHhUUGGo
         ZknFtQEhPJw2E5NR/21uHblPdZNsoZSlI0gdYF5tCt1fsubY2Urk4xXEundiYAenL3Ja
         224gYb6WeLgu9ln5gFQ/O9D9XPbkZtUoAJ/Dk90kE9xXRjjXD0uo0TP/bTxzZF2SYvlB
         27Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xbDm2rIeE4s6AcLj4uHfUqAXvLAtlmUfof9kDGDNf38=;
        b=sxWC/U6wAg5kEUOx0Pyem31xAzEKLazNL56RRgo5ygHHKAegSyhlWNH70Ta2zlgI86
         +E4bR0qDmdMRUEC7lb1au56JcfHkfU6p8xD2WHQo7mQIJhm7TcI2IIf2pTwlyaJA08eF
         /8foAQewi7/Qhise7qvMJJ9bmWLKhqBCHvpPjPGux7o4aO293isdHt2kWKWGnAK6yCBE
         udfSvLF8tn6I9w9JSPd45IsOqWsKQuX8Q3/bmGm4kvfcGdPTR8f7WUQlaUgioHg6cUyK
         y4qbXqLLThIJBpsFLZWUNS+Vg30qKAYPgTGkOPCXQoSJa2BJBMuicUFixapKTL6pCgH8
         8vpg==
X-Gm-Message-State: AOAM5323BK8lLyfeTpxGW9vXKhZwdVSjcwRL8C/9A00ri+319UoO3zGg
        pBcKHy+zcKuUT3WGN4pzWNUDKb7iAn8+
X-Google-Smtp-Source: ABdhPJyFXynzAao5s3Yi9KETHCllT8sCdWRGLd1bF9N/edNipexLvxfnpuJsltcL7ifNDIp1A6az2cGf2C0f
X-Received: by 2002:a0c:f494:: with SMTP id i20mr25770627qvm.179.1592240157096;
 Mon, 15 Jun 2020 09:55:57 -0700 (PDT)
Date:   Mon, 15 Jun 2020 17:55:52 +0100
Message-Id: <20200615165554.228063-1-qperret@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 0/2] cpufreq: Specify the default governor on command line
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

Feedback is very much welcome :-)

Thanks,
Quentin

Quentin Perret (2):
  cpufreq: Register governors at core_initcall
  cpufreq: Specify default governor on command line

 .../admin-guide/kernel-parameters.txt         |  5 +++
 Documentation/admin-guide/pm/cpufreq.rst      |  6 ++--
 .../platforms/cell/cpufreq_spudemand.c        | 26 ++------------
 drivers/cpufreq/cpufreq.c                     | 34 ++++++++++++++++---
 drivers/cpufreq/cpufreq_conservative.c        | 22 +++---------
 drivers/cpufreq/cpufreq_ondemand.c            | 24 ++++---------
 drivers/cpufreq/cpufreq_performance.c         | 14 ++------
 drivers/cpufreq/cpufreq_powersave.c           | 18 ++--------
 drivers/cpufreq/cpufreq_userspace.c           | 18 ++--------
 include/linux/cpufreq.h                       | 14 ++++++++
 kernel/sched/cpufreq_schedutil.c              |  6 +---
 11 files changed, 73 insertions(+), 114 deletions(-)

-- 
2.27.0.290.gba653c62da-goog

