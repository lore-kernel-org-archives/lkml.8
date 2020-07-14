Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	TVD_PH_BODY_ACCOUNTS_POST,TVD_PH_BODY_META_ALL,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B581C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623102067D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NW03zk8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgGNUzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:55:16 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:58734 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGNUzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:55:15 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EKqujA008190;
        Tue, 14 Jul 2020 20:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=9gAydN9tkf7vqIv4AFRYx4WuisnKrEAgHU9j5Ph1rdU=;
 b=NW03zk8Dwv+MsKoWXK123RITG7VK0dHlNAjHPxyU/x1WQFR8xZ7jozc3/rC5RYBG414u
 6o9WCHjV2K+Ln9hLFSoxiR4xH5ewupyQ2Yaln4vxgPiFBWvxLVfhbRb83QlMjrOnTaUU
 xBM3GYEfUqjKOnQV1Pf2YQSkHK18sGZx6/UFlwYZCeY2B3SDW7EJq9i22IrultOM55EW
 uhMO9a7HnXQ1rwFcshjia+7acrTbDEEoQ+t1WiQxzIkhR8DVl+8U0sM6A0yOXzxgmLxj
 iIVoYQHmgN8ROjp2LQhk3bkmSeE5BQHURuhwk25hFGdKYY5PJaY+bMe+Sw0kv8nF8foq uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 32762nfnt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 20:54:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06EKrcTG184155;
        Tue, 14 Jul 2020 20:54:57 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 327q6t1en1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 20:54:57 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06EKstaL032357;
        Tue, 14 Jul 2020 20:54:55 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 13:54:55 -0700
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: [PATCH v3] x86/mm: use max memory block size on bare metal
Date:   Tue, 14 Jul 2020 16:54:50 -0400
Message-Id: <20200714205450.945834-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140145
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of our servers spend significant time at kernel boot initializing
memory block sysfs directories and then creating symlinks between them
and the corresponding nodes.  The slowness happens because the machines
get stuck with the smallest supported memory block size on x86 (128M),
which results in 16,288 directories to cover the 2T of installed RAM.
The search for each memory block is noticeable even with
commit 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in
xarray to accelerate lookup").

Commit 078eb6aa50dc ("x86/mm/memory_hotplug: determine block size based
on the end of boot memory") chooses the block size based on alignment
with memory end.  That addresses hotplug failures in qemu guests, but
for bare metal systems whose memory end isn't aligned to even the
smallest size, it leaves them at 128M.

Make kernels that aren't running on a hypervisor use the largest
supported size (2G) to minimize overhead on big machines.  Kernel boot
goes 7% faster on the aforementioned servers, shaving off half a second.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Sistare <steven.sistare@oracle.com>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---

v3:
 - Add more accurate hypervisor check.  Someone kindly pointed me to
   517c3ba00916 ("x86/speculation/mds: Apply more accurate check on
   hypervisor platform"), and v2 had the same issue.
 - Rebase on v5.8-rc5

v2:
 - Thanks to David for the idea to make this conditional based on
   virtualization.
 - Update performance numbers to account for 4fb6eabf1037 (David)

 arch/x86/mm/init_64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index dbae185511cdf..51ea8b8e2959d 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1406,6 +1406,15 @@ static unsigned long probe_memory_block_size(void)
 		goto done;
 	}
 
+	/*
+	 * Use max block size to minimize overhead on bare metal, where
+	 * alignment for memory hotplug isn't a concern.
+	 */
+	if (!boot_cpu_has(X86_FEATURE_HYPERVISOR)) {
+		bz = MAX_BLOCK_SIZE;
+		goto done;
+	}
+
 	/* Find the largest allowed block size that aligns to memory end */
 	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))

base-commit: 11ba468877bb23f28956a35e896356252d63c983
-- 
2.27.0

