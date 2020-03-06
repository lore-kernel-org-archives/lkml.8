Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DC4C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15632084E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgCFGgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:36:21 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725867AbgCFGgV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:36:21 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6075959F70085361AA20;
        Fri,  6 Mar 2020 14:36:18 +0800 (CST)
Received: from [127.0.0.1] (10.177.246.209) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 14:36:11 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid weird message in hugetlb_init
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <arei.gonglei@huawei.com>, <huangzhichao@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20200305033014.1152-1-longpeng2@huawei.com>
 <fe9af2ff-01de-93ce-9628-10a54543be07@oracle.com>
From:   "Longpeng (Mike)" <longpeng2@huawei.com>
Message-ID: <cb3da0cf-9d4e-633d-c098-cac16d876956@huawei.com>
Date:   Fri, 6 Mar 2020 14:36:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <fe9af2ff-01de-93ce-9628-10a54543be07@oracle.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.246.209]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/3/6 8:09, Mike Kravetz 写道:
> On 3/4/20 7:30 PM, Longpeng(Mike) wrote:
>> From: Longpeng <longpeng2@huawei.com>
>>
>> Some architectures(e.g. x86,risv) doesn't add 2M-hstate by default,
>> so if we add 'default_hugepagesz=2M' but without 'hugepagesz=2M' in
>> cmdline, we'll get a message as follow:
>> "HugeTLB: unsupported default_hugepagesz 2097152. Reverting to 2097152"
> 
> Yes, that is a weird message that should not be printed.  Thanks for
> pointing out the issue!
> 
>> As architecture-specific HPAGE_SIZE hstate should be supported by
>> default, we can avoid this weird message by add it if we hadn't yet.
> 
> As you have discovered, some of the hugetlb size setup is done in
> architecture specific code.  And other code is architecture independent.
> 
> The code which verifies huge page sizes (hugepagesz=) is architecture
> specific.  The code which reads default_hugepagesz= is architecture
> independent.  In fact, no verification of the 'default_hugepagesz' value
> is made when value is read from the command line.  The value is verified
> later after command line processing.  Current code considers the value
> 'valid' if it corresponds to a hstate previously setup by architecture
> specific code.  If architecture specific code did not set up a corresponding 
> hstate, an error like that above is reported.
> 
> Some architectures such as arm, powerpc and sparc set up hstates for all
> supported sizes.  Other architectures such as riscv, s390 and x86 only
> set up hstates for those requested on the command line with hugepagesz=.
> Depending on config options, x86 and riscv may or may not set up PUD_SIZE
> hstates.
> 
> Therefore, on s390 and x86 and riscv (with certain config options) it
> would be possible to specify a valid huge page size (PUD_SIZE) with
> default_hugepagesz=, and have that value be rejected.  This is because
> the architecture specific code will not set up that hstate by default.
> 
> The code you have proposed handles the case where the value specified
> by default_hugepagesz= coresponds to HPAGE_SIZE.  That is because the
> architecture independent code will set up the hstate for HPAGE_SIZE.
> HPAGE_SIZE is the only valid huge page size known by the architecture
> independent code.
> 
Hi Mike,
Thanks for your detailed explanation :)

> I am thinking we may want to have a more generic solution by allowing
> the default_hugepagesz= processing code to verify the passed size and
> set up the corresponding hstate.  This would require more cooperation
> between architecture specific and independent code.  This could be
> accomplished with a simple arch_hugetlb_valid_size() routine provided
> by the architectures.  Below is an untested patch to add such support
> to the architecture independent code and x86.  Other architectures would
> be similar.
> 
> In addition, with architectures providing arch_hugetlb_valid_size() it
> should be possible to have a common routine in architecture independent
> code to read/process hugepagesz= command line arguments.
>
I just want to use the minimize changes to address this issue, so I choosed a
way which my patch did.

To be honest, the approach you suggested above is much better though it need
more changes.

