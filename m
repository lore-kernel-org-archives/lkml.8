Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33854C34031
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 131F824654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgBTGh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:37:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725962AbgBTGh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:37:57 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01K6Ns99048858
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:37:56 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y99pfdmrk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 01:37:56 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <naveen.n.rao@linux.vnet.ibm.com>;
        Thu, 20 Feb 2020 06:37:54 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 20 Feb 2020 06:37:51 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 01K6bokh42664382
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Feb 2020 06:37:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F15A642047;
        Thu, 20 Feb 2020 06:37:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2381E4203F;
        Thu, 20 Feb 2020 06:37:48 +0000 (GMT)
Received: from naverao1-tp.ibmuc.com (unknown [9.199.56.212])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 20 Feb 2020 06:37:47 +0000 (GMT)
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] tools headers: Move powerpc and s390 syscall table check to check-headers.sh
Date:   Thu, 20 Feb 2020 12:07:40 +0530
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20022006-0016-0000-0000-000002E87C09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022006-0017-0000-0000-0000334B96ED
Message-Id: <20200220063740.785913-1-naveen.n.rao@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-20_01:2020-02-19,2020-02-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002200046
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is good to know changes in headers and syscall tables across all
architectures so that the changes can be sync'ed at once. Move check for
arch-specific syscall table changes from tools/perf/arch for powerpc and
s390, to the generic check-headers.sh script, similar to how we do the
check for x86.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Thomas, Hendrik,
I see quite some changes with s390 syscall table since the previous 
sync. You may want to take a look.

- Naveen


 tools/perf/arch/powerpc/Makefile | 7 -------
 tools/perf/arch/s390/Makefile    | 4 ----
 tools/perf/check-headers.sh      | 2 ++
 3 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index e58d00d62f02..840ea0e59287 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -14,7 +14,6 @@ PERF_HAVE_JITDUMP := 1
 out    := $(OUTPUT)arch/powerpc/include/generated/asm
 header32 := $(out)/syscalls_32.c
 header64 := $(out)/syscalls_64.c
-syskrn := $(srctree)/arch/powerpc/kernel/syscalls/syscall.tbl
 sysprf := $(srctree)/tools/perf/arch/powerpc/entry/syscalls
 sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
@@ -23,15 +22,9 @@ systbl := $(sysprf)/mksyscalltbl
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header64): $(sysdef) $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-	(diff -B $(sysdef) $(syskrn) >/dev/null) \
-	|| echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' '64' $(sysdef) > $@
 
 $(header32): $(sysdef) $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-	(diff -B $(sysdef) $(syskrn) >/dev/null) \
-	|| echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' '32' $(sysdef) > $@
 
 clean::
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 6ac8887be7c9..74bffbea03e2 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -12,7 +12,6 @@ PERF_HAVE_JITDUMP := 1
 
 out    := $(OUTPUT)arch/s390/include/generated/asm
 header := $(out)/syscalls_64.c
-syskrn := $(srctree)/arch/s390/kernel/syscalls/syscall.tbl
 sysprf := $(srctree)/tools/perf/arch/s390/entry/syscalls
 sysdef := $(sysprf)/syscall.tbl
 systbl := $(sysprf)/mksyscalltbl
@@ -21,9 +20,6 @@ systbl := $(sysprf)/mksyscalltbl
 _dummy := $(shell [ -d '$(out)' ] || mkdir -p '$(out)')
 
 $(header): $(sysdef) $(systbl)
-	@(test -d ../../kernel -a -d ../../tools -a -d ../perf && ( \
-        (diff -B $(sysdef) $(syskrn) >/dev/null) \
-        || echo "Warning: Kernel ABI header at '$(sysdef)' differs from latest version at '$(syskrn)'" >&2 )) || true
 	$(Q)$(SHELL) '$(systbl)' $(sysdef) > $@
 
 clean::
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 68039a96c1dc..272d9ad33bf9 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -123,5 +123,7 @@ check arch/x86/lib/insn.c             '-I "^#include [\"<]\(../include/\)*asm/in
 
 # diff non-symmetric files
 check_2 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl arch/x86/entry/syscalls/syscall_64.tbl
+check_2 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl arch/powerpc/kernel/syscalls/syscall.tbl
+check_2 tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscalls/syscall.tbl
 
 cd tools/perf
-- 
2.24.1

