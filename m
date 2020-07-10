Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76EAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D04492076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGJF2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:28:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50814 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726369AbgGJFWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:22:47 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06A5233a065689;
        Fri, 10 Jul 2020 01:22:20 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk836s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 01:22:19 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06A54svC071807;
        Fri, 10 Jul 2020 01:22:19 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpk8365-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 01:22:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06A5GaN0032336;
        Fri, 10 Jul 2020 05:22:17 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 326bc309me-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 05:22:17 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06A5MErN8651142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 05:22:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 692F4A4054;
        Fri, 10 Jul 2020 05:22:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85164A405B;
        Fri, 10 Jul 2020 05:22:12 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.105.207])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 05:22:12 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        mikey@neuling.org, ravi.bangoria@linux.ibm.com,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] powerpc/powernv/idle: save-restore DAWR0,DAWRX0 for P10
Date:   Fri, 10 Jul 2020 10:52:06 +0530
Message-Id: <20200710052207.12003-3-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200710052207.12003-1-psampat@linux.ibm.com>
References: <20200710052207.12003-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_01:2020-07-09,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 mlxscore=0 mlxlogscore=840 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Additional registers DAWR0, DAWRX0 may be lost on Power 10 for
stop levels < 4.
Therefore save the values of these SPRs before entering a  "stop"
state and restore their values on wakeup.

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 19d94d021357..f2e2a6a4c274 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -600,6 +600,8 @@ struct p9_sprs {
 	u64 iamr;
 	u64 amor;
 	u64 uamor;
+	u64 dawr0;
+	u64 dawrx0;
 };
 
 static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
@@ -687,6 +689,10 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 	sprs.iamr	= mfspr(SPRN_IAMR);
 	sprs.amor	= mfspr(SPRN_AMOR);
 	sprs.uamor	= mfspr(SPRN_UAMOR);
+	if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+		sprs.dawr0 = mfspr(SPRN_DAWR0);
+		sprs.dawrx0 = mfspr(SPRN_DAWRX0);
+	}
 
 	srr1 = isa300_idle_stop_mayloss(psscr);		/* go idle */
 
@@ -710,6 +716,10 @@ static unsigned long power9_idle_stop(unsigned long psscr, bool mmu_on)
 		mtspr(SPRN_IAMR,	sprs.iamr);
 		mtspr(SPRN_AMOR,	sprs.amor);
 		mtspr(SPRN_UAMOR,	sprs.uamor);
+		if (cpu_has_feature(CPU_FTR_ARCH_31)) {
+			mtspr(SPRN_DAWR0, sprs.dawr0);
+			mtspr(SPRN_DAWRX0, sprs.dawrx0);
+		}
 
 		/*
 		 * Workaround for POWER9 DD2.0, if we lost resources, the ERAT
-- 
2.25.4

