Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7BFC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 839A62067C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 04:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YoUagbRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgIBEaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 00:30:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12864 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726021AbgIBEaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 00:30:21 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08240iGX133779;
        Wed, 2 Sep 2020 00:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WueL5bbnAhStAjp91dYVMqaOCtsmfsblMRkQBxibmcs=;
 b=YoUagbRpGI6C36m5v68OKwd+I4QEd8eiHkpFTlDwVLDyrHyYwuN6MoqZebeHAkl/sJ53
 VlVNsYwXcmPBV08UpMxe3d9d83V2OfS8st37tZXQ8+n/r5vL/JqTitqljzn3oVTCszCh
 KsL74MWM0iDJeOyJhROl6AT65D1j+hcl+If5f+zRRcu7KpRQKppc5AjVTHaCefd1tzrT
 njHqkvt3YXbc8r4mVkLgW+d67qOaMiN4uJ+xCXxB9sq3c0Ov31u+8FFHG9Rws5NfCJfL
 CofUa1OJ+MSYyhMZEHMQMvoW/yni8LKQ8O+/gzY7jy9Mrvhgo+aH1W8jbp5z4NVbQBUW bg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33a160mbtk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:30:00 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08240iZF133734;
        Wed, 2 Sep 2020 00:30:00 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 33a160mbt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 00:30:00 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0824QfA5011524;
        Wed, 2 Sep 2020 04:29:58 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04fra.de.ibm.com with ESMTP id 339ap7rwy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 04:29:58 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0824SNwL16515494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Sep 2020 04:28:23 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8212A405B;
        Wed,  2 Sep 2020 04:29:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1DF68A4054;
        Wed,  2 Sep 2020 04:29:52 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.37.120])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  2 Sep 2020 04:29:51 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, christophe.leroy@c-s.fr
Cc:     ravi.bangoria@linux.ibm.com, mikey@neuling.org, paulus@samba.org,
        naveen.n.rao@linux.vnet.ibm.com, pedromfc@linux.ibm.com,
        rogealve@linux.ibm.com, jniethe5@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/8] powerpc/watchpoint: Fix quarword instruction handling on p10 predecessors
Date:   Wed,  2 Sep 2020 09:59:38 +0530
Message-Id: <20200902042945.129369-2-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
References: <20200902042945.129369-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-02_02:2020-09-01,2020-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020031
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
 arch/powerpc/include/asm/hw_breakpoint.h |  1 +
 arch/powerpc/kernel/hw_breakpoint.c      | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index db206a7f38e2..9b68eafebf43 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -42,6 +42,7 @@ struct arch_hw_breakpoint {
 #else
 #define HW_BREAKPOINT_SIZE  0x8
 #endif
+#define HW_BREAKPOINT_SIZE_QUADWORD	0x10
 
 #define DABR_MAX_LEN	8
 #define DAWR_MAX_LEN	512
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

