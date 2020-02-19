Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EB8C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 628DA2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="zBJl5+of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgBSJiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:38:23 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52908 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgBSJiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:38:22 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J9XHMV006368;
        Wed, 19 Feb 2020 09:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=GhykKqJyDb1Rg15XSg/jmTOCOqKW+oHHr1gHq12e8aY=;
 b=zBJl5+oftFaoxNfDOjl/d410bFhtW3AyjIVBmRew3AsEeFg1QE7LF8TimOUamRKjNA1U
 RuNP2mEv4ApGEU43JtnbEI792pdksc7rf7LkMUBix/SyFt5RESPoG07Mat4Y0oTSyd5c
 Do87+MADgtitkySecvfQ8PvnarjsuLFj9Q/5YkifSLbcqxH7POmi6+XS3iqyhYoRgWxP
 u3qRjlUsztpbTawyNKBbC5KO8mIGrg9UILB12q6SrHBT7n4jIZsSXaiKkUC8IIKNs++s
 gIhMHCuTDKngeCEbM5BuMPNQ1Z+p1wHnoHdZat6G3Ff9cr86c31ELXVabNpvXV+GGl1M iQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2y8udd1rpy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 09:38:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01J9X2h1034713;
        Wed, 19 Feb 2020 09:35:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2y8uda4ss0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Feb 2020 09:35:59 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01J9ZwVj005397;
        Wed, 19 Feb 2020 09:35:58 GMT
Received: from dhcp-10-175-189-86.vpn.oracle.com (/10.175.189.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Feb 2020 01:33:59 -0800
From:   Alan Maguire <alan.maguire@oracle.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     mingo@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH v2 1/2] ftrace/selftests: workaround cgroup RT scheduling issues
Date:   Wed, 19 Feb 2020 09:33:29 +0000
Message-Id: <1582104810-12983-2-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
References: <1582104810-12983-1-git-send-email-alan.maguire@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 suspectscore=4 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002190070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9535 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=4
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002190070
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wakeup_rt.tc and wakeup.tc tests in tracers/ subdirectory
fail due to the chrt command returning:

 chrt: failed to set pid 0's policy: Operation not permitted.

To work around this, temporarily disable grout RT scheduling
during ftracetest execution.  Restore original value on
test run completion.  With these changes in place, both
tests consistently pass.

Fixes: c575dea2c1a5 ("selftests/ftrace: Add wakeup_rt tracer testcase")
Fixes: c1edd060b413 ("selftests/ftrace: Add wakeup tracer testcase")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/testing/selftests/ftrace/ftracetest | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 063ecb2..144308a 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -29,8 +29,25 @@ err_ret=1
 # kselftest skip code is 4
 err_skip=4
 
+# cgroup RT scheduling prevents chrt commands from succeeding, which
+# induces failures in test wakeup tests.  Disable for the duration of
+# the tests.
+
+readonly sched_rt_runtime=/proc/sys/kernel/sched_rt_runtime_us
+
+sched_rt_runtime_orig=$(cat $sched_rt_runtime)
+
+setup() {
+  echo -1 > $sched_rt_runtime
+}
+
+cleanup() {
+  echo $sched_rt_runtime_orig > $sched_rt_runtime
+}
+
 errexit() { # message
   echo "Error: $1" 1>&2
+  cleanup
   exit $err_ret
 }
 
@@ -39,6 +56,8 @@ if [ `id -u` -ne 0 ]; then
   errexit "this must be run by root user"
 fi
 
+setup
+
 # Utilities
 absdir() { # file_path
   (cd `dirname $1`; pwd)
@@ -235,6 +254,7 @@ TOTAL_RESULT=0
 
 INSTANCE=
 CASENO=0
+
 testcase() { # testfile
   CASENO=$((CASENO+1))
   desc=`grep "^#[ \t]*description:" $1 | cut -f2 -d:`
@@ -406,5 +426,7 @@ prlog "# of unsupported: " `echo $UNSUPPORTED_CASES | wc -w`
 prlog "# of xfailed: " `echo $XFAILED_CASES | wc -w`
 prlog "# of undefined(test bug): " `echo $UNDEFINED_CASES | wc -w`
 
+cleanup
+
 # if no error, return 0
 exit $TOTAL_RESULT
-- 
1.8.3.1

