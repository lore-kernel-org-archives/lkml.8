Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF914C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9ADE2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 05:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qjSniMvr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCTF6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 01:58:52 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:34452 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTF6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 01:58:43 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200320055841epoutp015267f48a08b2976019b75782c0ad5e09~97aF1zciV0507905079epoutp01Z
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 05:58:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200320055841epoutp015267f48a08b2976019b75782c0ad5e09~97aF1zciV0507905079epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584683921;
        bh=JLXzpDo2Uz5P4xcCLc3T6nk7O094GGMnndhBijC6c60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qjSniMvrQi9E6CrAZoY/KWmrEBPTDj078IDqBn/My8IG+488uyk2g1Ch1RLCUGPgv
         Lo8JPCEejcACRP/zAsoU1gI5kxd8HUyI+gvx8GKLNo1LvapLo7b4Z10tb/WB4icb52
         Lt22LOx5U1dteU9+hRVYtbOEGQQvGCIJglsvTciw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200320055841epcas1p24fde7418e65b52d116358225715ecc75~97aFdKznn0986109861epcas1p2N;
        Fri, 20 Mar 2020 05:58:41 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.166]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 48kCkm1mJzzMqYkV; Fri, 20 Mar
        2020 05:58:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        64.00.04071.09B547E5; Fri, 20 Mar 2020 14:58:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200320055839epcas1p189100549687530619d8a19919e8b5de0~97aDoCUx93235132351epcas1p1k;
        Fri, 20 Mar 2020 05:58:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200320055839epsmtrp23f33547d37fa3bf441efe7c22e14ea4b~97aDmu8c80413504135epsmtrp2y;
        Fri, 20 Mar 2020 05:58:39 +0000 (GMT)
X-AuditID: b6c32a37-797ff70000000fe7-81-5e745b901180
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        84.06.04158.F8B547E5; Fri, 20 Mar 2020 14:58:39 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200320055839epsmtip136b85553e8d717235870d503d3b4d8bf~97aDc9S7t1022410224epsmtip1P;
        Fri, 20 Mar 2020 05:58:39 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     willy@infradead.org, walken@google.com, bp@suse.de,
        akpm@linux-foundation.org, srostedt@vmware.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH v3 2/2] mm: mmap: add trace point of vm_unmapped_area
Date:   Fri, 20 Mar 2020 14:58:23 +0900
Message-Id: <20200320055823.27089-3-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200320055823.27089-1-jaewon31.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjm82zHs3JxWLeXkZcOJKmZO63pSaYU3Q7lD6P6U+Q6uMM2PLu0
        s5l2oZsMWVnOWGV4zeiGYUyLlIoywsgoRcooKqOItOYqs5uZbZ5F/Xve53senof3ewlMdQBX
        Exabi3faOIHCp8iu3E7JSK/c7CrQdJ+PY2pamnHGdySFOdhajZiK0FAM09dRgzMvmifkzJ2f
        gzLmd9VuZux7Db5UwbaffB7LNgTcbOu5VDbwuSqWvXtiTMYebruA2NbunexIIIEdrg/i+YpN
        gt7Mc0bemcTbCu1Gi82UQ61db1hu0GVq6HR6CZNFJdk4K59DrcjLT19lEcL9qKRiTnCHqXxO
        FKmMXL3T7nbxSWa76MqheIdRcNAax0KRs4pum2lhod2aTWs0i3Rh5VbB/PpFl8zRE19y700I
        34tC4EUKAsjFULP/CfKiKYSKvIqgr/aITBo+I/jUNS6LqFTkVwQX/Wl/HY/qH0b56wjqfImS
        4RuCU1cq8cgDTqZBqKFKHsEzSDP4f76c5DHSDcEPd7EInk6uhHf9HZMaGTkP6kLvUQQryRwY
        uH80xouIcFgiNE5MyhVkLvRfu4dHsoC8iUPthB9JhVZAbXtTjISnw1BXW6yE1TAyfD1qOIAg
        WN2KpKEMwfNARdSthYpDPVgkDSNToKUjQ6LnQvtYLZJKT4Ph0UNyqZASyj0qSZIMZW9H5RKe
        A+O/30YxC+O+Y9Et+hB4q29jlSjh5L+EBoQuoFm8Q7SaeJF2aP//sQCaPMDUrKvo0oO8TkQS
        iIpTnvCIBSo5VyyWWjsREBg1Q5luClNKI1e6g3faDU63wIudSBdepQ9Tzyy0h8/Z5jLQukVa
        rZZZnJmVqdNSs5X+fqFARZo4F1/E8w7e+dcXQyjUe5HfI1guKkZ7nhL71qUFP3roy+XeUv98
        j1HXePZl/P09p5FKP/DFsmDf1v5bm1YNtVyaFz97KHX1ui+xR9s2fvpYfmPDszXZzclF3LZd
        pWbD5S0KQ9Ov4JnNvYnjFUW9da+W6YmCH8lGunLWcTzbq27sHtheQrh/teUu+KZ/fD5u6iAl
        E80cnYo5Re4P59xB5ZYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsWy7bCSnG5/dEmcwZmH3BZz1q9hs5jYr2nR
        vXkmo0Xv+1dMFpd3zWGzuLfmP6vF0V8vWSz+Taq1+P1jDpsDp8fOWXfZPRZsKvXYvELLY9On
        SeweJ2b8ZvHo27KK0WPz6WqPz5vkPN7Nf8sWwBnFZZOSmpNZllqkb5fAlfH43nGWgguyFaee
        vGdrYHwv0cXIySEhYCJxdf55li5GLg4hgd2MEtPWrGSGSMhIvDn/FCjBAWQLSxw+XAwSFhL4
        yijx+FsRiM0moC3xfsEkVhBbRCBPomXTQzCbWaBS4t/tW2C2sICrxIvru8BsFgFViXnvXzOC
        2LwCthIPzkxmghgvL7HwP9hWTgE7iet7TrFBrLKVmDvxGfMERr4FjAyrGCVTC4pz03OLDQuM
        8lLL9YoTc4tL89L1kvNzNzGCQ1RLawfjiRPxhxgFOBiVeHgdWorjhFgTy4orcw8xSnAwK4nw
        6qYDhXhTEiurUovy44tKc1KLDzFKc7AoifPK5x+LFBJITyxJzU5NLUgtgskycXBKNTCqWfVE
        3ipUj1kTUPMzU9nKvTh1p7TY07eXA03/fRfXbL8ooZHT0fnRb0nVhWDNH7PSdzzauKD2SFz4
        9wv/LNbVb6pp2Fh2eaG0uHveSuVPMuUvPyvt/XE5kKtCpHvGnrj2vScPCs7u/WOn/OloklyM
        T9Oavfp3c5261+VVuzxVVf/X3TfHO02JpTgj0VCLuag4EQAVXKm9TQIAAA==
