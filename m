Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77279C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20D602075A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Q3MBxdkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgEDNRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 09:17:03 -0400
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:35276 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726351AbgEDNRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 09:17:02 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D1BBB2E09E9;
        Mon,  4 May 2020 16:16:59 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id bhSy61B6v3-GwAiDqeA;
        Mon, 04 May 2020 16:16:59 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1588598219; bh=tEjB8A0p1UcHdvUXrKJqH+iB2LtcyE8eUr0SvDqZaDI=;
        h=Message-ID:Date:To:From:Subject;
        b=Q3MBxdkX4Y3s5cKmcWxYye5Sf5T5+6xCu0U07odOma7I4LQKgQjnDVfzkUGdWOWDp
         gf6rr9irzdmGwGwTkxRQNP4gqT/FNMUhw5zFFHAnjbwXIIAOeFKfdUE4zC0BmvoEYD
         CbgVQHyObhDVOq+5NRX0j+0U6HtsT6o7bKAYCPRw=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b081:409::1:8])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id HJL57V0TdJ-GwWWU2R2;
        Mon, 04 May 2020 16:16:58 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH v3] perf tools: fix detecting SMT at machines with more than
 32 cpus
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Mon, 04 May 2020 16:16:58 +0300
Message-ID: <158859821815.15969.10293973465904199333.stgit@buzz>
User-Agent: StGit/0.22-32-g6a05
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
 tools/perf/util/smt.c |   39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 20bacd5972ad..ef713981725a 100644
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
@@ -9,6 +10,7 @@ int smt_on(void)
 {
 	static bool cached;
 	static int cached_result;
+	char *str = NULL;
 	int cpu;
 	int ncpu;
 
@@ -20,33 +22,24 @@ int smt_on(void)
 
 	ncpu = sysconf(_SC_NPROCESSORS_CONF);
 	for (cpu = 0; cpu < ncpu; cpu++) {
-		unsigned long long siblings;
-		char *str;
-		size_t strlen;
 		char fn[256];
+		size_t len;
 
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
+		if (sysfs__read_str(fn, &str, &len) > 0)
+			break;
+
+		snprintf(fn, sizeof(fn), "devices/system/cpu/cpu%d/topology/%s",
+			 cpu, "thread_siblings_list");
+		if (sysfs__read_str(fn, &str, &len) > 0)
 			break;
-		}
 	}
-	if (!cached) {
-		cached_result = 0;
+
+	// ',' or '-' should be in string if list contains more than one cpu
+	cached_result = str && (strchr(str, ',') || strchr(str, '-'));
+	free(str);
 done:
-		cached = true;
-	}
+	cached = true;
 	return cached_result;
 }

