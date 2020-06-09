Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AEFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321FE2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 10:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgFIK6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 06:58:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727090AbgFIK6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 06:58:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 059AZeQW063809;
        Tue, 9 Jun 2020 06:58:00 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31g7n8us40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 06:58:00 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 059AfOWr013024;
        Tue, 9 Jun 2020 10:57:57 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 31g2s7wsh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Jun 2020 10:57:57 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 059AucYj197328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 Jun 2020 10:56:39 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9AD2A4054;
        Tue,  9 Jun 2020 10:57:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21D45A405B;
        Tue,  9 Jun 2020 10:57:50 +0000 (GMT)
Received: from satheesh.ibmuc.com (unknown [9.85.125.230])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  9 Jun 2020 10:57:49 +0000 (GMT)
From:   Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: [PATCH] powerpc/pseries/svm: Remove unwanted check for shared_lppaca_size
Date:   Tue,  9 Jun 2020 16:27:31 +0530
Message-Id: <20200609105731.14032-1-sathnaga@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-09_03:2020-06-09,2020-06-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 suspectscore=1 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early secure guest boot hits the below crash while booting with
vcpus numbers aligned with page boundary for PAGE size of 64k
and LPPACA size of 1k i.e 64, 128 etc, due to the BUG_ON assert
for shared_lppaca_total_size equal to shared_lppaca_size,

 [    0.000000] Partition configured for 64 cpus.
 [    0.000000] CPU maps initialized for 1 thread per core
 [    0.000000] ------------[ cut here ]------------
 [    0.000000] kernel BUG at arch/powerpc/kernel/paca.c:89!
 [    0.000000] Oops: Exception in kernel mode, sig: 5 [#1]
 [    0.000000] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries

which is not necessary, let's remove it.

Cc: linux-kernel@vger.kernel.org
Cc: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc: Ram Pai <linuxram@us.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Laurent Dufour <ldufour@linux.ibm.com>
Signed-off-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/paca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 949eceb25..10b7c54a7 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -86,7 +86,7 @@ static void *__init alloc_shared_lppaca(unsigned long size, unsigned long align,
 	 * This is very early in boot, so no harm done if the kernel crashes at
 	 * this point.
 	 */
-	BUG_ON(shared_lppaca_size >= shared_lppaca_total_size);
+	BUG_ON(shared_lppaca_size > shared_lppaca_total_size);
 
 	return ptr;
 }
-- 
2.26.2

