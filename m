Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B57C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E08206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 08:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgHNIWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 04:22:09 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9805 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726050AbgHNIWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 04:22:09 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6B8E9FCEC132F76F3779;
        Fri, 14 Aug 2020 16:22:06 +0800 (CST)
Received: from [127.0.0.1] (10.108.235.113) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Fri, 14 Aug 2020
 16:21:57 +0800
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
To:     Dave Young <dyoung@redhat.com>
CC:     <kexec@lists.infradead.org>, <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <luanjianhai@huawei.com>,
        <zhuling8@huawei.com>, <luchunhua@huawei.com>,
        <pasha.tatashin@soleen.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
 <20200814065845.GA18234@dhcp-128-65.nay.redhat.com>
From:   Sang Yan <sangyan@huawei.com>
Message-ID: <ad098e21-d689-f655-1e32-c93adcf0cb2d@huawei.com>
Date:   Fri, 14 Aug 2020 16:21:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200814065845.GA18234@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.113]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/14/20 14:58, Dave Young wrote:
> On 08/14/20 at 01:52am, Sang Yan wrote:
>> In normal kexec, relocating kernel may cost 5 ~ 10 seconds, to
>> copy all segments from vmalloced memory to kernel boot memory,
>> because of disabled mmu.
> 
> It is not the case on all archs, I assume your case is arm64, please
> describe it in patch log :)
> 
Yes, it's particularly obvious on arm64. I will add it to the patch log,
and test how long it takes on x86 and other arch.

> About the arm64 problem, I know Pavel Tatashin is working on a patchset
> to improve the performance with enabling mmu.
> 
> I added Pavel in cc, can you try his patches?
> 
Thanks for your tips, I will try these patches. @Pavel.
Disable mmu after finishing copying pages?
>>
>> We introduce quick kexec to save time of copying memory as above,
>> just like kdump(kexec on crash), by using reserved memory
>> "Quick Kexec".
> 
> This approach may have gain, but it also introduce extra requirements to
> pre-reserve a memory region.  I wonder how Eric thinks about the idea.
> 
> Anyway the "quick" name sounds not very good, I would suggest do not
> introduce a new param, and the code can check if pre-reserved region
> exist then use it, if not then fallback to old way.
> 
aha. I agree with it, but I thought it may change the old behaviors of
kexec_load.

I will update a new patch without introducing new flags and new params.

Thanks a lot.

