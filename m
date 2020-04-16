Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158ADC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0ECE20771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503661AbgDPJNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502304AbgDPIbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:31:37 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6354C08C5F2;
        Thu, 16 Apr 2020 01:31:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOzvl-0000qT-RS; Thu, 16 Apr 2020 10:31:30 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6C99D1C03A9;
        Thu, 16 Apr 2020 10:31:29 +0200 (CEST)
Date:   Thu, 16 Apr 2020 08:31:29 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers: Update linux/vdso.h and grab a copy
 of vdso/const.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158702588903.28353.2967832668276700000.tip-bot2@tip-bot2>
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

Commit-ID:     ca64d84e93762f4e587e040a44ad9f6089afc777
Gitweb:        https://git.kernel.org/tip/ca64d84e93762f4e587e040a44ad9f6089afc777
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 14 Apr 2020 08:52:23 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 14 Apr 2020 08:55:03 -03:00

tools headers: Update linux/vdso.h and grab a copy of vdso/const.h

To get in line with:

  8165b57bca21 ("linux/const.h: Extract common header for vDSO")

And silence this tools/perf/ build warning:

  Warning: Kernel ABI header at 'tools/include/linux/const.h' differs from latest version at 'include/linux/const.h'
  diff -u tools/include/linux/const.h include/linux/const.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/const.h |  5 +----
 tools/include/vdso/const.h  | 10 ++++++++++
 tools/perf/check-headers.sh |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)
 create mode 100644 tools/include/vdso/const.h

diff --git a/tools/include/linux/const.h b/tools/include/linux/const.h
index 7b55a55..81b8aae 100644
--- a/tools/include/linux/const.h
+++ b/tools/include/linux/const.h
@@ -1,9 +1,6 @@
 #ifndef _LINUX_CONST_H
 #define _LINUX_CONST_H
 
-#include <uapi/linux/const.h>
-
-#define UL(x)		(_UL(x))
-#define ULL(x)		(_ULL(x))
+#include <vdso/const.h>
 
 #endif /* _LINUX_CONST_H */
diff --git a/tools/include/vdso/const.h b/tools/include/vdso/const.h
new file mode 100644
index 0000000..94b385a
--- /dev/null
+++ b/tools/include/vdso/const.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __VDSO_CONST_H
+#define __VDSO_CONST_H
+
+#include <uapi/linux/const.h>
+
+#define UL(x)		(_UL(x))
+#define ULL(x)		(_ULL(x))
+
+#endif /* __VDSO_CONST_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index bfb21d0..c905c68 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -23,6 +23,7 @@ include/uapi/linux/vhost.h
 include/uapi/sound/asound.h
 include/linux/bits.h
 include/linux/const.h
+include/vdso/const.h
 include/linux/hash.h
 include/uapi/linux/hw_breakpoint.h
 arch/x86/include/asm/disabled-features.h
