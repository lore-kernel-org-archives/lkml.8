Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4F9C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1550F206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 16:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BXBo9OXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgD2QWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:22:51 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:42548 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726456AbgD2QWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 12:22:51 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id DEF262E097C;
        Wed, 29 Apr 2020 19:22:47 +0300 (MSK)
Received: from vla1-81430ab5870b.qloud-c.yandex.net (vla1-81430ab5870b.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:8143:ab5])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id zCzNk2WdeO-MiWOmUe2;
        Wed, 29 Apr 2020 19:22:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588177367; bh=qvivbKulTADbj1G5HSZtFfM6sU/7nUqZpncf5ziB99E=;
        h=In-Reply-To:Message-ID:References:Date:To:From:Subject:Cc;
        b=BXBo9OXzDIiZqamVd66xfOV6xGvJj8RKiAYaoIFWhYWmHRZF4nGoy/682Huvr/L7N
         skZ2wZUmacXhmqqBoM57HDp81xtZhsyI2v79ToQy5QjEVpPE9m2L4oQeNaJCxWKq9u
         JTYfmcF8aUIPPKGqmu4r8kMggfCHgSsOZQiyB9/8=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7913::1:4])
        by vla1-81430ab5870b.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id jXZZ6t05sz-MhX0JEgG;
        Wed, 29 Apr 2020 19:22:43 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH v2 2/3] perf tool: fix detecting smt at machines with more
 than 32 cpus
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Wed, 29 Apr 2020 19:22:43 +0300
Message-ID: <158817735893.747933.15107805593224835078.stgit@buzz>
In-Reply-To: <158817718710.747528.11009278875028211991.stgit@buzz>
References: <158817718710.747528.11009278875028211991.stgit@buzz>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpu bitmap is split into 32 bit words. For system with more than 32 cores
threads are always in different words thus first word never has two bits:
cpu0: "0000,00000100,00000001", cpu 79: "8000,00000080,00000000".

Instead of parsing bitmap read "core_cpus_list" or "thread_siblings_list"
and simply check presence of ',' or '-' in it.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: de5077c4e38f ("perf tools: Add utility function to detect SMT status")
---
 tools/perf/util/smt.c |   37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 8481842e9edb..dc37b5abd1c3 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -1,6 +1,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <string.h>
 #include <linux/bitops.h>
 #include "api/fs/fs.h"
 #include "smt.h"
@@ -9,39 +10,35 @@ int smt_on(void)
 {
 	static bool cached;
 	static int cached_result;
+	int active;
 	int cpu;
 	int ncpu;
+	char *str = NULL;
+	size_t strlen;
 
 	if (cached)
 		return cached_result;
 
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
 	for (cpu = 0; cpu < ncpu; cpu++) {
-		unsigned long long siblings;
-		char *str;
-		size_t strlen;
 		char fn[256];
 
-		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
-		if (sysfs__read_str(fn, &str, &strlen) < 0) {
-			snprintf(fn, sizeof fn,
-				"devices/system/cpu/cpu%d/topology/thread_siblings",
-				cpu);
-			if (sysfs__read_str(fn, &str, &strlen) < 0)
-				continue;
-		}
-		/* Entry is hex, but does not have 0x, so need custom parser */
-		siblings = strtoull(str, NULL, 16);
-		free(str);
-		if (hweight64(siblings) > 1) {
-			cached_result = 1;
-			cached = true;
+		snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
+			 cpu, "core_cpus_list");
+		if (sysfs__read_str(fn, &str, &strlen) > 0)
+			break;
+
+		snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
+			 cpu, "thread_siblings_list");
+		if (sysfs__read_str(fn, &str, &strlen) > 0)
 			break;
-		}
 	}
+
+	active = str && (strchr(str, ',') != NULL || strchr(str, '-') != NULL);
+	free(str);
+
 	if (!cached) {
-		cached_result = 0;
+		cached_result = active;
 		cached = true;
 	}
 	return cached_result;

