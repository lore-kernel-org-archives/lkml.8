Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE2CC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4840622464
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 05:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgCKFGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 01:06:53 -0400
Received: from smtprelay0027.hostedemail.com ([216.40.44.27]:42604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727184AbgCKFGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:06:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id EC692181D330D;
        Wed, 11 Mar 2020 05:06:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: earth44_1e21c7c654313
X-Filterd-Recvd-Size: 4150
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 11 Mar 2020 05:06:46 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH -next 004/491] PERFORMANCE EVENTS SUBSYSTEM: Use fallthrough;
Date:   Tue, 10 Mar 2020 21:51:18 -0700
Message-Id: <73d22360c5c665fd7f480a209ae46807dfb07bbe.1583896348.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1583896344.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the various uses of fallthrough comments to fallthrough;

Done via script
Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/kernel/perf_event_mipsxx.c | 6 +++---
 arch/x86/events/intel/core.c         | 7 +++----
 arch/x86/events/intel/lbr.c          | 2 +-
 kernel/events/core.c                 | 3 +--
 4 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf_event_mipsxx.c
index 128fc9..484948 100644
--- a/arch/mips/kernel/perf_event_mipsxx.c
+++ b/arch/mips/kernel/perf_event_mipsxx.c
@@ -790,15 +790,15 @@ static void reset_counters(void *arg)
 	case 4:
 		mipsxx_pmu_write_control(3, 0);
 		mipspmu.write_counter(3, 0);
-		/* fall through */
+		fallthrough;
 	case 3:
 		mipsxx_pmu_write_control(2, 0);
 		mipspmu.write_counter(2, 0);
-		/* fall through */
+		fallthrough;
 	case 2:
 		mipsxx_pmu_write_control(1, 0);
 		mipspmu.write_counter(1, 0);
-		/* fall through */
+		fallthrough;
 	case 1:
 		mipsxx_pmu_write_control(0, 0);
 		mipspmu.write_counter(0, 0);
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 332954..8cd3bb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4637,8 +4637,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_CORE2_MEROM:
 		x86_add_quirk(intel_clovertown_quirk);
-		/* fall through */
-
+		fallthrough;
 	case INTEL_FAM6_CORE2_MEROM_L:
 	case INTEL_FAM6_CORE2_PENRYN:
 	case INTEL_FAM6_CORE2_DUNNINGTON:
@@ -5017,7 +5016,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_FAM6_SKYLAKE_X:
 		pmem = true;
-		/* fall through */
+		fallthrough;
 	case INTEL_FAM6_SKYLAKE_L:
 	case INTEL_FAM6_SKYLAKE:
 	case INTEL_FAM6_KABYLAKE_L:
@@ -5069,7 +5068,7 @@ __init int intel_pmu_init(void)
 	case INTEL_FAM6_ICELAKE_X:
 	case INTEL_FAM6_ICELAKE_D:
 		pmem = true;
-		/* fall through */
+		fallthrough;
 	case INTEL_FAM6_ICELAKE_L:
 	case INTEL_FAM6_ICELAKE:
 	case INTEL_FAM6_TIGERLAKE_L:
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 65113b1..2e2c6fb 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -967,7 +967,7 @@ static int branch_type(unsigned long from, unsigned long to, int abort)
 			ret = X86_BR_ZERO_CALL;
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	case 0x9a: /* call far absolute */
 		ret = X86_BR_CALL;
 		break;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6a47c3..7a8ed4d5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9762,8 +9762,7 @@ perf_event_parse_addr_filter(struct perf_event *event, char *fstr,
 		case IF_SRC_KERNELADDR:
 		case IF_SRC_KERNEL:
 			kernel = 1;
-			/* fall through */
-
+			fallthrough;
 		case IF_SRC_FILEADDR:
 		case IF_SRC_FILE:
 			if (state != IF_STATE_SOURCE)
-- 
2.24.0

