Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9C0C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 846C720719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585925708;
	bh=87I1nmpaatZnO4U7tVHMwtQt172m3CT5WZqY3wu4m2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FOG0RU5UDGwVD73ZS56yRuPu/iOQF33EvFtwkjah2mU4Cztm3D5eKyXkqBxoqdTmv
	 oy8SeJRgYhDUmDB8reyPRlMdcsLMf5Q+DqLlBeIp0smVKry4XL9l2vcjFYs7r3ANrZ
	 zGh7PYw4O96XNZwNKCpfvz9DK/Vedw1Z8vdQiJQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404039AbgDCOzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:60002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgDCOzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:55:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6679A214D8;
        Fri,  3 Apr 2020 14:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585925705;
        bh=87I1nmpaatZnO4U7tVHMwtQt172m3CT5WZqY3wu4m2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F27/tyt3Jk0oefMAWWD4D1GSOG8tb2AiZ1BOKgtmKPoI9RDIcvjlHtja9qfhwHzuh
         CUn3zTWDzRyTMXEgPREbNqt8sBMHE+ICDkb/4BB3gV2KLjc8LfHUmDwyrY7gMx/W9y
         CYq4tZu8G1X1AQQVmhc5lvLFzjbzAap2imYy+QrI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        He Zhe <zhe.he@windriver.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/31] perf: Normalize gcc parameter when generating arch errno table
Date:   Fri,  3 Apr 2020 11:54:15 -0300
Message-Id: <20200403145443.24774-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200403145443.24774-1-acme@kernel.org>
References: <20200403145443.24774-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

The $(CC) passed to arch_errno_names.sh may include a series of parameters
along with gcc itself. To avoid overwriting the following parameters of
arch_errno_names.sh and break the build like below, we just pick up the
first word of the $(CC).

  find: unknown predicate `-m64/arch'
  x86_64-wrs-linux-gcc: warning: '-x c' after last input file has no effect
  x86_64-wrs-linux-gcc: error: unrecognized command line option '-m64/include/uapi/asm-generic/errno.h'
  x86_64-wrs-linux-gcc: fatal error: no input files

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/1581618066-187262-2-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index a02aca9b21f4..d15a311408f1 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -574,7 +574,7 @@ arch_errno_hdr_dir := $(srctree)/tools
 arch_errno_tbl := $(srctree)/tools/perf/trace/beauty/arch_errno_names.sh
 
 $(arch_errno_name_array): $(arch_errno_tbl)
-	$(Q)$(SHELL) '$(arch_errno_tbl)' $(CC) $(arch_errno_hdr_dir) > $@
+	$(Q)$(SHELL) '$(arch_errno_tbl)' $(firstword $(CC)) $(arch_errno_hdr_dir) > $@
 
 sync_file_range_arrays := $(beauty_outdir)/sync_file_range_arrays.c
 sync_file_range_tbls := $(srctree)/tools/perf/trace/beauty/sync_file_range.sh
-- 
2.21.1

