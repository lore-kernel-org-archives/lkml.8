Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708F5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D1E20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 08:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="k96D0LhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgGHI1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 04:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbgGHI1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 04:27:02 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7003C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 01:27:01 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d21so26346143lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 01:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SOolC/vv83nDDMOzG10FTHkqfTRVAIjWH0PZ9g1P99E=;
        b=k96D0LhGIzJBEjseKx34L0lATj/LwM36St3znKXuTQIOWD+deqs9FlV1Nf5kc4ofLm
         Og1kxz3xZAS4KNpDxnt3cPjr8J9c3RwXr8uD7PXJkVwawvrFU0pMPWBQ/xoj8b9YZerD
         kGbtmrj994zW1MPftuIbLe57nFLSSr/aHycEUjKOp1RjnFOB+SJPJsoPXtzCp0kza9fj
         LEYjNS2HdJbyAJd/nW/dcLCjuYx4Dhz8YI/8F77dkc9c3/2DTP/igm5WOGEvvnZN7tXJ
         cECV3XdWxYJily5DxKNR9fpZ3ZjU/jvYyWWgLd2XE0Dy84ja5RNydmAdu4G9hCZGJSFK
         FBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SOolC/vv83nDDMOzG10FTHkqfTRVAIjWH0PZ9g1P99E=;
        b=heAPJOmbuupChSrbPEYWh88tmJTnkAzHa9VBkmI3A5W/6LpBfLDyaT2hwduVfop5vN
         E5yaUUoKWkhgoOwhaWoMh8nU1FVXv8aTT3aghVEgn3NmMCNydMjEvdYfkJ60l2iWahh9
         eR6OhahwulyTzeBCbOR+aK6+wiDB9mNN6jGPag6YzFhTrQy/IWM8MET9DziED5Q3OdPC
         WrOyfFd4W1XTnjxgMoLpTtsTEQQU97GambfKR/dfqsNEsJRv2eXDsg7avcV0U01LLa7S
         VgO7r7XpT0yqiIrgQCLrV27nTpw/ahVmG0YP4lQ7FL9ymuHUSL8HeXyMvR0USuYeERur
         KUtw==
X-Gm-Message-State: AOAM5328x+aUwkQjhDyFzzM7/axW/3TIrEGSldJe9A28937ArMjJXmcc
        wgtmaTTMmM7czPa5DtklzEcjKA==
X-Google-Smtp-Source: ABdhPJy5LQKzOYkmdjXfgpA68oHfAl4A56zFgFzUf1aCjCXhErM7MZQHShEd4/YI8LoBJY5hgyUG9A==
X-Received: by 2002:ac2:52af:: with SMTP id r15mr36021294lfm.24.1594196820443;
        Wed, 08 Jul 2020 01:27:00 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q11sm10209307lfe.34.2020.07.08.01.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 01:26:59 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id C01C3102260; Wed,  8 Jul 2020 11:27:00 +0300 (+03)
Date:   Wed, 8 Jul 2020 11:27:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, yang.shi@linux.alibaba.com, thomas_os@shipmail.org,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        peterx@redhat.com, aneesh.kumar@linux.ibm.com, willy@infradead.org,
        thellstrom@vmware.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [Patch v3 4/4] mm/mremap: use pmd_addr_end to simplify the
 calculate of extent
Message-ID: <20200708082700.ev7m5re42tupixqu@box>
References: <20200708012453.36588-1-richard.weiyang@linux.alibaba.com>
 <20200708012453.36588-5-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708012453.36588-5-richard.weiyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 08, 2020 at 09:24:53AM +0800, Wei Yang wrote:
> The purpose of this code is to calculate the smaller extent in old and
> new range. Let's leverage pmd_addr_end() to do the calculation.
> 
> Hope this would make the code easier to read.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> ---
>  mm/mremap.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index f5f17d050617..76e7fdf567c3 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -237,11 +237,12 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  		unsigned long new_addr, unsigned long len,
>  		bool need_rmap_locks)
>  {
> -	unsigned long extent, next, old_end;
> +	unsigned long extent, old_next, new_next, old_end, new_end;
>  	struct mmu_notifier_range range;
>  	pmd_t *old_pmd, *new_pmd;
>  
>  	old_end = old_addr + len;
> +	new_end = new_addr + len;
>  	flush_cache_range(vma, old_addr, old_end);
>  
>  	mmu_notifier_range_init(&range, MMU_NOTIFY_UNMAP, 0, vma, vma->vm_mm,
> @@ -250,14 +251,11 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  
>  	for (; old_addr < old_end; old_addr += extent, new_addr += extent) {
>  		cond_resched();
> -		next = (old_addr + PMD_SIZE) & PMD_MASK;
> -		/* even if next overflowed, extent below will be ok */
> -		extent = next - old_addr;
> -		if (extent > old_end - old_addr)
> -			extent = old_end - old_addr;
> -		next = (new_addr + PMD_SIZE) & PMD_MASK;
> -		if (extent > next - new_addr)
> -			extent = next - new_addr;
> +
> +		old_next = pmd_addr_end(old_addr, old_end);
> +		new_next = pmd_addr_end(new_addr, new_end);
> +		extent = min((old_next - old_addr), (new_next - new_addr));

Nit: redundant parentheses.

-- 
 Kirill A. Shutemov
