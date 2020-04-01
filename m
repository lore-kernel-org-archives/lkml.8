Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7572C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772B72078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbgDAKDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:03:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732217AbgDAKDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:03:00 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031A2wHQ133742
        for <linux-kernel@vger.kernel.org>; Wed, 1 Apr 2020 06:03:00 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 303wrx5yvk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 06:02:59 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <sourabhjain@linux.ibm.com>;
        Wed, 1 Apr 2020 11:02:13 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 11:02:11 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031A2KmJ54132840
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 10:02:20 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7D1211C058;
        Wed,  1 Apr 2020 10:02:20 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CCB411C052;
        Wed,  1 Apr 2020 10:02:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.79.179.228])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  1 Apr 2020 10:02:16 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
        Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PATCH v2] powerpc/fadump: fix race between pstore write and fadump crash trigger
Date:   Wed,  1 Apr 2020 15:32:03 +0530
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040110-0008-0000-0000-0000036863A1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040110-0009-0000-0000-00004A89EB6F
Message-Id: <20200401100203.23453-1-sourabhjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 mlxscore=0
 lowpriorityscore=0 mlxlogscore=623 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004010092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we enter into fadump crash path via system reset we fail to update
the pstore.

On the system reset path we first update the pstore then we go for fadump
crash. But the problem here is when all the CPUs try to get the pstore
lock to initiate the pstore write, only one CPUs will acquire the lock
and proceed with the pstore write. Since it in NMI context CPUs that fail
to get lock do not wait for their turn to write to the pstore and simply
proceed with the next operation which is fadump crash. One of the CPU who
proceeded with fadump crash path triggers the crash and does not wait for
the CPU who gets the pstore lock to complete the pstore update.

Timeline diagram to depicts the sequence of events that leads to an
unsuccessful pstore update when we hit fadump crash path via system reset.

                 1    2     3    ...      n   CPU Threads
                 |    |     |             |
                 |    |     |             |
 Reached to   -->|--->|---->| ----------->|
 system reset    |    |     |             |
 path            |    |     |             |
                 |    |     |             |
 Try to       -->|--->|---->|------------>|
 acquire the     |    |     |             |
 pstore lock     |    |     |             |
                 |    |     |             |
                 |    |     |             |
 Got the      -->| +->|     |             |<-+
 pstore lock     | |  |     |             |  |-->  Didn't get the
                 | --------------------------+     lock and moving
                 |    |     |             |        ahead on fadump
                 |    |     |             |        crash path
                 |    |     |             |
  Begins the  -->|    |     |             |
  process to     |    |     |             |<-- Got the chance to
  update the     |    |     |             |    trigger the crash
  pstore         | -> |     |    ... <-   |
                 | |  |     |         |   |
                 | |  |     |         |   |<-- Triggers the
                 | |  |     |         |   |    crash
                 | |  |     |         |   |      ^
                 | |  |     |         |   |      |
  Writing to  -->| |  |     |         |   |      |
  pstore         | |  |     |         |   |      |
                   |                  |          |
       ^           |__________________|          |
       |               CPU Relax                 |
       |                                         |
       +-----------------------------------------+
                          |
                          v
            Race: crash triggered before pstore
                  update completes

To avoid the race between the CPU who proceeds with the pstore and the CPU
who triggers the crash, a delay of 500 milliseconds is added on fadump
crash path to allow pstore update to complete before we trigger the crash.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

---
Changelog:

v1 -> v2
  - crash delay has been increased to 500 milliseconds
  - race happens in NMI context so updated the commit
    message to convey the same.
---

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ff0114aeba9b..471171c40e64 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -32,6 +32,16 @@
 #include <asm/fadump-internal.h>
 #include <asm/setup.h>
 
+
+/*
+ * The CPU who acquired the lock to trigger the fadump crash should
+ * wait for other CPUs to complete their tasks (for example updating
+ * pstore) before triggering the crash.
+ *
+ * The timeout is in milliseconds.
+ */
+#define CRASH_TIMEOUT		500
+
 static struct fw_dump fw_dump;
 
 static void __init fadump_reserve_crash_area(u64 base);
@@ -634,6 +644,14 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 
 	fdh->online_mask = *cpu_online_mask;
 
+	/*
+	 * If we reached here via system reset path then let's
+	 * wait for other CPUs to complete their task like pstore
+	 * update.
+	 */
+	if (TRAP(regs) == 0x100)
+		mdelay(CRASH_TIMEOUT);
+
 	fw_dump.ops->fadump_trigger(fdh, str);
 }
 
-- 
2.21.1

