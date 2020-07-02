Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CB7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BEF82083E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:49:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X4/TD4a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgGBCto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:49:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22663 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726097AbgGBCtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:49:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593658181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3VZyzSopGASnLmEIGgtT17E8Ttjkhdyan5Gl3/gdEDY=;
        b=X4/TD4a7S/us25um3gLxpELPF4m4OJCbSPkTEQ2JjxuVfxhoaZpZtBvvmxCfrRK+VqzQKp
        aWMh27v5eHx8nGS7v6YAp9w9Hx58cnMGwoVW3YOg2x90jJQQ5wd4TB9s5jEMRSgVeEsarC
        JJPKn7P5JJgp6rnMjvqbO0pm07rewJI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-PqWmnCCTMPSVXDEbdWbpFQ-1; Wed, 01 Jul 2020 22:49:34 -0400
X-MC-Unique: PqWmnCCTMPSVXDEbdWbpFQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D1F1107ACCD;
        Thu,  2 Jul 2020 02:49:31 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-13-96.pek2.redhat.com [10.72.13.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA48E19C4F;
        Thu,  2 Jul 2020 02:49:22 +0000 (UTC)
Date:   Thu, 2 Jul 2020 10:49:19 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bhe@redhat.com,
        catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        robh+dt@kernel.org, arnd@arndb.de, John.P.donnelly@oracle.com,
        prabhakar.pkin@gmail.com, nsaenzjulienne@suse.de, corbet@lwn.net,
        bhsharma@redhat.com, horms@verge.net.au, xiexiuqi@huawei.com,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, huawei.libin@huawei.com,
        guohanjun@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 1/5] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
Message-ID: <20200702024919.GA12277@dhcp-128-65.nay.redhat.com>
References: <20200628083458.40066-1-chenzhou10@huawei.com>
 <20200628083458.40066-2-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200628083458.40066-2-chenzhou10@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/28/20 at 04:34pm, Chen Zhou wrote:
