Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3BD5C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC2424672
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 02:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVBcjrQC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgBZCag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 21:30:36 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:54553 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbgBZCag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 21:30:36 -0500
Received: by mail-pg1-f201.google.com with SMTP id l17so752153pgh.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 18:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XL1znedA4fMtEGxLGk7NjP9zj307A8lQsc4L+MICY30=;
        b=oVBcjrQCI6WtKZf/BcZxDjvhXasLSMhheKBBVX16ir2pnUsfWSJGpJsyILGnSpvH40
         O79uROStFMycaKQNEF8ovTfet5AeILP2OBb+nDPYveoT/IYd7QQA5sxkgyT/tumiYfF7
         n3JUPHDP/mROnjQbiCEqc0pZ7tbei8Cp+hHQuydEQMpPWUkcj2xQ9rh/yJHVUSSg73Rn
         IDkPRItHhmCA0ld87NoM447njTSXubyqLNfE5VWFwrcgo1jXu/hTgu4q4Lv6pDj9Qae1
         lJNeXOBO5NhFLjQsMZywpoZZ9cFPlT9Qb7Fd0FtGhXIkKKvldour9QH+fWi4oaYpqUWt
         qV6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XL1znedA4fMtEGxLGk7NjP9zj307A8lQsc4L+MICY30=;
        b=uc5R+UJ0Cn88ZTy37Fm+WB+e0CSrr6HikdUsZ3E+18wPXM3aWc73nKd+kCYLN/eAzk
         tAuJ0sYIbrw15HEFmNMAXsgM2ngK8NVOyLHSp94qe9oeEVDzFKqR+5BJHOrFAcWsOLa8
         RfkEmK4CK4IWpz++av62a/lOiFQaAVWxtMXN5A8FWis36v7vxKBtm9BcxNQdSeEfyqf8
         oeb14VgG8MRFMgWJe8jI66/0eYecOoW5ztJewU7962AzNxpkCgwl/AklwezWbuPfn5OU
         7xsX9yTGwYW7BFULi2Tvu6+gpt9et9QlOksC46QvDH9oGkoBrgBLgGvFyali4eGAQNgd
         iGKg==
X-Gm-Message-State: APjAAAXnVvktKVXUuIOKT4SPSuVaZmSERpQULmTcGj9HgHHrPAGGZKLt
        E1tsG61rsPUycauwytub3tb1oRa2LQQbHKeQDG2LX79LAXmZW/xoFinUq6gy4tzHMZLGhimHXfP
        7zSIXb9zMCmOgSLCDzgSaUjhYAeJ37XOMV++ltRasF9EMkNAZ3Dk8sRoy2SfRos5az2bHJA==
X-Google-Smtp-Source: APXvYqzFB6MIsDKuxL/zAzn5l2w4hxfkxbbFNQEwFa7qXiGyRc9LM9brNyi70AipsMveA+7CM8sbvQy4k5U=
X-Received: by 2002:a63:aa07:: with SMTP id e7mr1499287pgf.90.1582684233286;
 Tue, 25 Feb 2020 18:30:33 -0800 (PST)
Date:   Tue, 25 Feb 2020 18:30:25 -0800
Message-Id: <20200226023027.218365-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH 0/2] quickstats, kernel sample collector
From:   Luigi Rizzo <lrizzo@google.com>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        naveen.n.rao@linux.ibm.com, changbin.du@intel.com, ardb@kernel.org,
        rizzo@iet.unipi.it, pabeni@redhat.com, toke@redhat.com,
        hawk@kernel.org
Cc:     Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a small library to collect per-cpu samples and
accumulate distributions to be exported through debugfs.

I have used this to trace the execution times of small sections of code
(network stack functions, drivers and xdp processing, ...)
or entire functions, or latencies (e.g. IPI dispatch, etc.) and the fine
granularity helps identifying outliers, multimodal distributions,
caching effects and generally help in performance analysis.

Samples are 64-bit values that are aggregated into per-cpu logarithmic buckets
with configurable density (typical sample collectors use one buckets for
each power of 2, powers of 2, but that is very coarse and corresponds
to 1 significant bit per value; in quickstats one can specify the number
of significant bits, up to 5, which is useful for finer grain
measurements).

There are two ways to trace a block of code: manual annotations has the best
performance at runtime and is done as follows:

	// create metric and entry in debugfs
	struct kstats *key = kstats_new("foo", frac_bits);

	...
	// instrument the code
	u64 t0 = ktime_get_ns();        // about 20ns
	<section of code to measure>
	t0 = ktime_get_ns() - t0;       // about 20ns
	kstats_record(key, t0);         // 5ns hot cache, 300ns cold

This method has an accuracy of about 20-30ns (inherited from the clock)
and an overhead with hot/cold cache as show above.

Values can be read from debugfs in an easy to parse format

	# cat /sys/kernel/debug/kstats/foo
	...
	slot 55  CPU  0    count      589 avg      480 p 0.027613
	slot 55  CPU  1    count       18 avg      480 p 0.002572
	slot 55  CPU  2    count       25 avg      480 p 0.003325
	...
	slot 55  CPUS 28   count      814 avg      480 p 0.002474
	...
	slot 97  CPU  13   count     1150 avg    20130 p 0.447442
	slot 97  CPUS 28   count   152585 avg    19809 p 0.651747
	...

And write to the file STOP, START, RESET executes the corresponding action

	echo RESET > /sys/kernel/debug/kstats/foo

The second instrumentation mechanism uses kretrprobes or tracepoints and
lets tracing be enabled or removed at runtime from the command line for
any globally visible function

	echo trace some_function bits 3 > /sys/kernel/debug/kstats/_control

Data are exported or controlled as abube. Accuracy is worse due to the
presence of kretprobe trampolines: 90ns with hot cache, 500ns with cold
cache. The overhead on the traced function is 250ns hot, 1500ns cold.

Hope you find this useful

Luigi Rizzo (2):
  quickstats, kernel sample collector
  quickstats: user commands to trace execution time of code

 include/linux/kstats.h |  61 ++++
 lib/Kconfig.debug      |   7 +
 lib/Makefile           |   1 +
 lib/kstats.c           | 659 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 728 insertions(+)
 create mode 100644 include/linux/kstats.h
 create mode 100644 lib/kstats.c

-- 
2.25.0.265.gbab2e86ba0-goog

