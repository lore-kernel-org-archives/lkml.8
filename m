Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E162A2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 21:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFJVwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 17:52:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21312 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726879AbgFJVwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 17:52:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05ALVYmb050649;
        Wed, 10 Jun 2020 17:52:04 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31k3q6qadd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 17:52:03 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05ALjG5N090995;
        Wed, 10 Jun 2020 17:52:03 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31k3q6qad6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 17:52:03 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05ALUShN019080;
        Wed, 10 Jun 2020 21:52:02 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 31g2saha8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Jun 2020 21:52:02 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05ALq0sA30343616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Jun 2020 21:52:00 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 381B1BE053;
        Wed, 10 Jun 2020 21:52:01 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38F12BE051;
        Wed, 10 Jun 2020 21:51:57 +0000 (GMT)
Received: from kermit.br.ibm.com.com (unknown [9.163.42.87])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Wed, 10 Jun 2020 21:51:56 +0000 (GMT)
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
Subject: [PATCH 1/3] powerpc/dt_cpu_ftrs: Remove unused macro ISA_V2_07B
Date:   Wed, 10 Jun 2020 18:51:12 -0300
Message-Id: <20200610215114.167544-2-muriloo@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200610215114.167544-1-muriloo@linux.ibm.com>
References: <20200610215114.167544-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-10_13:2020-06-10,2020-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 cotscore=-2147483648 impostorscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=920 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006100155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro ISA_V2_07B is defined but not used anywhere else in the code.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 arch/powerpc/kernel/dt_cpu_ftrs.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index 3a409517c031..1b7da8b5ce0d 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -24,7 +24,6 @@
 
 
 /* Device-tree visible constants follow */
-#define ISA_V2_07B      2070
 #define ISA_V3_0B       3000
 #define ISA_V3_1        3100
 
-- 
2.25.4

