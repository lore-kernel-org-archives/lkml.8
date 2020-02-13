Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EAB4C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EE91218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgBMGoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:44:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15806 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729767AbgBMGoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:44:46 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D6fRhI192840
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:45 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4j898f33-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:44 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 13 Feb 2020 06:44:42 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 06:44:37 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D6iamB45940986
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 06:44:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52F9D4204C;
        Thu, 13 Feb 2020 06:44:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6C274203F;
        Thu, 13 Feb 2020 06:44:32 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.58.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 06:44:32 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 6/8] perf annotate: Prefer cmdline option over default config
Date:   Thu, 13 Feb 2020 12:13:04 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021306-4275-0000-0000-000003A103CF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021306-4276-0000-0000-000038B503DC
Message-Id: <20200213064306.160480-7-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002130052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For all the perf-config options that can also be set from command line
option, the preference is given to command line version in case of any
conflict. But that's opposite in case of perf annotate. i.e. the more
preference is given to default option rather than command line option.
Fix it.

Before:

  $ ./perf config
  annotate.show_nr_samples=false

  $ ./perf annotate shash --show-nr-samples
  Percent│
         │24:   mov    -0xc(%rbp),%eax
   49.19 │      imul   $0x1003f,%eax,%ecx
         │      mov    -0x18(%rbp),%rax

After:

  Samples│
         │24:   mov    -0xc(%rbp),%eax
       1 │      imul   $0x1003f,%eax,%ecx
         │      mov    -0x18(%rbp),%rax

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/builtin-annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ea89077bb8e0..6c0a0412502e 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -566,6 +566,8 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		return ret;
 
+	annotation_config__init(&annotate.opts);
+
 	argc = parse_options(argc, argv, options, annotate_usage, 0);
 	if (argc) {
 		/*
@@ -605,8 +607,6 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
-	annotation_config__init(&annotate.opts);
-
 	symbol_conf.try_vmlinux_path = true;
 
 	ret = symbol__init(&annotate.session->header.env);
-- 
2.24.1

