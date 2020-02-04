Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C7CC3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 922762084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 04:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBDEw7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 23:52:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727150AbgBDEw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 23:52:59 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0144n5x5125807
        for <linux-kernel@vger.kernel.org>; Mon, 3 Feb 2020 23:52:58 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xxhfb483c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 23:52:58 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Tue, 4 Feb 2020 04:52:56 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Feb 2020 04:52:53 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0144pxq047972844
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Feb 2020 04:51:59 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7010911C04C;
        Tue,  4 Feb 2020 04:52:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60DBB11C050;
        Tue,  4 Feb 2020 04:52:49 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.60.95])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Feb 2020 04:52:49 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     namhyung@kernel.org, irogers@google.com, songliubraving@fb.com,
        yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH v3 0/6] perf annotate: Misc fixes / improvements
Date:   Tue,  4 Feb 2020 10:22:27 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20020404-0020-0000-0000-000003A6C18B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20020404-0021-0000-0000-000021FE8562
Message-Id: <20200204045233.474937-1-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-04_01:2020-02-04,2020-02-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=944 spamscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2002040035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few fixes / improvements related to perf annotate.

v2: https://lore.kernel.org/r/20200124080432.8065-1-ravi.bangoria@linux.ibm.com

v2->v3:
 - [PATCH v3 2/6] New function annotation_line__exit() to clear
   annotation_line objects.

v1: http://lore.kernel.org/r/20200117092612.30874-1-ravi.bangoria@linux.ibm.com

v1->v2:
 - Split [PATCH v1 1/3] into two patches.
 - Patch 5 and patch 6 are new.

Ravi Bangoria (6):
  perf annotate: Remove privsize from symbol__annotate() args
  perf annotate: Simplify disasm_line allocation and freeing code
  perf annotate: Align struct annotate_args
  perf annotate: Fix segfault with source toggle
  perf annotate: Make few functions static
  perf annotate: Get rid of annotation->nr_jumps

 tools/perf/builtin-top.c     |   2 +-
 tools/perf/ui/gtk/annotate.c |   2 +-
 tools/perf/util/annotate.c   | 115 ++++++++++++++---------------------
 tools/perf/util/annotate.h   |   8 +--
 4 files changed, 49 insertions(+), 78 deletions(-)

-- 
2.24.1

