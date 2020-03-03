Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1A221739
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583264919;
	bh=e7EgEEpHx+MetfEYHEnKupVQ1AJqH8L45PmTPfKes8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cTlYFbr4agOw0vicOBaDmbRDERqNqtmtYnShTj/WMWjS9IO+7H4aA4sbYHtootczC
	 dxR9GVkT5n6ILpzfVCBBusrAkk3PuVwU1alChf7NKX4HZwsgHj+YtpJzF0dzqcu8/o
	 BxP1Vn2Q7VBVUPLv6aGJoyU8caISLlyUBVd8xE2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbgCCTsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:48:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbgCCTsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:48:37 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2383214DB;
        Tue,  3 Mar 2020 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583264917;
        bh=e7EgEEpHx+MetfEYHEnKupVQ1AJqH8L45PmTPfKes8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FCpy+odaRn13PADwRUkA+QFx2hjbe7eXjCqpItQtZO14ulIGaFek219eb7j4pEKd0
         m9sTHvv0RPCZ5FNMo/EAaIxxfKi/0WbYKyYOBEyAP+vy99Rg7gl10rHivvQ/WSK3pM
         KDuihL89T6lxw3TJ7pIP8l6ten6NBxtLGDNR6HS0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 1/5] perf tests bp_account: Make global variable static
Date:   Tue,  3 Mar 2020 16:48:23 -0300
Message-Id: <20200303194827.6461-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200303194827.6461-1-acme@kernel.org>
References: <20200303194827.6461-1-acme@kernel.org>
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

