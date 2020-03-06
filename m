Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E52DC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5DAF20705
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583521925;
	bh=e7EgEEpHx+MetfEYHEnKupVQ1AJqH8L45PmTPfKes8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SvDItIPH/6R8gO7tVFO+X6eCUERgxfV6e/RYmhSvsmnmSzYuvk/Rg5BfLXPvawOlw
	 Df0ljs0IAaNsXJA0Z5u/WbEzZi+0po2E0sTPOaZ+Akay7PzxDWwmhjzvjozjzeQ1Tk
	 NB+DLcN4hurJJEK2D6eyW98AqZl3nkUDAtMqHv94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgCFTME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:12:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbgCFTMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:12:00 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BEFD206CC;
        Fri,  6 Mar 2020 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583521919;
        bh=e7EgEEpHx+MetfEYHEnKupVQ1AJqH8L45PmTPfKes8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Clf+7IbNqP0pZafdeo553q6pSCkAsA8+ItdKePMELE/0JIUApzTJQ1uQXBI5q/hME
         tFfXeiKcPNA8FA/hUBHuznm4H87va3og4jBuB2roIO4r1YtdFFPbhmpMM9ZuvE1rck
         vvAMqq9MQK47iwihnhQKM5cFu6dfFIbhFX54eG4Q=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/5] perf tests bp_account: Make global variable static
Date:   Fri,  6 Mar 2020 16:11:35 -0300
Message-Id: <20200306191144.12762-3-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To fix the build with newer gccs, that without this patch exit with:

    LD       /tmp/build/perf/tests/perf-in.o
  ld: /tmp/build/perf/tests/bp_account.o:/git/perf/tools/perf/tests/bp_account.c:22: multiple definition of `the_var'; /tmp/build/perf/tests/bp_signal.o:/git/perf/tools/perf/tests/bp_signal.c:38: first defined here
  make[4]: *** [/git/perf/tools/build/Makefile.build:145: /tmp/build/perf/tests/perf-in.o] Error 1

First noticed in fedora:rawhide/32 with:

  [perfbuilder@a5ff49d6e6e4 ~]$ gcc --version
  gcc (GCC) 10.0.1 20200216 (Red Hat 10.0.1-0.8)

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_account.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index d0b935356274..489b50604cf2 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -19,7 +19,7 @@
 #include "../perf-sys.h"
 #include "cloexec.h"
 
-volatile long the_var;
+static volatile long the_var;
 
 static noinline int test_function(void)
 {
-- 
2.21.1

