Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58BDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF722087D
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 04:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgFBECA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:02:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41890 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726139AbgFBEB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 00:01:58 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0523Wnb4122377;
        Tue, 2 Jun 2020 00:01:34 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bkc2wfqf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:01:33 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05240AUv183957;
        Tue, 2 Jun 2020 00:01:33 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31bkc2wfpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 00:01:33 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0524036W003751;
        Tue, 2 Jun 2020 04:01:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 31bf47t4ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 04:01:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05241SMK7799054
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 04:01:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A1C65205F;
        Tue,  2 Jun 2020 04:01:28 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.55.113])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA0B052065;
        Tue,  2 Jun 2020 04:01:24 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     mpe@ellerman.id.au, mikey@neuling.org
Cc:     ravi.bangoria@linux.ibm.com, apopple@linux.ibm.com,
        paulus@samba.org, npiggin@gmail.com, christophe.leroy@c-s.fr,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] powerpc/watchpoint: Rename current H_SET_MODE DAWR macro
Date:   Tue,  2 Jun 2020 09:31:03 +0530
Message-Id: <20200602040106.127693-5-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200602040106.127693-1-ravi.bangoria@linux.ibm.com>
References: <20200602040106.127693-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-01_12:2020-06-01,2020-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 cotscore=-2147483648 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current H_SET_MODE hcall macro name for setting/resetting DAWR0 is
H_SET_MODE_RESOURCE_SET_DAWR. Add suffix 0 to macro name as well.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/hvcall.h         | 2 +-
 arch/powerpc/include/asm/plpar_wrappers.h | 2 +-
 arch/powerpc/kvm/book3s_hv.c              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index e90c073e437e..a7f6f1aeda6b 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -354,7 +354,7 @@
 
 /* Values for 2nd argument to H_SET_MODE */
 #define H_SET_MODE_RESOURCE_SET_CIABR		1
-#define H_SET_MODE_RESOURCE_SET_DAWR		2
+#define H_SET_MODE_RESOURCE_SET_DAWR0		2
 #define H_SET_MODE_RESOURCE_ADDR_TRANS_MODE	3
 #define H_SET_MODE_RESOURCE_LE			4
 
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 4497c8afb573..93eb133d572c 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -312,7 +312,7 @@ static inline long plpar_set_ciabr(unsigned long ciabr)
 
 static inline long plpar_set_watchpoint0(unsigned long dawr0, unsigned long dawrx0)
 {
-	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR, dawr0, dawrx0);
+	return plpar_set_mode(0, H_SET_MODE_RESOURCE_SET_DAWR0, dawr0, dawrx0);
 }
 
 static inline long plpar_signal_sys_reset(long cpu)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a0cf17597838..26820b7bd75c 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -766,7 +766,7 @@ static int kvmppc_h_set_mode(struct kvm_vcpu *vcpu, unsigned long mflags,
 			return H_P3;
 		vcpu->arch.ciabr  = value1;
 		return H_SUCCESS;
-	case H_SET_MODE_RESOURCE_SET_DAWR:
+	case H_SET_MODE_RESOURCE_SET_DAWR0:
 		if (!kvmppc_power8_compatible(vcpu))
 			return H_P2;
 		if (!ppc_breakpoint_available())
-- 
2.26.2

