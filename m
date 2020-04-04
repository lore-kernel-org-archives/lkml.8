Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2904DC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66D620739
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 08:42:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDDImC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 04:42:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41475 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgDDIl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 04:41:56 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN2-0000uW-Dy; Sat, 04 Apr 2020 10:41:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F38711C0243;
        Sat,  4 Apr 2020 10:41:39 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:39 -0000
From:   "tip-bot2 for Andreas Gerstmayr" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf script: Fix invalid read of directory entry
 after closedir()
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402124337.419456-1-agerstmayr@redhat.com>
References: <20200402124337.419456-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Message-ID: <158598969966.28353.9977084020476897493.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     27486a85cb65bd258a9a213b3e95bdf8c24fd781
Gitweb:        https://git.kernel.org/tip/27486a85cb65bd258a9a213b3e95bdf8c24fd781
Author:        Andreas Gerstmayr <agerstmayr@redhat.com>
AuthorDate:    Thu, 02 Apr 2020 14:43:38 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 10:03:18 -03:00

perf script: Fix invalid read of directory entry after closedir()

closedir(lang_dir) frees the memory of script_dirent->d_name, which
gets accessed in the next line in a call to scnprintf().

Valgrind report:

  Invalid read of size 1
  ==413557==    at 0x483CBE6: strlen (vg_replace_strmem.c:461)
  ==413557==    by 0x4DD45FD: __vfprintf_internal (vfprintf-internal.c:1688)
  ==413557==    by 0x4DE6679: __vsnprintf_internal (vsnprintf.c:114)
  ==413557==    by 0x53A037: vsnprintf (stdio2.h:80)
  ==413557==    by 0x53A037: scnprintf (vsprintf.c:21)
  ==413557==    by 0x435202: get_script_path (builtin-script.c:3223)
  ==413557==  Address 0x52e7313 is 1,139 bytes inside a block of size 32,816 free'd
  ==413557==    at 0x483AA0C: free (vg_replace_malloc.c:540)
  ==413557==    by 0x4E303C0: closedir (closedir.c:50)
  ==413557==    by 0x4351DC: get_script_path (builtin-script.c:3222)

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200402124337.419456-1-agerstmayr@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 186ebf8..1f57a7e 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -3265,10 +3265,10 @@ static char *get_script_path(const char *script_root, const char *suffix)
 			__script_root = get_script_root(script_dirent, suffix);
 			if (__script_root && !strcmp(script_root, __script_root)) {
 				free(__script_root);
-				closedir(lang_dir);
 				closedir(scripts_dir);
 				scnprintf(script_path, MAXPATHLEN, "%s/%s",
 					  lang_path, script_dirent->d_name);
+				closedir(lang_dir);
 				return strdup(script_path);
 			}
 			free(__script_root);
