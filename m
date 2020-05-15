Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D47C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F031C20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 21:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLE+HX5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgEOV6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 17:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbgEOV6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 17:58:02 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25768C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:58:02 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id g6so4057195qvn.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=kkSiaJvog94/aYOcgzYy16QWa/dLPfi5rMQqLSVlixs=;
        b=VLE+HX5xG/MszCohlrtmOoUjX0QLWfFlKaiTQmZL08YQirgkZ4zeQ5/GMf1kKemxZM
         d1474CJ+MVc0mS+YBXdwVNpSd80PVTIdI0dNN52YsJzDVFAVHYhwI5zEdXjgfh8+TZXU
         gmWyuiCHQ8AX8vJ3Bsl4GiTe+ejqZHwOBcrcrJUoIPz087w84+qNUYhO7mv1SBwpuNmg
         S2lwGwzXX2I14Cuu1VTro2FIztctotjk4lHPNtVGv/GqQAmFPbmplDFRll9eBP2E0n4k
         HnK8E6LFPJnYYikuZbvDfNAiWwECI/gF3HYisG0DCWHGxM+IGP3aZZNKDiB7E3CZqYZ5
         zLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=kkSiaJvog94/aYOcgzYy16QWa/dLPfi5rMQqLSVlixs=;
        b=DMPx6Hy6suhJVU9n4tfkrxNRPkd4WJUiTH3zag1MC3MUZrZn4tJTHzLdRjp9+iy5Fq
         OD9CjbQ73bhW1WuttKI3LBqXxEENZQqYwUErd1dHbzpVVfv2Y1ohc0lUy+Dswaol0Wol
         tCL/fNJ/Prr2VUJPYoQ8XWgXL+HW9TZCzjcGfeEpmeZr+U8LyOQfM/ZDYd0t/fgXFOly
         ZkVcNvOKYk9GOvZ2KZzy2E+ov/+XGV2Ic3WLjK1FKgLrpZc6lodBy1mDgcXMhEyBj+yV
         nx8TCIKnmMaYEv01RHawcYA2fa0nSJOJ/K5I74C6pQCcmUNTXLRy5vu1+fJfFk18MG/5
         t2zQ==
X-Gm-Message-State: AOAM533e7yeqIQqa2vjOSS32wxacBlpX6Hgvt1t9kFkXH3A2hZWpZhqq
        mIooDzZpUziUwSPtNuyAND0GwK5qnSSbiulzTS4/rmru/3BXam4TCYgfaqhuHec2WhB7PE0sP6w
        HK/jyCRGNldOIeAmq/s90G7vsbi3mNwL5fuEHJ5A82jcepFTzS3OUAqvzoM8/rULMUrQjqu9k
X-Google-Smtp-Source: ABdhPJzWy0s5cY8yHOiUUdo1R4y36YRSik9iPIwKh0dgQ3f4LBSu3KCs7sC7yODqnrofPQMThPg6HwJlFbrr
X-Received: by 2002:a0c:b44c:: with SMTP id e12mr5551641qvf.30.1589579880899;
 Fri, 15 May 2020 14:58:00 -0700 (PDT)
Date:   Fri, 15 May 2020 14:57:30 -0700
Message-Id: <20200515215733.20647-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 0/3] perf/x86/rapl: Enable RAPL for AMD Fam17h
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@elte.hu, irogers@google.com,
        kim.phillips@amd.com, jolsa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for AMD Fam17h RAPL counters. As per
AMD PPR, Fam17h support Package RAPL counters to monitor power usage.
The RAPL counter operates as with Intel RAPL. As such, it is beneficial
to share the code.

The series first moves the rapl.c file to common perf_events x86 and then
adds the support.
From the user's point of view, the interface is identical with
/sys/devices/power. The energy-pkg event is the only one supported.

$ perf stat -a --per-socket -I 1000 -e power/energy-pkg/

Signed-off-by: Stephane Eranian <eranian@google.com>

Stephane Eranian (3):
  perf/x86/rapl: move RAPL support to common x86 code
  perf/x86/rapl: refactor code for Intel/AMD sharing
  perf/x86/rapl: add AMD Fam17h RAPL support

 arch/x86/events/Kconfig            |  8 ++---
 arch/x86/events/Makefile           |  1 +
 arch/x86/events/intel/Makefile     |  2 --
 arch/x86/events/probe.c            |  4 +++
 arch/x86/events/{intel => }/rapl.c | 55 +++++++++++++++++++++++++-----
 arch/x86/include/asm/msr-index.h   |  3 ++
 6 files changed, 58 insertions(+), 15 deletions(-)
 rename arch/x86/events/{intel => }/rapl.c (92%)

-- 
2.26.2.761.g0e0b3e54be-goog

