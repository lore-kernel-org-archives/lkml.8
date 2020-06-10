Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE2AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05108207ED
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgFJVwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:52:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgFJVwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:52:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ALX6s6099749;
        Wed, 10 Jun 2020 17:52:12 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31k6tb1g91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 17:52:12 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05ALh5Id154604;
        Wed, 10 Jun 2020 17:52:12 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31k6tb1g8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 17:52:11 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ALUqgV003203;
        Wed, 10 Jun 2020 21:52:10 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma02wdc.us.ibm.com with ESMTP id 31g2s8s68r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 21:52:10 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05ALq89m9634090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 21:52:08 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73C2EBE051;
        Wed, 10 Jun 2020 21:52:09 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BD9BBE04F;
        Wed, 10 Jun 2020 21:52:06 +0000 (GMT)
Received: from kermit.br.ibm.com.com (unknown [9.163.42.87])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 10 Jun 2020 21:52:05 +0000 (GMT)
From:   Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alistair Popple <alistair@popple.id.au>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Murilo Opsfelder Araujo <mopsfelder@gmail.com>,
        Jordan Niethe <jniethe5@gmail.com>,
        Daniel Axtens <dja@axtens.net>
Subject: [PATCH 3/3] powerpc/dt_cpu_ftrs: Make use of macro ISA_V3_1
Date:   Wed, 10 Jun 2020 18:51:14 -0300
Message-Id: <20200610215114.167544-4-muriloo@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200610215114.167544-1-muriloo@linux.ibm.com>
References: <20200610215114.167544-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 cotscore=-2147483648 clxscore=1015 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006100156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro ISA_V3_1 was defined but never used.  Use it instead of literal.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 9d6e833da2bd..a0edeb391e3e 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -678,7 +678,7 @@ static void __init cpufeatures_setup_start(u32 isa)
 		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_00;
 	}
 
-	if (isa >= 3100) {
+	if (isa >= ISA_V3_1) {
 		cur_cpu_spec->cpu_features |= CPU_FTR_ARCH_31;
 		cur_cpu_spec->cpu_user_features2 |= PPC_FEATURE2_ARCH_3_1;
 	}
-- 
2.25.4

