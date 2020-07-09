Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70771C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E6E520774
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wzb2c1z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGIKOK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbgGIKOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:14:05 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA37C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:14:05 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so904305pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7zJbzd7I0qjlOh1AsM0WBkxDNAEKcLGWWurw0dHxg8=;
        b=Wzb2c1z1qzrLVrgXLiLFowpIvwPzkNoY4wUDZk5bFzC9C5jZRUCZDoI7DhRVwdiKf4
         Yh/4b/7hKzqRD0HIFBH7U3BHCfn/mDEBDoOwwQwB9lhE51yBS8ZkU0oZZiTQqxdG2Wjf
         j9K+S5yx/XfkxgeFUN4B+hR0NfZQsulQwgIkiGV9v9Shdnj/NKMJeBiTJkUPN704jXi2
         vUOSGlD75ObH5TpHEeD6mSrWh4Nb2M5MtgVr0hY/Gk6Va/ksCgW1Sz1bZyl6TLqxDZVh
         pDrMu1EKxma+h4gUhileiX4EH8frlCZkgB9N6GhCFZfY8NaWFTsPV0ePgQX6bxCqc9Lp
         yqpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7zJbzd7I0qjlOh1AsM0WBkxDNAEKcLGWWurw0dHxg8=;
        b=atVZe50aVSkAjYuUeZVqwZPdkFMz4HPDvVoqFWZTSU1oKT1nL4NMXUvAKtGq3k4h6Q
         udF8ZJlQGMV+O7GkYlsOMFjkAY5/ZWDYNDfUxZifvSQ+NcjHjR14A+69YxV/xcv92O6z
         VkAA39ptqtk5NbNdbS1Rtc1soa+5ozgRskDEcLTJgkvMGcCYH64kyKkkmu6nC7p6ccfN
         +NfzwHr6SiPu0+Oq9pw+v7NRXXyHDNX72w6mXOkypMlZ/sOEi0V+vQx2gNxeS0F+5NkC
         gH7g6BJtBg4tPH2lnoF6GzJyvj5ma7Pbt12yI4Bx0fHymgVu9NTCCzFUxqBcwv5URJ3/
         uA1g==
X-Gm-Message-State: AOAM531q8LlyfaasiS4N68rxmuNEXN8J73YrZzddNXCgIW/0ayA2GP25
        tmT8o9PF1PVgEr17VrHmToBoug==
X-Google-Smtp-Source: ABdhPJx+nWnxi594yoD2CfrDxx754RW3BBZ0Apz2JK7s/LWAodsbqVutddC1PmDdT2gAarFJeCbD6Q==
X-Received: by 2002:a17:90a:84:: with SMTP id a4mr9758381pja.110.1594289643321;
        Thu, 09 Jul 2020 03:14:03 -0700 (PDT)
Received: from localhost ([122.172.40.201])
        by smtp.gmail.com with ESMTPSA id fh12sm2026352pjb.5.2020.07.09.03.14.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2020 03:14:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ben Segall <bsegall@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Peter Puhov <peter.puhov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [RFC 0/3] cpufreq: cppc: Add support for frequency invariance
Date:   Thu,  9 Jul 2020 15:43:32 +0530
Message-Id: <cover.1594289009.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

CPPC cpufreq driver is used for ARM servers and this patch series tries
to provide frequency invariance support for them. The same is also
provided using a specific hardware extension, known as AMU (Activity
Monitors Unit), but that is optional for platforms and at least few of
them don't have it.

This patchset allows multiple parts of the kernel to provide the same
functionality, by registering with the topology core.

This is tested with some hacks, as I didn't have access to the right
hardware, on the ARM64 hikey board to check the overall functionality
and that works fine.

Ionela/Peter Puhov, it would be nice if you guys can give this a shot.

This is based of my cpufreq/arm/linux-next branch (should work on
linux-next too) + a cleanup patch [1] that i sent this morning.

--
viresh

[1] https://lore.kernel.org/lkml/a710fc4e4e0f1d2e561320130b99bcb5167d73b4.1594277563.git.viresh.kumar@linaro.org/

Viresh Kumar (3):
  arm64: topology: Add amu_counters_supported() helper
  topology: Provide generic implementation of
    arch_freq_counters_available()
  cpufreq: cppc: Add support for frequency invariance

 arch/arm64/include/asm/topology.h |   7 --
 arch/arm64/kernel/topology.c      | 165 +++++++++++++++---------------
 drivers/base/arch_topology.c      |  43 +++++++-
 drivers/cpufreq/cppc_cpufreq.c    | 138 ++++++++++++++++++++++++-
 include/linux/arch_topology.h     |   5 +-
 kernel/sched/core.c               |   1 +
 6 files changed, 263 insertions(+), 96 deletions(-)

-- 
2.25.0.rc1.19.g042ed3e048af

