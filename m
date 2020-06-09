Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261CEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3D1620734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pY6fBT37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgFIWzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:55:15 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44478 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728642AbgFIWzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:55:12 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059MqpYU162182;
        Tue, 9 Jun 2020 22:54:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=HvGdtjAHs0B66PLoqaTxJLCRKpFgcsRjar2VCL7YTAM=;
 b=pY6fBT37pThpu8U1RgDw4s3DBAVMiKNNdDUyy8k7UG3GOq1xNqFjWifjrrvOEFerpyIj
 Q8d9hNxYXng/Q52Zdkkz5H4wK6oELx9vtmwnr6pBgw11vQbmkbSGLultBH92JZEz3B3y
 I7GwGV/yHvNtBwnpCepbjDqQEBSMx0AfUkv06MAJER7Wi7EWarykLFjN/J+Fs8ECAw+C
 +W8m5cP1B7BDaNQ2bJsaPp5wlTGB54mAH+Pqf/EjS8iAfGzgIJw5Sjvy8q6JghauDjbH
 GJ2wGhuKu6hLH3llB0Us/ckuB7PU5t5kbI4hkIn/5XVa3NQP0cuSY9RIajPqT2KUb16c YA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31jepnsaq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 22:54:58 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059Mru4t027272;
        Tue, 9 Jun 2020 22:54:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31gmqp8p6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 22:54:58 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 059MstQu012275;
        Tue, 9 Jun 2020 22:54:55 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 15:54:55 -0700
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
Subject: [PATCH v2] x86/mm: use max memory block size on bare metal
Date:   Tue,  9 Jun 2020 18:54:51 -0400
Message-Id: <20200609225451.3542648-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006090173
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

Applies to 5.7 and today's mainline

 arch/x86/mm/init_64.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8b5f73f5e207c..906fbdb060748 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -55,6 +55,7 @@
 #include <asm/uv/uv.h>
 #include <asm/setup.h>
 #include <asm/ftrace.h>
+#include <asm/hypervisor.h>
 
 #include "mm_internal.h"
 
@@ -1390,6 +1391,15 @@ static unsigned long probe_memory_block_size(void)
 		goto done;
 	}
 
+	/*
+	 * Use max block size to minimize overhead on bare metal, where
+	 * alignment for memory hotplug isn't a concern.
+	 */
+	if (hypervisor_is_type(X86_HYPER_NATIVE)) {
+		bz = MAX_BLOCK_SIZE;
+		goto done;
+	}
+
 	/* Find the largest allowed block size that aligns to memory end */
 	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))
-- 
2.26.2

