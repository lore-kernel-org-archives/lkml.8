Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412EBC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EA4249A5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgEHNGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730575AbgEHNFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:05:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB575C05BD09;
        Fri,  8 May 2020 06:05:46 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2h7-0007zA-TL; Fri, 08 May 2020 15:05:38 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE5581C0833;
        Fri,  8 May 2020 15:05:15 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:15 -0000
From:   "tip-bot2 for Tommi Rantala" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf cgroup: Avoid needless closing of unopened fd
Cc:     Tommi Rantala <tommi.t.rantala@nokia.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
MIME-Version: 1.0
Message-ID: <158894311574.8414.11952909768749094860.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d2e7d8636fb7d3e30aa8f894003f9e293ea62eea
Gitweb:        https://git.kernel.org/tip/d2e7d8636fb7d3e30aa8f894003f9e293ea62eea
Author:        Tommi Rantala <tommi.t.rantala@nokia.com>
AuthorDate:    Fri, 17 Apr 2020 16:23:26 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 22 Apr 2020 10:01:33 -03:00

perf cgroup: Avoid needless closing of unopened fd

Do not bother with close() if fd is not valid, just to silence valgrind:

    $ valgrind ./perf script
    ==59169== Memcheck, a memory error detector
    ==59169== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
    ==59169== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
    ==59169== Command: ./perf script
    ==59169==
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()
    ==59169== Warning: invalid file descriptor -1 in syscall close()

Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200417132330.119407-1-tommi.t.rantala@nokia.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cgroup.c b/tools/perf/util/cgroup.c
index b73fb78..050dea9 100644
--- a/tools/perf/util/cgroup.c
+++ b/tools/perf/util/cgroup.c
@@ -107,7 +107,8 @@ found:
 
 static void cgroup__delete(struct cgroup *cgroup)
 {
-	close(cgroup->fd);
+	if (cgroup->fd >= 0)
+		close(cgroup->fd);
 	zfree(&cgroup->name);
 	free(cgroup);
 }
