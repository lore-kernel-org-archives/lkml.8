Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B67C433F1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3312622D04
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgGWJJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:09:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25274 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728314AbgGWJJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:09:46 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06N93YbY188832;
        Thu, 23 Jul 2020 05:09:27 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f1gxgy5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:09:26 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N93hS3190179;
        Thu, 23 Jul 2020 05:09:26 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32f1gxgy4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:09:26 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N96B9J017349;
        Thu, 23 Jul 2020 09:09:23 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03fra.de.ibm.com with ESMTP id 32brq837cp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 09:09:23 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06N99J7463766918
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 09:09:19 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9DEEE4C05A;
        Thu, 23 Jul 2020 09:09:19 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 285D84C052;
        Thu, 23 Jul 2020 09:09:14 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.40.160])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Jul 2020 09:09:13 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     ravi.bangoria@linux.ibm.com, paulus@samba.org, npiggin@gmail.com,
        christophe.leroy@c-s.fr, naveen.n.rao@linux.vnet.ibm.com,
        peterz@infradead.org, jolsa@kernel.org, oleg@redhat.com,
        fweisbec@gmail.com, mingo@kernel.org, pedromfc@br.ibm.com,
        miltonm@us.ibm.com, jniethe5@gmail.com, rogealve@br.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/10] powerpc/watchpoint: Guest support for 2nd DAWR hcall
Date:   Thu, 23 Jul 2020 14:38:11 +0530
Message-Id: <20200723090813.303838-9-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200723090813.303838-1-ravi.bangoria@linux.ibm.com>
References: <20200723090813.303838-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230069
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
index b785e9f0071c..33793444144c 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -358,6 +358,7 @@
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
index d12c3680d946..ece84a430701 100644
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

