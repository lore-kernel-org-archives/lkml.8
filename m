Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC433C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF1524688
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GFvTYLsE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBZNuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:50:37 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:40261 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgBZNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:50:36 -0500
Received: by mail-pj1-f73.google.com with SMTP id ev1so2035294pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 05:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PYZaUdOqYqx4M6998+NOPh3hPZwThKUsmp2WTmT8hDA=;
        b=GFvTYLsE6VDPPWH5nvS1z761QY8oQVdzcepn+Uk4V6pSJIY8x5BmlLNo/agcXyeXzV
         YMULG18hCo/qyYwo5OiiDQGEjXv8uqa0gQ/0Ptu7HmLC2hIxy/AWGM8mfU4j/kLQjKSW
         WYZ3pkWXAqSd4VorOaBWeettOfQEh++HKQRfPiBzjd1UJRc3hM4Rx5HOCq8+zbd5j43O
         uzLfn+1XDdwq00dXVDyEYBxxJ/DB+NyehSCXLHvjW2pM3N6OpAcIO44/0EmtyNmWRu+f
         I6Dc1i0xhn/ObfBCIS7x1HNlBhojCeLGqAmF7aR6irvWcK/+u27Y1EzKWmROPuT724AQ
         DFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PYZaUdOqYqx4M6998+NOPh3hPZwThKUsmp2WTmT8hDA=;
        b=Mzxo4iypMmSgN0sw44IXNeZxDwYWCNgyuJHLmg8fjOfcw2FRq89af0ROLmsWJDQrzm
         RQqDyRKe1xP6PXomwlhtaQEfunFpputLF7/XC/ZlT4Q1nBBSqzadkIVLIOrPHVtDgG7Y
         iCFzFAzjMhI3UGJ9Hu+xQ1nNKLrJaQ3CFDmGUY38S+xyfIyKoimy+xy9q5xXfjBTMIk3
         rgacqWBUcwqPG1AD9S6t946wO4y3eRhLMqusRKTSFUZD5BPb6T++Qf0+CKsDcpMpYDWC
         4UH8DoYuKrMfWR3ESAeodZcfZYPSi4mUHtCCLc+Zdc2axy+OsRwb9S75QfMgAZHS6kCm
         ZPew==
X-Gm-Message-State: APjAAAXJFnKjIDGZavkvkMVO8fH3hlL16ZE17rZHrJNDVvJaEwtX9QGg
        0mrcWeBYBmTP79P5rAXqTAXFI82OiFaIBzW7v4enUcZl/dvqxnDVX0yKuKM5EhMqJ3CROQuQ0rV
        6NOQ1YECqOhoKYBcW14SQsg/mQ3gZlkZ37t/5QkLtc8O9U32hafHe/xhq+24SWnjyJkIxKg==
X-Google-Smtp-Source: APXvYqye8A19uNOX+jLwoB4yhTW2bInNRJ+acwtHbEP42877tnEa9WL7/VrbS3llv5gyotzBS7nUX2Kf1bM=
X-Received: by 2002:a65:6718:: with SMTP id u24mr4088545pgf.289.1582725035541;
 Wed, 26 Feb 2020 05:50:35 -0800 (PST)
Date:   Wed, 26 Feb 2020 05:50:25 -0800
Message-Id: <20200226135027.34538-1-lrizzo@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH v3 0/2] kstats: kernel metric collector
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

This v3 series addresses some initial comments (mostly style fixes in the
code) and revises commit logs.

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

