Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA482C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8221208CA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 18:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599158653;
	bh=Tz7EJQE6COoLh1crENEidXy5LD1W5odY1GUOhp4IItc=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=N5XxokLJ1JI2ve3zeg3CrypBGJVMmV+wfk+/Ggw6UW5YPfgImRTxdfMUr61oLafxx
	 HTK1YxMx8zFJgZXQiOQCLcYl1/8qB0UTwhsMAnks8feX6etuEkPamuYml4Q0DkrsMp
	 iB6D8GJ8lIUcUzyESRwJK9vrNYqUoGdv0C8nseKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgICSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 14:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728525AbgICSoC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 14:44:02 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08489208C7;
        Thu,  3 Sep 2020 18:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599158641;
        bh=Tz7EJQE6COoLh1crENEidXy5LD1W5odY1GUOhp4IItc=;
        h=Date:From:To:Cc:Subject:From;
        b=FE6UTzhngMJNhWRtBwXUf0NE/tJpZzm/x84SmfoCuCcUtWmJ9WDe9C34KwvsTCrqA
         9y5hSPGNAgmov50NajtJiCH4ibN2DMrTn6oqOHDBHfHR40uEv1rN4DK2UsUAAwzY7l
         /DEU7FuNVfscouBrCCAawxxcq1oryxvhEo3D3CtI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1DBA740D3D; Thu,  3 Sep 2020 15:43:59 -0300 (-03)
Date:   Thu, 3 Sep 2020 15:43:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Yonghong Song <yhs@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] perf parse-events: Use uintptr_t when casting numbers to
 pointers
Message-ID: <20200903184359.GC3495158@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

	Please check that this is ok with you,

Thanks,

- Arnaldo

commit 0823f768b800cca2592fad3b5649766ae6bc4eba
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Sep 3 15:34:20 2020 -0300

    perf parse-events: Use uintptr_t when casting numbers to pointers
    
    To address these errors found when cross building from x86_64 to MIPS
    little endian 32-bit:
    
        CC       /tmp/build/perf/util/parse-events-bison.o
      util/parse-events.y: In function 'parse_events_parse':
      util/parse-events.y:514:6: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
        514 |      (void *) $2, $6, $4);
            |      ^
      util/parse-events.y:531:7: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
        531 |       (void *) $2, NULL, $4)) {
            |       ^
      util/parse-events.y:547:6: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
        547 |      (void *) $2, $4, 0);
            |      ^
      util/parse-events.y:564:7: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
        564 |       (void *) $2, NULL, 0)) {
            |       ^
    
    Fixes: cabbf26821aa210f ("perf parse: Before yyabort-ing free components")
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Alexei Starovoitov <ast@kernel.org>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Ian Rogers <irogers@google.com>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: John Garry <john.garry@huawei.com>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Martin KaFai Lau <kafai@fb.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Song Liu <songliubraving@fb.com>
    Cc: Stephane Eranian <eranian@google.com>
    Cc: Yonghong Song <yhs@fb.com>
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b9fb91fdc5de9177..645bf4f1859fd76b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -511,7 +511,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(list, &parse_state->idx,
-					(void *) $2, $6, $4);
+					(void *)(uintptr_t) $2, $6, $4);
 	free($6);
 	if (err) {
 		free(list);
@@ -528,7 +528,7 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
 	list = alloc_list();
 	ABORT_ON(!list);
 	if (parse_events_add_breakpoint(list, &parse_state->idx,
-						(void *) $2, NULL, $4)) {
+						(void *)(uintptr_t) $2, NULL, $4)) {
 		free(list);
 		YYABORT;
 	}
@@ -544,7 +544,7 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(list, &parse_state->idx,
-					(void *) $2, $4, 0);
+					(void *)(uintptr_t) $2, $4, 0);
 	free($4);
 	if (err) {
 		free(list);
@@ -561,7 +561,7 @@ PE_PREFIX_MEM PE_VALUE sep_dc
 	list = alloc_list();
 	ABORT_ON(!list);
 	if (parse_events_add_breakpoint(list, &parse_state->idx,
-						(void *) $2, NULL, 0)) {
+						(void *)(uintptr_t) $2, NULL, 0)) {
 		free(list);
 		YYABORT;
 	}
