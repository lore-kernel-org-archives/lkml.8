Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9CDC4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAA22467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgBZOUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:20:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57921 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgBZOUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:20:44 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j6xYG-00080h-2G; Wed, 26 Feb 2020 15:20:40 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A6C181C2157;
        Wed, 26 Feb 2020 15:20:39 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:20:39 -0000
From:   "tip-bot2 for Thomas Richter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf test: Fix test trace+probe_vfs_getname.sh on s390
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200217102111.61137-1-tmricht@linux.ibm.com>
References: <20200217102111.61137-1-tmricht@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <158272683942.28353.13346247455892179046.tip-bot2@tip-bot2>
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

Commit-ID:     2bbc83537614517730e9f2811195004b712de207
Gitweb:        https://git.kernel.org/tip/2bbc83537614517730e9f2811195004b712de207
Author:        Thomas Richter <tmricht@linux.ibm.com>
AuthorDate:    Mon, 17 Feb 2020 11:21:11 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 18 Feb 2020 10:13:28 -03:00

perf test: Fix test trace+probe_vfs_getname.sh on s390

This test places a kprobe to function getname_flags() in the kernel
which has the following prototype:

  struct filename *getname_flags(const char __user *filename, int flags, int *empty)

The 'filename' argument points to a filename located in user space memory.

Looking at commit 88903c464321c ("tracing/probe: Add ustring type for
user-space string") the kprobe should indicate that user space memory is
accessed.

Output before:

   [root@m35lp76 perf]# ./perf test 66 67
   66: Use vfs_getname probe to get syscall args filenames   : FAILED!
   67: Check open filename arg using perf trace + vfs_getname: FAILED!
   [root@m35lp76 perf]#

Output after:

   [root@m35lp76 perf]# ./perf test 66 67
   66: Use vfs_getname probe to get syscall args filenames   : Ok
   67: Check open filename arg using perf trace + vfs_getname: Ok
   [root@m35lp76 perf]#

Comments from Masami Hiramatsu:

This bug doesn't happen on x86 or other archs on which user address
space and kernel address space is the same. On some arches (ppc64 in
this case?) user address space is partially or completely the same as
kernel address space.

(Yes, they switch the world when running into the kernel) In this case,
we need to use different data access functions for each space.

That is why I introduced the "ustring" type for kprobe events.

As far as I can see, Thomas's patch is sane. Thomas, could you show us
your result on your test environment?

Comments from Thomas Richter:

Test results for s/390 included above.

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200217102111.61137-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 7cb99b4..c2cc42d 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -14,7 +14,7 @@ add_probe_vfs_getname() {
 	if [ $had_vfs_getname -eq 1 ] ; then
 		line=$(perf probe -L getname_flags 2>&1 | egrep 'result.*=.*filename;' | sed -r 's/[[:space:]]+([[:digit:]]+)[[:space:]]+result->uptr.*/\1/')
 		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
-		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:string"
+		perf probe $verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
 	fi
 }
 
