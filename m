Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55998C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6472120658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posk.io header.i=@posk.io header.b="dUlaLNfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgHCWPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:15:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCWPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:15:15 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BCFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 15:15:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so18269073oij.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 15:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=posk.io; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=68OLwltgUQg9vRu6vY0+7ejuVFhq0Gr6CZjdfuZPmtg=;
        b=dUlaLNfUn8pSCsrSoGlCqiQOJzeiqHDmFXusW7XCapF3lUoJ94SHcoWA2Ht5NReB07
         GWsS54MTXvSpw52wv0U2oLdjc41LlJrAWom/zf8LcTTiY3dH44EDEqySjwCnwnfm23c8
         b/cZV0gCY8yR97F3+OcLfKmJd6semh8drm8VAEcuMQeTa2vdWoaaRIbgcKFdXqsjpDYI
         t7NMyTLIIyc1oJaJ2NXoRqHjSVkCGRq1WJ44f8+9Qk+wfUHk9p51pXA1T9nWmbqdAa+a
         vu941sh/ofga3/7LCjCJ/PH2SPlsSRdigFheVxmDuZTviDkwZh44cQ0qE3FgTV3qNImg
         R2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=68OLwltgUQg9vRu6vY0+7ejuVFhq0Gr6CZjdfuZPmtg=;
        b=bAwlIXg0FNdeig9idq4/+llJzYDOnBHM6xs0u0HNyVGFcIe6WT+tQvyAeO6ghiM8TV
         ZbUPuKZlirRRngHn0Xf29Xa+Eu1OB/tbJJRNYe/gMFLBfQwWZxjPrfLiHXWxOYYFjPNj
         yqLaC6Iz3MPReOeGM/dKhFUPn8MMFed/Yd14C3EfGyQdRkHHBk9YKcTJTKFXjRbRIoJY
         gRTHGIpEVkvsTH8w/LgbCtOuSQB+MtUYlCOnlr+o29X2j/FexsAMsNyFYE5id/LkxP8i
         2SXZhlWgkmei5a1FQBmavOp58bFvZrnwXIVGKoT6pFrpuGeqw5jiDJSiucQPnMtGYREY
         DMEA==
X-Gm-Message-State: AOAM530WzunbkXd/60FAm83SYcXKQlT1aGhFYvvyL/mYY7ieUNoD9O+M
        1TcZulcjyqOZNbycXtRY2wu70yPgikU=
X-Google-Smtp-Source: ABdhPJxaFCZHtmnCz6tocBNkOy2cvaG6wwVAISz5l8TnDLYgjwrMBkUvpyeyyX7Mhzcw4DEoRrSHmA==
X-Received: by 2002:aca:ecd4:: with SMTP id k203mr1189833oih.116.1596492914361;
        Mon, 03 Aug 2020 15:15:14 -0700 (PDT)
Received: from posk-x1c.lan (23-118-52-46.lightspeed.sntcca.sbcglobal.net. [23.118.52.46])
        by smtp.gmail.com with ESMTPSA id m8sm3026624ote.55.2020.08.03.15.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 15:15:13 -0700 (PDT)
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
Subject: [PATCH for 5.9 v2 0/4] FUTEX_SWAP (tip/locking/core)
Date:   Mon,  3 Aug 2020 15:15:06 -0700
Message-Id: <20200803221510.170674-1-posk@posk.io>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Oskolkov <posk@google.com>

This patchset introduces FUTEX_SWAP operation for fast
task context switching (aided by futexes). Detailed
use cases and reasoning are included in the commit message
of the first patch in the patchset.

v1->v2:
- split two #defines in futex.h into a small first patch
- detailed the use cases and reasoning in the commit message
  of the first patch
- renamed wake_up_process_prefer_current_cpu into wake_up_swap.


Peter Oskolkov (4):
  futex: introduce FUTEX_SWAP operation
  futex: implement FUTEX_SWAP as wake+wait.
  futex/sched: add wake_up_swap, use in FUTEX_SWAP
  selftests/futex: add futex_swap selftest

 include/linux/sched.h                         |   6 +
 include/uapi/linux/futex.h                    |   2 +
 kernel/futex.c                                |  86 +++++--
 kernel/sched/core.c                           |   5 +
 kernel/sched/fair.c                           |   3 +
 kernel/sched/sched.h                          |   1 +
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   1 +
 .../selftests/futex/functional/futex_swap.c   | 209 ++++++++++++++++++
 .../selftests/futex/include/futextest.h       |  19 ++
 10 files changed, 318 insertions(+), 15 deletions(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_swap.c

-- 
2.25.1