X-CMS-MailID: 20200320055839epcas1p189100549687530619d8a19919e8b5de0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200320055839epcas1p189100549687530619d8a19919e8b5de0
References: <20200320055823.27089-1-jaewon31.kim@samsung.com>
        <CGME20200320055839epcas1p189100549687530619d8a19919e8b5de0@epcas1p1.samsung.com>
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
277.156599: vm_unmapped_area: addr=77e0d03000 err=0 total_vm=0x17014b flags=0x1 len=0x400000 lo=0x8000 hi=0x7878c27000 mask=0x0 ofs=0x1
342.838740: vm_unmapped_area: addr=0 err=-12 total_vm=0xffb08 flags=0x0 len=0x100000 lo=0x40000000 hi=0xfffff000 mask=0x0 ofs=0x22

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
v3: reduce fast_assign and print format
v2: use trace point rather than printk with ratelimit
v1: use printk with ratelimit 
---
 include/trace/events/mmap.h | 48 +++++++++++++++++++++++++++++++++++++++++++++
 mm/mmap.c                   | 12 ++++++++++--
 2 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 include/trace/events/mmap.h

diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
new file mode 100644
index 000000000000..986a41b6cfa9
--- /dev/null
+++ b/include/trace/events/mmap.h
@@ -0,0 +1,48 @@
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
+		__entry->total_vm = current->mm->total_vm;
+		__entry->flags = info->flags;
+		__entry->length = info->length;
+		__entry->low_limit = info->low_limit;
+		__entry->high_limit = info->high_limit;
+		__entry->align_mask = info->align_mask;
+		__entry->align_offset = info->align_offset;
+	),
+
+	TP_printk("addr=%lx err=%ld total_vm=0x%lx flags=0x%lx len=0x%lx lo=0x%lx hi=0x%lx mask=0x%lx ofs=0x%lx\n",
+		IS_ERR_VALUE(__entry->addr) ? 0 : __entry->addr,
+		IS_ERR_VALUE(__entry->addr) ? __entry->addr : 0,
+		__entry->total_vm, __entry->flags, __entry->length,
+		__entry->low_limit, __entry->high_limit, __entry->align_mask,
+		__entry->align_offset)
+);
+#endif
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/mmap.c b/mm/mmap.c
index ba990c20ecc2..94ae18398c59 100644
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
@@ -2061,10 +2064,15 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
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

