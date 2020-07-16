Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828C3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 573142074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 18:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dvx6znEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729366AbgGPS2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 14:28:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40702 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgGPS2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 14:28:46 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIMorL116040;
        Thu, 16 Jul 2020 18:28:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=NMspoUF3zFfbPIO6bYbuQkF0xdzf5NUiaa140NHriiM=;
 b=Dvx6znEXNYqach8SL6g3CA1M7C93/fv3vpdg/QvWCBq+MlZnYqS2Y4a9RCRDpJfaFJxe
 j7/oS2UwK9Ssfhddm3SNYxdUtMStb2YDjuKdtpW/kUyypS6KVWcbDH0teffRgufFaGDB
 Wwg3IxpzaTefW8BcornOKuy6yJfoNLuC4VezF3XuqrTsYrks4SZBG8qmAo0d1FYBY3H4
 Y+59JzO1ZMsLdYnU31qK1n04wW37wt3Wx8b5DePcOhKQYVzTWko1+q0X++VEb4h3xgTC
 Dmw5VHZLaLN48P8weIQAoXU7gfyfacfRb7up99vHO04pXJGQDBH1C5f0tBULQA0M1n1y Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3275cmk3bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 16 Jul 2020 18:28:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06GIHhHv093791;
        Thu, 16 Jul 2020 18:26:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 327qbc55dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 18:26:05 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06GIPuYL032145;
        Thu, 16 Jul 2020 18:25:57 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jul 2020 11:25:56 -0700
Subject: Re: [PATCH v3] mm/hugetlb: split hugetlb_cma in nodes with memory
To:     Will Deacon <will@kernel.org>, Roman Gushchin <guro@fb.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        linux-mm@kvack.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "H.Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        akpm@linux-foundation.org, Mike Rapoport <rppt@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200710120950.37716-1-song.bao.hua@hisilicon.com>
 <359ea1d0-b1fd-d09f-d28a-a44655834277@oracle.com>
 <20200715081822.GA5683@willie-the-truck>
 <5724f1f8-63a6-ee0f-018c-06fb259b6290@oracle.com>
 <20200716081243.GA6561@willie-the-truck>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a867c7a2-e89b-2015-4895-f30f7aeb07cb@oracle.com>
Date:   Thu, 16 Jul 2020 11:25:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716081243.GA6561@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 mlxlogscore=-1000 malwarescore=0
 mlxscore=100 spamscore=100 phishscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9684 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=100 suspectscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=100
 impostorscore=0 malwarescore=0 mlxlogscore=-1000 clxscore=1015
 mlxscore=100 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/16/20 1:12 AM, Will Deacon wrote:
> On Wed, Jul 15, 2020 at 09:59:24AM -0700, Mike Kravetz wrote:
>>
>> So, everything in the existing code really depends on the hugetlb definition
>> of gigantic page (order >= MAX_ORDER).  The code to check for
>> 'order >= MAX_ORDER' in my proposed patch is just following the same
>> convention.
> 
> Fair enough, and thanks for the explanation. Maybe just chuck a comment in,
> then? Alternatively, having something like:
> 
> static inline bool page_order_is_gigantic(unsigned int order)
> {
> 	return order >= MAX_ORDER;
> }
> 
> static inline bool hstate_is_gigantic(struct hstate *h)
> {
> 	return page_order_is_gigantic(huge_page_order(h));
> }

Ok, the updated patch below includes both as well as your other suggestions.

It would be great if Roman could comment/test as he provided the initial
code and has a well defined use case.  Testing from Barry would also be
appreciated as most of the recent churn has come from his testing.

>> I think the current dependency on the hugetlb definition of gigantic page
>> may be too simplistic if using CMA for huegtlb pages becomes more common.
>> Some architectures (sparc, powerpc) have more than one gigantic pages size.
>> Currently there is no way to specify that CMA should be used for one and
>> not the other.  In addition, I could imagine someone wanting to reserve/use
>> CMA for non-gigantic (PMD) sized pages.  There is no mechainsm for that today.
>>
>> I honestly have not heard about many use cases for this CMA functionality.
>> When support was initially added, it was driven by a specific use case and
>> the 'all gigantic pages use CMA if defined' implementation was deemed
>> sufficient.  If there are more use cases, or this seems too simple we can
>> revisit that decision.
> 
> Agreed, I think your patch is an improvement regardless of that.

