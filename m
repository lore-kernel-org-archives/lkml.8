Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E925C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059772084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbgBDExI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:53:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727247AbgBDExH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:53:07 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0144k8ZF047476
        for <linux-kernel@vger.kernel.org>; Mon, 3 Feb 2020 23:53:06 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xxgjxb4et-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 23:53:06 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 4 Feb 2020 04:53:03 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Feb 2020 04:53:00 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0144q6eK50790858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 04:52:06 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4FBF711C052;
        Tue,  4 Feb 2020 04:52:59 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 888EB11C04A;
        Tue,  4 Feb 2020 04:52:56 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.60.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 04:52:56 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v3 2/6] perf annotate: Simplify disasm_line allocation and freeing code
Date:   Tue,  4 Feb 2020 10:22:29 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
References: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020404-0012-0000-0000-0000038372DE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020404-0013-0000-0000-000021BFD89D
Message-Id: <20200204045233.474937-3-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_01:2020-02-04,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=2 spamscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are allocating disasm_line object in annotation_line__new() instead
of disasm_line__new(). Similarly annotation_line__delete() is actually
freeing disasm_line object as well. This complexity is because of privsize.
But we don't need privsize anymore so get rid of privsize and simplify
disasm_line allocation and freeing code.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/annotate.c | 86 ++++++++++++++------------------------
 tools/perf/util/annotate.h |  1 -
 2 files changed, 31 insertions(+), 56 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ea70bc050bce..b7fb7451445f 100644
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
index dade64781670..75c58a759b96 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -141,7 +141,6 @@ struct annotation_line {
 	u64			 cycles;
 	u64			 cycles_max;
 	u64			 cycles_min;
-	size_t			 privsize;
 	char			*path;
 	u32			 idx;
 	int			 idx_asm;
-- 
2.24.1

