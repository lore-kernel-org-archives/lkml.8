Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0122C433FC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77196221F3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U1CHUpPV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgGNGhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgGNGg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:36:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF02C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:36:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so6612993pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 23:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbfKQREcoHPRf158XU0NW9idW+wBMzJwoASt/jMG48E=;
        b=U1CHUpPVALPCRm2GeeE0rAYNmIhgWuHt4IhvISlOf8IAmDCGM8f5XPKotEJJmnprrJ
         Gf+fbSf4vE2f/VJLVuwGqMIv++0tp6II899RIQdLpsan1vymqNP6niU1LD03GxnJ5TsE
         CMEFdAGK8MuDYIFYbf0LhBWxS2pnjA/bJ/HxMzuvotRHKNwtAKE1qISErPzQUDmdPSTx
         yk8BmtwaDya8LgEl2cdyRkblidtvRQELBQhdpE6RbXQ1z1rbpWtTHpDwF1S2Rrkhu2Tv
         B5oXH0yaeb9zdpEUTZGUHnJS/GIUVIyDd6BdPJdXfQmk6ldTsrZ6CgMimeHojAdrS/k7
         /vVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CbfKQREcoHPRf158XU0NW9idW+wBMzJwoASt/jMG48E=;
        b=OsEBZVF6N30DZAIsCdKvxWCMoEaKrPs4jniJhboC1CbuuTyBwvcazRmjZVyosAuJDn
         xvwgOl3x/gGX2fkRIcFsplhTpnCGR43fnqXMIqj5Y7/TUqx6L4JtNsIS4O1299QQlEMA
         +5Jpq0Iatwaok6+6hPJVzJ0RH9fms/MPsXRC/boIJ5JlVlXbgaBW8LrA2fwkIXAwuJeX
         5HHNL7m63yKsDkbPBOXTF1IUZXxXuf+Ksd+9AmjTOCqvHVNmAqEaPNupl5qCW5UAXQf1
         C/zXkqzWLOv37fJTZUTZTGhdzEHD7p6lCcMYWcjHC/Nh6InyficQlBnSCoSt0MV51K9y
         oP7g==
X-Gm-Message-State: AOAM530t0KLC5RRlQ0jQPE7/NYs1Pir/usRI6qApTJdwPDC4CCnHD5n3
        MV6LFtJ8DK8y7BK68q1QImZD2g==
X-Google-Smtp-Source: ABdhPJzPSDpx104AHJyC0SptSEf+RNXyoMEuzRH/VkY9e6+TY68j6A7Xsn7ZLbnkTPDWTQb4XUyvQQ==
X-Received: by 2002:a17:902:e9d2:: with SMTP id 18mr2739643plk.40.1594708619207;
        Mon, 13 Jul 2020 23:36:59 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id y17sm16080185pfe.30.2020.07.13.23.36.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2020 23:36:57 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Javi Merino <javi.merino@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Quentin Perret <qperret@google.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/2] cpufreq_cooling: Get effective CPU utilization from scheduler
Date:   Tue, 14 Jul 2020 12:06:51 +0530
Message-Id: <cover.1594707424.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Schedutil and fair.c use schedutil_cpu_util() currently to get an idea
of how busy a CPU is. Do the same for cpufreq_cooling which uses CPU's
idle time currently to get load, which is used to calculate the current
power consumption of the CPUs.

Tested with hackbench and sysbench on Hikey (octa-core SMP) and no
regression was observed.

--
Viresh

Viresh Kumar (2):
  sched/core: Rename and move schedutil_cpu_util to core.c
  thermal: cpufreq_cooling: Reuse effective_cpu_util()

 drivers/thermal/cpufreq_cooling.c |  65 +++++-------------
 kernel/sched/core.c               | 106 +++++++++++++++++++++++++++++
 kernel/sched/cpufreq_schedutil.c  | 108 +-----------------------------
 kernel/sched/fair.c               |   6 +-
 kernel/sched/sched.h              |  20 ++----
 5 files changed, 130 insertions(+), 175 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

