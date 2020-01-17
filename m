Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61526C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CEF20730
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbgAQJsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:48:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbgAQJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:48:08 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00H9Ddbm102034
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 04:26:28 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xk0qgdutv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 04:26:27 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Fri, 17 Jan 2020 09:26:25 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 17 Jan 2020 09:26:21 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00H9QKd836569336
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jan 2020 09:26:20 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADF5D4C06F;
        Fri, 17 Jan 2020 09:26:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37F3B4C059;
        Fri, 17 Jan 2020 09:26:19 +0000 (GMT)
Received: from bangoria.in.ibm.com (unknown [9.124.31.171])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 17 Jan 2020 09:26:19 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 3/3] perf annotate: Fix segfault with source toggle
Date:   Fri, 17 Jan 2020 14:56:12 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200117092612.30874-1-ravi.bangoria@linux.ibm.com>
References: <20200117092612.30874-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011709-0008-0000-0000-0000034A3A90
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011709-0009-0000-0000-00004A6A96B4
Message-Id: <20200117092612.30874-4-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_02:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001170072
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While rendering annotate browser from perf report tui, we keep track
of total number of lines(asm + source) in annotation->nr_entries and
total number of asm lines in annotation->nr_asm_entries. But we don't
reset them before starting. Thus if user annotates same function
multiple times, we restart incrementing these fields with old values.

This causes a segfault when user tries to toggle source code after
annotating same function multiple times. Fix it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/annotate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fe98d29dfbc4..df09c2070337 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2610,6 +2610,8 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
 	struct annotation_line *al;
 
 	notes->max_line_len = 0;
+	notes->nr_entries = 0;
+	notes->nr_asm_entries = 0;
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		size_t line_len = strlen(al->line);
-- 
2.24.1