> In preparation for supporting reserve_crashkernel_low in arm64 as
> x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.
> 
> BTW, move x86_64 CRASH_ALIGN to 2M suggested by Dave. CONFIG_PHYSICAL_ALIGN
> can be selected from 2M to 16M, move to the same as arm64.
> 
> Note, in arm64, we reserve low memory if and only if crashkernel=X,low
> is specified. Different with x86_64, don't set low memory automatically.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> Tested-by: John Donnelly <John.p.donnelly@oracle.com>
> Tested-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
> ---
>  arch/x86/kernel/setup.c    | 66 ++++-------------------------
>  include/linux/crash_core.h |  3 ++
>  include/linux/kexec.h      |  2 -
>  kernel/crash_core.c        | 85 ++++++++++++++++++++++++++++++++++++++
>  kernel/kexec_core.c        | 17 --------
>  5 files changed, 96 insertions(+), 77 deletions(-)
> 
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index a3767e74c758..33db99ae3035 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -401,8 +401,8 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  
>  #ifdef CONFIG_KEXEC_CORE
>  
> -/* 16M alignment for crash kernel regions */
> -#define CRASH_ALIGN		SZ_16M
> +/* 2M alignment for crash kernel regions */
> +#define CRASH_ALIGN		SZ_2M
>  
>  /*
>   * Keep the crash kernel below this limit.
> @@ -425,59 +425,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>  # define CRASH_ADDR_HIGH_MAX	SZ_64T
>  #endif
>  
> -static int __init reserve_crashkernel_low(void)
> -{
> -#ifdef CONFIG_X86_64
> -	unsigned long long base, low_base = 0, low_size = 0;
> -	unsigned long total_low_mem;
> -	int ret;
> -
> -	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> -
> -	/* crashkernel=Y,low */
> -	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
> -	if (ret) {
> -		/*
> -		 * two parts from kernel/dma/swiotlb.c:
> -		 * -swiotlb size: user-specified with swiotlb= or default.
> -		 *
> -		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> -		 * to 8M for other buffers that may need to stay low too. Also
> -		 * make sure we allocate enough extra low memory so that we
> -		 * don't run out of DMA buffers for 32-bit devices.
> -		 */
> -		low_size = max(swiotlb_size_or_default() + (8UL << 20), 256UL << 20);
> -	} else {
> -		/* passed with crashkernel=0,low ? */
> -		if (!low_size)
> -			return 0;
> -	}
> -
> -	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> -	if (!low_base) {
> -		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> -		       (unsigned long)(low_size >> 20));
> -		return -ENOMEM;
> -	}
> -
> -	ret = memblock_reserve(low_base, low_size);
> -	if (ret) {
> -		pr_err("%s: Error reserving crashkernel low memblock.\n", __func__);
> -		return ret;
> -	}
> -
> -	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
> -		(unsigned long)(low_size >> 20),
> -		(unsigned long)(low_base >> 20),
> -		(unsigned long)(total_low_mem >> 20));
> -
> -	crashk_low_res.start = low_base;
> -	crashk_low_res.end   = low_base + low_size - 1;
> -	insert_resource(&iomem_resource, &crashk_low_res);
> -#endif
> -	return 0;
> -}
> -
>  static void __init reserve_crashkernel(void)
>  {
>  	unsigned long long crash_size, crash_base, total_mem;
> @@ -541,9 +488,12 @@ static void __init reserve_crashkernel(void)
>  		return;
>  	}
>  
> -	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
> -		memblock_free(crash_base, crash_size);
> -		return;
> +	if (crash_base >= (1ULL << 32)) {
> +		if (reserve_crashkernel_low()) {
> +			memblock_free(crash_base, crash_size);
> +			return;
> +		}
> +		insert_resource(&iomem_resource, &crashk_low_res);
>  	}
>  
>  	pr_info("Reserving %ldMB of memory at %ldMB for crashkernel (System RAM: %ldMB)\n",
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index 525510a9f965..4df8c0bff03e 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -63,6 +63,8 @@ phys_addr_t paddr_vmcoreinfo_note(void);
>  extern unsigned char *vmcoreinfo_data;
>  extern size_t vmcoreinfo_size;
>  extern u32 *vmcoreinfo_note;
> +extern struct resource crashk_res;
> +extern struct resource crashk_low_res;
>  
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len);
> @@ -74,5 +76,6 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
>  int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>  		unsigned long long *crash_size, unsigned long long *crash_base);
> +int __init reserve_crashkernel_low(void);
>  
>  #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ea67910ae6b7..a460afdbab0f 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -330,8 +330,6 @@ extern int kexec_load_disabled;
>  
>  /* Location of a reserved region to hold the crash kernel.
>   */
> -extern struct resource crashk_res;
> -extern struct resource crashk_low_res;
>  extern note_buf_t __percpu *crash_notes;
>  
>  /* flag to track if kexec reboot is in progress */
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index 9f1557b98468..a7580d291c37 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -7,6 +7,8 @@
>  #include <linux/crash_core.h>
>  #include <linux/utsname.h>
>  #include <linux/vmalloc.h>
> +#include <linux/memblock.h>
> +#include <linux/swiotlb.h>
>  
>  #include <asm/page.h>
>  #include <asm/sections.h>
> @@ -19,6 +21,22 @@ u32 *vmcoreinfo_note;
>  /* trusted vmcoreinfo, e.g. we can make a copy in the crash memory */
>  static unsigned char *vmcoreinfo_data_safecopy;
>  
> +/* Location of the reserved area for the crash kernel */
> +struct resource crashk_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +struct resource crashk_low_res = {
> +	.name  = "Crash kernel",
> +	.start = 0,
> +	.end   = 0,
> +	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> +	.desc  = IORES_DESC_CRASH_KERNEL
> +};
> +
>  /*
>   * parsing the "crashkernel" commandline
>   *
> @@ -292,6 +310,73 @@ int __init parse_crashkernel_low(char *cmdline,
>  				"crashkernel=", suffix_tbl[SUFFIX_LOW]);
>  }
>  
> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> +#define CRASH_ALIGN		SZ_2M
> +#endif
> +
> +int __init reserve_crashkernel_low(void)
> +{
> +#if defined(CONFIG_X86_64) || defined(CONFIG_ARM64)
> +	unsigned long long base, low_base = 0, low_size = 0;
> +	unsigned long total_low_mem;
> +	int ret;
> +
> +	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
> +
> +	/* crashkernel=Y,low */
> +	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size,
> +			&base);
> +	if (ret) {
> +#ifdef CONFIG_X86_64
> +		/*
> +		 * two parts from lib/swiotlb.c:
> +		 * -swiotlb size: user-specified with swiotlb= or default.
> +		 *
> +		 * -swiotlb overflow buffer: now hardcoded to 32k. We round it
> +		 * to 8M for other buffers that may need to stay low too. Also
> +		 * make sure we allocate enough extra low memory so that we
> +		 * don't run out of DMA buffers for 32-bit devices.
> +		 */
> +		low_size = max(swiotlb_size_or_default() + (8UL << 20),
> +				256UL << 20);
> +#else
> +		/*
> +		 * in arm64, reserve low memory if and only if crashkernel=X,low
> +		 * specified.
> +		 */
> +		return -EINVAL;
> +#endif
> +	} else {
> +		/* passed with crashkernel=0,low ? */
> +		if (!low_size)
> +			return 0;
> +	}
> +
> +	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
> +	if (!low_base) {
> +		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
> +		       (unsigned long)(low_size >> 20));
> +		return -ENOMEM;
> +	}
> +
> +	ret = memblock_reserve(low_base, low_size);
> +	if (ret) {
> +		pr_err("%s: Error reserving crashkernel low memblock.\n",
> +				__func__);
> +		return ret;
> +	}
> +
> +	pr_info("Reserving %ldMB of low memory at %ldMB for crashkernel (System low RAM: %ldMB)\n",
> +		(unsigned long)(low_size >> 20),
> +		(unsigned long)(low_base >> 20),
> +		(unsigned long)(total_low_mem >> 20));
> +
> +	crashk_low_res.start = low_base;
> +	crashk_low_res.end   = low_base + low_size - 1;
> +#endif
> +	return 0;
> +}
> +
>  Elf_Word *append_elf_note(Elf_Word *buf, char *name, unsigned int type,
>  			  void *data, size_t data_len)
>  {
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c19c0dad1ebe..db66bbabfff3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -53,23 +53,6 @@ note_buf_t __percpu *crash_notes;
>  /* Flag to indicate we are going to kexec a new kernel */
>  bool kexec_in_progress = false;
>  
> -
> -/* Location of the reserved area for the crash kernel */
> -struct resource crashk_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -struct resource crashk_low_res = {
> -	.name  = "Crash kernel",
> -	.start = 0,
> -	.end   = 0,
> -	.flags = IORESOURCE_BUSY | IORESOURCE_SYSTEM_RAM,
> -	.desc  = IORES_DESC_CRASH_KERNEL
> -};
> -
>  int kexec_should_crash(struct task_struct *p)
>  {
>  	/*
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> kexec mailing list
> kexec@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kexec
> 

Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave

