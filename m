Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1875C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC44207FC
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 06:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHEG2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:28:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55306 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727114AbgHEG2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 02:28:32 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 075613ds072016;
        Wed, 5 Aug 2020 02:28:11 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32qkgjn5xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 02:28:11 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 075617It072430;
        Wed, 5 Aug 2020 02:28:10 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32qkgjn5wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 02:28:10 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0756H109003829;
        Wed, 5 Aug 2020 06:28:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 32mynhag0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Aug 2020 06:28:08 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0756S4hl10944798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Aug 2020 06:28:04 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 07AD74C040;
        Wed,  5 Aug 2020 06:28:04 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 650D74C044;
        Wed,  5 Aug 2020 06:28:01 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.33.73])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  5 Aug 2020 06:28:01 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        pedromfc@br.ibm.com, rogealve@br.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] powerpc/watchpoint/ptrace: Introduce PPC_DEBUG_FEATURE_DATA_BP_ARCH_31
Date:   Wed,  5 Aug 2020 11:57:50 +0530
Message-Id: <20200805062750.290289-3-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805062750.290289-1-ravi.bangoria@linux.ibm.com>
References: <20200805062750.290289-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-05_04:2020-08-03,2020-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=1
 mlxlogscore=999 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008050049
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
index bf94ab837735..d5be73ab9e74 100644
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

