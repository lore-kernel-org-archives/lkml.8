Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A47C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E1E205ED
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgCOUNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 16:13:14 -0400
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:23877 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgCOUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:13:14 -0400
Received: from localhost.localdomain ([93.22.37.174])
        by mwinf5d57 with ME
        id EkD2220093lSDvh03kD3A1; Sun, 15 Mar 2020 21:13:12 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 15 Mar 2020 21:13:12 +0100
X-ME-IP: 93.22.37.174
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, mhiramat@kernel.org,
        allison@lohutok.net, rostedt@goodmis.org, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] perf probe: Fix an error handling path in 'parse_perf_probe_command()'
Date:   Sun, 15 Mar 2020 21:12:59 +0100
Message-Id: <20200315201259.29190-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a memory allocation fail, we should branch to the error handling path in
order to free some resources allocated a few lines above.

Fixes: 15354d546986 ("perf probe: Generate event name with line number")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 tools/perf/util/probe-event.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index eea132f512b0..65a615ee4b4c 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -1683,8 +1683,10 @@ int parse_perf_probe_command(const char *cmd, struct perf_probe_event *pev)
 	if (!pev->event && pev->point.function && pev->point.line
 			&& !pev->point.lazy_line && !pev->point.offset) {
 		if (asprintf(&pev->event, "%s_L%d", pev->point.function,
-			pev->point.line) < 0)
-			return -ENOMEM;
+			pev->point.line) < 0) {
+			ret = -ENOMEM;
+			goto out;
+		}
 	}
 
 	/* Copy arguments and ensure return probe has no C argument */
-- 
2.20.1

