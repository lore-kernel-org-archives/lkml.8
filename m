Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0493BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:37:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF0D5207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ow6RTtEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732868AbgG1ThQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732747AbgG1ThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:37:15 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C731EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:37:15 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h12so1282321pgf.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S9oWtxlrH1e8HbgfASs/OeffS6W2pnOvETdR7J5lPbE=;
        b=Ow6RTtEihhawwuhPMj/TMNdM06Aqj5FJr8X+lPSr8qBaWVrnB0XstAwyWEwl9XSjN3
         Md6+pbeStVX90Wl0u9R5plBdwYXwqfSUQ7rz41bmuVXI+zon6M1jr6W8weItuQvOtko6
         WuMCKb2Q8z7L+wdeUN+BleRIeeI9kqeDS3ZYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S9oWtxlrH1e8HbgfASs/OeffS6W2pnOvETdR7J5lPbE=;
        b=rT5COYe3LcruzC9oFJDutsVRVdJdCnirLVJgz0xA9WKtlTqktMg8AGqCsmWF5ZU70X
         G1f3oDy6NdSFPPNgMvZ7zeizdTEevveI0EJn+Y5fJKyflnLrPmUXJjFGs73hFO9Ks3yI
         rB1V+8oyyaC8v4bP5KhmCK1F7/7nK6znx5Wa2oEncZcJaeaCmJRHMbgRkvmt3MAdCqi+
         tCB1YczxOQ5YUoNLPXIf2TOgn3/YLK+xarXutPdUuq5H/H2GoWO4F0hl0EIICyGHmOnu
         y9vtYUymLLMeehw8zlDoDqNhM3cIOcaPIoEVZsGdDGqFWrDAeWPL5r+Cv59bkitBag+P
         LpWQ==
X-Gm-Message-State: AOAM532p0TugFIyYVBi3WxZ7Mh30MkT/+A/HQIsC1vRFr6Xe5jw9co4S
        TwLeJCTCyHF5JzCDSybk0Aiw84uqiLc=
X-Google-Smtp-Source: ABdhPJzNcZam7F+MqNFwaxAyYNUyMve2w5FcO4bIh5UOIxAPz3fbYJkkvb1z5smJbucl9iubso9e1Q==
X-Received: by 2002:a65:408b:: with SMTP id t11mr25622575pgp.407.1595965035273;
        Tue, 28 Jul 2020 12:37:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a184sm12508385pfa.83.2020.07.28.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:37:14 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:37:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] x86/kaslr: Don't use 64-bit mem_vector for 32-bit
 kernel
Message-ID: <202007281235.B9743EA@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-9-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-9-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:08:01PM -0400, Arvind Sankar wrote:
> Commit
>   f28442497b5c ("x86/boot: Fix KASLR and memmap= collision")
> converted mem_vector type to use 64-bit on the 32-bit kernel as well,
> based on Thomas's review [0]. However:
> - the code still doesn't consistently use 64-bit types. For instance,
>   mem_avoid_overlap uses 32-bit types when checking for overlaps.  This
>   is actually okay, as the passed in memory range will have been clipped
>   to below 4G, but it is difficult to reason about the safety of the
>   code.
> - KASLR on 32-bit can't use memory above 4G anyway, so it's pointless
>   to keep track of ranges above 4G.
> 
> Switch the type back to unsigned long, and use a helper function to clip
> regions to 4G on 32-bit, when storing mem_avoid, immovable_mem, EFI,
> E820 and command-line memory regions.

The reason for long long is to avoid having to check for overflows in
any of the offset calculations. Why not just leave this as-is?

