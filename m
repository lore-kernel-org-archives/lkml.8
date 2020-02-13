Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF9C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093582082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgBMGou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:44:50 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729767AbgBMGot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:44:49 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D6fFXL017510
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:48 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2y4qyahcme-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:48 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 13 Feb 2020 06:44:46 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 06:44:42 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D6ifdt36569334
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 06:44:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 256B64203F;
        Thu, 13 Feb 2020 06:44:41 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E73CC42047;
        Thu, 13 Feb 2020 06:44:36 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.58.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 06:44:36 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 7/8] perf annotate: Fix perf config option description
Date:   Thu, 13 Feb 2020 12:13:05 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021306-0008-0000-0000-0000035267D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021306-0009-0000-0000-00004A730FB1
Message-Id: <20200213064306.160480-8-ravi.bangoria@linux.ibm.com>
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

perf config annotate options says it works only with TUI, which is wrong.
Most of the TUI options are applicable to stdio2 as well. So remove that
generic line and add individual line with each option stating which
browsers supports that option. Also, annotate.show_nr_samples config is
missing in Documentation. Describe it.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/Documentation/perf-config.txt | 30 +++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index c4dd23c4b478..9dae0df3ab7e 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -239,7 +239,6 @@ buildid.*::
 		set buildid.dir to /dev/null. The default is $HOME/.debug
 
 annotate.*::
-	These options work only for TUI.
 	These are in control of addresses, jump function, source code
 	in lines of assembly code from a specific program.
 
@@ -269,6 +268,8 @@ annotate.*::
 		│        mov    (%rdi),%rdx
 		│              return n;
 
+		This option works with tui, stdio2 browsers.
+
         annotate.use_offset::
 		Basing on a first address of a loaded function, offset can be used.
 		Instead of using original addresses of assembly code,
@@ -287,6 +288,8 @@ annotate.*::
 
 		             368:│  mov    0x8(%r14),%rdi
 
+		This option works with tui, stdio2 browsers.
+
 	annotate.jump_arrows::
 		There can be jump instruction among assembly code.
 		Depending on a boolean value of jump_arrows,
@@ -306,6 +309,8 @@ annotate.*::
 		│1330:   mov    %r15,%r10
 		│1333:   cmp    %r15,%r14
 
+		This option works with tui browser.
+
         annotate.show_linenr::
 		When showing source code if this option is 'true',
 		line numbers are printed as below.
@@ -325,6 +330,8 @@ annotate.*::
 		│                     array++;
 		│             }
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_nr_jumps::
 		Let's see a part of assembly code.
 
@@ -335,6 +342,8 @@ annotate.*::
 
 		│1 1382:   movb   $0x1,-0x270(%rbp)
 
+		This option works with tui, stdio2 browsers.
+
         annotate.show_total_period::
 		To compare two records on an instruction base, with this option
 		provided, display total number of samples that belong to a line
@@ -348,11 +357,30 @@ annotate.*::
 
 		99.93 │      mov    %eax,%eax
 
+		This option works with tui, stdio2, stdio browsers.
+
+	annotate.show_nr_samples::
+		By default perf annotate shows percentage of samples. This option
+		can be used to print absolute number of samples. Ex, when set as
+		false:
+
+		Percent│
+		 74.03 │      mov    %fs:0x28,%rax
+
+		When set as true:
+
+		Samples│
+		     6 │      mov    %fs:0x28,%rax
+
+		This option works with tui, stdio2, stdio browsers.
+
 	annotate.offset_level::
 		Default is '1', meaning just jump targets will have offsets show right beside
 		the instruction. When set to '2' 'call' instructions will also have its offsets
 		shown, 3 or higher will show offsets for all instructions.
 
+		This option works with tui, stdio2 browsers.
+
 hist.*::
 	hist.percentage::
 		This option control the way to calculate overhead of filtered entries -
-- 
2.24.1

