Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC83C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2448F22B3F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 23:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="ZLFrfAiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733057AbgGVXpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 19:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgGVXpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 19:45:44 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E0EC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:45:44 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k22so3461234oib.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 16:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUExGfM+953A+bS/pUbiCTiJmKxiMhSnl8wFBZoEMeE=;
        b=ZLFrfAiMWAgjGgB/LtApRIC8/J6QB5YZr9E2vnZP+7xCoJFgG8XLZ/+238YT5PL43g
         rO3KzjCVobRN6pXIoL5vfi/jJfwpLVjG9Z+aUTJiy4uT6r28rjjJVwCI58r653sXfTTG
         SWGiFElNO/D7OwwzvC+OQ/rfnMab76ddZsLhUxdv6G2G/tfcZ9X5KztENyOQX9H3vi8E
         syKNyviJ0gm8z8ykItCuyC0eLtH7kDESNW3++zjdb0ypvBHAFB4VpL/ubkS+mstEY1Xt
         gSXMd69T4Ie8pA9Ldyzc2cC8XVf7LnFaRIqal/CBeGuvtIJpJFK8Ps3chwPhL6noN9zC
         W2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jUExGfM+953A+bS/pUbiCTiJmKxiMhSnl8wFBZoEMeE=;
        b=eEtU8LEuJB4/KWW4L0EyFo0pflqS5DcExH+2HseAxQtzq1YVD7jKVGQW7+vOYljoIg
         bBvyK13gdBpn5mbWwjzD/yY13Mgu9IVr7Vf9qrZYXVpxqUexOzxFDSx13AaV+1mqZmOQ
         9vMceynAD/F6UrSDoWo2q47nqy53VpkPmcWL4/DdUnBeV05OLGz/bbFYNaMEIjETCe7F
         uIb6wnxw1EVdPy0zELLblzaQOYtBfPuovZeJLbyGRvgYe0l8PRTdeZJqyOdd7kJ+7/fP
         dE5weY4MQHXpmL2hgDZQZmgc/XjQQGf3+60P7wDKw50wC1/0ewzfEnQlbyOFORe+uW4l
         ep1Q==
X-Gm-Message-State: AOAM532Ka9mO7OVH0lWGy5cbzPQEZ3xKN8yn438p8J1MEXIM6+eI0uQQ
        IGoWC14JxSKk8EYkHEmVSUF8JBvIdmI=
X-Google-Smtp-Source: ABdhPJz75Ag/ApFs8fLJCKnaY1zSlAFePL5S8B4LN4X7lia6ZgqPtodt52vICzorIefhCUiHYc3uiQ==
X-Received: by 2002:aca:c392:: with SMTP id t140mr1660809oif.131.1595461543248;
        Wed, 22 Jul 2020 16:45:43 -0700 (PDT)
Received: from posk-x1c.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id x9sm294804ota.9.2020.07.22.16.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 16:45:42 -0700 (PDT)
From:   Peter Oskolkov <posk@posk.io>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Oskolkov <posk@google.com>, Andrei Vagin <avagin@google.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Aaron Lu <aaron.lwe@gmail.com>
Subject: [PATCH for 5.9 0/3] FUTEX_SWAP (tip/locking/core)
Date:   Wed, 22 Jul 2020 16:45:35 -0700
Message-Id: <20200722234538.166697-1-posk@posk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

As Paul Turner presented at LPC in 2013 ...
- pdf: http://pdxplumbers.osuosl.org/2013/ocw//system/presentations/1653/original/LPC%20-%20User%20Threading.pdf
- video: https://www.youtube.com/watch?v=KXuZi9aeGTw

... Google has developed an M:N userspace threading subsystem backed
by Google-private SwitchTo Linux Kernel API (page 17 in the pdf referenced
above). This subsystem provides latency-sensitive services at Google with
fine-grained user-space control/scheduling over what is running when,
and this subsystem is used widely internally (called schedulers or fibers).

This patchset is the first step to open-source this work. As explained
in the linked pdf and video, SwitchTo API has three core operations: wait,
resume, and swap (=switch). So this patchset adds a FUTEX_SWAP operation
that, in addition to FUTEX_WAIT and FUTEX_WAKE, will provide a foundation
on top of which user-space threading libraries can be built.

Another common use case for FUTEX_SWAP is message passing a-la RPC
between tasks: task/thread T1 prepares a message,
wakes T2 to work on it, and waits for the results; when T2 is done, it
wakes T1 and waits for more work to arrive. Currently the simplest
way to implement this is

a. T1: futex-wake T2, futex-wait
b. T2: wakes, does what it has been woken to do
c. T2: futex-wake T1, futex-wait

With FUTEX_SWAP, steps a and c above can be reduced to one futex operation
that runs 5-10 times faster.

Patches in this patchset:

Patch 1: introduce FUTEX_SWAP futex operation that,
         internally, does wake + wait. The purpose of this patch is
         to work out the API.
Patch 2: a first rough attempt to make FUTEX_SWAP faster than
         what wake + wait can do.
Patch 3: a selftest that can also be used to benchmark FUTEX_SWAP vs
         FUTEX_WAKE + FUTEX_WAIT.

Peter Oskolkov (3):
  futex: introduce FUTEX_SWAP operation
  futex/sched: add wake_up_process_prefer_current_cpu, use in FUTEX_SWAP
  selftests/futex: add futex_swap selftest

 include/linux/sched.h                         |   1 +
 include/uapi/linux/futex.h                    |   2 +
 kernel/futex.c                                |  89 ++++++--
 kernel/sched/core.c                           |   5 +
 kernel/sched/fair.c                           |   3 +
 kernel/sched/sched.h                          |   1 +
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   1 +
 .../selftests/futex/functional/futex_swap.c   | 209 ++++++++++++++++++
 .../selftests/futex/include/futextest.h       |  19 ++
 10 files changed, 315 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_swap.c

-- 
2.25.1

