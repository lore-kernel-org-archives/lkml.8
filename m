Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A29C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB76520853
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgGHEv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:51:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10672 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729549AbgGHEvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:51:51 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0684X5i3190639;
        Wed, 8 Jul 2020 00:51:30 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324y2xm507-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 00:51:30 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0684XAgf190924;
        Wed, 8 Jul 2020 00:51:29 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324y2xm4yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 00:51:29 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0684kGVn005724;
        Wed, 8 Jul 2020 04:51:28 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 322hd7v4bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 04:51:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0684pPFw40894700
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 04:51:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F1FFAE045;
        Wed,  8 Jul 2020 04:51:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BCABFAE051;
        Wed,  8 Jul 2020 04:51:21 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.51.84])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 04:51:21 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     ravi.bangoria@linux.ibm.com, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/9] powerpc/watchpoint: Guest support for 2nd DAWR hcall
Date:   Wed,  8 Jul 2020 10:20:44 +0530
Message-Id: <20200708045046.135702-8-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708045046.135702-1-ravi.bangoria@linux.ibm.com>
References: <20200708045046.135702-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_01:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 cotscore=-2147483648 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007080029
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2nd DAWR can be set/unset using H_SET_MODE hcall with resource value 5.
Enable powervm guest support with that. This has no effect on kvm guest
because kvm will return error if guest does hcall with resource value 5.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h         | 1 +
 arch/powerpc/include/asm/machdep.h        | 2 +-
 arch/powerpc/include/asm/plpar_wrappers.h | 5 +++++
 arch/powerpc/kernel/dawr.c                | 2 +-
 arch/powerpc/platforms/pseries/setup.c    | 7 +++++--
 5 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index a7f6f1aeda6b..3f170b9496a1 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -357,6 +357,7 @@
 #define H_SET_MODE_RESOURCE_SET_DAWR0		2
 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE	3
 #define H_SET_MODE_RESOURCE_LE			4
+#define H_SET_MODE_RESOURCE_SET_DAWR1		5
 
 /* Values for argument to H_SIGNAL_SYS_RESET */
 #define H_SIGNAL_SYS_RESET_ALL			-1
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 7bcb64444a39..a90b892f0bfe 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -131,7 +131,7 @@ struct machdep_calls {
 				    unsigned long dabrx);
 
 	/* Set DAWR for this platform, leave empty for default implementation */
-	int		(*set_dawr)(unsigned long dawr,
+	int		(*set_dawr)(int nr, unsigned long dawr,
 				    unsigned long dawrx);
 
 #ifdef CONFIG_PPC32	/* XXX for now */
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 93eb133d572c..d7a1acc83593 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -315,6 +315,11 @@ static inline long plpar_set_watchpoint0(unsigned long dawr0, unsigned long dawr
 	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR0, dawr0, dawrx0);
 }
 
+static inline long plpar_set_watchpoint1(unsigned long dawr1, unsigned long dawrx1)
+{
+	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR1, dawr1, dawrx1);
+}
+
 static inline long plpar_signal_sys_reset(long cpu)
 {
 	return plpar_hcall_norets(H_SIGNAL_SYS_RESET, cpu);
diff --git a/arch/powerpc/kernel/dawr.c b/arch/powerpc/kernel/dawr.c
index 500f52fa4711..cdc2dccb987d 100644
--- a/arch/powerpc/kernel/dawr.c
+++ b/arch/powerpc/kernel/dawr.c
@@ -37,7 +37,7 @@ int set_dawr(int nr, struct arch_hw_breakpoint *brk)
 	dawrx |= (mrd & 0x3f) << (63 - 53);
 
 	if (ppc_md.set_dawr)
-		return ppc_md.set_dawr(dawr, dawrx);
+		return ppc_md.set_dawr(nr, dawr, dawrx);
 
 	if (nr == 0) {
 		mtspr(SPRN_DAWR0, dawr);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 2db8469e475f..d516ee8eb7fc 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -831,12 +831,15 @@ static int pseries_set_xdabr(unsigned long dabr, unsigned long dabrx)
 	return plpar_hcall_norets(H_SET_XDABR, dabr, dabrx);
 }
 
-static int pseries_set_dawr(unsigned long dawr, unsigned long dawrx)
+static int pseries_set_dawr(int nr, unsigned long dawr, unsigned long dawrx)
 {
 	/* PAPR says we can't set HYP */
 	dawrx &= ~DAWRX_HYP;
 
-	return  plpar_set_watchpoint0(dawr, dawrx);
+	if (nr == 0)
+		return plpar_set_watchpoint0(dawr, dawrx);
+	else
+		return plpar_set_watchpoint1(dawr, dawrx);
 }
 
 #define CMO_CHARACTERISTICS_TOKEN 44
-- 
2.26.2