>>
>> Constructing quick kimage as the same as crash kernel,
>> then simply copy all segments of kimage to reserved memroy.
>>
>> We also add this support in syscall kexec_load using flags
>> of KEXEC_QUICK.
>>
>> Signed-off-by: Sang Yan <sangyan@huawei.com>
>> ---
>>  arch/Kconfig               | 10 ++++++++++
>>  include/linux/ioport.h     |  3 +++
>>  include/linux/kexec.h      | 13 +++++++++++-
>>  include/uapi/linux/kexec.h |  3 +++
>>  kernel/kexec.c             | 10 ++++++++++
>>  kernel/kexec_core.c        | 41 +++++++++++++++++++++++++++++---------
>>  6 files changed, 70 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 3329fa143637..eca782cb8e29 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -21,6 +21,16 @@ config KEXEC_CORE
>>  config KEXEC_ELF
>>  	bool
>>  
>> +config QUICK_KEXEC
>> +	bool "Support for quick kexec"
>> +	depends on KEXEC_CORE
>> +	help
>> +	  Say y here to enable this feature.
>> +	  It use reserved memory to accelerate kexec, just like crash
>> +	  kexec, load new kernel and initrd to reserved memory, and
>> +	  boot new kernel on that memory. It will save the time of
>> +	  relocating kernel.
>> +
>>  config HAVE_IMA_KEXEC
>>  	bool
>>  
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 6c2b06fe8beb..f37c632accbe 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -136,6 +136,9 @@ enum {
>>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>>  	IORES_DESC_RESERVED			= 7,
>>  	IORES_DESC_SOFT_RESERVED		= 8,
>> +#ifdef CONFIG_QUICK_KEXEC
>> +	IORES_DESC_QUICK_KEXEC			= 9,
>> +#endif
>>  };
>>  
>>  /*
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 9e93bef52968..976bf9631070 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -269,9 +269,12 @@ struct kimage {
>>  	unsigned long control_page;
>>  
>>  	/* Flags to indicate special processing */
>> -	unsigned int type : 1;
>> +	unsigned int type : 2;
>>  #define KEXEC_TYPE_DEFAULT 0
>>  #define KEXEC_TYPE_CRASH   1
>> +#ifdef CONFIG_QUICK_KEXEC
>> +#define KEXEC_TYPE_QUICK   2
>> +#endif
>>  	unsigned int preserve_context : 1;
>>  	/* If set, we are using file mode kexec syscall */
>>  	unsigned int file_mode:1;
>> @@ -331,6 +334,11 @@ extern int kexec_load_disabled;
>>  #define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
>>  #endif
>>  
>> +#ifdef CONFIG_QUICK_KEXEC
>> +#undef KEXEC_FLAGS
>> +#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_QUICK)
>> +#endif
>> +
>>  /* List of defined/legal kexec file flags */
>>  #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
>>  				 KEXEC_FILE_NO_INITRAMFS)
>> @@ -340,6 +348,9 @@ extern int kexec_load_disabled;
>>  extern struct resource crashk_res;
>>  extern struct resource crashk_low_res;
>>  extern note_buf_t __percpu *crash_notes;
>> +#ifdef CONFIG_QUICK_KEXEC
>> +extern struct resource quick_kexec_res;
>> +#endif
>>  
>>  /* flag to track if kexec reboot is in progress */
>>  extern bool kexec_in_progress;
>> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
>> index 05669c87a0af..e3213614b713 100644
>> --- a/include/uapi/linux/kexec.h
>> +++ b/include/uapi/linux/kexec.h
>> @@ -12,6 +12,9 @@
>>  /* kexec flags for different usage scenarios */
>>  #define KEXEC_ON_CRASH		0x00000001
>>  #define KEXEC_PRESERVE_CONTEXT	0x00000002
>> +#ifdef CONFIG_QUICK_KEXEC
>> +#define KEXEC_QUICK		0x00000004
>> +#endif
>>  #define KEXEC_ARCH_MASK		0xffff0000
>>  
>>  /*
>> diff --git a/kernel/kexec.c b/kernel/kexec.c
>> index f977786fe498..428af4cd3e1a 100644
>> --- a/kernel/kexec.c
>> +++ b/kernel/kexec.c
>> @@ -44,6 +44,9 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>>  	int ret;
>>  	struct kimage *image;
>>  	bool kexec_on_panic = flags & KEXEC_ON_CRASH;
>> +#ifdef CONFIG_QUICK_KEXEC
>> +	bool kexec_on_quick = flags & KEXEC_QUICK;
>> +#endif
>>  
>>  	if (kexec_on_panic) {
>>  		/* Verify we have a valid entry point */
>> @@ -69,6 +72,13 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
>>  		image->type = KEXEC_TYPE_CRASH;
>>  	}
>>  
>> +#ifdef CONFIG_QUICK_KEXEC
>> +	if (kexec_on_quick) {
>> +		image->control_page = quick_kexec_res.start;
>> +		image->type = KEXEC_TYPE_QUICK;
>> +	}
>> +#endif
>> +
>>  	ret = sanity_check_segment_list(image);
>>  	if (ret)
>>  		goto out_free_image;
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index c19c0dad1ebe..b73dd749368b 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -70,6 +70,16 @@ struct resource crashk_low_res = {
>>  	.desc  = IORES_DESC_CRASH_KERNEL
>>  };
>>  
>> +#ifdef CONFIG_QUICK_KEXEC
>> +struct resource quick_kexec_res = {
>> +	.name  = "Quick kexec",
>> +	.start = 0,
>> +	.end   = 0,
>> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
>> +	.desc  = IORES_DESC_QUICK_KEXEC
>> +};
>> +#endif
>> +
>>  int kexec_should_crash(struct task_struct *p)
>>  {
>>  	/*
>> @@ -413,8 +423,10 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
>>  	return pages;
>>  }
>>  
>> -static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>> -						      unsigned int order)
>> +
>> +static struct page *kimage_alloc_special_control_pages(struct kimage *image,
>> +						       unsigned int order,
>> +						       unsigned long end)
>>  {
>>  	/* Control pages are special, they are the intermediaries
>>  	 * that are needed while we copy the rest of the pages
>> @@ -444,7 +456,7 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>>  	size = (1 << order) << PAGE_SHIFT;
>>  	hole_start = (image->control_page + (size - 1)) & ~(size - 1);
>>  	hole_end   = hole_start + size - 1;
>> -	while (hole_end <= crashk_res.end) {
>> +	while (hole_end <= end) {
>>  		unsigned long i;
>>  
>>  		cond_resched();
>> @@ -479,7 +491,6 @@ static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
>>  	return pages;
>>  }
>>  
>> -
>>  struct page *kimage_alloc_control_pages(struct kimage *image,
>>  					 unsigned int order)
>>  {
>> @@ -490,8 +501,15 @@ struct page *kimage_alloc_control_pages(struct kimage *image,
>>  		pages = kimage_alloc_normal_control_pages(image, order);
>>  		break;
>>  	case KEXEC_TYPE_CRASH:
>> -		pages = kimage_alloc_crash_control_pages(image, order);
>> +		pages = kimage_alloc_special_control_pages(image, order,
>> +							   crashk_res.end);
>> +		break;
>> +#ifdef CONFIG_QUICK_KEXEC
>> +	case KEXEC_TYPE_QUICK:
>> +		pages = kimage_alloc_special_control_pages(image, order,
>> +							   quick_kexec_res.end);
>>  		break;
>> +#endif
>>  	}
>>  
>>  	return pages;
>> @@ -847,11 +865,11 @@ static int kimage_load_normal_segment(struct kimage *image,
>>  	return result;
>>  }
>>  
>> -static int kimage_load_crash_segment(struct kimage *image,
>> +static int kimage_load_special_segment(struct kimage *image,
>>  					struct kexec_segment *segment)
>>  {
>> -	/* For crash dumps kernels we simply copy the data from
>> -	 * user space to it's destination.
>> +	/* For crash dumps kernels and quick kexec kernels
>> +	 * we simply copy the data from user space to it's destination.
>>  	 * We do things a page at a time for the sake of kmap.
>>  	 */
>>  	unsigned long maddr;
>> @@ -925,8 +943,13 @@ int kimage_load_segment(struct kimage *image,
>>  		result = kimage_load_normal_segment(image, segment);
>>  		break;
>>  	case KEXEC_TYPE_CRASH:
>> -		result = kimage_load_crash_segment(image, segment);
>> +		result = kimage_load_special_segment(image, segment);
>> +		break;
>> +#ifdef CONFIG_QUICK_KEXEC
>> +	case KEXEC_TYPE_QUICK:
>> +		result = kimage_load_special_segment(image, segment);
>>  		break;
>> +#endif
>>  	}
>>  
>>  	return result;
>> -- 
>> 2.19.1
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec
>>
> 
> Thanks
> Dave
> 
> 
> .
> 
Thanks
Sang Yan

