Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFAAC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AF82082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbgBMGoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:44:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17614 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729849AbgBMGox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:44:53 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D6iphr068709
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:53 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4qysh545-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:52 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 13 Feb 2020 06:44:38 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 06:44:33 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D6iWgD47448432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 06:44:32 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31B3142045;
        Thu, 13 Feb 2020 06:44:32 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E602D42047;
        Thu, 13 Feb 2020 06:44:27 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.58.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 06:44:27 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 5/8] perf annotate: Make perf config effective
Date:   Thu, 13 Feb 2020 12:13:03 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021306-0016-0000-0000-000002E65BDC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021306-0017-0000-0000-000033495BCC
Message-Id: <20200213064306.160480-6-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf default config set by user in [annotate] section is totally
ignored by annotate code. Fix it.

Before:

  $ ./perf config
  annotate.hide_src_code=true
  annotate.show_nr_jumps=true
  annotate.show_nr_samples=true

  $ ./perf annotate shash
         │    unsigned h = 0;
         │      movl   $0x0,-0xc(%rbp)
         │    while (*s)
         │    ↓ jmp    44
         │    h = 65599 * h + *s++;
   11.33 │24:   mov    -0xc(%rbp),%eax
   43.50 │      imul   $0x1003f,%eax,%ecx
         │      mov    -0x18(%rbp),%rax

After:

         │        movl   $0x0,-0xc(%rbp)
         │      ↓ jmp    44
       1 │1 24:   mov    -0xc(%rbp),%eax
       4 │        imul   $0x1003f,%eax,%ecx
         │        mov    -0x18(%rbp),%rax

Note that we have removed show_nr_samples and show_total_period from
annotation_options because they are not used. Instead of them we use
symbol_conf.show_nr_samples and symbol_conf.show_total_period.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/builtin-annotate.c |  2 +-
 tools/perf/builtin-report.c   |  2 +-
 tools/perf/builtin-top.c      |  2 +-
 tools/perf/util/annotate.c    | 78 +++++++++++++----------------------
 tools/perf/util/annotate.h    |  4 +-
 5 files changed, 33 insertions(+), 55 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ff61795a4d13..ea89077bb8e0 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -605,7 +605,7 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
-	annotation_config__init();
+	annotation_config__init(&annotate.opts);
 
 	symbol_conf.try_vmlinux_path = true;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 9483b3f0cae3..72a12b69f120 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1507,7 +1507,7 @@ int cmd_report(int argc, const char **argv)
 			symbol_conf.priv_size += sizeof(u32);
 			symbol_conf.sort_by_name = true;
 		}
-		annotation_config__init();
+		annotation_config__init(&report.annotation_opts);
 	}
 
 	if (symbol__init(&session->header.env) < 0)
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 3e37747364e0..f6dd1a63f159 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1683,7 +1683,7 @@ int cmd_top(int argc, const char **argv)
 	if (status < 0)
 		goto out_delete_evlist;
 
-	annotation_config__init();
+	annotation_config__init(&top.annotation_opts);
 
 	symbol_conf.try_vmlinux_path = (symbol_conf.vmlinux_name == NULL);
 	status = symbol__init(NULL);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e05aeee40ed1..4e2706274d85 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3071,66 +3071,46 @@ int symbol__annotate2(struct map_symbol *ms, struct evsel *evsel,
 	return err;
 }
 