> 
> [0] https://lore.kernel.org/linux-nvdimm/alpine.DEB.2.20.1701111246400.3579@nanos/
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/acpi.c  |  7 +++----
>  arch/x86/boot/compressed/kaslr.c | 25 ++++++++++---------------
>  arch/x86/boot/compressed/misc.h  | 19 +++++++++++++++++--
>  3 files changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
> index 8bcbcee54aa1..d09e0ec5637e 100644
> --- a/arch/x86/boot/compressed/acpi.c
> +++ b/arch/x86/boot/compressed/acpi.c
> @@ -106,7 +106,7 @@ static acpi_physical_address kexec_get_rsdp_addr(void)
>  	}
>  
>  	/* Get systab from boot params. */
> -	systab = (efi_system_table_64_t *) (ei->efi_systab | ((__u64)ei->efi_systab_hi << 32));
> +	systab = (efi_system_table_64_t *) (ei->efi_systab | ((u64)ei->efi_systab_hi << 32));
>  	if (!systab)
>  		error("EFI system table not found in kexec boot_params.");
>  
> @@ -139,7 +139,7 @@ static acpi_physical_address efi_get_rsdp_addr(void)
>  
>  	/* Get systab from boot params. */
>  #ifdef CONFIG_X86_64
> -	systab = ei->efi_systab | ((__u64)ei->efi_systab_hi << 32);
> +	systab = ei->efi_systab | ((u64)ei->efi_systab_hi << 32);
>  #else
>  	if (ei->efi_systab_hi || ei->efi_memmap_hi) {
>  		debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
> @@ -404,8 +404,7 @@ int count_immovable_mem_regions(void)
>  
>  			ma = (struct acpi_srat_mem_affinity *)sub_table;
>  			if (!(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE) && ma->length) {
> -				immovable_mem[num].start = ma->base_address;
> -				immovable_mem[num].size = ma->length;
> +				immovable_mem[num] = mem_vector_ctor(ma->base_address, ma->length);
>  				num++;
>  			}
>  
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index eca2acc65e2a..8c44041ae9cb 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -98,7 +98,7 @@ static bool memmap_too_large;
>   * Store memory limit: MAXMEM on 64-bit and KERNEL_IMAGE_SIZE on 32-bit.
>   * It may be reduced by "mem=nn[KMG]" or "memmap=nn[KMG]" command line options.
>   */
> -static unsigned long long mem_limit;
> +static unsigned long mem_limit;
>  
>  /* Number of immovable memory regions */
>  static int num_immovable_mem;
> @@ -141,8 +141,7 @@ enum parse_mode {
>  };
>  
>  static int
> -parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
> -		enum parse_mode mode)
> +parse_memmap(char *p, u64 *start, u64 *size, enum parse_mode mode)
>  {
>  	char *oldp;
>  
> @@ -172,7 +171,7 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
>  			 */
>  			*size = 0;
>  		} else {
> -			unsigned long long flags;
> +			u64 flags;
>  
>  			/*
>  			 * efi_fake_mem=nn@ss:attr the attr specifies
> @@ -211,7 +210,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
>  
>  	while (str && (i < MAX_MEMMAP_REGIONS)) {
>  		int rc;
> -		unsigned long long start, size;
> +		u64 start, size;
>  		char *k = strchr(str, ',');
>  
>  		if (k)
> @@ -230,8 +229,7 @@ static void mem_avoid_memmap(enum parse_mode mode, char *str)
>  			continue;
>  		}
>  
> -		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].start = start;
> -		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i].size = size;
> +		mem_avoid[MEM_AVOID_MEMMAP_BEGIN + i] = mem_vector_ctor(start, size);
>  		i++;
>  	}
>  
> @@ -422,8 +420,7 @@ static void mem_avoid_init(unsigned long input, unsigned long input_size,
>  	initrd_start |= boot_params->hdr.ramdisk_image;
>  	initrd_size  = (u64)boot_params->ext_ramdisk_size << 32;
>  	initrd_size |= boot_params->hdr.ramdisk_size;
> -	mem_avoid[MEM_AVOID_INITRD].start = initrd_start;
> -	mem_avoid[MEM_AVOID_INITRD].size = initrd_size;
> +	mem_avoid[MEM_AVOID_INITRD] = mem_vector_ctor(initrd_start, initrd_size);
>  	/* No need to set mapping for initrd, it will be handled in VO. */
>  
>  	/* Avoid kernel command line. */
> @@ -673,7 +670,7 @@ static bool process_mem_region(struct mem_vector *region,
>  	 * immovable memory and @region.
>  	 */
>  	for (i = 0; i < num_immovable_mem; i++) {
> -		unsigned long long start, end, entry_end, region_end;
> +		unsigned long start, end, entry_end, region_end;
>  		struct mem_vector entry;
>  
>  		if (!mem_overlaps(region, &immovable_mem[i]))
> @@ -728,7 +725,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>  	}
>  	pmap =  e->efi_memmap;
>  #else
> -	pmap = (e->efi_memmap | ((__u64)e->efi_memmap_hi << 32));
> +	pmap = (e->efi_memmap | ((u64)e->efi_memmap_hi << 32));
>  #endif
>  
>  	nr_desc = e->efi_memmap_size / e->efi_memdesc_size;
> @@ -765,8 +762,7 @@ process_efi_entries(unsigned long minimum, unsigned long image_size)
>  		    !(md->attribute & EFI_MEMORY_MORE_RELIABLE))
>  			continue;
>  
> -		region.start = md->phys_addr;
> -		region.size = md->num_pages << EFI_PAGE_SHIFT;
> +		region = mem_vector_ctor(md->phys_addr, md->num_pages << EFI_PAGE_SHIFT);
>  		if (process_mem_region(&region, minimum, image_size))
>  			break;
>  	}
> @@ -793,8 +789,7 @@ static void process_e820_entries(unsigned long minimum,
>  		/* Skip non-RAM entries. */
>  		if (entry->type != E820_TYPE_RAM)
>  			continue;
> -		region.start = entry->addr;
> -		region.size = entry->size;
> +		region = mem_vector_ctor(entry->addr, entry->size);
>  		if (process_mem_region(&region, minimum, image_size))
>  			break;
>  	}
> diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
> index 726e264410ff..fd7c49ab0f02 100644
> --- a/arch/x86/boot/compressed/misc.h
> +++ b/arch/x86/boot/compressed/misc.h
> @@ -70,10 +70,25 @@ int cmdline_find_option(const char *option, char *buffer, int bufsize);
>  int cmdline_find_option_bool(const char *option);
>  
>  struct mem_vector {
> -	unsigned long long start;
> -	unsigned long long size;
> +	unsigned long start;
> +	unsigned long size;
>  };
>  
> +static inline
> +struct mem_vector mem_vector_ctor(u64 start, u64 size)
> +{
> +	u64 end = start + size;
> +	struct mem_vector ret;
> +
> +	start = min_t(u64, start, ULONG_MAX);
> +	end   = min_t(u64, end,   ULONG_MAX);
> +
> +	ret.start = (unsigned long)start;
> +	ret.size  = (unsigned long)(end - start);
> +
> +	return ret;
> +}
> +
>  #if CONFIG_RANDOMIZE_BASE
>  /* kaslr.c */
>  void choose_random_location(unsigned long input,
> -- 
> 2.26.2
> 

-- 
Kees Cook
