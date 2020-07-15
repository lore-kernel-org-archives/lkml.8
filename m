Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41F0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC7120663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lg7GSCoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgGOCeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgGOCeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:34:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F46BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:34:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so1495875pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f8bxNyYbjIyrEgdnKxseoK9sUsIhf1Geu3/0Dwhdzfo=;
        b=Lg7GSCoJTXc0YQelgL/P52/3iTZKrQIZIe7yu0kjse46jGmcE8ft0Uc+Uy29RAVyyl
         a9cV45GdUgTgLwkRx6Eiwn9n64dQLKf8uc4VdGWQ8L9s++pkJrhwUcqjVhttxMzbUAP/
         WHA7OYmrGtxn0saNdhkA4RKZFOiGJDBUiwsVxLi40BEayeyFsMKX3bKmOCFaDpCqBpbW
         xOoLzZUb/v6CNuRDIgq/vH2cr6SWwpaKaUCry9dA3bwb+uYlsY2nE/rQtnmw/52ELMRi
         +3DuesZ+jwtdbsa6HkMJLQztW/I7FznIQj9+lS4BadNHpHYJXkPDYjPdCfrN2PLTot5E
         yrhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f8bxNyYbjIyrEgdnKxseoK9sUsIhf1Geu3/0Dwhdzfo=;
        b=gSTvWrl3lARWUL8FUabcVXrssRaE/f9EiR2mEqaV4Lk56EuPCtQkQWD1YaGPZQB1Tw
         EUS0eIxC5lTF9o89dkilTmG2mS1eS9YFZysrTvwxnEbfRGK08dNML5Krti1L4m3Ht26U
         qucIsjFw0vGmFLQmyjSwNdCf1oFntEdggXEmOWoSnBcPgbxP3mqgVMxo/Pvk3jfkHOW5
         ShQBGQK81PBGsPezUj6tvS5OuXfG2mcELNZOQqKSOV9n7vo9x2GdeL0db6eVKHbUBJNh
         x9Fw+HkTnLXNR4I70g3e2wLC7Xch3Cd3S37HI7Dj5rrByTWGfoNz8/c5g0hh6NHLqNbq
         JqSQ==
X-Gm-Message-State: AOAM533mzCGz8hWrS/LmvR3RZ3d7Zy6LVEoIsaoUAptz6cW/TwBrqwdF
        JfJkuSV0BcXCPiADODYYfv6/uw==
X-Google-Smtp-Source: ABdhPJxK8WwHunxN6nLXrZNZFF+rCKtOdu5cqIUe0d68mEvk5nnlYzrqJbDP0qUuw9COZlzSWKvrNA==
X-Received: by 2002:a17:902:c38a:: with SMTP id g10mr6088232plg.50.1594780458021;
        Tue, 14 Jul 2020 19:34:18 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id o4sm339248pjo.16.2020.07.14.19.34.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:34:17 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kemeng Shi <shikemeng@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ian Rogers <irogers@google.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 0/3] Perf tool: Enable Arm arch timer counter and arm-spe's timestamp
Date:   Wed, 15 Jul 2020 10:33:58 +0800
Message-Id: <20200715023401.23988-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to enable Arm arch timer counter and Arm SPE is the
first customer to use arch timer counter for its timestamp.

The patch 01 is to retrieve arch timer's parameters from mmaped page;
patch 02 provides APIs for the conversion between arch timer's counter
and time; patch 03 is to enable timestamp based on the new introduced
APIs for timestamp related calculation.

Note, this patch set is depend on the kernel changes for "arm64: perf:
Proper cap_user_time* support" [1].

This patch set has been rebased on mainline kernel with the latest
commit 11ba468877bb ("Linux 5.8-rc5") and also applied on top of patch
set [1].  After enabling the timestamp, the samples can show the
timestamp, and the timestamp is consistent with the kernel's timestamp
by checking the kernel log:

  $ perf script -F,+time
    dd  6799 [034] 25496.733475:          1              l1d-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733475:          1              tlb-access:      ffff87f37b88 _dl_start+0x288 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733479:          1              l1d-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733479:          1              tlb-access:      ffff87f37c74 _dl_start+0x374 (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733485:          1              l1d-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)
    dd  6799 [034] 25496.733485:          1              tlb-access:      ffff87f49af4 __GI___tunables_init+0x3c (/usr/lib/aarch64-linux-gnu/ld-2.28.so)

[1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=318401


Leo Yan (3):
  perf tools: Support Arm arch timer counter
  perf arm_arch_timer: Convert between counter and timestamp
  perf arm-spe: Enable timestamp with arch timer counter

 tools/perf/arch/arm64/util/Build        |  1 +
 tools/perf/arch/arm64/util/arch_timer.c | 50 +++++++++++++++++++++++++
 tools/perf/arch/arm64/util/arm-spe.c    | 17 +++++++++
 tools/perf/util/Build                   |  1 +
 tools/perf/util/arm-spe.c               | 16 +++++++-
 tools/perf/util/arm-spe.h               |  5 +++
 tools/perf/util/arm_arch_timer.c        | 28 ++++++++++++++
 tools/perf/util/arm_arch_timer.h        | 23 ++++++++++++
 8 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 tools/perf/arch/arm64/util/arch_timer.c
 create mode 100644 tools/perf/util/arm_arch_timer.c
 create mode 100644 tools/perf/util/arm_arch_timer.h

-- 
2.17.1

