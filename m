Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6146C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938CC207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 05:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Za/sOcxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgGPFLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 01:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgGPFLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 01:11:51 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18825C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:11:51 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so4268011pgf.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 22:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ig+Pz0HvOxBec7mSBcRcKr3V9Zl8Ma01mbpSkhfzxHQ=;
        b=Za/sOcxJGOG3wt1UvmCh3w0KQ9uZrZoFgdVX2u+PCGoFZjQXtZ/aLB4tmQI1s1fOj6
         eNQOijKwq467jqwkqiv40fiTJjrT7GravSYEfAI1jxQxd0ZYhaDn+JaZFUNEaOUj95+H
         aMvle/21tW7bIKvpI7Uc42vgCdi723IgCcmxMq1TnuUp0JDtVf2DlhUh13jLdzTARxED
         TrlILdqXtw36c3cZzZ6iyvfc6+yHWAH0EAW6hCm3AJ7EXRPYaAoYjEaE4bZZmhun2hcB
         QpkdHlic6fmRD9P601IfDQgdm+LC7L5vB4qP6kSzflf7yirYc0QJwCJBMMlpfTuQ+TTe
         563w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ig+Pz0HvOxBec7mSBcRcKr3V9Zl8Ma01mbpSkhfzxHQ=;
        b=CTuUSmpkU/Pu9D+Sia0bBGA7pSOCfAJbP5USwlAx+HnVOLr9RsTPWyeaTU6Ks0gvhz
         WWkVVCyWuRIuuN5wpCjy308KZBv2Tfv897IysvgoNqZEQN6q89hlJ3mjwGTiQrE+oTS2
         JbBmh4zkXDHBKyLAvzsR8NPQMAbN4ZTb35m2koDcXwF3pOxQy0UmMrBSrHM/QYQc/71r
         f/5x6qUmwHzZ5/mxWVqxaow5mlr7SWjIS3ay0/p42ufAanXaGEZImuVO3YgcN0gdwdE9
         6h3kuQTOlC6V5ACCxVWRkuoQXsXSzLcGifh5uX67ogl/vLIx6Cf72mBpqOFQcH37zjfY
         quKg==
X-Gm-Message-State: AOAM533bvxbwUA1U8thfTmUSJhgiGSBcmBGf36Fez8D6FSHMaWFsksVd
        p5tpfpidZB0yj0CoQ7gFqnZZew==
X-Google-Smtp-Source: ABdhPJytphd2kofWJjJYe1jPA/1m0TOD9T+g7Bq7P//Mnf57T4ygPu+Nf2NAUeZNAHOQCEOrHAwNGA==
X-Received: by 2002:a63:7e55:: with SMTP id o21mr2829176pgn.263.1594876310048;
        Wed, 15 Jul 2020 22:11:50 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id g4sm3737878pgn.64.2020.07.15.22.11.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 22:11:49 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Paul Cercueil <paul@crapouillou.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 0/7] arm64: perf: Proper cap_user_time* support
Date:   Thu, 16 Jul 2020 13:11:23 +0800
Message-Id: <20200716051130.4359-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is rebased for Peter's patch set to support
cap_user_time/cap_user_time_short ABI for Arm64, and export Arm arch
timer counter related parameters from kernel to Perf tool.

After get feedback from Ahmed, this patch set contains Ahmed's new patch
to refine sched clock data accessing with raw_read_seqcount_latch().

This patch set has been rebased on mainline kernel with the latest
commit 994e99a96c9b ("Merge tag 'platform-drivers-x86-v5.8-2' of
git://git.infradead.org/linux-platform-drivers-x86 into master"); it
has been verified with Perf tool for Arm SPE timestamp enabling.


Changes from v2:
- Included Ahmed's patch to use raw_read_seqcount_latch() for
  sched_clock's seqcount latching;
- Changed to use mul_u64_u32_shr() for converting counter to ns
  in Arm64's arch_perf_update_userpage() (PeterZ).


Ahmed S. Darwish (1):
  time/sched_clock: Use raw_read_seqcount_latch()

Leo Yan (1):
  tools headers UAPI: Update tools's copy of linux/perf_event.h

Peter Zijlstra (5):
  sched_clock: Expose struct clock_read_data
  arm64: perf: Implement correct cap_user_time
  arm64: perf: Only advertise cap_user_time for arch_timer
  perf: Add perf_event_mmap_page::cap_user_time_short ABI
  arm64: perf: Add cap_user_time_short

 arch/arm64/kernel/perf_event.c        | 57 ++++++++++++++++++++-------
 include/linux/sched_clock.h           | 28 +++++++++++++
 include/uapi/linux/perf_event.h       | 23 +++++++++--
 kernel/time/sched_clock.c             | 41 ++++++-------------
 tools/include/uapi/linux/perf_event.h | 23 +++++++++--
 5 files changed, 124 insertions(+), 48 deletions(-)

-- 
2.17.1

