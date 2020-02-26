Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BC3C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D24D2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAiEwNKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgBZNqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:46:46 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:35842 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgBZNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:46:46 -0500
Received: by mail-pj1-f73.google.com with SMTP id m61so2043887pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 05:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=qeSh50iw2mfGwCVy8a6hYA44UG8luPXQGKb+YPVPRpk=;
        b=ZAiEwNKr7fkZcNBKQPqqQhDt4zbN5d2YaTnEL33HQlp2rROu6W6T6qRVf3H3DexcwC
         7hv1Yt1NAwo/4R9HMvtS67Y+aYU76cMDvz4uAbSP26Wcq9lQoET3FxmyQ2ALIGBKaIU6
         6JB4mGEeT4ikFHRpDaJddOub471mvuiVqFRtr0wuFZsmOs+QDdKH6hmUe9Ioc9odsqcO
         Fo3mROTi9PlKNhtlTKNnJv1g2RbHWtwOrkD5KH42ppYodOuBb4GkGphYkvnJY1BuotNL
         7Di9MUE3VhC1sLbq7Sgjmh5ISPZOgYToa9AJWe0MFszX+E6l39BhUGvcTEuPJx0f0x/I
         JTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=qeSh50iw2mfGwCVy8a6hYA44UG8luPXQGKb+YPVPRpk=;
        b=dMeYOjBHURWovZQCi7BDHXGH8ZbQy7aXsoY30HIA+CdRVaPeQI0nhWP/zZmJSqU7zA
         Xz1SfJgUd4an0AiozPpTmQelb3rtuh8FsmPRpgRMbdmRCX12aBzEvUVfAiw16LVTWR3K
         G/6tVCwbDnx1hU3/iGBxnoECui2UQYFEoWcyb4vakhpuaSt+gPd3zRItlON6S+pGuAdM
         szloNjIZUSCJzNWC8hn8mSHGCKW4wmd8LnmQhiui4H846mBfQlm7J7vLr0ZdDY51uhCF
         HLS6g0HnoJfcBE0zsIDKgfGmrnTxFsSf1lPfFSGrYDQbSP4nHpuv21jeS5naEHky8rVu
         6OrQ==
X-Gm-Message-State: APjAAAVlHqJ36WkU+lkkqoigP3r3NgMXmR6Ytb/YosxGCWNDKsJn/DVE
        rC8TGjZb8hXEP67bF0Uc/6pyBEZhMlu6CODeX2bInBd1Z74mRx0jUE+qzEDH0Q9g3sw+2hq7c+2
        c0iRfDvnCZcuBb+IIn0uy172oAe+xreyR/i3Anlc24vLhUXue/GPUp12C5h4nw7onEDlz1g==
X-Google-Smtp-Source: APXvYqxFpeSSovjauaZECVwcq2haINB2tMT/4UzZFL+R2QzXBrseLFvAkMgarO+cuxH6Q2Tfs+X4fCU4EKQ=
X-Received: by 2002:a63:d241:: with SMTP id t1mr3822851pgi.283.1582724804738;
 Wed, 26 Feb 2020 05:46:44 -0800 (PST)
Date:   Wed, 26 Feb 2020 05:46:35 -0800
Message-Id: <20200226134637.31670-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v2 0/2] kstats: kernel metric collector
From:   Luigi Rizzo <lrizzo@google.com>
To:     linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        naveen.n.rao@linux.ibm.com, ardb@kernel.org, rizzo@iet.unipi.it,
        pabeni@redhat.com, giuseppe.lettieri@unipi.it, toke@redhat.com,
        hawk@kernel.org, mingo@redhat.com, acme@kernel.org,
        rostedt@goodmis.org, peterz@infradead.org
Cc:     Luigi Rizzo <lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset introduces a small library to collect per-cpu samples and
accumulate distributions to be exported through debugfs.

Note that use case and performance are orthogonal to those of the
perf/tracing architecture, which is why this is proposed as a standalone
component.

I have used this to trace the execution times of small sections of code
(network stack functions, drivers and xdp processing, ...), whole functions,
or notification latencies (e.g. IPI dispatch, etc.).  The fine granularity
of the aggregation helps identifying outliers, multimodal distributions,
caching effects and general performance-related issues.

Samples are 64-bit values that are aggregated into per-cpu logarithmic buckets
with configurable density (typical sample collectors use one buckets for
each power of 2, powers of 2, but that is very coarse and corresponds
to 1 significant bit per value; in quickstats one can specify the number
of significant bits, up to 5, which is useful for finer grain measurements).

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

Writing STOP, START, RESET to the file executes the corresponding action

	echo RESET > /sys/kernel/debug/kstats/foo

The second instrumentation mechanism uses kretrprobes or tracepoints and
lets tracing be enabled or removed at runtime from the command line for
any globally visible function

	echo trace some_function bits 3 > /sys/kernel/debug/kstats/_control

Data are exported or controlled in the same way as above. Accuracy is
worse due to the presence of kretprobe trampolines: 90ns with hot cache,
500ns with cold cache. The overhead on the traced function is 250ns hot,
1500ns cold.

Hope you find this useful.


Luigi Rizzo (2):
  kstats: kernel metric collector
  kstats: kretprobe and tracepoint support

 include/linux/kstats.h |  62 ++++
 lib/Kconfig.debug      |   7 +
 lib/Makefile           |   1 +
 lib/kstats.c           | 654 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 724 insertions(+)
 create mode 100644 include/linux/kstats.h
 create mode 100644 lib/kstats.c

-- 
2.25.0.265.gbab2e86ba0-goog

