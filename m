Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722BCC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F1E20702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgGUPhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:37:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42718 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728089AbgGUPhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:37:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LFVdTZ176534;
        Tue, 21 Jul 2020 11:37:18 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32d9827qyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 11:37:18 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LFVjCN177031;
        Tue, 21 Jul 2020 11:37:18 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32d9827qx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 11:37:18 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LFKZ26015536;
        Tue, 21 Jul 2020 15:37:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 32brq8226u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 15:37:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LFbDdc64749946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 15:37:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 518F8A404D;
        Tue, 21 Jul 2020 15:37:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 506F7A4040;
        Tue, 21 Jul 2020 15:37:11 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.79.210.59])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 15:37:11 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, npiggin@gmail.com, benh@kernel.crashing.org,
        paulus@samba.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, psampat@linux.ibm.com,
        pratik.r.sampat@gmail.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] powerpc/powernv/idle: Replace CPU features check with PVR check
Date:   Tue, 21 Jul 2020 21:07:06 +0530
Message-Id: <20200721153708.89057-2-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200721153708.89057-1-psampat@linux.ibm.com>
References: <20200721153708.89057-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_09:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 phishscore=0 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007210110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the idle framework's architecture is incomplete, hence instead of
checking for just the processor type advertised in the device tree CPU
features; check for the Processor Version Register (PVR) so that finer
granularity can be leveraged while making processor checks.

Hence, making the PVR check on the outer level function, subsequently in
the hierarchy keeping the CPU_FTR_ARCH_300 check intact as it is a
faster check to do because of static branches

Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 2dd467383a88..642abf0b8329 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -1205,7 +1205,7 @@ static void __init pnv_probe_idle_states(void)
 		return;
 	}
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (pvr_version_is(PVR_POWER9))
 		pnv_power9_idle_init();
 
 	for (i = 0; i < nr_pnv_idle_states; i++)
-- 
2.25.4

