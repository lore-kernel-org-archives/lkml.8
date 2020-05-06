Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14676C4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E627F20CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778736;
	bh=aBpiZ0CDnUe5OjSXDqD9oQ+ne/XZHBGUT1iXk3bbtdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j9lqJRYLpO/CYcJJF3KKzOdVvHKRwoh381Ip3OEdl5LskIEBBYyDzutTdinJb4R4M
	 +9wPaOe2goENnUcm+OZ9rYUoxoVj4E4GA4C/k6uSVsaJy7iwm2lgmdrQhYy/2r0JYR
	 6BLWgYNYjTGvh0NI9VucJOKYYlGaYIZxfuEQypyQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbgEFPZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:45954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbgEFPZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:32 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85F8121744;
        Wed,  6 May 2020 15:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778732;
        bh=aBpiZ0CDnUe5OjSXDqD9oQ+ne/XZHBGUT1iXk3bbtdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NMtHRH5C3GeJtljtvRlquwK242ItIKa69F2F58GS20ak/JAq9GTBN6Kiwz84pRVa+
         fVh1zRrYO9bZEs7u1hNwc/AXXFascossbJ80rn38wS2t3y6+6NRpzJTCHOi3ho63iF
         svlxt7uPszxWch7PLDwGOPWm4b4TMJFu7/Q67kfw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 47/91] perf intel-pt: Update documentation about using /proc/kcore
Date:   Wed,  6 May 2020 12:21:50 -0300
Message-Id: <20200506152234.21977-48-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Update documentation to reflect the advent of the --kcore option for
'perf record'.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200429150751.12570-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-intel-pt.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-intel-pt.txt b/tools/perf/Documentation/perf-intel-pt.txt
index 782eb8a65caf..eb8b7d42591a 100644
--- a/tools/perf/Documentation/perf-intel-pt.txt
+++ b/tools/perf/Documentation/perf-intel-pt.txt
@@ -69,22 +69,22 @@ And profiled with 'perf report' e.g.
 To also trace kernel space presents a problem, namely kernel self-modifying
 code.  A fairly good kernel image is available in /proc/kcore but to get an
 accurate image a copy of /proc/kcore needs to be made under the same conditions
-as the data capture.  A script perf-with-kcore can do that, but beware that the
-script makes use of 'sudo' to copy /proc/kcore.  If you have perf installed
-locally from the source tree you can do:
+as the data capture. 'perf record' can make a copy of /proc/kcore if the option
+--kcore is used, but access to /proc/kcore is restricted e.g.
 
-	~/libexec/perf-core/perf-with-kcore record pt_ls -e intel_pt// -- ls
+	sudo perf record -o pt_ls --kcore -e intel_pt// -- ls
 
-which will create a directory named 'pt_ls' and put the perf.data file and
-copies of /proc/kcore, /proc/kallsyms and /proc/modules into it.  Then to use
-'perf report' becomes:
+which will create a directory named 'pt_ls' and put the perf.data file (named
+simply 'data') and copies of /proc/kcore, /proc/kallsyms and /proc/modules into
+it.  The other tools understand the directory format, so to use 'perf report'
+becomes:
 
-	~/libexec/perf-core/perf-with-kcore report pt_ls
+	sudo perf report -i pt_ls
 
 Because samples are synthesized after-the-fact, the sampling period can be
 selected for reporting. e.g. sample every microsecond
 
-	~/libexec/perf-core/perf-with-kcore report pt_ls --itrace=i1usge
+	sudo perf report pt_ls --itrace=i1usge
 
 See the sections below for more information about the --itrace option.
 
-- 
2.21.1

