Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40506C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F59246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898478;
	bh=l+2EfmcZOjafeTnHGdFpV29cI4AdppFdQ/imGLCkQxk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oQT84hvlVLacub8g2zfuwNjcZbBJ0h86eZv6PbA2JzKHJIRYrxwa35njaUFkjPFhd
	 Y1+cpZVhbUD/LcPW8jDK2tzatLYzl/H5QvaSmCeJMT+WywLd9OFkGryOPmVUpNv/j6
	 DcM38SrhCnEh4IS7Qil2KiBP5msKIIkRYDHD5eFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgB1OBR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:01:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgB1OBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:01:15 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3FD9246B9;
        Fri, 28 Feb 2020 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898474;
        bh=l+2EfmcZOjafeTnHGdFpV29cI4AdppFdQ/imGLCkQxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtICU7ObEdXA7UyVmqjUDG0G90mTvQc+cFyVZPgf4qVJF6WKzKFerTBy8dkHlgghQ
         Yi10boQFqkEMRPWzpUqybzk2jdx2zlSLPof0OpeqyFeBZwnQqKwoIGi5Dog69vF22n
         7Vt5ry7aPnM36d7jmVFvtanydc2E+NXjAGVa1Vac=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        He Zhe <zhe.he@windriver.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/15] perf probe: Check return value of strlist__add() for -ENOMEM
Date:   Fri, 28 Feb 2020 11:00:10 -0300
Message-Id: <20200228140014.1236-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

strlist__add() may fail with -ENOMEM. Check it and give debugging hint
in advance.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lore.kernel.org/lkml/1582727404-180095-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-probe.c   |  6 ++++--
 tools/perf/util/probe-file.c | 28 ++++++++++++++++++++++++----
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
index 26bc5923e6b5..70548df2abb9 100644
--- a/tools/perf/builtin-probe.c
+++ b/tools/perf/builtin-probe.c
@@ -449,7 +449,8 @@ static int perf_del_probe_events(struct strfilter *filter)
 		ret = probe_file__del_strlist(kfd, klist);
 		if (ret < 0)
 			goto error;
-	}
+	} else if (ret == -ENOMEM)
+		goto error;
 
 	ret2 = probe_file__get_events(ufd, filter, ulist);
 	if (ret2 == 0) {
@@ -459,7 +460,8 @@ static int perf_del_probe_events(struct strfilter *filter)
 		ret2 = probe_file__del_strlist(ufd, ulist);
 		if (ret2 < 0)
 			goto error;
-	}
+	} else if (ret2 == -ENOMEM)
+		goto error;
 
 	if (ret == -ENOENT && ret2 == -ENOENT)
 		pr_warning("\"%s\" does not hit any event.\n", str);
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 5003ba403345..0f5fda11675f 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -301,10 +301,15 @@ int probe_file__get_events(int fd, struct strfilter *filter,
 		p = strchr(ent->s, ':');
 		if ((p && strfilter__compare(filter, p + 1)) ||
 		    strfilter__compare(filter, ent->s)) {
-			strlist__add(plist, ent->s);
+			ret = strlist__add(plist, ent->s);
+			if (ret == -ENOMEM) {
+				pr_err("strlist__add failed with -ENOMEM\n");
+				goto out;
+			}
 			ret = 0;
 		}
 	}
+out:
 	strlist__delete(namelist);
 
 	return ret;
@@ -511,7 +516,11 @@ static int probe_cache__load(struct probe_cache *pcache)
 				ret = -EINVAL;
 				goto out;
 			}
-			strlist__add(entry->tevlist, buf);
+			ret = strlist__add(entry->tevlist, buf);
+			if (ret == -ENOMEM) {
+				pr_err("strlist__add failed with -ENOMEM\n");
+				goto out;
+			}
 		}
 	}
 out:
@@ -672,7 +681,12 @@ int probe_cache__add_entry(struct probe_cache *pcache,
 		command = synthesize_probe_trace_command(&tevs[i]);
 		if (!command)
 			goto out_err;
-		strlist__add(entry->tevlist, command);
+		ret = strlist__add(entry->tevlist, command);
+		if (ret == -ENOMEM) {
+			pr_err("strlist__add failed with -ENOMEM\n");
+			goto out_err;
+		}
+
 		free(command);
 	}
 	list_add_tail(&entry->node, &pcache->entries);
@@ -853,9 +867,15 @@ int probe_cache__scan_sdt(struct probe_cache *pcache, const char *pathname)
 			break;
 		}
 
-		strlist__add(entry->tevlist, buf);
+		ret = strlist__add(entry->tevlist, buf);
+
 		free(buf);
 		entry = NULL;
+
+		if (ret == -ENOMEM) {
+			pr_err("strlist__add failed with -ENOMEM\n");
+			break;
+		}
 	}
 	if (entry) {
 		list_del_init(&entry->node);
-- 
2.21.1

