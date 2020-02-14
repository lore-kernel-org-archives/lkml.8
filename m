Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A033AC3B1BF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6940D222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581707490;
	bh=T9hr3oqQTIdwJTyFThcBifwYRUrB5IE0iVZT/BotkRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ohthcljnj1h4mOocrDJ4d6JMTn6+INXJc3QewXZ7NvrVFEMHI//NE/RA0r1cR+sZC
	 9Z+N+1MBKFmpcT1yzIOvOIw3RIAioDAoa0w7iwuSaQx2PhVIWvXtLqmC5ojpPyfFYq
	 EVB5cTnPX67lTOLeZXWC2VW1DF7y3O8feQfkTmyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbgBNTL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:11:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387499AbgBNTL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:11:28 -0500
Received: from quaco.ghostprotocols.net (187-26-102-114.3g.claro.net.br [187.26.102.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABACF206D7;
        Fri, 14 Feb 2020 19:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581707487;
        bh=T9hr3oqQTIdwJTyFThcBifwYRUrB5IE0iVZT/BotkRk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EfVZIjzD8aoZO4XOGLf1TFoAyriQ634Hs7AY6z8tVh2hlIMnw5alyMXIzcwh1Xq+A
         luGs1EiS021gtWVVIqbtwdYnRrIEiQ33RY2CGIQspN0HU8sEDcyl/xyN1V6D4rFbC/
         B1MXNMYNyn9Zh5RpGYV/sApDtW3vfHZwsSfZYa5I=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kim Phillips <kim.phillips@amd.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 03/23] perf symbols: Convert symbol__is_idle() to use strlist
Date:   Fri, 14 Feb 2020 16:10:37 -0300
Message-Id: <20200214191057.26266-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214191057.26266-1-acme@kernel.org>
References: <20200214191057.26266-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

Use the more optimized strlist implementation to do the idle function
lookup.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200210163147.25358-1-kim.phillips@amd.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index f3120c4f47ad..1077013d8ce2 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -654,13 +654,17 @@ static bool symbol__is_idle(const char *name)
 		NULL
 	};
 	int i;
+	static struct strlist *idle_symbols_list;
 
-	for (i = 0; idle_symbols[i]; i++) {
-		if (!strcmp(idle_symbols[i], name))
-			return true;
-	}
+	if (idle_symbols_list)
+		return strlist__has_entry(idle_symbols_list, name);
 
-	return false;
+	idle_symbols_list = strlist__new(NULL, NULL);
+
+	for (i = 0; idle_symbols[i]; i++)
+		strlist__add(idle_symbols_list, idle_symbols[i]);
+
+	return strlist__has_entry(idle_symbols_list, name);
 }
 
 static int map__process_kallsym_symbol(void *arg, const char *name,
-- 
2.21.1

