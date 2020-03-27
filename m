Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DA4C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 722112073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 11:33:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0LdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 07:33:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727443AbgC0LdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 07:33:03 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02RB7Dlh015805;
        Fri, 27 Mar 2020 07:32:57 -0400
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywe7x1fy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 07:32:57 -0400
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 02RBUIhT021901;
        Fri, 27 Mar 2020 11:32:56 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 2ywawgp8mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Mar 2020 11:32:56 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02RBWtN457278834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Mar 2020 11:32:55 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4ADFB78060;
        Fri, 27 Mar 2020 11:32:55 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D99207805E;
        Fri, 27 Mar 2020 11:32:54 +0000 (GMT)
Received: from sofia.ibm.com (unknown [9.85.72.108])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 27 Mar 2020 11:32:54 +0000 (GMT)
Received: by sofia.ibm.com (Postfix, from userid 1000)
        id 853902E3B09; Fri, 27 Mar 2020 17:02:45 +0530 (IST)
From:   "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v4 5/6] Documentation: Document sysfs interfaces purr, spurr, idle_purr, idle_spurr
Date:   Fri, 27 Mar 2020 17:02:39 +0530
Message-Id: <1585308760-28792-6-git-send-email-ego@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1585308760-28792-1-git-send-email-ego@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-27_03:2020-03-27,2020-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003270097
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Add documentation for the following sysfs interfaces:
/sys/devices/system/cpu/cpuX/purr
/sys/devices/system/cpu/cpuX/spurr
/sys/devices/system/cpu/cpuX/idle_purr
/sys/devices/system/cpu/cpuX/idle_spurr

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 2e0e3b4..bc07677 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -580,3 +580,42 @@ Description:	Secure Virtual Machine
 		If 1, it means the system is using the Protected Execution
 		Facility in POWER9 and newer processors. i.e., it is a Secure
 		Virtual Machine.
+
+What: 		/sys/devices/system/cpu/cpuX/purr
+Date:		Apr 2005
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	PURR ticks for this CPU since the system boot.
+
+		The Processor Utilization Resources Register (PURR) is
+		a 64-bit counter which provides an estimate of the
+		resources used by the CPU thread. The contents of this
+		register increases monotonically. This sysfs interface
+		exposes the number of PURR ticks for cpuX.
+
+What: 		/sys/devices/system/cpu/cpuX/spurr
+Date:		Dec 2006
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	SPURR ticks for this CPU since the system boot.
+
+		The Scaled Processor Utilization Resources Register
+		(SPURR) is a 64-bit counter that provides a frequency
+		invariant estimate of the resources used by the CPU
+		thread. The contents of this register increases
+		monotonically. This sysfs interface exposes the number
+		of SPURR ticks for cpuX.
+
+What: 		/sys/devices/system/cpu/cpuX/idle_purr
+Date:		Mar 2020
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	PURR ticks for cpuX when it was idle.
+
+		This sysfs interface exposes the number of PURR ticks
+		for cpuX when it was idle.
+
+What: 		/sys/devices/system/cpu/cpuX/idle_spurr
+Date:		Mar 2020
+Contact:	Linux for PowerPC mailing list <linuxppc-dev@ozlabs.org>
+Description:	SPURR ticks for cpuX when it was idle.
+
+		This sysfs interface exposes the number of SPURR ticks
+		for cpuX when it was idle.
-- 
1.9.4

