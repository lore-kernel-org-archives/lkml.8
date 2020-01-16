Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CF2C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0502077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579182524;
	bh=sxIYoP7Q2YrsXOkrgiWQCH36ACzK8aXJadFG+XAro8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p0nQgXCGHp3o6GwV/i1P83N7b7TkkWol4YoBIYX3BZ7lQZuACfuXwSRklhI8nqYRu
	 N/jCcz21GNO34pWVyV6b+wdtd1FP7g2ZE4N/aUaDsUYj/HMSlxr8CIEy53N8Rqjh8i
	 S2ZA97MAXYQ31lBut9F24JiktExU540fKK7Sj1vU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbgAPNsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:48:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:49904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgAPNsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:48:42 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D9C2081E;
        Thu, 16 Jan 2020 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579182521;
        bh=sxIYoP7Q2YrsXOkrgiWQCH36ACzK8aXJadFG+XAro8Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KHz8xVvEqI7B+ga9Qd0Zm1rjOhfcMe9/hXxT0I6kliYeeVJlbT+5e03AtWpW1adzg
         NFSoY+mjpiq0gBBTwjUUHdDkm1rSKswlCnlCHIeh2AXk8fgimKCH174700FtUX56or
         b2xFpl6A80aiRGJRaSX7I7cuMTSpyKrsqEZhMNKk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 05/12] perf report: Fix no libunwind compiled warning break s390 issue
Date:   Thu, 16 Jan 2020 10:48:07 -0300
Message-Id: <20200116134814.8811-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116134814.8811-1-acme@kernel.org>
References: <20200116134814.8811-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

Commit 800d3f561659 ("perf report: Add warning when libunwind not
compiled in") breaks the s390 platform. S390 uses libdw-dwarf-unwind for
call chain unwinding and had no support for libunwind.

So the warning "Please install libunwind development packages during the
perf build." caused the confusion even if the call-graph is displayed
correctly.

This patch adds checking for HAVE_DWARF_SUPPORT, which is set when
libdw-dwarf-unwind is compiled in.

Fixes: 800d3f561659 ("perf report: Add warning when libunwind not compiled in")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Reviewed-by: Thomas Richter <tmricht@linux.ibm.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200107191745.18415-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 627bb6570988..9483b3f0cae3 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -412,10 +412,10 @@ static int report__setup_sample_type(struct report *rep)
 				PERF_SAMPLE_BRANCH_ANY))
 		rep->nonany_branch_mode = true;
 
-#ifndef HAVE_LIBUNWIND_SUPPORT
+#if !defined(HAVE_LIBUNWIND_SUPPORT) && !defined(HAVE_DWARF_SUPPORT)
 	if (dwarf_callchain_users) {
-		ui__warning("Please install libunwind development packages "
-			    "during the perf build.\n");
+		ui__warning("Please install libunwind or libdw "
+			    "development packages during the perf build.\n");
 	}
 #endif
 
-- 
2.21.1

