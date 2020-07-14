Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E29CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67D9020658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZRRF+jnB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGNXVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:21:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:40482 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgGNXVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:21:48 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06ENI58Z031995;
        Tue, 14 Jul 2020 23:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=huwe7LJjPiG05JDlokSws0RPUDGrjHXSLJK2vvuRoFM=;
 b=ZRRF+jnBix38ga052rXF5+mTn5/bZZ4SWTrmykOkoErMt/KZGutKmStn2PBDRM3FPJ50
 VRtz2j4BKJvSFnt2C5a64/mer1JdTrBf7rN6Jj8NuAWYqFTrjY1Z0rw8HYHJBU7iWACi
 2Lde/HNtt/YVgy9sd2KJwLdOQtloYAi/jMqcjeiOcUJ8Rp5bEv1FjZUWY1hmUh3EmQPj
 rw2B26boLreFPzagSWP0L5MAfSJeF7Nv4G9fBQuBkL3UuB2iyV+ewGncq4Ra+tYMkkbr
 FwDhqKlXQTvmJKE3w/HTtDmjvs+QG0Rxm926fEuPF9C+YADLE4QKXLPHQMO3wvE1C3cR SA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3274ur8bjv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Jul 2020 23:21:08 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06ENDcdx077551;
        Tue, 14 Jul 2020 23:21:08 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 327q6t810m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Jul 2020 23:21:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06ENL32W032162;
        Tue, 14 Jul 2020 23:21:04 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 14 Jul 2020 16:21:03 -0700
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org
Cc:     x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, linux-arm-kernel@lists.infradead.org,
        Roman Gushchin <guro@fb.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H.Peter Anvin" <hpa@zytor.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
Date:   Tue, 14 Jul 2020 16:21:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=2
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007140161
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9682 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=2 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007140161
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/20 5:09 AM, Barry Song wrote:
> Online nodes are not necessarily memory containing nodes. Splitting
> huge_cma in online nodes can lead to inconsistent hugetlb_cma size
> with user setting. For example, for one system with 4 numa nodes and
> only one of them has memory, if users set hugetlb_cma to 4GB, it will
> split into four 1GB. So only the node with memory will get 1GB CMA.
> All other three nodes get nothing. That means the whole system gets
> only 1GB CMA while users ask for 4GB.
> 
> Thus, it is more sensible to split hugetlb_cma in nodes with memory.
> For the above case, the only node with memory will reserve 4GB cma
> which is same with user setting in bootargs. In order to split cma
> in nodes with memory, hugetlb_cma_reserve() should scan over those
> nodes with N_MEMORY state rather than N_ONLINE state. That means
> the function should be called only after arch code has finished
> setting the N_MEMORY state of nodes.
> 
> The problem is always there if N_ONLINE != N_MEMORY. It is a general
> problem to all platforms. But there is some trivial difference among
> different architectures.
> For example, for ARM64, before hugetlb_cma_reserve() is called, all
> nodes have got N_ONLINE state. So hugetlb will get inconsistent cma
> size when some online nodes have no memory. For x86 case, the problem
> is hidden because X86 happens to just set N_ONLINE on the nodes with
> memory when hugetlb_cma_reserve() is called.
> 
> Anyway, this patch moves to scan N_MEMORY in hugetlb_cma_reserve()
> and lets both x86 and ARM64 call the function after N_MEMORY state
> is ready. It also documents the requirement in the definition of
> hugetlb_cma_reserve().
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>

I agree we should only be concerned with N_MEMORY nodes for the CMA
reservations.  However, this patch got me thinking:
- Do we really have to initiate the CMA reservations from arch specific code?
- Can we move the call to reserve CMA a little later into hugetlb arch
  independent code?

I know the cma_declare_contiguous_nid() routine says it should be called
from arch specific code.  However, unless I am missing something that seems
mostly about timing.

What about a change like this on top of this patch?

From 72b5b9a623f8711ad7f79f1a8f910906245f5d07 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 14 Jul 2020 15:54:46 -0700
Subject: [PATCH] hugetlb: move cma allocation call to arch independent code

Instead of calling hugetlb_cma_reserve() from arch specific code,
call from arch independent code when a gigantic page hstate is
created.  This is late enough in the init process that all numa
memory information should be initialized.  And, it is early enough
to still use early memory allocator.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/arm64/mm/init.c    | 10 ----------
 arch/x86/kernel/setup.c |  9 ---------
 mm/hugetlb.c            |  8 +++++++-
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 79806732f4b4..ff0ff584dde9 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -427,16 +427,6 @@ void __init bootmem_init(void)
 	sparse_init();
 	zone_sizes_init(min, max);
 
-	/*
-	 * must be done after zone_sizes_init() which calls free_area_init()
-	 * that calls node_set_state() to initialize node_states[N_MEMORY]
-	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
-	 * state
-	 */
-#ifdef CONFIG_ARM64_4K_PAGES
-	hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-#endif
-
 	memblock_dump_all();
 }
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index a1a9712090ae..111c8467fafa 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1177,15 +1177,6 @@ void __init setup_arch(char **cmdline_p)
 
 	x86_init.paging.pagetable_init();
 
-	/*
-	 * must be done after zone_sizes_init() which calls free_area_init()
-	 * that calls node_set_state() to initialize node_states[N_MEMORY]
-	 * because hugetlb_cma_reserve() will scan over nodes with N_MEMORY
-	 * state
-	 */
-	if (boot_cpu_has(X86_FEATURE_GBPAGES))
-		hugetlb_cma_reserve(PUD_SHIFT - PAGE_SHIFT);
-
 	kasan_init();
 
 	/*
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f24acb3af741..a0007d1d12d2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3273,6 +3273,9 @@ void __init hugetlb_add_hstate(unsigned int order)
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 
+	if (order >= MAX_ORDER && hugetlb_cma_size)
+		hugetlb_cma_reserve(order);
+
 	parsed_hstate = h;
 }
 
@@ -5647,7 +5650,10 @@ void __init hugetlb_cma_reserve(int order)
 	unsigned long size, reserved, per_node;
 	int nid;
 
-	cma_reserve_called = true;
+	if (cma_reserve_called)
+		return;
+	else
+		cma_reserve_called = true;
 
 	if (!hugetlb_cma_size)
 		return;
-- 
2.25.4