-#define ANNOTATION__CFG(n) \
-	{ .name = #n, .value = &annotation__default_options.n, }
-
-/*
- * Keep the entries sorted, they are bsearch'ed
- */
-static struct annotation_config {
-	const char *name;
-	void *value;
-} annotation__configs[] = {
-	ANNOTATION__CFG(hide_src_code),
-	ANNOTATION__CFG(jump_arrows),
-	ANNOTATION__CFG(offset_level),
-	ANNOTATION__CFG(show_linenr),
-	ANNOTATION__CFG(show_nr_jumps),
-	ANNOTATION__CFG(show_nr_samples),
-	ANNOTATION__CFG(show_total_period),
-	ANNOTATION__CFG(use_offset),
-};
-
-#undef ANNOTATION__CFG
-
-static int annotation_config__cmp(const void *name, const void *cfgp)
+static int annotation__config(const char *var, const char *value, void *data)
 {
-	const struct annotation_config *cfg = cfgp;
-
-	return strcmp(name, cfg->name);
-}
-
-static int annotation__config(const char *var, const char *value,
-			    void *data __maybe_unused)
-{
-	struct annotation_config *cfg;
-	const char *name;
+	struct annotation_options *opt = data;
 
 	if (!strstarts(var, "annotate."))
 		return 0;
 
-	name = var + 9;
-	cfg = bsearch(name, annotation__configs, ARRAY_SIZE(annotation__configs),
-		      sizeof(struct annotation_config), annotation_config__cmp);
-
-	if (cfg == NULL)
-		pr_debug("%s variable unknown, ignoring...", var);
-	else if (strcmp(var, "annotate.offset_level") == 0) {
-		perf_config_int(cfg->value, name, value);
-
-		if (*(int *)cfg->value > ANNOTATION__MAX_OFFSET_LEVEL)
-			*(int *)cfg->value = ANNOTATION__MAX_OFFSET_LEVEL;
-		else if (*(int *)cfg->value < ANNOTATION__MIN_OFFSET_LEVEL)
-			*(int *)cfg->value = ANNOTATION__MIN_OFFSET_LEVEL;
+	if (!strcmp(var, "annotate.offset_level")) {
+		perf_config_u8(&opt->offset_level, "offset_level", value);
+
+		if (opt->offset_level > ANNOTATION__MAX_OFFSET_LEVEL)
+			opt->offset_level = ANNOTATION__MAX_OFFSET_LEVEL;
+		else if (opt->offset_level < ANNOTATION__MIN_OFFSET_LEVEL)
+			opt->offset_level = ANNOTATION__MIN_OFFSET_LEVEL;
+	} else if (!strcmp(var, "annotate.hide_src_code")) {
+		opt->hide_src_code = perf_config_bool("hide_src_code", value);
+	} else if (!strcmp(var, "annotate.jump_arrows")) {
+		opt->jump_arrows = perf_config_bool("jump_arrows", value);
+	} else if (!strcmp(var, "annotate.show_linenr")) {
+		opt->show_linenr = perf_config_bool("show_linenr", value);
+	} else if (!strcmp(var, "annotate.show_nr_jumps")) {
+		opt->show_nr_jumps = perf_config_bool("show_nr_jumps", value);
+	} else if (!strcmp(var, "annotate.show_nr_samples")) {
+		symbol_conf.show_nr_samples = perf_config_bool("show_nr_samples",
+								value);
+	} else if (!strcmp(var, "annotate.show_total_period")) {
+		symbol_conf.show_total_period = perf_config_bool("show_total_period",
+								value);
+	} else if (!strcmp(var, "annotate.use_offset")) {
+		opt->use_offset = perf_config_bool("use_offset", value);
 	} else {
-		*(bool *)cfg->value = perf_config_bool(name, value);
+		pr_debug("%s variable unknown, ignoring...", var);
 	}
+
 	return 0;
 }
 
-void annotation_config__init(void)
+void annotation_config__init(struct annotation_options *opt)
 {
-	perf_config(annotation__config, NULL);
+	perf_config(annotation__config, opt);
 }
 
 static unsigned int parse_percent_type(char *str1, char *str2)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 632e28b67990..d9b5bb105056 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -83,8 +83,6 @@ struct annotation_options {
 	     full_path,
 	     show_linenr,
 	     show_nr_jumps,
-	     show_nr_samples,
-	     show_total_period,
 	     show_minmax_cycle,
 	     show_asm_raw,
 	     annotate_src;
@@ -407,7 +405,7 @@ static inline int symbol__tui_annotate(struct map_symbol *ms __maybe_unused,
 }
 #endif
 
-void annotation_config__init(void);
+void annotation_config__init(struct annotation_options *opt);
 
 int annotate_parse_percent_type(const struct option *opt, const char *_str,
 				int unset);
-- 
2.24.1

