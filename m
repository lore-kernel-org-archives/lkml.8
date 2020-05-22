Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02007C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1D92072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RyzbX7u1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730830AbgEVSHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgEVSHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:07:47 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27668C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:07:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n11so6125232qkn.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 11:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vH0SIRcdqBYbo5IszVfrP4ZKKcMviAZ2YJGSIx16SXk=;
        b=RyzbX7u17MqvWljynr1irwnhoX2xj5sHr4obj1QC7hBUAsn6OSaMLxAATctxuNkf1w
         QNKWKb4z8S4id5TNIoOdFzMXBPFEdNpSy8V9jUOM5DbDYZQ1HWt5G0ihQ+vmnwSSn9ZU
         P7kOgQhCdEDqDAd7wbqn9vy6TLDwrXGnlt17JrCk0Z8V7YsLGnNlqzHkyCK/hUa1cS/M
         bLG0eKX6ZiPix8hrPx/JxFa+CdcnCj0XrKMHcYVsWdOFo9CuLxMmFCZrWlzrxWYdLBGD
         wSaCe9+dzqTk/UI0hjP8Ue6gUUv5Ypj76z9F0Z6esFFTZ4qbCKAK0hlb4EZT5XEwr/gF
         sckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vH0SIRcdqBYbo5IszVfrP4ZKKcMviAZ2YJGSIx16SXk=;
        b=uKkCKxUFFWJLBEdnOEjODyeEPbR3lQ2jNenD5wfmRyDrbd//7U2eNElUKPG9dfPldV
         ZyyCpwLRimUBKHFkfGtmVL26SB/1das/cHODGegTk3bz/xRIhVaMcmPSrf/K8unHjQEC
         3snZXtm1r1sEjvc5f9d6vVhJKQBUAN7b0DlTFJR9gG/EmPr0mgnLtwGvAoyR2CP7BS2R
         QEh7DD+Yfntd1ZutF0hB6oJXrd2cbhth3Uln0/LtgBq7XuHi7bGxn9PWyYP3yMiQyG8+
         ABWEy2vFyMHTZ9IuPw5I4wHHkCUu0+r6AnzX69OffoT7IwNBM1k1yC99IHbBk+aF54Cq
         EJ0g==
X-Gm-Message-State: AOAM531Rk4oB7JjDQ+FWmIbEd5V8csVEjkhMT9T0ccIjA5wWNF6vos9m
        YR4pQXmU81OUrsn2u4gZGzeRoQ==
X-Google-Smtp-Source: ABdhPJzcMplqsdtBfyt+v8k9hymlCaZTzBqkLl6Rzb6R/qsAwn2XxJPwfexutgUU06YGyGAmpl7rWQ==
X-Received: by 2002:a05:620a:15f8:: with SMTP id p24mr3519262qkm.227.1590170866332;
        Fri, 22 May 2020 11:07:46 -0700 (PDT)
Received: from Qians-MacBook-Air.local (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d18sm1245753qkb.99.2020.05.22.11.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 11:07:45 -0700 (PDT)
Date:   Fri, 22 May 2020 14:07:41 -0400
From:   Qian Cai <cai@lca.pw>
To:     Steven Price <steven.price@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Jan Beulich <jbeulich@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 1/2] x86: mm: ptdump: Calculate effective permissions
 correctly
Message-ID: <20200522180741.GB1337@Qians-MacBook-Air.local>
References: <20200521152308.33096-1-steven.price@arm.com>
 <20200521152308.33096-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521152308.33096-2-steven.price@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 04:23:07PM +0100, Steven Price wrote:
> --- a/arch/x86/mm/dump_pagetables.c
> +++ b/arch/x86/mm/dump_pagetables.c
> @@ -249,10 +249,22 @@ static void note_wx(struct pg_state *st, unsigned long addr)
> @@ -270,16 +282,10 @@ static void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>  	struct seq_file *m = st->seq;
>  
>  	new_prot = val & PTE_FLAGS_MASK;
> +	new_eff = st->prot_levels[level];

This will trigger,

.config (if ever matters):
https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config 

[  104.532621] UBSAN: array-index-out-of-bounds in arch/x86/mm/dump_pagetables.c:284:27
[  104.542620] index -1 is out of range for type 'pgprotval_t [5]'
[  104.552624] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-rc6-next-20200522+ #5
[  104.560865] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
[  104.562604] Call Trace:
[  104.562604]  dump_stack+0xa7/0xea
[  104.562604]  ubsan_epilogue+0x9/0x45
[  104.562604]  __ubsan_handle_out_of_bounds.cold.12+0x2b/0x36
[  104.562604]  ? __kasan_check_write+0x14/0x20
[  104.562604]  note_page+0x91f/0xa00
[  104.562604]  ? down_read_non_owner+0x330/0x330
[  104.562604]  ? match_held_lock+0x20/0x250
[  104.562604]  ptdump_walk_pgd+0xa1/0xb0
[  104.562604]  ptdump_walk_pgd_level_core+0x19f/0x200
[  104.562604]  ? up+0x46/0x60
[  104.562604]  ? hugetlb_get_unmapped_area+0x590/0x590
[  104.562604]  ? lock_downgrade+0x3e0/0x3e0
[  104.562604]  ? _raw_spin_unlock_irqrestore+0x44/0x50
[  104.562604]  ? ptdump_walk_pgd_level_debugfs+0x80/0x80
[  104.562604]  ? ptdump_walk_pgd_level_core+0x200/0x200
[  104.562604]  ? virt_efi_set_variable_nonblocking+0xf1/0x110
[  104.562604]  ptdump_walk_pgd_level+0x32/0x40
[  104.562604]  efi_dump_pagetable+0x17/0x19
[  104.562604]  efi_enter_virtual_mode+0x3e5/0x3f5
[  104.562604]  start_kernel+0x848/0x8f6
[  104.562604]  ? __early_make_pgtable+0x2cb/0x314
[  104.562604]  ? thread_stack_cache_init+0xb/0xb
[  104.562604]  ? early_make_pgtable+0x21/0x23
[  104.562604]  ? early_idt_handler_common+0x35/0x4c
[  104.562604]  x86_64_start_reservations+0x24/0x26
[  104.562604]  x86_64_start_kernel+0xf4/0xfb
[  104.562604]  secondary_startup_64+0xb6/0xc0

>  
> -	if (level > 0) {
> -		new_eff = effective_prot(st->prot_levels[level - 1],
> -					 new_prot);
> -	} else {
> -		new_eff = new_prot;
> -	}
> -
> -	if (level >= 0)
> -		st->prot_levels[level] = new_eff;
> +	if (!val)
> +		new_eff = 0;
>  
>  	/*
>  	 * If we have a "break" in the series, we need to flush the state that
