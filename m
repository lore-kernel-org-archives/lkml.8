Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7677CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E162074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883110;
	bh=vTilJT7sSfr6FjNGlvX9bZpL9rzwrQ7T9O6h9ya2LFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XTktcWeK2o9Gn4kH7fU+wQ+Vr28GtPmMRCKHUjIQUZ81VqI8nz5afQVM8jkjM/vCl
	 6t60p6Ku2Y8yfeRxwdHEe4326/7XV4Mqfsnjv51XmZaJnIttMzaC25qgK1iQIheVDy
	 CzjHkDtcc1U9Jkc+4IQ2VZXvq9V2ZZH6mix2QZWA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502270AbgDNQvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440401AbgDNQtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DCFC32074D;
        Tue, 14 Apr 2020 16:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882953;
        bh=vTilJT7sSfr6FjNGlvX9bZpL9rzwrQ7T9O6h9ya2LFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QOB4089nemdYQa+eI5eY+Gj9BAbGvG+2oRZ1BiaXCTV35XyLpONezX9iHMA/hlIel
         j/ycYpyWhz5kP3nOgCcFNJjA/OIQpmfByu7RkUk+iccPN+z270B7rGrxbmllre/O6g
         AEKVtdEesEujEAGzR++sGymBhBvBPZ8tnaQcWjJQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: [PATCH 04/15] tools headers: Update linux/vdso.h and grab a copy of vdso/const.h
Date:   Tue, 14 Apr 2020 13:48:43 -0300
Message-Id: <20200414164854.26026-5-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index 7b55a55f5911..81b8aae5a855 100644
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
index 000000000000..94b385ad438d
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
index bfb21d049e6c..c905c683606a 100755
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
-- 
2.21.1

