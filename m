Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B694C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C011204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 03:55:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h2Mvt9jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgFDDzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 23:55:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33686 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDDzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 23:55:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0543qUMV129253;
        Thu, 4 Jun 2020 03:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=Z6Q9Wq0yQ9bYp+C/bSDjX1Q1JFM5hLt2P2p/aVt1ixU=;
 b=h2Mvt9jhAjmuJDQf5LnGjf46WdYyN920Yi6mmXKJiQzn0dRY1fnmYxrAfEQ8xvVraODM
 FCaR3RGaHPuMiNLN3V3UMpILWWXjH+5QkzOod+P0JGhRUX82gnFmmfahYH9Tz4KIvF21
 rwwsVmgzGkDO6c0ywQ0iADNxEkSyXwEQOWouXghyNpTwNfWG8ghtrFRFfALjKy1JZuAK
 YQ4t5CX7k2lLgdPi8kyXpcQQ7GIcX39wJl1bfi4+RIbMFKqwAk1qw2o1nsIqewJNjWPv
 2/I2LMkqT/lHdqaBfsff4vriYFWITse67cL/U7YMoc3DaSOnm8Qvg/i/4jCAJJQeQ/Cg hA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 31bewr4eqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 04 Jun 2020 03:54:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0543rTBt168559;
        Thu, 4 Jun 2020 03:54:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 31ej0ysgp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Jun 2020 03:54:51 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0543snsW032028;
        Thu, 4 Jun 2020 03:54:49 GMT
Received: from localhost.localdomain (/98.229.125.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 03 Jun 2020 20:54:48 -0700
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
Subject: [PATCH] x86/mm: use max memory block size with unaligned memory end
Date:   Wed,  3 Jun 2020 23:54:43 -0400
Message-Id: <20200604035443.3267046-1-daniel.m.jordan@oracle.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006040022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9641 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 cotscore=-2147483648
 lowpriorityscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006040022
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of our servers spend 14 out of the 21 seconds of kernel boot
initializing memory block sysfs directories and then creating symlinks
between them and the corresponding nodes.  The slowness happens because
the machines get stuck with the smallest supported memory block size on
x86 (128M), which results in 16,288 directories to cover the 2T of
installed RAM, and each of these paths does a linear search of the
memory blocks for every block id, with atomic ops at each step.

Commit 078eb6aa50dc ("x86/mm/memory_hotplug: determine block size based
on the end of boot memory") chooses the block size based on alignment
with memory end.  That addresses hotplug failures in qemu guests, but
for bare metal systems whose memory end isn't aligned to the smallest
size, it leaves them at 128M.

For such systems, use the largest supported size (2G) to minimize
overhead on big machines.  That saves nearly all of the 14 seconds so
the kernel boots 3x faster.

There are some simple ways to avoid the linear searches, but for now it
makes no difference with a 2G block.

Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
---
 arch/x86/mm/init_64.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 8b5f73f5e207c..d388127d1b519 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1390,6 +1390,15 @@ static unsigned long probe_memory_block_size(void)
 		goto done;
 	}
 
+	/*
+	 * Memory end isn't aligned to any allowed block size, so default to
+	 * the largest to minimize overhead on large memory systems.
+	 */
+	if (!IS_ALIGNED(boot_mem_end, MIN_MEMORY_BLOCK_SIZE)) {
+		bz = MAX_BLOCK_SIZE;
+		goto done;
+	}
+
 	/* Find the largest allowed block size that aligns to memory end */
 	for (bz = MAX_BLOCK_SIZE; bz > MIN_MEMORY_BLOCK_SIZE; bz >>= 1) {
 		if (IS_ALIGNED(boot_mem_end, bz))

base-commit: 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162
-- 
2.26.2

