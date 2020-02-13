Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5216CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C672082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgBMGod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:44:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729767AbgBMGoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:44:32 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D6fFwo017552
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4qyahccj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:30 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 13 Feb 2020 06:44:28 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 06:44:24 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D6iMFU61800632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 06:44:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A06C342049;
        Thu, 13 Feb 2020 06:44:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0FE94204B;
        Thu, 13 Feb 2020 06:44:17 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.58.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 06:44:17 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 3/8] perf annotate: Fix --show-nr-samples for tui/stdio2
Date:   Thu, 13 Feb 2020 12:13:01 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021306-0016-0000-0000-000002E65BD9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021306-0017-0000-0000-000033495BC9
Message-Id: <20200213064306.160480-4-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf annotate --show-nr-samples does not really show number of samples.
The reason is we have two separate variables for the same purpose. One
is in symbol_conf.show_nr_samples and another is
annotation_options.show_nr_samples. We save command line option
in symbol_conf.show_nr_samples but uses
annotation_option.show_nr_samples while rendering tui/stdio2 browser.

Though, we copy symbol_conf.show_nr_samples to
annotation__default_options.show_nr_samples but that is not really
effective as we don't use annotation__default_options once we copy
default options to dynamic variable annotate.opts in cmd_annotate().

Instead of all these complication, keep only one variable and use it
all over. symbol_conf.show_nr_samples is used by perf report/top as
well. So let's kill annotation_options.show_nr_samples.

On a side note, I've kept annotation_options.show_nr_samples definition
because it's still used by perf-config code. Follow up patch to fix
perf-config for annotate will remove annotation_options.show_nr_samples.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/ui/browsers/annotate.c | 6 +++---
 tools/perf/util/annotate.c        | 6 ++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 7e5b44becb5c..9023267e5643 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -835,9 +835,9 @@ static int annotate_browser__run(struct annotate_browser *browser,
 		case 't':
 			if (symbol_conf.show_total_period) {
 				symbol_conf.show_total_period = false;
-				notes->options->show_nr_samples = true;
-			} else if (notes->options->show_nr_samples)
-				notes->options->show_nr_samples = false;
+				symbol_conf.show_nr_samples = true;
+			} else if (symbol_conf.show_nr_samples)
+				symbol_conf.show_nr_samples = false;
 			else
 				symbol_conf.show_total_period = true;
 			annotation__update_column_widths(notes);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index c0c3832e3789..e05aeee40ed1 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2894,7 +2894,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 			obj__set_percent_color(obj, percent, current_entry);
 			if (symbol_conf.show_total_period) {
 				obj__printf(obj, "%11" PRIu64 " ", al->data[i].he.period);
-			} else if (notes->options->show_nr_samples) {
+			} else if (symbol_conf.show_nr_samples) {
 				obj__printf(obj, "%6" PRIu64 " ",
 						   al->data[i].he.nr_samples);
 			} else {
@@ -2909,7 +2909,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		else {
 			obj__printf(obj, "%-*s", pcnt_width,
 					   symbol_conf.show_total_period ? "Period" :
-					   notes->options->show_nr_samples ? "Samples" : "Percent");
+					   symbol_conf.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
 
@@ -3131,8 +3131,6 @@ static int annotation__config(const char *var, const char *value,
 void annotation_config__init(void)
 {
 	perf_config(annotation__config, NULL);
-
-	annotation__default_options.show_nr_samples   = symbol_conf.show_nr_samples;
 }
 
 static unsigned int parse_percent_type(char *str1, char *str2)
-- 
2.24.1

