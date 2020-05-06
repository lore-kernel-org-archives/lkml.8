Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48F9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D2620A8B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588778707;
	bh=hL/kKAoJjpVSuhX0xX+QYZmcEFItB9E0+Y8VyH/J4W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ebNlbmggGtYBmH7pW/MrPaFXHnKmOUx44B51EWtguFiZppJNzruPbEQFRJMb6dwGy
	 bnadmieWjhihQ+bMQEWNw0Kp4IHzrzUW9N/T3AEzSE9gnmvcNkQUlz0DK9vZY1zgvt
	 9UWE4AomSY6UA/X5POhyoFmSfKS/q9PozvV9WRPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729945AbgEFPZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:44216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbgEFPZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:25:03 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA2C120B1F;
        Wed,  6 May 2020 15:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588778702;
        bh=hL/kKAoJjpVSuhX0xX+QYZmcEFItB9E0+Y8VyH/J4W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yv6bjs781qadSIoVW0IjWRRN7OPa4jKhbGLfxuI5dIMgYZiLIynfleA7o2u1aRtTi
         3U+TojPa9UOhxC1V92jIVMk2iMJkXSHePWQQ8l/NeFTBmXvkEFgmfYf5HnBGNYuodG
         Ta57zr3Crgrn/6mNkaG592FE3ph78rCpEYaLcQCs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andi Kleen <ak@linux.intel.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 37/91] perf tools: Fix reading new topology attribute "core_cpus"
Date:   Wed,  6 May 2020 12:21:40 -0300
Message-Id: <20200506152234.21977-38-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200506152234.21977-1-acme@kernel.org>
References: <20200506152234.21977-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

Check if access("devices/system/cpu/cpu%d/topology/core_cpus", F_OK)
fails, which will happen unless the current directory is "/sys".

Simply try to read this file first.

Fixes: 0ccdb8407a46 ("perf tools: Apply new CPU topology sysfs attributes")
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/158817718710.747528.11009278875028211991.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/smt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/smt.c b/tools/perf/util/smt.c
index 3b791ef2cd50..8481842e9edb 100644
--- a/tools/perf/util/smt.c
+++ b/tools/perf/util/smt.c
@@ -24,13 +24,13 @@ int smt_on(void)
 
 		snprintf(fn, sizeof fn,
 			"devices/system/cpu/cpu%d/topology/core_cpus", cpu);
-		if (access(fn, F_OK) == -1) {
+		if (sysfs__read_str(fn, &str, &strlen) < 0) {
 			snprintf(fn, sizeof fn,
 				"devices/system/cpu/cpu%d/topology/thread_siblings",
 				cpu);
+			if (sysfs__read_str(fn, &str, &strlen) < 0)
+				continue;
 		}
-		if (sysfs__read_str(fn, &str, &strlen) < 0)
-			continue;
 		/* Entry is hex, but does not have 0x, so need custom parser */
 		siblings = strtoull(str, NULL, 16);
 		free(str);
-- 
2.21.1

