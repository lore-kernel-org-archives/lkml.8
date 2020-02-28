Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E696C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499D7246B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582898490;
	bh=JcULsbmnVERYhdgjnZr0faWiD06SNieNewex/PJgf7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ufF+FNyowdJZxKnQysewOpED10IUWI99JZOwwqj/KetthbCHh7SyAmgskU7Gb7rL0
	 RkklYZpEODW1uDbFLNsvXR/T73XwB8dewnYB5XdcVmyyBrXfy1FkqAbvWTL5cLDQor
	 PYi0ZbrHdYdtGS44710GInHYMu77xbbaHaBNA8Fg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgB1OB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbgB1OBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:01:23 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B5E7246B7;
        Fri, 28 Feb 2020 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582898482;
        bh=JcULsbmnVERYhdgjnZr0faWiD06SNieNewex/PJgf7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qmtJJJnWmHGdWLoP4OOjX6wndzoT5iaOFiPNYzwt8ywaTsWBGh0Yi8zFh3D+a8zZl
         N/YsqKWeYRzR5dWxCDoLKPlCJ8j4bjvF8xkia6uTXNdoazB4gbSW7gSjDE40yNbh4R
         Ah+p7+g2f+cYiD9X+YjQXb2EPKBiD61S2bUW+gIQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/15] perf annotate: Simplify disasm_line allocation and freeing code
Date:   Fri, 28 Feb 2020 11:00:12 -0300
Message-Id: <20200228140014.1236-14-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228140014.1236-1-acme@kernel.org>
References: <20200228140014.1236-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

We are allocating disasm_line object in annotation_line__new() instead
of disasm_line__new(). Similarly annotation_line__delete() is actually
freeing disasm_line object as well. This complexity is because of
privsize.  But we don't need privsize anymore so get rid of privsize and
simplify disasm_line allocation and freeing code.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lore.kernel.org/lkml/20200204045233.474937-3-ravi.bangoria@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 86 ++++++++++++++------------------------
 tools/perf/util/annotate.h |  1 -
 2 files changed, 31 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a76309fcf381..f11031a40290 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1143,7 +1143,6 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 }
 
 struct annotate_args {
-	size_t			 privsize;
 	struct arch		*arch;
 	struct map_symbol	 ms;
 	struct evsel	*evsel;
@@ -1153,83 +1152,61 @@ struct annotate_args {
 	int			 line_nr;
 };
 
-static void annotation_line__delete(struct annotation_line *al)
+static void annotation_line__init(struct annotation_line *al,
+				  struct annotate_args *args,
+				  int nr)
 {
-	void *ptr = (void *) al - al->privsize;
+	al->offset = args->offset;
+	al->line = strdup(args->line);
+	al->line_nr = args->line_nr;
+	al->data_nr = nr;
+}
 
+static void annotation_line__exit(struct annotation_line *al)
+{
 	free_srcline(al->path);
 	zfree(&al->line);
-	free(ptr);
 }
 
-/*
- * Allocating the annotation line data with following
- * structure:
- *
- *    --------------------------------------
- *    private space | struct annotation_line
- *    --------------------------------------
- *
- * Size of the private space is stored in 'struct annotation_line'.
- *
- */
-static struct annotation_line *
-annotation_line__new(struct annotate_args *args, size_t privsize)
+static size_t disasm_line_size(int nr)
 {
 	struct annotation_line *al;
-	struct evsel *evsel = args->evsel;
-	size_t size = privsize + sizeof(*al);
-	int nr = 1;
-
-	if (perf_evsel__is_group_event(evsel))
-		nr = evsel->core.nr_members;
-
-	size += sizeof(al->data[0]) * nr;
 
-	al = zalloc(size);
-	if (al) {
-		al = (void *) al + privsize;
-		al->privsize   = privsize;
-		al->offset     = args->offset;
-		al->line       = strdup(args->line);
-		al->line_nr    = args->line_nr;
-		al->data_nr    = nr;
-	}
-
-	return al;
+	return (sizeof(struct disasm_line) + (sizeof(al->data[0]) * nr));
 }
 
 /*
  * Allocating the disasm annotation line data with
  * following structure:
  *
- *    ------------------------------------------------------------
- *    privsize space | struct disasm_line | struct annotation_line
- *    ------------------------------------------------------------
+ *    -------------------------------------------
+ *    struct disasm_line | struct annotation_line
+ *    -------------------------------------------
  *
  * We have 'struct annotation_line' member as last member
  * of 'struct disasm_line' to have an easy access.
- *
  */
 static struct disasm_line *disasm_line__new(struct annotate_args *args)
 {
 	struct disasm_line *dl = NULL;
-	struct annotation_line *al;
-	size_t privsize = args->privsize + offsetof(struct disasm_line, al);
+	int nr = 1;
 
-	al = annotation_line__new(args, privsize);
-	if (al != NULL) {
-		dl = disasm_line(al);
+	if (perf_evsel__is_group_event(args->evsel))
+		nr = args->evsel->core.nr_members;
 
-		if (dl->al.line == NULL)
-			goto out_delete;
+	dl = zalloc(disasm_line_size(nr));
+	if (!dl)
+		return NULL;
 
-		if (args->offset != -1) {
-			if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
-				goto out_free_line;
+	annotation_line__init(&dl->al, args, nr);
+	if (dl->al.line == NULL)
+		goto out_delete;
 
-			disasm_line__init_ins(dl, args->arch, &args->ms);
-		}
+	if (args->offset != -1) {
+		if (disasm_line__parse(dl->al.line, &dl->ins.name, &dl->ops.raw) < 0)
+			goto out_free_line;
+
+		disasm_line__init_ins(dl, args->arch, &args->ms);
 	}
 
 	return dl;
@@ -1248,7 +1225,8 @@ void disasm_line__free(struct disasm_line *dl)
 	else
 		ins__delete(&dl->ops);
 	zfree(&dl->ins.name);
-	annotation_line__delete(&dl->al);
+	annotation_line__exit(&dl->al);
+	free(dl);
 }
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw, int max_ins_name)
@@ -2152,11 +2130,9 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		     struct annotation_options *options, struct arch **parch)
 {
-	size_t privsize = 0;
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
-		.privsize	= privsize,
 		.evsel		= evsel,
 		.options	= options,
 	};
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 7bc60988e478..001258601a37 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -139,7 +139,6 @@ struct annotation_line {
 	u64			 cycles;
 	u64			 cycles_max;
 	u64			 cycles_min;
-	size_t			 privsize;
 	char			*path;
 	u32			 idx;
 	int			 idx_asm;
-- 
2.21.1

