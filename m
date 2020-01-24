Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B85AC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782532071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgAXIFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:05:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27672 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730066AbgAXIFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:05:05 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00O84kHf095143
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:05:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xqmjt53cc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 03:05:04 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 24 Jan 2020 08:05:01 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 24 Jan 2020 08:04:58 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00O84wwK40239400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jan 2020 08:04:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E733C4C046;
        Fri, 24 Jan 2020 08:04:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8402F4C050;
        Fri, 24 Jan 2020 08:04:56 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.144])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jan 2020 08:04:56 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v2 5/6] perf annotate: Make few functions static
Date:   Fri, 24 Jan 2020 13:34:31 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124080432.8065-1-ravi.bangoria@linux.ibm.com>
References: <20200124080432.8065-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20012408-0028-0000-0000-000003D3F272
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012408-0029-0000-0000-000024983027
Message-Id: <20200124080432.8065-6-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-24_02:2020-01-24,2020-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001240065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions are not used outside of tools/perf/util/annotate.c.
Make them static.

Suggested-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/annotate.c | 8 ++++----
 tools/perf/util/annotate.h | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 58e2c51e9d62..50b2c99b2551 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1057,7 +1057,7 @@ static void annotation__count_and_fill(struct annotation *notes, u64 start, u64
 	}
 }
 
-void annotation__compute_ipc(struct annotation *notes, size_t size)
+static void annotation__compute_ipc(struct annotation *notes, size_t size)
 {
 	s64 offset;
 
@@ -2578,7 +2578,7 @@ bool disasm_line__is_valid_local_jump(struct disasm_line *dl, struct symbol *sym
 	return true;
 }
 
-void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
+static void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 {
 	u64 offset, size = symbol__size(sym);
 
@@ -2611,7 +2611,7 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 	}
 }
 
-void annotation__set_offsets(struct annotation *notes, s64 size)
+static void annotation__set_offsets(struct annotation *notes, s64 size)
 {
 	struct annotation_line *al;
 
@@ -2667,7 +2667,7 @@ static int annotation__max_ins_name(struct annotation *notes)
 	return max_name;
 }
 
-void annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
+static void annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
 {
 	notes->widths.addr = notes->widths.target =
 		notes->widths.min_addr = hex_width(symbol__size(sym));
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 75c58a759b96..3b6848c1d593 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -316,11 +316,7 @@ static inline bool annotation_line__filter(struct annotation_line *al, struct an
 	return notes->options->hide_src_code && al->offset == -1;
 }
 
-void annotation__set_offsets(struct annotation *notes, s64 size);
-void annotation__compute_ipc(struct annotation *notes, size_t size);
-void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
 void annotation__update_column_widths(struct annotation *notes);
-void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
 
 static inline struct sym_hist *annotated_source__histogram(struct annotated_source *src, int idx)
 {
-- 
2.24.1

