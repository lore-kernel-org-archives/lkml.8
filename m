Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD7CDC1975A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00E3205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="jYBkpxRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgCMBOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:14:39 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:46853 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgCMBOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:14:36 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200313011433epoutp02311b6d980016537ee6c54fbb693f6d20~7uBAVuIfG1299912999epoutp029
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 01:14:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200313011433epoutp02311b6d980016537ee6c54fbb693f6d20~7uBAVuIfG1299912999epoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584062073;
        bh=NvJFVm2bsV+GemohYVQY+wUum4EmPRZJ8wPRx8bxLLE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jYBkpxRMsOyUPgxDQ0PwoQ8MU/wEfqB75QP980oK7dArmZ1I213NtqJCloYGxujRh
         cBkhxpvVmSa5nXA+BOUQvhRMxRmSHBqgLrv7w8nv52/BpO2MvMF2Rlh1DiEXdF+Bqk
         29sixdGEjxi/zwbfVO2HWgGjLDsBqWWYkRBI9uxY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200313011432epcas1p1b5673dd781286a312b8dca88253b3115~7uA-9xDdm1118711187epcas1p16;
        Fri, 13 Mar 2020 01:14:32 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48dnm70VtrzMqYkq; Fri, 13 Mar
        2020 01:14:31 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.40.52419.67EDA6E5; Fri, 13 Mar 2020 10:14:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200313011430epcas1p436a6c02a262debcd755f3e1378331764~7uA96yy9I0946109461epcas1p4m;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200313011430epsmtrp1ef4f3ccca6893c6725e579532befeed3~7uA96GG1j1195111951epsmtrp19;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
X-AuditID: b6c32a37-59fff7000001ccc3-8d-5e6ade76d50b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.67.06963.67EDA6E5; Fri, 13 Mar 2020 10:14:30 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200313011430epsmtip22fbaed503f8f0c4bd57967a0e932ded6~7uA9wdaxy1860718607epsmtip22;
        Fri, 13 Mar 2020 01:14:30 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     willy@infradead.org, walken@google.com, bp@suse.de,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v2 2/2] mm: mmap: add trace point of vm_unmapped_area
Date:   Fri, 13 Mar 2020 10:14:20 +0900
Message-Id: <20200313011420.15995-3-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200313011420.15995-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHedx2d9VWl2V2GJF6S2HqamtNb6Fib3orAykK8oPropep7Y3d
        zVIrrMzCNJv5IU1JETNKUjYJV4iwypdWoUQIgVZKgvZiabPA1LZdo779zjn/85w/5zm4QDov
        kuH5RitrMTJ6EgsRPnwiVyhOjRVkK5cMVENHO0bZq+XUVWcdoqpmpoOo148aMGqsfVlELdWc
        pRZ+NWCpOO2qHxXTTQ4b7bwbSztma8T0wM0FIX2t6x6inZ4Ses6xMRPP0iflsUwua4lkjTmm
        3HyjLpk8eES7R6tJUKoUqh1UIhlpZAxsMrk3I1ORlq/3mSIjCxm9zZfKZDiO3JqSZDHZrGxk
        nomzJpOsOVdvVinNWzjGwNmMui05JsNOlVK5TeNTntDn1bVVIvP5iNP2ifRSZJdVoGAciO3w
        zjWPVaAQXEp0I2huvyTig1kE4y8Gg/hgHoGnpl74t+VCRWuApUQPgtHFOF70E8GCa1LgL2BE
        HMw01fiewvEw4ghM1GH+tICwwZfPAwHJWmIfTHkbAiwkouFBUzXml0uIZOj9dtSPQERA83JA
        EUykgMP5MeANiE4MvB3uFTt7YfKJa4XXwnR/l5hnGUxVl4v5hosIvtQ5ER+U+Tw7qhCvUkNV
        5ZDAP01AyKHj0VY+HQWuhUbEe14NX72VIt6QBK6US3lJDJRNekU8b4DFpckVpmHuzjMxvxI7
        guU3HuF1tLH+34QmhO6hcNbMGXQspzKr//8vBwrcXGxiN+p8leFGBI7IVRJleEG2VMQUckUG
        NwJcQIZJtBG6bKkklykqZi0mrcWmZzk30vg2aRfI1uWYfBdstGpVmm1qtZranpCYoFGT6yUf
        jsuzpYSOsbInWdbMWv72BeHBslJEhQ5Vt2Qs9mt7s2LSR44etnmEz9nxtE6rwvo79VDR5sak
        voEzytrKtKrhvqyWcz1RitbWlk+7b2lGBj0hB1vjH9d+2D8csWlEpLpRYgr93gZ7YrBiRe0P
        aVvjYsmr6L5d6fdvH7h8bJMwY0je/D5xzUjZyxdPNT3x4rcvw0Rxbi8p5PIYVazAwjF/AB+h
        vVmJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHLMWRmVeSWpSXmKPExsWy7bCSvG7Zvaw4g7u9chZz1q9hs5jYr2nR
        vXkmo0Xv+1dMFpd3zWGzuLfmP6vFv0m1Fr9/zGFz4PDYOesuu8eCTaUem1doeWz6NInd48SM
        3ywefVtWMXpsPl3t8XmTXABHFJdNSmpOZllqkb5dAlfGzOU9jAWN8hUTH7s3ME6U6mLk5JAQ
        MJFo6lrK0sXIxSEksJtR4ubuuywQCRmJN+efAtkcQLawxOHDxRA1Xxklpt5aww5SwyagLfF+
        wSRWkBoRgXCJqdsrQMLMApUS/27fYgWxhQVcJV5+ncMMYrMIqEqsW9DPBlLOK2Arsf9DKMR0
        eYmF/8EqOAXsJDZtfgrWKQRU0fphFvsERr4FjAyrGCVTC4pz03OLDQsM81LL9YoTc4tL89L1
        kvNzNzGCQ1FLcwfj5SXxhxgFOBiVeHgNxLLihFgTy4orcw8xSnAwK4nwxsunxwnxpiRWVqUW
        5ccXleakFh9ilOZgURLnfZp3LFJIID2xJDU7NbUgtQgmy8TBKdXAGKppJab5e9Hq3WZZPjl3
        8qcz8GuZXg9xvfX8jUhdQpHL68V7Sr54S5mcis9M95WUznzrySWS8MzsUrHvz/PPvh/3Su3s
        atY/+7Uja11n9m2rkiktc3kmG0pX5HnkH0xdf1nGtmSv0p8dQV77o9mPHkqy6j0974PKvqly
        epdXr6tl2b59s+trJZbijERDLeai4kQAdsQJAUECAAA=
