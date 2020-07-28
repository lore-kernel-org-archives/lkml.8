Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813A5C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AFA220656
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PTVl4se9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732850AbgG1Tes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732843AbgG1Ter (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:34:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12B3C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:34:47 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id gc9so453139pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CVNKrpnm5xCb7negocsdXpYBZglk+rfoTR4NPg9c5rg=;
        b=PTVl4se9rTOYPS9sCnyw/QuOgKajGaiXJib9l2Td6BKaLS3SUc2z+sDA2MJRyIeo8j
         nP1OuAO25HRDQywu5MuXynLvacrasbs1PbUHftm2KXDri9/s4Lg1xLW0SuqIF9rr9b7J
         N8fGXF9ds8ow+UNAodv8t7ZjrpKDgIlnaA+O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CVNKrpnm5xCb7negocsdXpYBZglk+rfoTR4NPg9c5rg=;
        b=OlaqqxcU7apBvjz/95hPm7GytzNIin5lNAGypNt5pDqlHWeF47OXkWruv0Keq7GBKM
         3eLBzygVClWXSNov46yTHQlobKgm2s4q2hAn9WL6tsh3SJrwE2R6oFezowucr0duvhLm
         x4mpebj1sZPNpqH+WXbHl8CMq/c7WuXAzmKCrAbvBPU11XV1nDpB6srcFzs+DwmD87Ch
         a/p4JNdvzDGqo5K/c6xH9qjbAFgNPk0EPa3eaWTeAxaUf4z+ZMTEYbqs3jmsgtQGU+lm
         aUncmVdN+nCkM/w2aMlZs6jI7p7ysM6ZVvJvE5q/MmS1yOcnGKBGfjVHuySmXjaXTi3i
         BJVw==
X-Gm-Message-State: AOAM533/Zd19AiQfdBI9XnLC5Z8lnj1YM5Ut45Fj9ixfzMYuzadEUzM9
        MUwkskJakDsmoK48oOwut8Y70w==
X-Google-Smtp-Source: ABdhPJzIaEwjba+7nmF4wdaFJpa6GK4wj2auDFPTOQA/PPxCGTeVX5HyDNPaA2VG6gKtqa+2Hfingg==
X-Received: by 2002:a17:902:a9c1:: with SMTP id b1mr25027259plr.234.1595964887213;
        Tue, 28 Jul 2020 12:34:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j13sm3826058pjf.28.2020.07.28.12.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:34:46 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:34:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/8] x86/kaslr: Clean up slot handling
Message-ID: <202007281228.B5011DC7@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-8-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-8-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:08:00PM -0400, Arvind Sankar wrote:
> The number of slots and slot areas can be unsigned int, since on 64-bit,
> the maximum amount of memory is 2^52, the minimum alignment is 2^21, so
> the slot number cannot be greater than 2^31. The slot areas are limited
> by MAX_SLOT_AREA, currently 100. Replace the type used for slot number,
> which is currently a mix of int and unsigned long, with unsigned int
> consistently.

I think it's good to standardize the type, but let's go to unsigned long
then we don't have to think about this again in the future.

> Drop unnecessary check that number of slots is not zero in
> store_slot_info, it's guaranteed to be at least 1 by the calculation.
> 
> Drop unnecessary alignment of image_size to CONFIG_PHYSICAL_ALIGN in
> find_random_virt_addr, it cannot change the result: the largest valid
> slot is the largest n that satisfies

I view all of these things as robustness checks. It doesn't hurt to do
these checks and it'll avoid crashing into problems if future
refactoring breaks assumptions.

But again, let's split this patch up. type changes, refactoring, etc.

Notes below...

> 
>   minimum + n * CONFIG_PHYSICAL_ALIGN + image_size <= KERNEL_IMAGE_SIZE
> 
> (since minimum is already aligned) and so n is equal to
> 
>   (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN
> 
> even if image_size is not aligned to CONFIG_PHYSICAL_ALIGN.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/kaslr.c | 36 ++++++++++++--------------------
>  1 file changed, 13 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 91c5f9771f42..eca2acc65e2a 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -511,16 +511,14 @@ static bool mem_avoid_overlap(struct mem_vector *img,
>  
>  struct slot_area {
>  	unsigned long addr;
> -	int num;
> +	unsigned int num;
>  };
>  
>  #define MAX_SLOT_AREA 100
>  
>  static struct slot_area slot_areas[MAX_SLOT_AREA];
> -
> -static unsigned long slot_max;
> -
> -static unsigned long slot_area_index;
> +static unsigned int slot_area_index;
> +static unsigned int slot_max;
>  
>  static void store_slot_info(struct mem_vector *region, unsigned long image_size)
>  {
> @@ -530,13 +528,10 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
>  		return;
>  
>  	slot_area.addr = region->start;
> -	slot_area.num = (region->size - image_size) /
> -			CONFIG_PHYSICAL_ALIGN + 1;
> +	slot_area.num = 1 + (region->size - image_size) / CONFIG_PHYSICAL_ALIGN;
>  
> -	if (slot_area.num > 0) {
> -		slot_areas[slot_area_index++] = slot_area;
> -		slot_max += slot_area.num;
> -	}
> +	slot_areas[slot_area_index++] = slot_area;
> +	slot_max += slot_area.num;
>  }
>  
>  /*
> @@ -589,8 +584,7 @@ process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
>  
>  static unsigned long slots_fetch_random(void)
>  {
> -	unsigned long slot;
> -	int i;
> +	unsigned int slot, i;
>  
>  	/* Handle case of no slots stored. */
>  	if (slot_max == 0)
> @@ -603,7 +597,7 @@ static unsigned long slots_fetch_random(void)
>  			slot -= slot_areas[i].num;
>  			continue;
>  		}
> -		return slot_areas[i].addr + slot * CONFIG_PHYSICAL_ALIGN;
> +		return slot_areas[i].addr + (unsigned long)slot * CONFIG_PHYSICAL_ALIGN;
>  	}
>  
>  	if (i == slot_area_index)
> @@ -819,28 +813,24 @@ static unsigned long find_random_phys_addr(unsigned long minimum,
>  		return 0;
>  	}
>  
> -	if (process_efi_entries(minimum, image_size))
> -		return slots_fetch_random();
> +	if (!process_efi_entries(minimum, image_size))
> +		process_e820_entries(minimum, image_size);

I like this change; the double-call to slots_fetch_random() bugged me.
:)

>  
> -	process_e820_entries(minimum, image_size);
>  	return slots_fetch_random();
>  }
>  
>  static unsigned long find_random_virt_addr(unsigned long minimum,
>  					   unsigned long image_size)
>  {
> -	unsigned long slots, random_addr;
> -
> -	/* Align image_size for easy slot calculations. */
> -	image_size = ALIGN(image_size, CONFIG_PHYSICAL_ALIGN);
> +	unsigned int slots;
> +	unsigned long random_addr;
>  
>  	/*
>  	 * There are how many CONFIG_PHYSICAL_ALIGN-sized slots
>  	 * that can hold image_size within the range of minimum to
>  	 * KERNEL_IMAGE_SIZE?
>  	 */
> -	slots = (KERNEL_IMAGE_SIZE - minimum - image_size) /
> -		 CONFIG_PHYSICAL_ALIGN + 1;
> +	slots = 1 + (KERNEL_IMAGE_SIZE - minimum - image_size) / CONFIG_PHYSICAL_ALIGN;

These are the same -- why change the code?

>  
>  	random_addr = kaslr_get_random_long("Virtual") % slots;
>  
> -- 
> 2.26.2
> 

-- 
Kees Cook
