Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE1FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE15220734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFQLSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:18:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726331AbgFQLSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:18:08 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05HB3SfZ065319;
        Wed, 17 Jun 2020 07:18:02 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31q6j52yxv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 07:18:01 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05HBCTG4025289;
        Wed, 17 Jun 2020 11:18:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 31q6ckrcf0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Jun 2020 11:18:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05HBHwO357409596
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jun 2020 11:17:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDA2C4C040;
        Wed, 17 Jun 2020 11:17:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 724304C04E;
        Wed, 17 Jun 2020 11:17:55 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.102.24.40])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Jun 2020 11:17:55 +0000 (GMT)
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     hbathini@linux.ibm.com, mahesh@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v5] powerpc/fadump: fix race between pstore write and fadump crash trigger
Date:   Wed, 17 Jun 2020 16:47:49 +0530
Message-Id: <20200617111749.22412-1-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-17_03:2020-06-17,2020-06-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 cotscore=-2147483648 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006170087
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

To avoid this race condition a barrier is added on crash_fadump path, it
prevents the CPU to trigger the crash until all the online CPUs completes
their task.

A barrier is added to make sure all the secondary CPUs hit the
crash_fadump function before we initiates the crash. A timeout is kept to
ensure the primary CPU (one who initiates the crash) do not wait for
secondary CPUs indefinitely.

Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
 arch/powerpc/kernel/fadump.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

---
Chanagelog:

v1 -> v3:
   - https://lists.ozlabs.org/pipermail/linuxppc-dev/2020-April/208267.html

v3 -> v4:

   - Now the primary CPU (one who triggers dump) waits for all secondary
     CPUs to enter and then initiates the crash.

v4 -> v5:
    - Fixed a build failure reported by kernel test robot <lkp@intel.com>
      Now the cpus_in_crash variable is defined outside CONFIG_CMA
      config option.
---

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ff0114aeba9b..08dfa9d34096 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -32,10 +32,20 @@
 #include <asm/fadump-internal.h>
 #include <asm/setup.h>
 
+/*
+ * The CPU who acquired the lock to trigger the fadump crash should
+ * wait for other CPUs to enter.
+ *
+ * The timeout is in milliseconds.
+ */
+#define CRASH_TIMEOUT		500
+
 static struct fw_dump fw_dump;
 
 static void __init fadump_reserve_crash_area(u64 base);
 
+static atomic_t cpus_in_crash;
+
 #ifndef CONFIG_PRESERVE_FA_DUMP
 static DEFINE_MUTEX(fadump_mutex);
 struct fadump_mrange_info crash_mrange_info = { "crash", NULL, 0, 0, 0 };
@@ -594,8 +604,11 @@ early_param("fadump_reserve_mem", early_fadump_reserve_mem);
 
 void crash_fadump(struct pt_regs *regs, const char *str)
 {
+	unsigned int msecs;
 	struct fadump_crash_info_header *fdh = NULL;
 	int old_cpu, this_cpu;
+	/* Do not include first CPU */
+	unsigned int ncpus = num_online_cpus() - 1;
 
 	if (!should_fadump_crash())
 		return;
@@ -611,6 +624,8 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 	old_cpu = cmpxchg(&crashing_cpu, -1, this_cpu);
 
 	if (old_cpu != -1) {
+		atomic_inc(&cpus_in_crash);
+
 		/*
 		 * We can't loop here indefinitely. Wait as long as fadump
 		 * is in force. If we race with fadump un-registration this
@@ -634,6 +649,16 @@ void crash_fadump(struct pt_regs *regs, const char *str)
 
 	fdh->online_mask = *cpu_online_mask;
 
+	/*
+	 * If we came in via system reset, wait a while for the secondary
+	 * CPUs to enter.
+	 */
+	if (TRAP(&(fdh->regs)) == 0x100) {
+		msecs = CRASH_TIMEOUT;
+		while ((atomic_read(&cpus_in_crash) < ncpus) && (--msecs > 0))
+			mdelay(1);
+	}
+
 	fw_dump.ops->fadump_trigger(fdh, str);
 }
 
-- 
2.25.4

