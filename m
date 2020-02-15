Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A9C4741C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BA9246A3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 08:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgBOImB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 03:42:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56775 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgBOImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 03:42:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j2t1P-0005Fx-GB; Sat, 15 Feb 2020 09:41:55 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 26E511C2039;
        Sat, 15 Feb 2020 09:41:50 +0100 (CET)
Date:   Sat, 15 Feb 2020 08:41:49 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf trace: Resolve prctl's 'option' arg strings
 to numbers
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mike Christie <mchristi@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158175610991.13786.8051798173112946702.tip-bot2@tip-bot2>
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

Commit-ID:     d7a07b293216e5561705303751bc0d213e9fb328
Gitweb:        https://git.kernel.org/tip/d7a07b293216e5561705303751bc0d213e9fb328
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 11 Feb 2020 15:54:08 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 11 Feb 2020 16:41:50 -03:00

perf trace: Resolve prctl's 'option' arg strings to numbers

  # perf trace -e syscalls:sys_enter_prctl --filter="option==SET_NAME"
     0.000 Socket Thread/3860 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7fc50b9733e8)
     0.053 SSL Cert #78/3860 syscalls:sys_enter_prctl(option: SET_NAME, arg2: 0x7fc50b9733e8)
^C  #

If one uses '-v' with 'perf trace', we can see the filter it puts in
place:

  New filter for syscalls:sys_enter_prctl: (option==0xf) && (common_pid != 3859 && common_pid != 2757)

We still need to allow using plain '-e prctl' and have this turn into
creating a 'syscalls:sys_enter_prctl' event so that the filter can be
applied only to it as right now '-e prctl' ends up using the
'raw_syscalls:sys_enter/sys_exit'.

The end goal is to have something like:

  # perf trace -e prctl/option==SET_NAME/

And have that use tracepoint filters or eBPF ones.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mike Christie <mchristi@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 46a72ec..01d5420 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1065,7 +1065,9 @@ static struct syscall_fmt syscall_fmts[] = {
 	{ .name	    = "poll", .timeout = true, },
 	{ .name	    = "ppoll", .timeout = true, },
 	{ .name	    = "prctl",
-	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */ },
+	  .arg = { [0] = { .scnprintf = SCA_PRCTL_OPTION, /* option */
+			   .strtoul   = STUL_STRARRAY,
+			   .parm      = &strarray__prctl_options, },
 		   [1] = { .scnprintf = SCA_PRCTL_ARG2, /* arg2 */ },
 		   [2] = { .scnprintf = SCA_PRCTL_ARG3, /* arg3 */ }, }, },
 	{ .name	    = "pread", .alias = "pread64", },
