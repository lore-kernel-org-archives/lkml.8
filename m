Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4507DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DA820671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="0w4nQel5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgENJ0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725925AbgENJ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:26:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C3BC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:26:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w10so2762908ljo.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 02:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/tJIRKNQneeHlQjEaZHszK2k+iclO+jR+dvoNvPPVag=;
        b=0w4nQel5wYmmZuOCNC96sAPuFmQwbr0ilMU5hH0f2m5RwAJDAf0vWJaJjGpDd4Xye/
         5sgD0Jrp7stAugAy5kTH/BFKJOhiJUZ/f65X13cYFZM31Z5sQMkmeX8wtZvzYu0vDeIf
         d/x+KrDtoLAArPmF5sFwM7+C4vhIGtai0LXmnrJpZ/kv27w6zkQgIhNYcHTnNe6/12lY
         sV5Vhad3rEy4OI919WVv+fZlccGcCLA0igXtdSXXa4ehV2f8CR6NgCY0MZDJLQp//i7n
         sA81o26C1WgsQyNpR3eDgkMibS1XJK/0c/r77nF6p5r5s/dYJ4KfUkCvvqpJEwdPHcdG
         hGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/tJIRKNQneeHlQjEaZHszK2k+iclO+jR+dvoNvPPVag=;
        b=DUW71razvC6Mii2E27P85vWa6HLhgtYTGtLdLYnCDrcweRfKruavxnd68shdYnNaBV
         JZQMDEg9HEnXTdTkukY9AVA3YTi0VG4fMel9cLNyeVQp3+HjcvTryIbIx9Tk9qzDfmc6
         IlQbdJPmlL0IN5/5HYwLSGKASveioG8OVTxFQr9tK+YTTYOESufKATyEsGRH2AKmYVt1
         DG0o1mepZXBDxiCXa37yB9qTYxxef2g3/rfFRx2ORSPZzobfGDGGpRSKmA+Gi0imIVxP
         U8DOm+TSEBGtKK7SUWs0JDDjHe/seBLdmG6I/oneuvJSOegU4Dci0BfN1kAhEBeQafkl
         SCCA==
X-Gm-Message-State: AOAM530fMCd2tmlyM5onZqWHaHNk1Yj999s+XS3gAL/dWmGjHcSKsh7R
        sm3OQVCaiDMB1n7lFEPt39y6vQ==
X-Google-Smtp-Source: ABdhPJypxqTmuwxppOif/Z3CQU8dOmf27s2EyHuP2mHtcLneEg9vxjP+VMreICRF8ePrT6CXo0k70w==
X-Received: by 2002:a2e:731a:: with SMTP id o26mr2227667ljc.189.1589448406062;
        Thu, 14 May 2020 02:26:46 -0700 (PDT)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.googlemail.com with ESMTPSA id e25sm1426117lfb.89.2020.05.14.02.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 02:26:45 -0700 (PDT)
From:   john mathew <john.mathew@unikie.com>
X-Google-Original-From: john mathew <John.Mathew@unikie.com>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, tsbogend@alpha.franken.de,
        lukas.bulwahn@gmail.com, x86@kernel.org,
        linux-mips@vger.kernel.org, tglx@linutronix.de,
        mostafa.chamanara@gmail.com, willy@infradead.org,
        valentin.schneider@arm.com, rdunlap@infradead.org,
        john mathew <John.Mathew@unikie.com>
Subject: [RFC PATCH v5 0/3] Add scheduler overview documentation
Date:   Thu, 14 May 2020 12:26:34 +0300
Message-Id: <20200514092637.15684-1-John.Mathew@unikie.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series updates the scheduler documentation to add more topics
wrt to scheduler overview. New sections are added to provide a brief
overview of the kernel structs used by the scheduler, scheduler invocation,
context switch and Capacity Aware Scheduling. Previous version of
the patch was reviewed at:
Link: https://lore.kernel.org/lkml/20200513134338.19688-2-John.Mathew@unikie.com/

version 5:
 -Fix description error on CAS

version 4:
 -Added section on Capacity-Aware Scheduling
 -Reworded CFS recently added features.
 -Removed vruntime description from scheduler structs
 -Added description of idle and stopper sched classses

version 3:
 -Fix spelling, spacing and typo errors.

version 2:
- Remove :c:func: directive as it was redundant
- Limit document width (line symbol count) to 75
- Replace dot file with ASCII art
- Describe prepare_task_switch(), ASID use, 
  kernel/user transtion, MIPS FPU affinity correctly
- Add missing references to files
- Removed internal APIs from scheduler API reference
- Described rq struct member as kernel-doc comments
- Replaced CFS history with CFS current status
- Added documentation for sched_class fields
- Refined explanation of context swtich functionality
- Replace CFS history with recent changes
- Added kernel-doc comments for struct rq

John Mathew (3):
  docs: scheduler: Restructure scheduler documentation.
  docs: scheduler: Add scheduler overview documentation
  docs: scheduler: Add introduction to scheduler context-switch

 Documentation/scheduler/arch-specific.rst     |  14 +
 Documentation/scheduler/cfs-overview.rst      | 102 ++++++
 Documentation/scheduler/context-switching.rst | 125 ++++++++
 Documentation/scheduler/index.rst             |  33 +-
 .../scheduler/mips-context-switch.rst         |  89 ++++++
 Documentation/scheduler/overview.rst          | 293 ++++++++++++++++++
 Documentation/scheduler/sched-cas.rst         |  92 ++++++
 .../scheduler/sched-data-structs.rst          | 182 +++++++++++
 Documentation/scheduler/sched-debugging.rst   |  14 +
 Documentation/scheduler/sched-features.rst    |  21 ++
 Documentation/scheduler/scheduler-api.rst     |  31 ++
 .../scheduler/x86-context-switch.rst          |  65 ++++
 kernel/sched/core.c                           |  28 +-
 kernel/sched/sched.h                          | 169 +++++++++-
 14 files changed, 1238 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/scheduler/arch-specific.rst
 create mode 100644 Documentation/scheduler/cfs-overview.rst
 create mode 100644 Documentation/scheduler/context-switching.rst
 create mode 100644 Documentation/scheduler/mips-context-switch.rst
 create mode 100644 Documentation/scheduler/overview.rst
 create mode 100644 Documentation/scheduler/sched-cas.rst
 create mode 100644 Documentation/scheduler/sched-data-structs.rst
 create mode 100644 Documentation/scheduler/sched-debugging.rst
 create mode 100644 Documentation/scheduler/sched-features.rst
 create mode 100644 Documentation/scheduler/scheduler-api.rst
 create mode 100644 Documentation/scheduler/x86-context-switch.rst

-- 
2.17.1

