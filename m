Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B812AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABED20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgFLOaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:30:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49582 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726089AbgFLOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:30:16 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05CD46FF013211;
        Fri, 12 Jun 2020 10:30:06 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31kgs524vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 10:30:05 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05CELQQG005959;
        Fri, 12 Jun 2020 14:30:02 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 31g2s83gfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jun 2020 14:30:02 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05CEShCb36307422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 14:28:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB6B9A4060;
        Fri, 12 Jun 2020 14:29:59 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA9A9A405F;
        Fri, 12 Jun 2020 14:29:56 +0000 (GMT)
Received: from satheesh.ibmuc.com (unknown [9.102.1.49])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jun 2020 14:29:56 +0000 (GMT)
From:   Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH V2] powerpc/pseries/svm: Drop unused align argument in alloc_shared_lppaca() function
Date:   Fri, 12 Jun 2020 19:59:53 +0530
Message-Id: <20200612142953.135408-1-sathnaga@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_23:2020-06-11,2020-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=964 spamscore=0
 mlxscore=0 suspectscore=1 lowpriorityscore=0 cotscore=-2147483648
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1015 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006110174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Argument "align" in alloc_shared_lppaca() was unused inside the
function. Let's drop it and update code comment for page alignment.

Cc: linux-kernel@vger.kernel.org
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Reviewed-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
---

V2:
Added reviewed by Thiago.
Dropped align argument as per Michael suggest.
Modified commit msg.

V1: http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200609113909.17236-1-sathnaga@linux.vnet.ibm.com/
---
 arch/powerpc/kernel/paca.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 8d96169c597e..a174d64d9b4d 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -57,8 +57,8 @@ static void *__init alloc_paca_data(unsigned long size, unsigned long align,
 
 #define LPPACA_SIZE 0x400
 
-static void *__init alloc_shared_lppaca(unsigned long size, unsigned long align,
-					unsigned long limit, int cpu)
+static void *__init alloc_shared_lppaca(unsigned long size, unsigned long limit,
+					int cpu)
 {
 	size_t shared_lppaca_total_size = PAGE_ALIGN(nr_cpu_ids * LPPACA_SIZE);
 	static unsigned long shared_lppaca_size;
@@ -68,6 +68,12 @@ static void *__init alloc_shared_lppaca(unsigned long size, unsigned long align,
 	if (!shared_lppaca) {
 		memblock_set_bottom_up(true);
 
+		/* See Documentation/powerpc/ultravisor.rst for mode details
+		 *
+		 * UV/HV data share is in PAGE granularity, In order to
+		 * minimize the number of pages shared and maximize the
+		 * use of a page, let's use page align.
+		 */
 		shared_lppaca =
 			memblock_alloc_try_nid(shared_lppaca_total_size,
 					       PAGE_SIZE, MEMBLOCK_LOW_LIMIT,
@@ -122,7 +128,7 @@ static struct lppaca * __init new_lppaca(int cpu, unsigned long limit)
 		return NULL;
 
 	if (is_secure_guest())
-		lp = alloc_shared_lppaca(LPPACA_SIZE, 0x400, limit, cpu);
+		lp = alloc_shared_lppaca(LPPACA_SIZE, limit, cpu);
 	else
 		lp = alloc_paca_data(LPPACA_SIZE, 0x400, limit, cpu);
 
-- 
2.26.2

