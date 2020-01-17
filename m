Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1090FC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D851920730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgAQJnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:43:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726371AbgAQJnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:43:52 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00H9CLft092567
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 04:26:24 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qsxe46-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 04:26:23 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 17 Jan 2020 09:26:20 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 09:26:18 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00H9QHHw54591650
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 09:26:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CD164C04E;
        Fri, 17 Jan 2020 09:26:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA6624C074;
        Fri, 17 Jan 2020 09:26:15 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.171])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jan 2020 09:26:15 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 1/3] perf annotate: Nuke privsize
Date:   Fri, 17 Jan 2020 14:56:10 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117092612.30874-1-ravi.bangoria@linux.ibm.com>
References: <20200117092612.30874-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011709-4275-0000-0000-000003986B45
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011709-4276-0000-0000-000038AC6C3E
Message-Id: <20200117092612.30874-2-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_02:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=2 mlxlogscore=999
 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use privsize now and it's always 0. Remove privsize
from code. Also simplify disasm_line allocation and freeing
code which was bit complex because of privsize.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/builtin-top.c     |  2 +-
 tools/perf/ui/gtk/annotate.c |  2 +-
 tools/perf/util/annotate.c   | 92 +++++++++++++-----------------------
 tools/perf/util/annotate.h   |  3 +-
 4 files changed, 35 insertions(+), 64 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 795e353de095..26765e41c083 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -143,7 +143,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(&he->ms, evsel, 0, &top->annotation_opts, NULL);
+	err = symbol__annotate(&he->ms, evsel, &top->annotation_opts, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 22cc240f7371..35f9641bf670 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -174,7 +174,7 @@ static int symbol__gtk_annotate(struct map_symbol *ms, struct evsel *evsel,
 	if (ms->map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(ms, evsel, 0, &annotation__default_options, NULL);
+	err = symbol__annotate(ms, evsel, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(ms, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f5e77ed237e8..7f9851772462 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1143,7 +1143,6 @@ static int disasm_line__parse(char *line, const char **namep, char **rawp)
 }
 
 struct annotate_args {
-	size_t			 privsize;
 	struct arch		*arch;
 	struct map_symbol	 ms;
 	struct evsel	*evsel;
@@ -1153,83 +1152,55 @@ struct annotate_args {
 	int			 line_nr;
 };
 
-static void annotation_line__delete(struct annotation_line *al)
+static void annotation_line__new(struct annotation_line *al,
+				 struct annotate_args *args,
+				 int nr)
 {
-	void *ptr = (void *) al - al->privsize;
-
-	free_srcline(al->path);
-	zfree(&al->line);
-	free(ptr);
+	al->offset = args->offset;
+	al->line = strdup(args->line);
+	al->line_nr = args->line_nr;
+	al->data_nr = nr;
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
 
-	size += sizeof(al->data[0]) * nr;
-
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
+	annotation_line__new(&dl->al, args, nr);
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
@@ -1248,7 +1219,9 @@ void disasm_line__free(struct disasm_line *dl)
 	else
 		ins__delete(&dl->ops);
 	zfree(&dl->ins.name);
-	annotation_line__delete(&dl->al);
+	free_srcline(dl->al.path);
+	zfree(&dl->al.line);
+	free(dl);
 }
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw, int max_ins_name)
@@ -2143,13 +2116,12 @@ void symbol__calc_percent(struct symbol *sym, struct evsel *evsel)
 	annotation__calc_percent(notes, evsel, symbol__size(sym));
 }
 
-int symbol__annotate(struct map_symbol *ms, struct evsel *evsel, size_t privsize,
+int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		     struct annotation_options *options, struct arch **parch)
 {
 	struct symbol *sym = ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotate_args args = {
-		.privsize	= privsize,
 		.evsel		= evsel,
 		.options	= options,
 	};
@@ -2784,7 +2756,7 @@ int symbol__tty_annotate(struct map_symbol *ms, struct evsel *evsel,
 	struct symbol *sym = ms->sym;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(ms, evsel, 0, opts, NULL) < 0)
+	if (symbol__annotate(ms, evsel, opts, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
@@ -3064,7 +3036,7 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
 
-	err = symbol__annotate(ms, evsel, 0, options, parch);
+	err = symbol__annotate(ms, evsel, options, parch);
 	if (err)
 		goto out_free_offsets;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 7075d98f69d9..4a86558646ff 100644
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
@@ -350,7 +349,7 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct map_symbol *ms,
-		     struct evsel *evsel, size_t privsize,
+		     struct evsel *evsel,
 		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct map_symbol *ms,
-- 
2.24.1

