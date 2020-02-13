Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38ABEC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AFCF2082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgBMGo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:44:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729849AbgBMGoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:44:55 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01D6eIEJ067876
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:54 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y4j870ad7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 01:44:54 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Thu, 13 Feb 2020 06:44:52 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 13 Feb 2020 06:44:48 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01D6ikcB34734408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Feb 2020 06:44:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64EAB42049;
        Thu, 13 Feb 2020 06:44:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 885A642041;
        Thu, 13 Feb 2020 06:44:41 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.58.40])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Feb 2020 06:44:41 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     acme@kernel.org, jolsa@redhat.com
Cc:     xieyisheng1@huawei.com, alexey.budankov@linux.intel.com,
        treeze.taeung@gmail.com, adrian.hunter@intel.com,
        tmricht@linux.ibm.com, namhyung@kernel.org, irogers@google.com,
        songliubraving@fb.com, yao.jin@linux.intel.com,
        changbin.du@intel.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH 8/8] perf config: Document missing config options
Date:   Thu, 13 Feb 2020 12:13:06 +0530
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
References: <20200213064306.160480-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20021306-0020-0000-0000-000003A9AEB8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20021306-0021-0000-0000-0000220197E7
Message-Id: <20200213064306.160480-9-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-13_01:2020-02-12,2020-02-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002130052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While documenting annotate.show_nr_samples config option, I found many
other config options missing in perf-config documentation. Add them.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/Documentation/perf-config.txt | 44 ++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Documentation/perf-config.txt
index 9dae0df3ab7e..8ead55593984 100644
--- a/tools/perf/Documentation/perf-config.txt
+++ b/tools/perf/Documentation/perf-config.txt
@@ -518,6 +518,12 @@ top.*::
 		column by default.
 		The default is 'true'.
 
+	top.call-graph::
+		This is identical to 'call-graph.record-mode', except it is
+		applicable only for 'top' subcommand. This option ONLY setup
+		the unwind method. To enable 'perf top' to actually use it,
+		the command line option -g must be specified.
+
 man.*::
 	man.viewer::
 		This option can assign a tool to view manual pages when 'help'
@@ -545,6 +551,16 @@ record.*::
 		But if this option is 'no-cache', it will not update the build-id cache.
 		'skip' skips post-processing and does not update the cache.
 
+	record.call-graph::
+		This is identical to 'call-graph.record-mode', except it is
+		applicable only for 'record' subcommand. This option ONLY setup
+		the unwind method. To enable 'perf record' to actually use it,
+		the command line option -g must be specified.
+
+	record.aio::
+		Use 'n' control blocks in asynchronous (Posix AIO) trace writing
+		mode ('n' default: 1, max: 4).
+
 diff.*::
 	diff.order::
 		This option sets the number of columns to sort the result.
@@ -594,6 +610,11 @@ trace.*::
 		"libbeauty", the default, to use the same argument beautifiers used in the
 		strace-like sys_enter+sys_exit lines.
 
+ftrace.*::
+	ftrace.tracer::
+		Can be used to select the default tracer. Possible values are
+		'function' and 'function_graph'.
+
 llvm.*::
 	llvm.clang-path::
 		Path to clang. If omit, search it from $PATH.
@@ -638,6 +659,29 @@ scripts.*::
 	The script gets the same options passed as a full perf script,
 	in particular -i perfdata file, --cpu, --tid
 
+convert.*::
+
+	convert.queue-size::
+		Limit the size of ordered_events queue, so we could control
+		allocation size of perf data files without proper finished
+		round events.
+
+intel-pt.*::
+
+	intel-pt.cache-divisor::
+
+	intel-pt.mispred-all::
+		If set, Intel PT decoder will set the mispred flag on all
+		branches.
+
+auxtrace.*::
+
+	auxtrace.dumpdir::
+		s390 only. The directory to save the auxiliary trace buffer
+		can be changed using this option. Ex, auxtrace.dumpdir=/tmp.
+		If the directory does not exist or has the wrong file type,
+		the current directory is used.
+
 SEE ALSO
 --------
 linkperf:perf[1]
-- 
2.24.1

