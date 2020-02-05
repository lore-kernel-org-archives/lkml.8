Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FFDC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D99222C2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgBEPpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:45:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35844 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgBEPpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:45:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1izMrR-0004Qe-No; Wed, 05 Feb 2020 16:45:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 68D431C1EC5;
        Wed,  5 Feb 2020 16:45:05 +0100 (CET)
Date:   Wed, 05 Feb 2020 15:45:05 -0000
From:   "tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf probe: Add ustring support for perf probe command
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, sumanthk@linux.ibm.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200120132011.64698-2-tmricht@linux.ibm.com>
References: <20200120132011.64698-2-tmricht@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158091750519.411.12825187466008183227.tip-bot2@tip-bot2>
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

Commit-ID:     1873f1547dde65c687de143938581347a9312207
Gitweb:        https://git.kernel.org/tip/1873f1547dde65c687de143938581347a9312207
Author:        Thomas Richter <tmricht@linux.ibm.com>
AuthorDate:    Mon, 20 Jan 2020 14:20:10 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 31 Jan 2020 09:33:58 +01:00

perf probe: Add ustring support for perf probe command

Kernel commit 88903c464321 ("tracing/probe: Add ustring type for user-space string")
adds support for user-space strings when type 'ustring' is specified.

Here is an example using sysfs command line interface
for kprobes:

Function to probe:
  struct filename *
  getname_flags(const char __user *filename, int flags, int *empty)

Setup:
  # cd /sys/kernel/debug/tracing/
  # echo 'p:tmr1 getname_flags +0(%r2):ustring' > kprobe_events
  # cat events/kprobes/tmr1/format | fgrep print
  print fmt: "(%lx) arg1=\"%s\"", REC->__probe_ip, REC->arg1
  # echo 1 > events/kprobes/tmr1/enable
  # touch /tmp/111
  # echo 0 > events/kprobes/tmr1/enable
  # cat trace|fgrep /tmp/111
  touch-5846  [005] d..2 255520.717960: tmr1:\
	  (getname_flags+0x0/0x400) arg1="/tmp/111"

Doing the same with the perf tool fails.
Using type 'string' succeeds:
 # perf probe "vfs_getname=getname_flags:72 pathname=filename:string"
 Added new event:
   probe:vfs_getname (on getname_flags:72 with pathname=filename:string)
   ....
 # perf probe -d probe:vfs_getname
 Removed event: probe:vfs_getname

However using type 'ustring' fails (output before):
 # perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
 Failed to write event: Invalid argument
   Error: Failed to add events.
 #

Fix this by adding type 'ustring' in function
convert_variable_type().

Using ustring succeeds (output after):
 # ./perf probe "vfs_getname=getname_flags:72 pathname=filename:ustring"
 Added new event:
   probe:vfs_getname (on getname_flags:72 with pathname=filename:ustring)

 You can now use it in all perf tools, such as:

	perf record -e probe:vfs_getname -aR sleep 1

 #

Note: This issue also exists on x86, it is not s390 specific.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: sumanthk@linux.ibm.com
Link: http://lore.kernel.org/lkml/20200120132011.64698-2-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-finder.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index c470c49..1c817ad 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -303,7 +303,8 @@ static int convert_variable_type(Dwarf_Die *vr_die,
 	char prefix;
 
 	/* TODO: check all types */
-	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "x") != 0 &&
+	if (cast && strcmp(cast, "string") != 0 && strcmp(cast, "ustring") &&
+	    strcmp(cast, "x") != 0 &&
 	    strcmp(cast, "s") != 0 && strcmp(cast, "u") != 0) {
 		/* Non string type is OK */
 		/* and respect signedness/hexadecimal cast */
