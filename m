Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4309C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74DC20678
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s08+8sOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgHYEgy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:36:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22680 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725900AbgHYEgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:36:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07P4XGjT112175;
        Tue, 25 Aug 2020 00:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=g8/ESLF6QPK7iC7HMbfZ/nTQORJG2JSioRv2Q4EOBXc=;
 b=s08+8sOFM8gz8EVRy4i5mQw6IMrMpdePBNua8f/qYghPMSW8koWawYg+gkN2DHCxZ2gX
 D+TyUPGcJTsE4JVFPNy/uoI9gIC+YC2lx878GqRsDglhpbSf1bpdrPxvYjIj7AM0J+94
 KbiVasg/J++lKOGgow5YSXiIrOdrPJa2P3SVupEiXR3koHebDdG8MurVJdCg2lCjzA+O
 oOWDkR4ovmM4UhrzBoW5XIljm0VRr7APn0qii/RjDonxSyUX5Wy3oKCajZoB3w3jE89u
 KLAletjOvxqvbcvxEgPhHCWFM/jBJv4yblDAkxhEaTh4F+iL+HF05lr+AyXRswQ+nCvs FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334s1ybjgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 00:36:33 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07P4Yje2115479;
        Tue, 25 Aug 2020 00:36:32 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 334s1ybjev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 00:36:32 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07P4WfXH008323;
        Tue, 25 Aug 2020 04:36:30 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 332ujrsua9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Aug 2020 04:36:29 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07P4aRxB28246280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Aug 2020 04:36:27 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA14DAE051;
        Tue, 25 Aug 2020 04:36:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 353A9AE045;
        Tue, 25 Aug 2020 04:36:24 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.33.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Aug 2020 04:36:23 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/8] powerpc/watchpoint: Fix quarword instruction handling on p10 predecessors
Date:   Tue, 25 Aug 2020 10:06:10 +0530
Message-Id: <20200825043617.1073634-2-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
References: <20200825043617.1073634-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-24_12:2020-08-24,2020-08-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2008250035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On p10 predecessors, watchpoint with quarword access is compared at
quardword length. If the watch range is doubleword or less than that
in a first half of quarword aligned 16 bytes, and if there is any
unaligned quadword access which will access only the 2nd half, the
handler should consider it as extraneous and emulate/single-step it
before continuing.

Reported-by: Pedro Miraglia Franco de Carvalho <pedromfc@linux.ibm.com>
Fixes: 74c6881019b7 ("powerpc/watchpoint: Prepare handler to handle more than one watchpoint")
Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hw_breakpoint.h |  3 ++-
 arch/powerpc/kernel/hw_breakpoint.c      | 12 ++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index db206a7f38e2..da38e05e04d9 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -40,7 +40,8 @@ struct arch_hw_breakpoint {
 #ifdef CONFIG_PPC_8xx
 #define HW_BREAKPOINT_SIZE  0x4
 #else
-#define HW_BREAKPOINT_SIZE  0x8
+#define HW_BREAKPOINT_SIZE		0x8
+#define HW_BREAKPOINT_SIZE_QUADWORD	0x10
 #endif
 
 #define DABR_MAX_LEN	8
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 1f4a1efa0074..9f7df1c37233 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -520,9 +520,17 @@ static bool ea_hw_range_overlaps(unsigned long ea, int size,
 				 struct arch_hw_breakpoint *info)
 {
 	unsigned long hw_start_addr, hw_end_addr;
+	unsigned long align_size = HW_BREAKPOINT_SIZE;
 
-	hw_start_addr = ALIGN_DOWN(info->address, HW_BREAKPOINT_SIZE);
-	hw_end_addr = ALIGN(info->address + info->len, HW_BREAKPOINT_SIZE);
+	/*
+	 * On p10 predecessors, quadword is handle differently then
+	 * other instructions.
+	 */
+	if (!cpu_has_feature(CPU_FTR_ARCH_31) && size == 16)
+		align_size = HW_BREAKPOINT_SIZE_QUADWORD;
+
+	hw_start_addr = ALIGN_DOWN(info->address, align_size);
+	hw_end_addr = ALIGN(info->address + info->len, align_size);
 
 	return ((ea < hw_end_addr) && (ea + size > hw_start_addr));
 }
-- 
2.26.2

