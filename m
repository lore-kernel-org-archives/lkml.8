Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF860C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:53:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9015B21582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbgBDExZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:53:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727347AbgBDExU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:53:20 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0144k1vf132113
        for <linux-kernel@vger.kernel.org>; Mon, 3 Feb 2020 23:53:19 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xxfrvjy5y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 23:53:18 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 4 Feb 2020 04:53:16 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Feb 2020 04:53:14 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0144qKGR50004426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 04:52:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 250BC11C050;
        Tue,  4 Feb 2020 04:53:13 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3722611C054;
        Tue,  4 Feb 2020 04:53:10 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.60.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 04:53:09 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v3 6/6] perf annotate: Get rid of annotation->nr_jumps
Date:   Tue,  4 Feb 2020 10:22:33 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
References: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020404-0020-0000-0000-000003A6C191
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020404-0021-0000-0000-000021FE8568
Message-Id: <20200204045233.474937-7-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_01:2020-02-04,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_jumps from struct annotation is not used since it's inception in
commit 2402e4a936a0 ("perf annotate browser: Show 'jumpy' functions").
Get rid of it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/annotate.c | 2 --
 tools/perf/util/annotate.h | 1 -
 2 files changed, 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index bf7b5eefb990..b2a26adeb4cd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2611,8 +2611,6 @@ static void annotation__mark_jump_targets(struct annotation *notes, struct symbo
 
 		if (++al->jump_sources > notes->max_jump_sources)
 			notes->max_jump_sources = al->jump_sources;
-
-		++notes->nr_jumps;
 	}
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 3b6848c1d593..2f333dfb586d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -281,7 +281,6 @@ struct annotation {
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
-	int			nr_jumps;
 	int			max_jump_sources;
 	int			nr_entries;
 	int			nr_asm_entries;
-- 
2.24.1

