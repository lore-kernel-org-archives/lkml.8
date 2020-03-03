Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ADFC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B144A20870
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583257900;
	bh=dYY2nfybQa9fso0nwr0Pvip/Pef4msplkJ7pnFd76jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uDPoMj9tC3CofGcfXWu0j+Qav+VxtNNDuUbgUHQMBBMacy2PDOg9qFbO7OwCqMZ39
	 wmGSq6L78y3QjsDO3Ar5rueNTGZeKqVIotbCu5TPv9zi9dfjGhj0TOPf/pz67JafXf
	 Ea5Ue+b7x9dOwhHuXixVF8G1K9uTNZA5J/5xBj8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732023AbgCCRvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:51:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:59622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731998AbgCCRvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:51:31 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7FFA20870;
        Tue,  3 Mar 2020 17:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583257891;
        bh=dYY2nfybQa9fso0nwr0Pvip/Pef4msplkJ7pnFd76jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YFa4f23j2CskE8y4Z0VjyPPun1VSNrJymLBTfhETc0tQ7HBbt2TVVN/qgiq258FNZ
         i3VN5xQg9t65h0hAPzkwf88BxMHErGthwES/tPSMSvWSCuBQUBb8tz6/lD4ghyxVti
         2quHHZ/dpWtnv4tYduZYSCNsh+0NAfiBMvcDR43U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5.5 140/176] perf report: Fix no libunwind compiled warning break s390 issue
Date:   Tue,  3 Mar 2020 18:43:24 +0100
Message-Id: <20200303174320.976028884@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174304.593872177@linuxfoundation.org>
References: <20200303174304.593872177@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

commit c3314a74f86dc00827e0945c8e5039fc3aebaa3c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/perf/builtin-report.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -412,10 +412,10 @@ static int report__setup_sample_type(str
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
 


