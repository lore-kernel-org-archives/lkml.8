Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4792C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83D852082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgBMGon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:44:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36498 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729767AbgBMGon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:44:43 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D6ifFU096802
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y3wxf8wuw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:41 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 13 Feb 2020 06:44:32 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 06:44:28 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D6iRh850462812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 06:44:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50E1942047;
        Thu, 13 Feb 2020 06:44:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B2B842045;
        Thu, 13 Feb 2020 06:44:23 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.58.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 06:44:22 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 4/8] perf config: Introduce perf_config_u8()
Date:   Thu, 13 Feb 2020 12:13:02 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021306-0016-0000-0000-000002E65BDB
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021306-0017-0000-0000-000033495BCB
Message-Id: <20200213064306.160480-5-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 bulkscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce perf_config_u8() utility function to convert char * input
into u8 destination. We will utilize it in followup patch.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/config.c | 12 ++++++++++++
 tools/perf/util/config.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index 0bc9c4d7fdc5..ef38eba56ed0 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -374,6 +374,18 @@ int perf_config_int(int *dest, const char *name, const char *value)
 	return 0;
 }
 
+int perf_config_u8(u8 *dest, const char *name, const char *value)
+{
+	long ret = 0;
+
+	if (!perf_parse_long(value, &ret)) {
+		bad_config(name);
+		return -1;
+	}
+	*dest = ret;
+	return 0;
+}
+
 static int perf_config_bool_or_int(const char *name, const char *value, int *is_bool)
 {
 	int ret;
diff --git a/tools/perf/util/config.h b/tools/perf/util/config.h
index bd0a5897c76a..c10b66dde2f3 100644
--- a/tools/perf/util/config.h
+++ b/tools/perf/util/config.h
@@ -29,6 +29,7 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 int perf_default_config(const char *, const char *, void *);
 int perf_config(config_fn_t fn, void *);
 int perf_config_int(int *dest, const char *, const char *);
+int perf_config_u8(u8 *dest, const char *name, const char *value);
 int perf_config_u64(u64 *dest, const char *, const char *);
 int perf_config_bool(const char *, const char *);
 int config_error_nonbool(const char *);
-- 
2.24.1

