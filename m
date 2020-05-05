Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EB7C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E46320735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RXHFNjbE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgEENz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgEENz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:55:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A28C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:55:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so858616plr.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DYoV4g+eBtUMQiWGeiHqcByOOgkJemjo7RNmxRSrxEU=;
        b=RXHFNjbEfNN2/RlW1Hul1jwbxxG2m59QspzJlL0uZadHZCe7vTBfRFMqgL28fkluis
         4HNC/CsUdbtnzQfr5FTpjcvJJ+rv6WYK+lUGRIUeT4nf/6K+hIExT9LqIIroo8ZJLwvO
         ARnvblBicwU+0VfADtPkEF9RwlVm0Jq5qVa0aHKGs5JZrsrUaRACs3+CJ6ea/BDtrVIP
         cjG9rmEYTcUQjM0Ui/CCl/pEuFG6l7xDSTpcKDTBfjirK6OVzKS+lvrqiCt8Rzw0HiNA
         rgVmx6HMgEHnu7e9qRFlgI+zJqT49/usJD/ZKlIMA2YF99X/Yz3KVltk9MBNnTtZPPos
         5GOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DYoV4g+eBtUMQiWGeiHqcByOOgkJemjo7RNmxRSrxEU=;
        b=ph7F1cUM2o3SbtAi/RbNodJm9rije+XctrTcipWLpUwPMzZ2ToYuAP8ll4zJ0GdO59
         66Bib8xps1AET7WvABSW3UGkhbvxSqB1tTz2NJrSn8Qe3cvXhobS/mc5ITqjPTvwVZYd
         HlZhAAxxGU865pBuGThCkMaG7DaiCJCT+JPDJKfdO+3JCw749j3BDhBxQk8lyZI1kGZ4
         klFrOL6BD/nX1nENcm6CbUx22HSvTMJ3iseb3ePIYGAfAXq5CRNtzGKfXs7gXn5kR5EV
         IcLppUjhpkt+2n/2IbPU2ZlBehMsVXUzaTvdr1HCkpFpjqm0lTpI7Pql0PSrDoho6HJg
         tYjg==
X-Gm-Message-State: AGi0PuY5xeoXxVI5L45frWhn5DKgYCOSLjr2rkCObq3vypZlJWS08ueY
        qCulBcw32JH86McZYlwhZnnThw==
X-Google-Smtp-Source: APiQypK8A+s0fLvlIkTj9fiCvSROntMoJtckKK/YWvVvyq1ctUdfysHnkou/Uk3gNoYgVsDCI5hF2g==
X-Received: by 2002:a17:902:a706:: with SMTP id w6mr2987753plq.173.1588686958545;
        Tue, 05 May 2020 06:55:58 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id ie17sm2136120pjb.19.2020.05.05.06.55.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 May 2020 06:55:58 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/3] arm64: perf_event: Fix time offset prior to epoch
Date:   Tue,  5 May 2020 21:55:41 +0800
Message-Id: <20200505135544.6003-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to fix time offset prior to epoch for Arm arch timer.
This series is mainly following on suggestions on LKML [1].

To acheive the accurate time offset for a clock source prior to epoch,
patch 01 adds a new variant sched_clock_register_epoch() which allows to
output an extra argument for time offset prior to sched clock's
registration.

Patch 02 is to add handling for time offset in Arm arch timer driver, As
Will Deacon suggested to "disable the perf userpage if sched_clock
changes clocksource too" [2], after thinking about this suggestion, the
race condition doesn't exist between sched_clock's registration and perf
userpage.  The reason is sched_clock's registration is finished in
system's initialisation phase and at this point it has no chance to use
any userpage by Perf tool.  For this reason let's keep the code simple
and don't acquire all Perf events' seqlock during sched_clock's
registration.

Patch 03 is simply to pass time offset from arch timer driver
(clocksource driver) to perf event.

[1] https://lkml.org/lkml/2020/3/20/199
[2] https://lkml.org/lkml/2020/5/1/906

Changes from v1:
- Added patch 01 to retrieve more accurate offset when sched clock
  registration;
- Added patch 02 to handle time offset in arch timer driver.

Leo Yan (3):
  time/sched_clock: Add new variant sched_clock_register_epoch()
  clocksource/drivers/arm_arch_timer: Handle time offset prior to epoch
  arm64: perf_event: Fix time_offset for arch timer

 arch/arm64/kernel/perf_event.c       |  8 ++++++--
 drivers/clocksource/arm_arch_timer.c | 10 +++++++++-
 include/clocksource/arm_arch_timer.h |  6 ++++++
 include/linux/sched_clock.h          | 10 ++++++++++
 kernel/time/sched_clock.c            | 13 ++++++++++++-
 5 files changed, 43 insertions(+), 4 deletions(-)

-- 
2.17.1

