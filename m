Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6E4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9704A20776
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxoX3kOI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgE3IUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 04:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728841AbgE3IUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 04:20:43 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3327AC08C5C9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 01:20:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r18so5924258ybg.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 01:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=K2vvSflHIYm1tyfKJhwXQeu+hDzkoR50BrI5LF1sUSs=;
        b=GxoX3kOIvLpUG9kgTxLuZtXJVMzEFZvGOgKhHJUBsnhgofHZmtpXfAaMYDa+K4P88w
         2hzUczhRvRviZIHEn/fjjz82WqgNuicMDHEUCJnKSyWB3khfBfDhDw7iWHa7ARnrKg3w
         xjdhtZB+PPiS7vBN3PfdqvBpGqE51lY4QBIXxscOAQ8mt7ToWs6AaWu/yKuOl55G2U3x
         4nYRQpSXnODYnEzyFcVmtr/QkbzsfutR6rxbfFkMEVUZWbMBMpDZh95mZOn4qG1Y77Lu
         5rwFNcL+XaoOYcxe2xcpPgnY03hELjmHmSZHf8IgN5dA2nECHia0y16VD4HN36F+AdxB
         BuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=K2vvSflHIYm1tyfKJhwXQeu+hDzkoR50BrI5LF1sUSs=;
        b=JyEEnaYaaOw3qICAg2lukLssPAa43axlw3wtQZzpRVbCsfiEBZHIkhvzsg304TCnGG
         ygkRPId3gnvHMPECfxrJDnfh3pOcRyetNq34zIxzS+zN+G0A9nzu1+h2rhdcJGR9Ci2U
         k8sDP/5/wIE9ic4sDVvQH+BJ+DGDgUNCpO7ehOKAHL/Mn1m5CWKMd/tnXam7TEZFsi9E
         MaigAMpbkozF1EgOYlNUERMCYMio1Ov4WTfBjFyrJ3ze8mCwU4oLECwfKFpvaJS1O/Jj
         EfUUDa+gO0XX/dF076KaF0To+RB7PPMUY3gNmZmjBQ5DBSS/MFHU69hmicQi8/7dW3c0
         Z9sw==
X-Gm-Message-State: AOAM532h45Kh5gzrYxxoeKuke4ERANEMV8ty55amlzNoaTh0AmHWjL6j
        BLZKdCVs+ythBLamhaJvGoEMn35c07Nh
X-Google-Smtp-Source: ABdhPJwyjQPxMFo5SQsOfMvkpaYt0UHV26agm9m1gv6urDkiHorNbCIRDrinvSIzEPkYT4Gv+u596cl8rpjQ
X-Received: by 2002:a25:ba8d:: with SMTP id s13mr20428240ybg.123.1590826841380;
 Sat, 30 May 2020 01:20:41 -0700 (PDT)
Date:   Sat, 30 May 2020 01:20:15 -0700
In-Reply-To: <20200530082015.39162-1-irogers@google.com>
Message-Id: <20200530082015.39162-4-irogers@google.com>
Mime-Version: 1.0
References: <20200530082015.39162-1-irogers@google.com>
X-Mailer: git-send-email 2.27.0.rc2.251.g90737beb825-goog
Subject: [PATCH 3/3] perf test: Initialize memory in dwarf-unwind
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a false positive caused by assembly code in arch/x86.
In tests, zero the perf_event to avoid uninitialized memory uses.
Warnings were caught using clang with -fsanitize=memory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/tests/dwarf-unwind.c | 8 ++++++++
 tools/perf/tests/dwarf-unwind.c          | 1 +
 2 files changed, 9 insertions(+)

diff --git a/tools/perf/arch/x86/tests/dwarf-unwind.c b/tools/perf/arch/x86/tests/dwarf-unwind.c
index ef43be9b6ec2..4e40402a4f81 100644
--- a/tools/perf/arch/x86/tests/dwarf-unwind.c
+++ b/tools/perf/arch/x86/tests/dwarf-unwind.c
@@ -55,6 +55,14 @@ int test__arch_unwind_sample(struct perf_sample *sample,
 		return -1;
 	}
 
+#ifdef MEMORY_SANITIZER
+	/*
+	 * Assignments to buf in the assembly function perf_regs_load aren't
+	 * seen by memory sanitizer. Zero the memory to convince memory
+	 * sanitizer the memory is initialized.
+	 */
+	memset(buf, 0, sizeof(u64) * PERF_REGS_MAX);
+#endif
 	perf_regs_load(buf);
 	regs->abi  = PERF_SAMPLE_REGS_ABI;
 	regs->regs = buf;
diff --git a/tools/perf/tests/dwarf-unwind.c b/tools/perf/tests/dwarf-unwind.c
index 2a0dac81f44c..2491d167bf76 100644
--- a/tools/perf/tests/dwarf-unwind.c
+++ b/tools/perf/tests/dwarf-unwind.c
@@ -37,6 +37,7 @@ static int init_live_machine(struct machine *machine)
 	union perf_event event;
 	pid_t pid = getpid();
 
+	memset(&event, 0, sizeof(event));
 	return perf_event__synthesize_mmap_events(NULL, &event, pid, pid,
 						  mmap_handler, machine, true);
 }
-- 
2.27.0.rc2.251.g90737beb825-goog

