Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2197C35E03
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D39C92176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730868AbgBYOo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:44:56 -0500
Received: from mail5.windriver.com ([192.103.53.11]:39990 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730627AbgBYOoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:44:55 -0500
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 01PEfvnd028868
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 25 Feb 2020 06:42:58 -0800
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Tue, 25 Feb 2020 06:42:22 -0800
From:   <zhe.he@windriver.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@redhat.com>, <namhyung@kernel.org>, <mhiramat@kernel.org>,
        <kstewart@linuxfoundation.org>, <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH 2/2] perf: probe-file: Check return value of strlist__add
Date:   Tue, 25 Feb 2020 22:41:43 +0800
Message-ID: <1582641703-233485-2-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582641703-233485-1-git-send-email-zhe.he@windriver.com>
References: <1582641703-233485-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

strlist__add may fail with -ENOMEM or -EEXIST. Check it and give debugging
hint when necessary.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 tools/perf/builtin-probe.c   | 30 ++++++++++++++++--------------
 tools/perf/util/probe-file.c | 26 +++++++++++++++++++++-----
 2 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 26bc5923e6b5..8b4511c70fed 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -442,24 +442,26 @@ static int perf_del_probe_events(struct strfilter *filter)
 	}
 
 	ret = probe_file__get_events(kfd, filter, klist);
-	if (ret == 0) {
-		strlist__for_each_entry(ent, klist)
-			pr_info("Removed event: %s\n", ent->s);
+	if (ret < 0)
+		goto out;
 
-		ret = probe_file__del_strlist(kfd, klist);
-		if (ret < 0)
-			goto error;
-	}
+	strlist__for_each_entry(ent, klist)
+		pr_info("Removed event: %s\n", ent->s);
+
+	ret = probe_file__del_strlist(kfd, klist);
+	if (ret < 0)
+		goto error;
 
 	ret2 = probe_file__get_events(ufd, filter, ulist);
-	if (ret2 == 0) {
-		strlist__for_each_entry(ent, ulist)
-			pr_info("Removed event: %s\n", ent->s);
+	if (ret2 < 0)
+		goto out;
 
-		ret2 = probe_file__del_strlist(ufd, ulist);
-		if (ret2 < 0)
-			goto error;
-	}
+	strlist__for_each_entry(ent, ulist)
+		pr_info("Removed event: %s\n", ent->s);
+
+	ret2 = probe_file__del_strlist(ufd, ulist);
+	if (ret2 < 0)
+		goto error;
 
 	if (ret == -ENOENT && ret2 == -ENOENT)
 		pr_warning("\"%s\" does not hit any event.\n", str);
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index cf44c05f89c1..00f086cba88f 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -307,10 +307,14 @@ int probe_file__get_events(int fd, struct strfilter *filter,
 		p = strchr(ent->s, ':');
 		if ((p && strfilter__compare(filter, p + 1)) ||
 		    strfilter__compare(filter, ent->s)) {
-			strlist__add(plist, ent->s);
-			ret = 0;
+			ret = strlist__add(plist, ent->s);
+			if (ret < 0) {
+				pr_debug("strlist__add failed (%d)\n", ret);
+				goto out;
+			}
 		}
 	}
+out:
 	strlist__delete(namelist);
 
 	return ret;
@@ -517,7 +521,11 @@ static int probe_cache__load(struct probe_cache *pcache)
 				ret = -EINVAL;
 				goto out;
 			}
-			strlist__add(entry->tevlist, buf);
+			ret = strlist__add(entry->tevlist, buf);
+			if (ret < 0) {
+				pr_debug("strlist__add failed (%d)\n", ret);
+				goto out;
+			}
 		}
 	}
 out:
@@ -678,7 +686,12 @@ int probe_cache__add_entry(struct probe_cache *pcache,
 		command = synthesize_probe_trace_command(&tevs[i]);
 		if (!command)
 			goto out_err;
-		strlist__add(entry->tevlist, command);
+		ret = strlist__add(entry->tevlist, command);
+		if (ret < 0) {
+			pr_debug("strlist__add failed (%d)\n", ret);
+			goto out_err;
+		}
+
 		free(command);
 	}
 	list_add_tail(&entry->node, &pcache->entries);
@@ -859,7 +872,10 @@ int probe_cache__scan_sdt(struct probe_cache *pcache, const char *pathname)
 			break;
 		}
 
-		strlist__add(entry->tevlist, buf);
+		ret = strlist__add(entry->tevlist, buf);
+		if (ret < 0)
+			pr_debug("strlist__add failed (%d)\n", ret);
+
 		free(buf);
 		entry = NULL;
 	}
-- 
2.24.1

