Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3907C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A24E2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="0EGsba8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD2KAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2KAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:00:46 -0400
X-Greylist: delayed 160297 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Apr 2020 03:00:45 PDT
Received: from forwardcorp1j.mail.yandex.net (forwardcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0748AC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 03:00:45 -0700 (PDT)
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 4F0B62E14F8;
        Wed, 29 Apr 2020 13:00:41 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id LwAPw3r2ej-0eWKRgZF;
        Wed, 29 Apr 2020 13:00:41 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588154441; bh=gP489w7s3rUBOauoVcawLipj/7JSOZ/VcxF7zU9U1Gs=;
        h=Message-ID:Date:To:From:Subject:Cc;
        b=0EGsba8Aaim60DqlIBUCLHkdJpDnvU8kuuHe/IvJ8tCccZahcBwY+Qu9c/B0S2oYQ
         9xGbBa47LycxIJQq7h8I+wBlCFucIUH7JK+208JM5paI/vvEfV6NKbahdVdsq3o1eR
         M/e/nQo9mqMKtdAKQt1EORuZoY+9jkIKfHwKR5Js=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:6905::1:6])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id WSh2rztLM4-0dWKIrZP;
        Wed, 29 Apr 2020 13:00:40 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH] perf tool: fix detection of active SMT
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Date:   Wed, 29 Apr 2020 13:00:39 +0300
Message-ID: <158815443969.303706.11130341357699244442.stgit@buzz>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMT now could be disabled via "/sys/devices/system/cpu/smt/control".
Status shown in "/sys/devices/system/cpu/smt/active" simply as "0" / "1".

If this knob isn't here fallback to checking topology but fix couple bugs:

Check access("devices/system/cpu/cpu%d/topology/core_cpus", F_OK) fails,
unless current directory is "/sys". Simply try read this file first.

Cpu bitmap is split into 32 bit words. For system with more than 32 cores
threads are always in different words thus first word never has two bits:
cpu0: "0000,00000100,00000001", cpu 79: "8000,00000080,00000000".

Instead of parsing bitmap read "core_cpus_list" or "thread_siblings_list"
and simply check presence of ',' or '-' in it.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Fixes: de5077c4e38f ("perf tools: Add utility function to detect SMT status")
Fixes: 0ccdb8407a46 ("perf tools: Apply new CPU topology sysfs attributes")
---
 tools/perf/util/smt.c |   41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 3b791ef2cd50..c398528d1006 100644
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
@@ -9,39 +10,39 @@ int smt_on(void)
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
 
+	if (sysfs__read_int("devices/system/cpu/smt/active", &active) > 0)
+		goto done;
+
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
 	for (cpu = 0; cpu < ncpu; cpu++) {
-		unsigned long long siblings;
-		char *str;
-		size_t strlen;
 		char fn[256];
 
-		snprintf(fn, sizeof fn,
-			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
-		if (access(fn, F_OK) == -1) {
-			snprintf(fn, sizeof fn,
-				"devices/system/cpu/cpu%d/topology/thread_siblings",
-				cpu);
-		}
-		if (sysfs__read_str(fn, &str, &strlen) < 0)
-			continue;
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
+done:
 	if (!cached) {
-		cached_result = 0;
+		cached_result = active;
 		cached = true;
 	}
 	return cached_result;

