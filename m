Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5E2C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1962076A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 12:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585140194;
	bh=3Z/cfF42ZEAVj6GwgPuOMa72XBxzcKlUhXUtG/XsyjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sxq/KmU4pq+I7Iq481JnSB8XxOuUQmUD++VVz0OntJUsKtW6fJo6JYL1mFjvxRBel
	 5+r25/fZNDWrNTCoWlBNncuCsfbn1V9Vinyfovxr8F7S3Acc3rxu60LaHF2VvfvWI2
	 1KaWvb95TK+ANyN1p2QbfiJuSjkdqsJXzKvKej6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCYMnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 08:43:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgCYMnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 08:43:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72AE02077D;
        Wed, 25 Mar 2020 12:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585140189;
        bh=3Z/cfF42ZEAVj6GwgPuOMa72XBxzcKlUhXUtG/XsyjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JIzlYqoVuX0f31pmWLSGwA2d2LZdfNdCSg4ntCDt4w9gaiWk5kCtgQn2p1YFVNzGp
         pcj2NSoedRzBw0bD9GBCAdAgMBHNCAyocaaxSqfJaeqgMpmYkgQDHaCKPD4KIHG+GI
         OmDGTfKT12E8GRAa1MfRHrEf+8cb48aKu2ybcfmk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        David Laight <David.Laight@ACULAB.COM>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Don Zickus <dzickus@redhat.com>, He Zhe <zhe.he@windriver.com>,
        Jan Stancek <jstancek@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kernel-janitors@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 23/24] perf cpumap: Fix snprintf overflow check
Date:   Wed, 25 Mar 2020 09:41:23 -0300
Message-Id: <20200325124124.32648-24-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325124124.32648-1-acme@kernel.org>
References: <20200325124124.32648-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

'snprintf' returns the number of characters which would be generated for
the given input.

If the returned value is *greater than* or equal to the buffer size, it
means that the output has been truncated.

Fix the overflow test accordingly.

Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Suggested-by: David Laight <David.Laight@ACULAB.COM>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: He Zhe <zhe.he@windriver.com>
Cc: Jan Stancek <jstancek@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lore.kernel.org/lkml/20200324070319.10901-1-christophe.jaillet@wanadoo.fr
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cpumap.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 983b7388f22b..dc5c5e6fc502 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -317,7 +317,7 @@ static void set_max_cpu_num(void)
 
 	/* get the highest possible cpu number for a sparse allocation */
 	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
-	if (ret == PATH_MAX) {
+	if (ret >= PATH_MAX) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -328,7 +328,7 @@ static void set_max_cpu_num(void)
 
 	/* get the highest present cpu number for a sparse allocation */
 	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
-	if (ret == PATH_MAX) {
+	if (ret >= PATH_MAX) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -356,7 +356,7 @@ static void set_max_node_num(void)
 
 	/* get the highest possible cpu number for a sparse allocation */
 	ret = snprintf(path, PATH_MAX, "%s/devices/system/node/possible", mnt);
-	if (ret == PATH_MAX) {
+	if (ret >= PATH_MAX) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		goto out;
 	}
@@ -441,7 +441,7 @@ int cpu__setup_cpunode_map(void)
 		return 0;
 
 	n = snprintf(path, PATH_MAX, "%s/devices/system/node", mnt);
-	if (n == PATH_MAX) {
+	if (n >= PATH_MAX) {
 		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 		return -1;
 	}
@@ -456,7 +456,7 @@ int cpu__setup_cpunode_map(void)
 			continue;
 
 		n = snprintf(buf, PATH_MAX, "%s/%s", path, dent1->d_name);
-		if (n == PATH_MAX) {
+		if (n >= PATH_MAX) {
 			pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
 			continue;
 		}
-- 
2.21.1