X-CMS-MailID: 20200313011430epcas1p436a6c02a262debcd755f3e1378331764
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200313011430epcas1p436a6c02a262debcd755f3e1378331764
References: <20200313011420.15995-1-jaewon31.kim@samsung.com>
        <CGME20200313011430epcas1p436a6c02a262debcd755f3e1378331764@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
Virtual memory space shortage of a task on mmap is reported to userspace
as -ENOMEM. It can be confused as physical memory shortage of overall
system.

The vm_unmapped_area can be called to by some drivers or other kernel
core system like filesystem. In my platform, GPU driver calls to
vm_unmapped_area and the driver returns -ENOMEM even in GPU side
shortage. It can be hard to distinguish which code layer returns the
-ENOMEM.

Create mmap trace file and add trace point of vm_unmapped_area.

i.e.)
265.214275: vm_unmapped_area: addr=fffffffffffffff4 err=-12 tvm=0xffb08 flags=0x1 len=0x100000 lo=0x8000 hi=0xf7182000 mask=0x0 ofs=0x22
265.214276: vm_unmapped_area: addr=fffffffffffffff4 err=-12 tvm=0xffb08 flags=0x0 len=0x100000 lo=0x40000000 hi=0xfffff000 mask=0x0 ofs=0x22
510.827472: vm_unmapped_area: addr=7377060000 err=0 tvm=0x262f flags=0x1 len=0x7f000 lo=0x8000 hi=0x73795f7000 mask=0x0 ofs=0x22
510.827668: vm_unmapped_area: addr=73794d1000 err=0 tvm=0x25cc flags=0x1 len=0x1000 lo=0x8000 hi=0x73795f7000 mask=0x0 ofs=0x22

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/trace/events/mmap.h | 52 +++++++++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                   | 12 +++++++++--
 2 files changed, 62 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/mmap.h

diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
new file mode 100644
index 000000000000..a51dd8af6f8c
--- /dev/null
+++ b/include/trace/events/mmap.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM mmap
+
+#if !defined(_TRACE_MMAP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_MMAP_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(vm_unmapped_area,
+
+	TP_PROTO(unsigned long addr, struct vm_unmapped_area_info *info),
+
+	TP_ARGS(addr, info),
+
+	TP_STRUCT__entry(
+		__field(unsigned long,	addr)
+		__field(unsigned long,	error)
+		__field(unsigned long,	total_vm)
+		__field(unsigned long,	flags)
+		__field(unsigned long,	length)
+		__field(unsigned long,	low_limit)
+		__field(unsigned long,	high_limit)
+		__field(unsigned long,	align_mask)
+		__field(unsigned long,	align_offset)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		if (IS_ERR_VALUE(addr))
+			__entry->error = addr;
+		else
+			__entry->error = 0;
+		__entry->total_vm = current->mm->total_vm;
+		__entry->flags = info->flags;
+		__entry->length = info->length;
+		__entry->low_limit = info->low_limit;
+		__entry->high_limit = info->high_limit;
+		__entry->align_mask = info->align_mask;
+		__entry->align_offset = info->align_offset;
+	),
+
+	TP_printk("addr=%lx err=%ld tvm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
+		__entry->addr, __entry->error, __entry->total_vm,
+		__entry->flags, __entry->length, __entry->low_limit,
+		__entry->high_limit, __entry->align_mask,
+		__entry->align_offset)
+);
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/mmap.c b/mm/mmap.c
index eeaddb76286c..68ccbd7d5256 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -53,6 +53,9 @@
 #include <asm/tlb.h>
 #include <asm/mmu_context.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/mmap.h>
+
 #include "internal.h"
 
 #ifndef arch_mmap_check
@@ -2061,10 +2064,15 @@ unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
  */
 unsigned long vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
+	unsigned long addr;
+
 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
-		return unmapped_area_topdown(info);
+		addr = unmapped_area_topdown(info);
 	else
-		return unmapped_area(info);
+		addr = unmapped_area(info);
+
+	trace_vm_unmapped_area(addr, info);
+	return addr;
 }
 
 #ifndef arch_get_mmap_end
-- 
2.13.7

