Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996C3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693022465E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XveByeXa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCBPJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:09:20 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41954 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgCBPJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:09:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id l21so126658qtr.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 07:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+apLJWjExJ8VxuyjBvnXQYOfQQ8hl3/eahyCF3FSk1E=;
        b=XveByeXagNMtDfoeCVfKPZG8GU9ry2ifaOzGK1rI3omR6I79KNRQ0UGmMh0D/YGvRR
         MaJsfi2GNKxEyiQh18k+jMY0yj/X1D2eqDhZwb9IuRKjs4GeVQicV/5HfNbiOZh7oBO+
         yw45vyG7tf7mPQYZJTNBH1yQrpLPvcqY3KxrKc3YlqDZW2Cph4fEDYSVuJ872p0xL787
         3ftkQ9J9Lg2M6KMc/0NSoLBdopkX2ADzSIc3UnDlrEOMB136MRrCFURECJCWWVGSQ58C
         neOlfO6Fkbq9AzArEPb+PeDkEPlZiVBMQON4Ro6BqzDsyFKppl2vhVXWikeH1bTpnlGx
         fgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+apLJWjExJ8VxuyjBvnXQYOfQQ8hl3/eahyCF3FSk1E=;
        b=JG6mZGc51BGHyuSzuM9Sdj6PNuKQKcAe9T53YfWdTO2OtV1C7JFTQ5PtAcTDuK5NiW
         lHL/cxvaNdl5Bbd4ERMSk0+6UWhENGhtAZyOT5eSDZTbHcXrFTK5qjm9sizNh14uULgM
         niQ8XhTPajtEWqCStP4FkUEQw9/z3Bd+5pmIvuJSVCmTxwOpaHcJ98bQswUUEwfmahvr
         uxvQaADmuTytXVtbIlfjeW2O3JiPQWHMr/xlFRFOKO9ylA1LLUWVS3h3HLn/xdDbu2bM
         a2pL04DIui65RDjsxrGwgS6sUYVpBEA8uoOdPbcq3mEBAHP68337cXZYEB7vWtSM+Tge
         GkvQ==
X-Gm-Message-State: ANhLgQ365Arsf0MdB7mD6aVmGFQtzHMB4/ViaPUrz8fCVHiGqT+7qu0u
        5AoAy7+smY4uqTvACrTIfULQJsp3GtA=
X-Google-Smtp-Source: ADFU+vviJh0ACosKvaEPyG2THPSoekQINBEK8CkLUfOqGD7cBsDsvfQbKkKnuBnkj47pvsVUXOuTQw==
X-Received: by 2002:ac8:f95:: with SMTP id b21mr197270qtk.50.1583161757229;
        Mon, 02 Mar 2020 07:09:17 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id l20sm47401qtu.22.2020.03.02.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 07:09:16 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 80655403AD; Mon,  2 Mar 2020 12:09:14 -0300 (-03)
Date:   Mon, 2 Mar 2020 12:09:14 -0300
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf bench: Share 'start', 'end', 'runtime' global vars
Message-ID: <20200302150914.GB28183@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Noticed with gcc 10 (fedora rawhide) that those variables were
not being declared as static, so end up with:

ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `end'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `start'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
ld: /tmp/build/perf/bench/epoll-wait.o:/git/perf/tools/perf/bench/epoll-wait.c:93: multiple definition of `runtime'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `end'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `start'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
ld: /tmp/build/perf/bench/epoll-ctl.o:/git/perf/tools/perf/bench/epoll-ctl.c:38: multiple definition of `runtime'; /tmp/build/perf/bench/futex-hash.o:/git/perf/tools/perf/bench/futex-hash.c:40: first defined here
make[4]: *** [/git/perf/tools/build/Makefile.build:145: /tmp/build/perf/bench/perf-in.o] Error 1

	Just prefixing them with 'extern' in all but one (futex-hash.c)
seems to be enough, ok?

- Arnaldo

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index bb617e568841..8a7681fca8ab 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -35,7 +35,7 @@
 
 static unsigned int nthreads = 0;
 static unsigned int nsecs    = 8;
-struct timeval start, end, runtime;
+extern struct timeval start, end, runtime;
 static bool done, __verbose, randomize;
 
 /*
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index 7af694437f4e..170b96938275 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -90,7 +90,7 @@
 
 static unsigned int nthreads = 0;
 static unsigned int nsecs    = 8;
-struct timeval start, end, runtime;
+extern struct timeval start, end, runtime;
 static bool wdone, done, __verbose, randomize, nonblocking;
 
 /*
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index d0cae8125423..253ae62e618d 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -37,7 +37,7 @@ static bool silent = false, multi = false;
 static bool done = false, fshared = false;
 static unsigned int nthreads = 0;
 static int futex_flag = 0;
-struct timeval start, end, runtime;
+extern struct timeval start, end, runtime;
 static pthread_mutex_t thread_lock;
 static unsigned int threads_starting;
 static struct stats throughput_stats;
