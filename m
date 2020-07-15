Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB926C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB76220663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KSk5xf+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGOCFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOCFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:05:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD05C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g67so1160147pgc.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=IaDIKmrv4dx2/me1ziKFX3npWTh6u2+K8VHR4xtYEvI=;
        b=KSk5xf+9ttvbvG1cUFueIBgCZIa/2o3Ml/6KGETT23GM0EIHEb+kwexHi648eok0q+
         b+rTfFxE6XjfnzX23D3MkRRo5oDlpI4h3Yg6JvtLWpYRR0MPrnWfCKvsk7a4OoFmZXWp
         0a4wXfZbRtKWI7gtfU5yF51cqxGhVaUshB1jfsMmQ5VBkyJCSHsbSfBxZcFMcNkxtxrw
         YSiJ8zj1LJ1+HMafeOB/Sq75celLO4f7hb7lhBKux2CGbTKti/Oyc1VYBPdnsAi7unSN
         vO9JhCJN+kF0TxsPVQxU/v/XWDZgjKoNn8++ar7cpNVMUuwS3+jmRVvEEo75eGv8rrWz
         fMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=IaDIKmrv4dx2/me1ziKFX3npWTh6u2+K8VHR4xtYEvI=;
        b=UguCfhdooHjl44Rj82BCHbGsak5KhKmhOsUs4RcKA4H5/P4gqOthYFluzTJlTaIpnQ
         GyTnOhpmpGidK3NDiCc19Brgi3cPnfhfggeqP2GCyedrSriNqhu7gh91lJfx0mcNZLqL
         YsQhYFi4Qg73I76J+y+5Tx4TySoXtBWdhhY/1ML6deMgfK40qDzYrlPalGqYENRaFlV/
         p6lFhV+2DQ0snOSkjd4kXBXssfqFRu1FPJmZP4PXrj4AfazTp3JjHQtffZqHuzULm/gT
         +Ne9MyI9nTarQIuOTEE4aRe2/YqSp0h/NH+U+PdQUlBKNit5GflZvPN/3fbisDFDkw5l
         701Q==
X-Gm-Message-State: AOAM531cqeb2MHEPIsaH9qmmnzrqJujS6TT6S2kbzddo9lgB5vQAaWGc
        wQw6yjqnlvevpIGVrT0g0W6uSQ==
X-Google-Smtp-Source: ABdhPJzcTSLzoTkwN0ZklOtgUfNh6CnWTfMrQCsIPnKPLy5Pumiyh3t7E4wIxKgRr9byBrCe1lgrHw==
X-Received: by 2002:a62:1801:: with SMTP id 1mr6907081pfy.242.1594778723827;
        Tue, 14 Jul 2020 19:05:23 -0700 (PDT)
Received: from localhost ([2400:8904::f03c:91ff:fe8a:bbe4])
        by smtp.gmail.com with ESMTPSA id my9sm296320pjb.44.2020.07.14.19.05.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 19:05:23 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/6] arm64: perf: Proper cap_user_time* support
Date:   Wed, 15 Jul 2020 10:05:06 +0800
Message-Id: <20200715020512.20991-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is rebased for Peter's patch set to support
cap_user_time/cap_user_time_short ABI for Arm64, and export Arm arch
timer counter related parameters from kernel to Perf tool.

In this version, there have two changes comparing to Peter's original
patch set [1]:

The first change is for calculation 'time_zero', in the old patch it
used the formula:

  userpg->time_zero -= (rd->epoch_cyc * rd->mult) >> rd->shift;

From the testing, if 'rd->epoch_cyc' is a big counter value, then it's
easily to cause overflow issue when multiply by the 'rd->mult'.  So in
this patch set, it changes to use quot/rem approach for the calculation
and can avoid overflow:

  quot = rd->epoch_cyc >> rd->shift;
  rem = rd->epoch_cyc & (((u64)1 << rd->shift) - 1);
  ns = quot * rd->mult + ((rem * rd->mult) >> rd->shift);
  userpg->time_zero -= ns;

The second change is to add new patch 'tools headers UAPI: Update
tools's copy of linux/perf_event.h', it's used to update perf tool
header so make sure the headers are consistent between kernel and user
space.

This patch set has been rebased on mainline kernel with the latest
commit 11ba468877bb ("Linux 5.8-rc5"); it has been verified with Perf
tool for Arm SPE timestamp enabling, the patch set for Arm SPE timestamp
enabling will be sent out separately.


[1] https://lkml.org/lkml/2020/5/12/481


Leo Yan (1):
  tools headers UAPI: Update tools's copy of linux/perf_event.h

Peter Zijlstra (5):
  sched_clock: Expose struct clock_read_data
  arm64: perf: Implement correct cap_user_time
  arm64: perf: Only advertise cap_user_time for arch_timer
  perf: Add perf_event_mmap_page::cap_user_time_short ABI
  arm64: perf: Add cap_user_time_short

 arch/arm64/kernel/perf_event.c        | 59 ++++++++++++++++++++-------
 include/linux/sched_clock.h           | 28 +++++++++++++
 include/uapi/linux/perf_event.h       | 23 +++++++++--
 kernel/time/sched_clock.c             | 41 ++++++-------------
 tools/include/uapi/linux/perf_event.h | 23 +++++++++--
 5 files changed, 126 insertions(+), 48 deletions(-)

-- 
2.17.1

