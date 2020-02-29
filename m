Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61943C3F2D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42629246CB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 09:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgB2JRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 04:17:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38841 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgB2JRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 04:17:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j7yEu-0005u4-PY; Sat, 29 Feb 2020 10:16:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9088D1C219E;
        Sat, 29 Feb 2020 10:16:51 +0100 (CET)
Date:   Sat, 29 Feb 2020 09:16:51 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@suse.de>, Jiri Olsa <jolsa@kernel.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158296781131.28353.6184599188781210087.tip-bot2@tip-bot2>
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

Commit-ID:     d8e3ee2e2b4ef36d7be3dd8a8fb6e136f2661203
Gitweb:        https://git.kernel.org/tip/d8e3ee2e2b4ef36d7be3dd8a8fb6e136f2661203
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 27 Feb 2020 09:23:35 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 27 Feb 2020 09:49:56 -03:00

tools arch x86: Sync the msr-index.h copy with the kernel sources

To pick up the changes from these csets:

  21b5ee59ef18 ("x86/cpu/amd: Enable the fixed Instructions Retired counter IRPERF")

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ git diff
  diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
  index ebe1685e92dd..d5e517d1c3dd 100644
  --- a/tools/arch/x86/include/asm/msr-index.h
  +++ b/tools/arch/x86/include/asm/msr-index.h
  @@ -512,6 +512,8 @@
   #define MSR_K7_HWCR                    0xc0010015
   #define MSR_K7_HWCR_SMMLOCK_BIT                0
   #define MSR_K7_HWCR_SMMLOCK            BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
  +#define MSR_K7_HWCR_IRPERF_EN_BIT      30
  +#define MSR_K7_HWCR_IRPERF_EN          BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
   #define MSR_K7_FID_VID_CTL             0xc0010041
   #define MSR_K7_FID_VID_STATUS          0xc0010042
  $

That don't result in any change in tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  $

To silence this perf build warning:

  Warning: Kernel ABI header at 'tools/arch/x86/include/asm/msr-index.h' differs from latest version at 'arch/x86/include/asm/msr-index.h'
  diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index ebe1685..d5e517d 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -512,6 +512,8 @@
 #define MSR_K7_HWCR			0xc0010015
 #define MSR_K7_HWCR_SMMLOCK_BIT		0
 #define MSR_K7_HWCR_SMMLOCK		BIT_ULL(MSR_K7_HWCR_SMMLOCK_BIT)
+#define MSR_K7_HWCR_IRPERF_EN_BIT	30
+#define MSR_K7_HWCR_IRPERF_EN		BIT_ULL(MSR_K7_HWCR_IRPERF_EN_BIT)
 #define MSR_K7_FID_VID_CTL		0xc0010041
 #define MSR_K7_FID_VID_STATUS		0xc0010042
 
