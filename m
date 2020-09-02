Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100D0C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD70820767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FhSmNf9A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIBEao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:30:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:18144 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726755AbgIBEad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:30:33 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0824DS8F084329;
        Wed, 2 Sep 2020 00:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=rTG77Xf8QbKTzcCimDkhTPuRC+vx7lwB9xW36lycOxE=;
 b=FhSmNf9AQxC5NkYaabvLrZn11htJFxqLMlWFEZxLmnNS0aA8YSu2F+zl14Ngl20ePpYV
 b8w272eGGhhAlk/7xvwmuWLvDEPZiV1Ms4Ay5i5/+PiKAMg5D2eKZgj5s/T+J4c/OiKy
 PJru/HbGJvw/F8KEPAAxEOE0fSQgjlNLxEYbaGK8Ye2KiNbG0+8K/ik+Y9MI9P2kVFRv
 opfP/McohT7pYhTH0lVCg+NPuJfOmwYN9AWrbzYZQOYPoVbuw1p2jjmOmvYk2I7xzVUn
 k5XCQy2cjGmdwISAmhAYwtHF+IeJ2nUOI86e52t1Cmuu2ZWmjUMTvxNCt8sYiu9SIZtc zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a462gaj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:30:17 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0824Dw2r084714;
        Wed, 2 Sep 2020 00:30:17 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33a462gagn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:30:16 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0824RYqf008622;
        Wed, 2 Sep 2020 04:30:14 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 337en8c80h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 04:30:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0824UB4w23921140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 04:30:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 803E0A4054;
        Wed,  2 Sep 2020 04:30:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 35E5CA405C;
        Wed,  2 Sep 2020 04:30:09 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 04:30:09 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] powerpc/watchpoint/ptrace: Introduce PPC_DEBUG_FEATURE_DATA_BP_ARCH_31
Date:   Wed,  2 Sep 2020 09:59:44 +0530
Message-Id: <20200902042945.129369-8-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_02:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009020037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PPC_DEBUG_FEATURE_DATA_BP_ARCH_31 can be used to determine whether
we are running on an ISA 3.1 compliant machine. Which is needed to
determine DAR behaviour, 512 byte boundary limit etc. This was
requested by Pedro Miraglia Franco de Carvalho for extending
watchpoint features in gdb. Note that availability of 2nd DAWR is
independent of this flag and should be checked using
ppc_debug_info->num_data_bps.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 Documentation/powerpc/ptrace.rst          | 1 +
 arch/powerpc/include/uapi/asm/ptrace.h    | 1 +
 arch/powerpc/kernel/ptrace/ptrace-noadv.c | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/Documentation/powerpc/ptrace.rst b/Documentation/powerpc/ptrace.rst
index 864d4b6dddd1..77725d69eb4a 100644
--- a/Documentation/powerpc/ptrace.rst
+++ b/Documentation/powerpc/ptrace.rst
@@ -46,6 +46,7 @@ features will have bits indicating whether there is support for::
   #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x4
   #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x8
   #define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x10
+  #define PPC_DEBUG_FEATURE_DATA_BP_ARCH_31		0x20
 
 2. PTRACE_SETHWDEBUG
 
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index f5f1ccc740fc..7004cfea3f5f 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -222,6 +222,7 @@ struct ppc_debug_info {
 #define PPC_DEBUG_FEATURE_DATA_BP_RANGE		0x0000000000000004
 #define PPC_DEBUG_FEATURE_DATA_BP_MASK		0x0000000000000008
 #define PPC_DEBUG_FEATURE_DATA_BP_DAWR		0x0000000000000010
+#define PPC_DEBUG_FEATURE_DATA_BP_ARCH_31	0x0000000000000020
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/kernel/ptrace/ptrace-noadv.c b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
index 48c52426af80..aa36fcad36cd 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-noadv.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-noadv.c
@@ -57,6 +57,8 @@ void ppc_gethwdinfo(struct ppc_debug_info *dbginfo)
 	} else {
 		dbginfo->features = 0;
 	}
+	if (cpu_has_feature(CPU_FTR_ARCH_31))
+		dbginfo->features |= PPC_DEBUG_FEATURE_DATA_BP_ARCH_31;
 }
 
 int ptrace_get_debugreg(struct task_struct *child, unsigned long addr,
-- 
2.26.2

