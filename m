Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD759C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30082073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGwRh67I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgCFHLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:11:19 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:52568 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgCFHLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:11:19 -0500
Received: by mail-vs1-f74.google.com with SMTP id f5so102113vsl.19
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 23:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TpuZ8/QnXNSoGEeK+/muFq4adN3Yp5MgzNXJiGkWsjQ=;
        b=OGwRh67IRKM1ml5sBA5LK88dCaDe3mJGfWcTzyhjeXoXXgVndXpk9ahmkLp1My4LTo
         U9qIBk/YITEVIhbaYZKLZyCTl+3C8U7/QljEtPqeIvbNZQwxDCAs8bkSbiExkM6HMkrM
         2McTy5dTz9cDKa6Rc+I4LOZPfIz/ZrNxmkBlxuB4mbZll0J5sfFMLMEH/rMnaul5O1Rh
         Yu5PDB8GL5Y1RcstgRQdwZoe5qAkB1/YoZXArJPidVMjJx3cPRWbT5/s+8Jd91qnZJ+Q
         clhW4velQJJ1zlNqHBDmoGG2MyV6vnPTWVG4JEk3magbWZ6tLIQHY5+5vRzR/8SA/I6t
         X5wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TpuZ8/QnXNSoGEeK+/muFq4adN3Yp5MgzNXJiGkWsjQ=;
        b=ICYLAgfo0jSEG5GVMwO90fBPiBwk+6u9Z5NNLiwUoPhdWvqUJ1y8wLlIRfqE3TioIs
         oxhz3TQvEu7UNY7v+6xDUBS3L9Szr1MZaP0x5JV84XxGRrjmj7BW9EK0mzT6pbk3RwP3
         ebch6ipfPIBk73tJw1rgkQtdaJHee+uhuJPsjx489sxziCmFTirfwXC36aZSRt9hQbc8
         hKOCotcF5D5Hyw0dv4FperL9O+682Esac5fjZQzyQeiH5zSh0zsXXb6f9uGDWnFXFALc
         RRNDDnZeGtktpNhGmoxtbeiNQZIQrknmA3L6KtG9pXCbXFQBdArg0XB9yFIJV2tOkgUA
         KU9Q==
X-Gm-Message-State: ANhLgQ1h3HgOe3S7BfJc982WpDobZTY0sB9GZd8RoX7lGjyT1DEVzovJ
        Q+VMSHAzbbXQk3ap+rrrm8PbeGyHQAlJ
X-Google-Smtp-Source: ADFU+vtpZalFJVB8LanB+jLXjcP3/+ERgAyir0fmfACRj5QJ5x/HUXeu7jHwlqr61CbqsJpQqarS0DEyqKxx
X-Received: by 2002:a67:ecd5:: with SMTP id i21mr1362248vsp.166.1583478678040;
 Thu, 05 Mar 2020 23:11:18 -0800 (PST)
Date:   Thu,  5 Mar 2020 23:11:07 -0800
Message-Id: <20200306071110.130202-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH 0/3] perf tool: build related fixes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Li <liwei391@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches better enable a build of perf when not using the regular
Makefiles, in my case using bazel.

Ian Rogers (3):
  tools: fix off-by 1 relative directory includes
  libperf: avoid redefining _GNU_SOURCE in test
  tools/perf: build fixes for arch_errno_names.sh

 tools/include/uapi/asm/errno.h              | 14 +++++-----
 tools/lib/perf/tests/test-evlist.c          |  2 ++
 tools/perf/arch/arm64/util/arm-spe.c        | 20 +++++++-------
 tools/perf/arch/arm64/util/perf_regs.c      |  2 +-
 tools/perf/arch/powerpc/util/perf_regs.c    |  4 +--
 tools/perf/arch/x86/util/auxtrace.c         | 14 +++++-----
 tools/perf/arch/x86/util/event.c            | 12 ++++-----
 tools/perf/arch/x86/util/header.c           |  4 +--
 tools/perf/arch/x86/util/intel-bts.c        | 24 ++++++++---------
 tools/perf/arch/x86/util/intel-pt.c         | 30 ++++++++++-----------
 tools/perf/arch/x86/util/machine.c          |  6 ++---
 tools/perf/arch/x86/util/perf_regs.c        |  8 +++---
 tools/perf/arch/x86/util/pmu.c              |  6 ++---
 tools/perf/trace/beauty/arch_errno_names.sh |  4 +--
 14 files changed, 76 insertions(+), 74 deletions(-)

-- 
2.25.1.481.gfbce0eb801-goog

