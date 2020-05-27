Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A39842073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIt1yYkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgE0WrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE0WrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:47:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4B4C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m10so858055ybk.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YQlMleJvTCYdzPc5tUzXYuVHdCb2672LVpK+yCo0EI8=;
        b=KIt1yYkfDoujQU/q2+6yUL12rwYUtycfMzefXGKvpV1scm516Y2Er7P4WL//vv7Oby
         MbssnS7TWdNVjjLcJ/iEHXYhCAz5LZ+IqwmoaHNyZ0uIn3y39Ez4ZS6vMeB2jRQAJjYZ
         tR9WFXGeV/UZsOeQw4TohrdYRu1geha6vHMYsl7qiMRW5IB2v8tDVE01Z5aW8AkihhR1
         nmw3/VDAXd0cCMpoNbCTMF85apYM1K4Qie1t+B34E3naqC5oGX2vxtPiYIQRrBe8c1V3
         ttfC6Nxl2eV0EwI8etkQ9Pj4MPsZIDjH2v2111lEw191NGKk1GgiZKs27yrb8M+nfhMW
         cn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YQlMleJvTCYdzPc5tUzXYuVHdCb2672LVpK+yCo0EI8=;
        b=kSpHM/O8F1zt3frmmaSD7cKSi+WxZNiqit6H+vaq8B8cm5cErZd1fEfuHw5X5enZMe
         OoexlDNwwGbD8yt7g0VDTNAvhskQDR0D4Q6vREL4qrwprHH3BiKZy1ZDo25uTE94gqPg
         T1TTsgUdxW/L9Fh6TUP8xdMFykV1jfrIB1xUCe5HvHAEVqU9oRg3ahfpbCS0iFpVDfdg
         PkUu7NgA6jaGV1o95LCE2M7WkHFdwQr6S+LJYqODbUwxt2rgyf1Smnhhjuoh5rAQ6TG9
         TD5AUsbsATwtf/9gvrctn3KvKrBtQkxGU0uWMxWn5gowe4Gr4wMfot6nbAwJyw1hClOT
         uX1Q==
X-Gm-Message-State: AOAM532iyEf1ueqA9fAOfcZA9mZFLsXHPLEFIZg3NkEP3sDoornEhV7v
        rmFSwN4vLlue95bJz626G9mEZC1AV11UJITul0lkWd7Ww6g7dXyLSgfDAGuilsczsVAaNDX4mh5
        0aYB1wJTPWHgsqP6zge5s900Oh2rh2HzefJ0Y1LpEl18rGeRNfGV6FYM5bVOp6D76nf1Aqd3O
X-Google-Smtp-Source: ABdhPJzWXzSf2r84NEA6M6XyuUJyLYlBwo1vnnAd+qGYj4/DCnMLY3htwnyoDRWZ1iE1x8SkFInRaxg8ol4V
X-Received: by 2002:a25:35d5:: with SMTP id c204mr782416yba.292.1590619627706;
 Wed, 27 May 2020 15:47:07 -0700 (PDT)
Date:   Wed, 27 May 2020 15:46:54 -0700
Message-Id: <20200527224659.206129-1-eranian@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
Subject: [PATCH v2 0/5] perf/x86/rapl: Enable RAPL for AMD Fam17h
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

In V2, we integrated Peter's comments:
- keep the same CONFIG_PERF_EVENTS_INTEL_RAPL for both Intel and AMD support
- msr is unsigned int
- cleanup initialization of the *_rapl_msrs[] arrays

In particular, we split the patch some more to clearly identify the changes.
We flip the visibility logic to work around the behavior of perf_msr_probe().
We improve that function to handle msrs[] array with unpopulated entries.
This help RAPL on AMD, because only one MSR (PKG) is define. That way
we can initialize the amd_rapl_msrs[] array just with that entry. But because
we prefer having the same encoding for the same RAPL event between AMD and Intel
this means, we need to handle unpopulated entries in the array and in perf_msr_probe()
which is what patch 4 does.

Signed-off-by: Stephane Eranian <eranian@google.com>


Stephane Eranian (5):
  perf/x86/rapl: move RAPL support to common x86 code
  perf/x86/rapl: refactor code for Intel/AMD sharing
  perf/x86/rapl: flip logic on default events visibility
  perf/x86: make perf_probe_msr() more robust and flexible
  perf/x86/rapl: add AMD Fam17h RAPL support

 arch/x86/events/Kconfig            |  6 +--
 arch/x86/events/Makefile           |  1 +
 arch/x86/events/intel/Makefile     |  2 -
 arch/x86/events/probe.c            | 13 ++++++
 arch/x86/events/{intel => }/rapl.c | 67 ++++++++++++++++++++++++++----
 arch/x86/include/asm/msr-index.h   |  3 ++
 6 files changed, 78 insertions(+), 14 deletions(-)
 rename arch/x86/events/{intel => }/rapl.c (92%)

-- 
2.27.0.rc0.183.gde8f92d652-goog

