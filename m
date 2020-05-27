Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88446C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 640B420787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=unikie-com.20150623.gappssmtp.com header.i=@unikie-com.20150623.gappssmtp.com header.b="olBkgcZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbgE0Ioa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388113AbgE0Ioa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:44:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ACBC03E97C
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:44:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k5so27866244lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unikie-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=MFoYK1tdyEHkeM2PPovQEs5479N+lz7pmFiM6Ih3uJk=;
        b=olBkgcZifHmXXUqZg49Yy3KTfO3eNt/7yfrgYYlMTI1MOwKCCjQJcTtGjEoziZYMWQ
         GQ8uG3CZ/H+3ToPlIJ1xPnu+pSE5SoVzE/IC4gm9MwOgvpY0f2/nQ7nAiujvzA7D3dIi
         tON6zrDAE5nOO/NeSYpTx37GptVxr0vR8IsjIwcHBUjU7SQ/Yh3OLku8OeVJph2thdJB
         qB/aE58oM0/96x1QT2+JYAYG8wZy4XWA9nHmQHr8/jTZMD9KgIrYJecQS7j9/DN4Om5O
         +oY4upzrNgn7N3UBB3f98pydImVaxOylsOcasGl4Q3Y3jueTb5CzjR9dFKEFnaNPbzKv
         xpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MFoYK1tdyEHkeM2PPovQEs5479N+lz7pmFiM6Ih3uJk=;
        b=jjhovzkPtsjvlOp/HkaXGqkol3bqYlVoKBi2qTT+/zavxc+lnFa3EUJ2EjAV0MPR53
         oIdtFDVDy7x9juMA/SNa3/Kl/jO+8LKc2Z2QMzNzX7QxyyJ1H7YoXMzYnnfG8hkUilws
         KN3pa7rxM2dnuGDVlXeSKT2DkgN3t7esbCqbbsiE0S4MKwdvnUVhfuiuoQ/rVfLFCN1B
         rI/o0XzmirbTZeXeg1pme/M0QhJPUwSbHaN5IVpVz2h7+KuMfs6BWjye6CEHoBjgRyF4
         hgaYV95HSr/FxNPeUsNKgwF8q9Djo81x7tS9/KYWGI8mEBSf6MpyYoeFi6uJHS/z6z7C
         3DfQ==
X-Gm-Message-State: AOAM5317PrCvcS9knqx00FnAyW0RxFTPZFvazsAYD+OnFC/IZyp9Gxu8
        A2dd+7+MqsLWAv0sxqs3mG6JZg==
X-Google-Smtp-Source: ABdhPJzDaH1iDFR+BxrddOsLDTpZzTIIxQ+A9Fc7OrKYAHgar8y5fyveSzDjW9XTJleFpiWHgJHSOw==
X-Received: by 2002:a05:651c:2dc:: with SMTP id f28mr2450294ljo.36.1590569068041;
        Wed, 27 May 2020 01:44:28 -0700 (PDT)
Received: from localhost.localdomain ([109.204.235.119])
        by smtp.googlemail.com with ESMTPSA id o4sm654925lff.78.2020.05.27.01.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 01:44:27 -0700 (PDT)
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
        valentin.schneider@arm.com, srikar@linux.vnet.ibm.com,
        john mathew <John.Mathew@unikie.com>
Subject: [RFC PATCH v6 0/3] Add scheduler overview documentation
Date:   Wed, 27 May 2020 11:44:18 +0300
Message-Id: <20200527084421.4673-1-John.Mathew@unikie.com>
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
https://lore.kernel.org/lkml/20200514092637.15684-1-John.Mathew@unikie.com/

version 6:
 -Fix typos.

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