> Of course, another approach would be to simply require ALL architectures
> to set up hstates for ALL supported huge page sizes.
> 
I think this is also needed, then we can request all supported size of hugepages
by sysfs(e.g. /sys/kernel/mm/hugepages/*) dynamically. Currently, (x86) we can
only request 1G-hugepage through sysfs if we boot with 'default_hugepagesz=1G',
even with the first approach.


BTW, because it's not easy to discuss with you due to the time difference, I
have another question about the default hugepages to consult you here. Why the
/proc/meminfo only show the info about the default hugepages, but not others?
meminfo is more well know than sysfs, some ordinary users know meminfo but don't
know use the sysfs to get the hugepages status(e.g. total, free).

> Thoughts?
> -- 
> Mike Kravetz
> 
> diff --git a/arch/x86/include/asm/hugetlb.h b/arch/x86/include/asm/hugetlb.h
> index f65cfb48cfdd..dc00c3df1f22 100644
> --- a/arch/x86/include/asm/hugetlb.h
> +++ b/arch/x86/include/asm/hugetlb.h
> @@ -7,6 +7,9 @@
>  
>  #define hugepages_supported() boot_cpu_has(X86_FEATURE_PSE)
>  
> +#define __HAVE_ARCH_HUGETLB_VALID_SIZE
> +extern bool __init arch_hugetlb_valid_size(unsigned long size);
> +
>  static inline int is_hugepage_only_range(struct mm_struct *mm,
>  					 unsigned long addr,
>  					 unsigned long len) {
> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
> index 5bfd5aef5378..1c4372bfe782 100644
> --- a/arch/x86/mm/hugetlbpage.c
> +++ b/arch/x86/mm/hugetlbpage.c
> @@ -181,13 +181,22 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  #endif /* CONFIG_HUGETLB_PAGE */
>  
>  #ifdef CONFIG_X86_64
> +bool __init arch_hugetlb_valid_size(unsigned long size)
> +{
> +	if (size == PMD_SIZE)
> +		return true;
> +	else if (size == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES))
> +		return true;
> +	else
> +		return false;
> +}
> +
>  static __init int setup_hugepagesz(char *opt)
>  {
>  	unsigned long ps = memparse(opt, &opt);
> -	if (ps == PMD_SIZE) {
> -		hugetlb_add_hstate(PMD_SHIFT - PAGE_SHIFT);
> -	} else if (ps == PUD_SIZE && boot_cpu_has(X86_FEATURE_GBPAGES)) {
> -		hugetlb_add_hstate(PUD_SHIFT - PAGE_SHIFT);
> +
> +	if (arch_hugetlb_valid_size(ps)) {
> +		hugetlb_add_hstate(ilog2(ps) - PAGE_SHIFT);
>  	} else {
>  		hugetlb_bad_size();
>  		printk(KERN_ERR "hugepagesz: Unsupported page size %lu M\n",
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 50480d16bd33..822d0d8559c7 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -678,6 +678,13 @@ static inline spinlock_t *huge_pte_lockptr(struct hstate *h,
>  	return &mm->page_table_lock;
>  }
>  
> +#ifndef __HAVE_ARCH_HUGETLB_VALID_SIZE
> +static inline bool arch_hugetlb_valid_size(unsigned long size)
> +{
> +	return (size == HPAGE_SIZE);
> +}
> +#endif
> +
>  #ifndef hugepages_supported
>  /*
>   * Some platform decide whether they support huge pages at boot
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 7fb31750e670..fc3f0f1e3a27 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3078,17 +3078,13 @@ static int __init hugetlb_init(void)
>  	if (!hugepages_supported())
>  		return 0;
>  
> +	/* if default_hstate_size != 0, corresponding hstate was added */
>  	if (!size_to_hstate(default_hstate_size)) {
> -		if (default_hstate_size != 0) {
> -			pr_err("HugeTLB: unsupported default_hugepagesz %lu. Reverting to %lu\n",
> -			       default_hstate_size, HPAGE_SIZE);
> -		}
> -
>  		default_hstate_size = HPAGE_SIZE;
> -		if (!size_to_hstate(default_hstate_size))
> -			hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
> +		hugetlb_add_hstate(HUGETLB_PAGE_ORDER);
>  	}
>  	default_hstate_idx = hstate_index(size_to_hstate(default_hstate_size));
> +
>  	if (default_hstate_max_huge_pages) {
>  		if (!default_hstate.max_huge_pages)
>  			default_hstate.max_huge_pages = default_hstate_max_huge_pages;
> @@ -3195,7 +3191,15 @@ __setup("hugepages=", hugetlb_nrpages_setup);
>  
>  static int __init hugetlb_default_setup(char *s)
>  {
> -	default_hstate_size = memparse(s, &s);
> +	unsigned long size = memparse(s, &s);
> +
> +	if (arch_hugetlb_valid_size(size)) {
> +		default_hstate_size = size;
> +		hugetlb_add_hstate(ilog2(size) - PAGE_SHIFT);
> +	} else {
> +		pr_err("HugeTLB: unsupported default_hugepagesz %lu.\n", size);
> +		hugetlb_bad_size();
> +	}
>  	return 1;
>  }
>  __setup("default_hugepagesz=", hugetlb_default_setup);
> 


-- 
Regards,
Longpeng(Mike)

