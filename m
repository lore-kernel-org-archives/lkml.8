Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8120C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D3B32088E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="KP5o51H2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388539AbgEYEtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEYEtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:49:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17158C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:49:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v16so19332132ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iD84QEka0uyrBHdirOMsRVTHqCAdidnfL6x/KyVREOU=;
        b=KP5o51H2NPFzZtn/+C17vSTj+PZnknpP0DQ3r+SdJ84uZ/doMQxhhVox7zKjyIPoTG
         o8Xa8de+TlevcMyshRcbDfc6W0SZoqtj+jQEtJ9oVmJNxvWUnwgVHfdSAGmYaBtMV8dP
         9lussDyiF3t8X9YA+gZxyW9uW5ZpzUm8SeqB8zjnoVTXt8Dy6I14avayjn1yliY+l+vw
         y3Gt6+fPUHVxOJp2GLlQXxIiWPEp9/W98mkg5Yg5VmY9eDLO9AeBPYiTloJCsTSFmZ0V
         b2iBS6JfrTJTmIIRYTPTXnPiba8i+vBxuo4d8VupCFqRSxxvvO19AjQYLA7AVooh8WnH
         hXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iD84QEka0uyrBHdirOMsRVTHqCAdidnfL6x/KyVREOU=;
        b=RWDEooQ9A1gxl1Dg9Dfdtqog5s6DOTfs9s5sMz5fnlbS2xeyvdiGQxCywexMOWPsl0
         hAn8ZaQKzlCYoaLlb24MIGbk+mBrSf1sC5UJRY/kUEh1/QWJnQcPTaO0oWVWfhy2TVIO
         7pHp70Vb9xMDEDGKnub6H2UmUapwqjqwrZRXqSajQAFJySpMRiKe7vlDuTpovR16DKeN
         b7SWW07f1CnI+B1C0tuGlT0WaLMCUUXkqAwLm+qU1ukTUuldSBFMcFk0KXvS5WTRz0wj
         rdLdYtumuS3D+EIhGG0G2OvjrdvzRCZlKxYL5467RniaBu3dS884HqRZrV+FihF/9DZ4
         iH6Q==
X-Gm-Message-State: AOAM531Wl74rt46PUs8scJe39pNyrRd+RJtC2laEKsonXFbPQGhUlodz
        Be3OUTF8Q0fTLY5mIjg0EsW9Tg==
X-Google-Smtp-Source: ABdhPJzTFZ5URstTJ1gWnPM0fQHzkYgolDxlxFE03EUEm7VjgGPGn27S6do9PXWk6YnwrGKB+o4bxg==
X-Received: by 2002:a2e:601:: with SMTP id 1mr12485657ljg.126.1590382142399;
        Sun, 24 May 2020 21:49:02 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x69sm4457568lff.19.2020.05.24.21.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 21:49:01 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 942F31012E6; Mon, 25 May 2020 07:49:02 +0300 (+03)
Date:   Mon, 25 May 2020 07:49:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix boot with some memory above MAXMEM
Message-ID: <20200525044902.rsb46bxu5hdsqglt@box>
References: <20200511191721.1416-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511191721.1416-1-kirill.shutemov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:17:21PM +0300, Kirill A. Shutemov wrote:
> A 5-level paging capable machine can have memory above 46-bit in the
> physical address space. This memory is only addressable in the 5-level
> paging mode: we don't have enough virtual address space to create direct
> mapping for such memory in the 4-level paging mode.
> 
> Currently, we fail boot completely: NULL pointer dereference in
> subsection_map_init().
> 
> Skip creating a memblock for such memory instead and notify user that
> some memory is not addressable.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@intel.com>
> Cc: stable@vger.kernel.org # v4.14
> ---

Gentle ping.

It's not urgent, but it's a bug fix. Please consider applying.

> Tested with a hacked QEMU: https://gist.github.com/kiryl/d45eb54110944ff95e544972d8bdac1d
> 
> ---
>  arch/x86/kernel/e820.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
> index c5399e80c59c..d320d37d0f95 100644
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -1280,8 +1280,8 @@ void __init e820__memory_setup(void)
>  
>  void __init e820__memblock_setup(void)
>  {
> +	u64 size, end, not_addressable = 0;
>  	int i;
> -	u64 end;
>  
>  	/*
>  	 * The bootstrap memblock region count maximum is 128 entries
> @@ -1307,7 +1307,22 @@ void __init e820__memblock_setup(void)
>  		if (entry->type != E820_TYPE_RAM && entry->type != E820_TYPE_RESERVED_KERN)
>  			continue;
>  
> -		memblock_add(entry->addr, entry->size);
> +		if (entry->addr >= MAXMEM) {
> +			not_addressable += entry->size;
> +			continue;
> +		}
> +
> +		end = min_t(u64, end, MAXMEM - 1);
> +		size = end - entry->addr;
> +		not_addressable += entry->size - size;
> +		memblock_add(entry->addr, size);
> +	}
> +
> +	if (not_addressable) {
> +		pr_err("%lldGB of physical memory is not addressable in the paging mode\n",
> +		       not_addressable >> 30);
> +		if (!pgtable_l5_enabled())
> +			pr_err("Consider enabling 5-level paging\n");
>  	}
>  
>  	/* Throw away partial pages: */
> -- 
> 2.26.2
> 
> 

-- 
 Kirill A. Shutemov
