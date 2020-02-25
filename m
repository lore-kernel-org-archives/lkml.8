Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2462DC35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC18C2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgBYOox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:44:53 -0500
Received: from mail5.windriver.com ([192.103.53.11]:39988 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbgBYOox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:44:53 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 01PEfvnc028868
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Feb 2020 06:42:07 -0800
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Tue, 25 Feb 2020 06:41:46 -0800
From:   <zhe.he@windriver.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <mhiramat@kernel.org>,
        <kstewart@linuxfoundation.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH 1/2] perf: Fix checking of duplicate probe to give proper hint
Date:   Tue, 25 Feb 2020 22:41:42 +0800
Message-ID: <1582641703-233485-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

Since commit 72363540c009 ("perf probe: Support multiprobe event") and its
series, if there are multiple probes for one event,
__probe_file__get_namelist would return -EEXIST and cause the following
failure without proper hint, due to adding existing entry to output list.

root@qemuarm64:~# perf probe -x /lib64/libc.so.6 free
Added new events:
  probe_libc:free      (on free in /lib64/libc-2.31.so)
  probe_libc:free      (on free in /lib64/libc-2.31.so)

You can now use it in all perf tools, such as:

        perf record -e probe_libc:free -aR sleep 1

root@qemuarm64:~# perf probe -l
  probe_libc:free      (on free@plt in /lib64/libc-2.31.so)
  probe_libc:free      (on cfree in /lib64/libc-2.31.so)
root@qemuarm64:~# perf probe -x /lib64/libc.so.6 free
  Error: Failed to add events.

As we just want to check if there is any probe with the same name, -EEXIST
can be ignored, so we can have the right hint as before.

root@qemuarm64:~# perf probe -x /lib64/libc.so.6 free
Error: event "free" already exists.
 Hint: Remove existing event by 'perf probe -d'
       or force duplicates by 'perf probe -f'
       or set 'force=yes' in BPF source.
  Error: Failed to add events.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/perf/util/probe-file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5003ba403345..cf44c05f89c1 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -201,10 +201,16 @@ static struct strlist *__probe_file__get_namelist(int fd, bool include_group)
 		if (include_group) {
 			ret = e_snprintf(buf, 128, "%s:%s", tev.group,
 					tev.event);
-			if (ret >= 0)
+			if (ret >= 0) {
 				ret = strlist__add(sl, buf);
-		} else
+				if (ret == -EEXIST)
+					ret = 0;
+			}
+		} else {
 			ret = strlist__add(sl, tev.event);
+			if (ret == -EEXIST)
+				ret = 0;
+		}
 		clear_probe_trace_event(&tev);
 		if (ret < 0)
 			break;
-- 
2.24.1

