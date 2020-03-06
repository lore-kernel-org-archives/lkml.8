Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351E9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 080B920675
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583521953;
	bh=eKN4y81vfxJtOm3uTRe+eoZlCNjMOJ3iGso6q9jjdVw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r/cl45mg9Z8Vd65IMK5sP3cqBJe8nqyGaavHjVuH+VioXVLnt1Ue3WDHgaktDsDgL
	 Bd2re155NUq4dqOCFMhcyh+4cWBp01oxWUOEgX/fqqOgY25+duLsEAk9jrwcwkdU+I
	 o3QGx4YBasCu9zCSok0olYLFd6KeL6iPrtyzXDVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbgCFTMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:12:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:39424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgCFTMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2456E206CC;
        Fri,  6 Mar 2020 19:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583521936;
        bh=eKN4y81vfxJtOm3uTRe+eoZlCNjMOJ3iGso6q9jjdVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0yKRYXA4yQv6P5LMY8eM7hyCPxGACK5LAzH7KQQYu8Z+n3/Qt1/9fUgfMxHSb5t4/
         z5kYA9nuLFN8BVvB0Qfj+tS33E76Wrh2B2a0dhHXckTZICVsKqWqgW6TTQoWEwhaSX
         A9ft6lNvq1tk/oCQTRBfJIHcPTKKtXuS1wh7vPTQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 4/6] perf bench: Clear struct sigaction before sigaction() syscall
Date:   Fri,  6 Mar 2020 16:11:40 -0300
Message-Id: <20200306191144.12762-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tommi Rantala <tommi.t.rantala@nokia.com>

Avoid garbage in sigaction structs used in sigaction() syscalls.
Valgrind is complaining about it.

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/20200305083714.9381-4-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/bench/epoll-ctl.c           | 1 +
 tools/perf/bench/epoll-wait.c          | 1 +
 tools/perf/bench/futex-hash.c          | 1 +
 tools/perf/bench/futex-lock-pi.c       | 1 +
 tools/perf/bench/futex-requeue.c       | 1 +
 tools/perf/bench/futex-wake-parallel.c | 1 +
 tools/perf/bench/futex-wake.c          | 1 +
 7 files changed, 7 insertions(+)

diff --git a/tools/perf/bench/epoll-ctl.c b/tools/perf/bench/epoll-ctl.c
index a7526c05df38..cadc18d42aa4 100644
--- a/tools/perf/bench/epoll-ctl.c
+++ b/tools/perf/bench/epoll-ctl.c
@@ -312,6 +312,7 @@ int bench_epoll_ctl(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/epoll-wait.c b/tools/perf/bench/epoll-wait.c
index d1c5cb526b9f..f938c585d512 100644
--- a/tools/perf/bench/epoll-wait.c
+++ b/tools/perf/bench/epoll-wait.c
@@ -426,6 +426,7 @@ int bench_epoll_wait(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 21776862e940..65eebe06c04d 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -137,6 +137,7 @@ int bench_futex_hash(int argc, const char **argv)
 	if (!cpu)
 		goto errmem;
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-lock-pi.c b/tools/perf/bench/futex-lock-pi.c
index 30d97121dc4f..89fd8f325f38 100644
--- a/tools/perf/bench/futex-lock-pi.c
+++ b/tools/perf/bench/futex-lock-pi.c
@@ -160,6 +160,7 @@ int bench_futex_lock_pi(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index a00a6891447a..7a15c2e61022 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -128,6 +128,7 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "cpu_map__new");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index a053cf2b7039..cd2b81a845ac 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -234,6 +234,7 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 		exit(EXIT_FAILURE);
 	}
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 58906e9499bb..2dfcef3e371e 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -136,6 +136,7 @@ int bench_futex_wake(int argc, const char **argv)
 	if (!cpu)
 		err(EXIT_FAILURE, "calloc");
 
+	memset(&act, 0, sizeof(act));
 	sigfillset(&act.sa_mask);
 	act.sa_sigaction = toggle_done;
 	sigaction(SIGINT, &act, NULL);
-- 
2.21.1