Anshuman and Barry have pending patches changing the place in arch specific
code where hugetlb_cma_reserve is called.  This will not be necessary if the
proposed code proves successful.

From 17c8f37afbf42fe7412e6eebb3619c6e0b7e1c3c Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 14 Jul 2020 15:54:46 -0700
Subject: [PATCH] hugetlb: move cma reservation to code setting up gigantic
 hstate

Instead of calling hugetlb_cma_reserve() directly from arch specific
code, call from hugetlb_add_hstate when adding a gigantic hstate.
hugetlb_add_hstate is either called from arch specific huge page setup,
or as the result of hugetlb command line processing.  In either case,
this is late enough in the init process that all numa memory information
should be initialized.  And, it is early enough to still use early
memory allocator.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 arch/arm64/mm/init.c    | 10 ----------
 arch/x86/kernel/setup.c |  9 ---------
 include/linux/hugetlb.h | 12 ------------
 mm/hugetlb.c            | 32 ++++++++++++++++++++++++++++----
 4 files changed, 28 insertions(+), 35 deletions(-)

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
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 6b9508dc31b4..5fadba1febcc 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -933,16 +933,4 @@ static inline spinlock_t *huge_pte_lock(struct hstate *h,
 	return ptl;
 }
 
-#if defined(CONFIG_HUGETLB_PAGE) && defined(CONFIG_CMA)
-extern void __init hugetlb_cma_reserve(int order);
-extern void __init hugetlb_cma_check(void);
-#else
-static inline __init void hugetlb_cma_reserve(int order)
-{
-}
-static inline __init void hugetlb_cma_check(void)
-{
-}
-#endif
-
 #endif /* _LINUX_HUGETLB_H */
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f24acb3af741..2ca68c5620b7 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -76,8 +76,10 @@ DEFINE_SPINLOCK(hugetlb_lock);
 static int num_fault_mutexes;
 struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 
-/* Forward declaration */
+/* Forward declarations */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
+static void __init hugetlb_cma_reserve(int order);
+static void __init hugetlb_cma_check(void);
 
 static inline void unlock_or_release_subpool(struct hugepage_subpool *spool)
 {
@@ -3273,6 +3275,13 @@ void __init hugetlb_add_hstate(unsigned int order)
 	snprintf(h->name, HSTATE_NAME_LEN, "hugepages-%lukB",
 					huge_page_size(h)/1024);
 
+	/*
+	 * If user wants CMA for gigantic pages, reserve it now as we
+	 * set up the gigantic page hstate.
+	 */
+	if (hstate_is_gigantic(h) && hugetlb_cma_size)
+		hugetlb_cma_reserve(order);
+
 	parsed_hstate = h;
 }
 
@@ -5627,12 +5636,16 @@ void move_hugetlb_state(struct page *oldpage, struct page *newpage, int reason)
 #ifdef CONFIG_CMA
 static bool cma_reserve_called __initdata;
 
+/*
+ * early_param, as hugetlb_cma_size must be processed before any call to
+ * hugetlb_add_hstate by arch specific code or regular hugetlb command
+ * line processing.
+ */
 static int __init cmdline_parse_hugetlb_cma(char *p)
 {
 	hugetlb_cma_size = memparse(p, &p);
 	return 0;
 }
-
 early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
 
 /*
@@ -5642,11 +5655,13 @@ early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
  * hugetlb_cma_reserve() scans over N_MEMORY nodemask and hence expects the platforms
  * to have initialized N_MEMORY state.
  */
-void __init hugetlb_cma_reserve(int order)
+static void __init hugetlb_cma_reserve(int order)
 {
 	unsigned long size, reserved, per_node;
 	int nid;
 
+	if (cma_reserve_called)
+		return;
 	cma_reserve_called = true;
 
 	if (!hugetlb_cma_size)
@@ -5693,12 +5708,21 @@ void __init hugetlb_cma_reserve(int order)
 	}
 }
 
-void __init hugetlb_cma_check(void)
+static void __init hugetlb_cma_check(void)
 {
 	if (!hugetlb_cma_size || cma_reserve_called)
 		return;
 
 	pr_warn("hugetlb_cma: the option isn't supported by current arch\n");
 }
+#else
+
+static void __init hugetlb_cma_reserve(int order)
+{
+}
+
+static void __init hugetlb_cma_check(void)
+{
+}
 
 #endif /* CONFIG_CMA */
-- 
2.25.4

