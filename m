Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0DAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5164520825
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 04:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="ZB2bMapT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388766AbgEYE7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 00:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgEYE7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 00:59:46 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CABCC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:59:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q2so19287263ljm.10
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 21:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+n9rUAP4H6+Zi0TTUL1JxYkv/zQYKpYIKNpCWjLtusE=;
        b=ZB2bMapTM0gZ3T/pJxS+tIAjDieTMBYojZ0mwW7XuuEWD+Fv+k1JtiyzD+ZqaBr9Tq
         lH8i3F7zAGGxPGXuTWnJm9Te/UUSV9cqtaEZZG7sQ1yVfu7pjqZXGmOZbQZ7YCEp6xBE
         4fm2u6hmW3kKMvvIu51nvAPRHQ46c4IKra087+r7Va256OtaGkLjwLkOorTUxEdBsAmr
         XnmXf6OmMz/WmDrnKLg6gDYFWdak47KotwHkuSZCX9HSmPFcHJci0FqyN7NN5ZdCVJP0
         hszBVumbnqx0pFYBFLzeidtDBQtf7eqEj0775nkJ1h0ho+RWfKdHcKpQ8ZBa7ee6WNl6
         rrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+n9rUAP4H6+Zi0TTUL1JxYkv/zQYKpYIKNpCWjLtusE=;
        b=dy8q5wTlyLt11YO3hLwt5KdTH7vi1tdiAWVxkDhaDQellxithooeeLTqUNPX/9FOXL
         kGFrEjg+f3hyFI8jTmClU/yLt4/5mcx64RivLvg6nJOWHWc2LiVPYqNkRojpN8MHSRLl
         D3ATfeO60lbX5A/m7Xfx5x7UKVgmkb1eKIQM+pDpW9cJflVBgXQD6La3G90ds7EjqThF
         8h7x+z1eNcFJ9PIysREovi/InDH4UWYtjwgc/l+5IhpQDePv7qEBJogMu8LuDJDUpurB
         B0vA0IhgjnwkxcCf6mmEU1uDl7BaEll2lFVkqnLliP6N7zjgdPa0S8QtNdhrM6Q7qf1T
         rlvA==
X-Gm-Message-State: AOAM532+UdzxUqlcl0sMttnkCNNBi7OKJuHHgl4vXZnaWrDcRinQKo1d
        wzzW5ZjD59Yy3PsDOnVXxonFhg==
X-Google-Smtp-Source: ABdhPJyCwJ2sAx2IX4iHY4LLE2cNk9uJ0NgIZnJVby3cTBD/nQ12Uvgtsyf7i4RxGbVF7B8X5BKElQ==
X-Received: by 2002:a2e:9a41:: with SMTP id k1mr13615461ljj.143.1590382784839;
        Sun, 24 May 2020 21:59:44 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id f5sm903566ljm.69.2020.05.24.21.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 21:59:44 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 367BE1012E6; Mon, 25 May 2020 07:59:45 +0300 (+03)
Date:   Mon, 25 May 2020 07:59:45 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 24/36] mm: Remove page fault assumption of compound
 page size
Message-ID: <20200525045945.lkw36jergxwg7bfj@box>
References: <20200515131656.12890-1-willy@infradead.org>
 <20200515131656.12890-25-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515131656.12890-25-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 06:16:44AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> A compound page in the page cache will not necessarily be of PMD size,
> so check explicitly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  mm/memory.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index f703fe8c8346..d68ce428ddd2 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3549,13 +3549,14 @@ static vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
>  	unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>  	pmd_t entry;
>  	int i;
> -	vm_fault_t ret;
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
>  
>  	if (!transhuge_vma_suitable(vma, haddr))
> -		return VM_FAULT_FALLBACK;
> +		return ret;
>  
> -	ret = VM_FAULT_FALLBACK;
>  	page = compound_head(page);
> +	if (page_order(page) != HPAGE_PMD_ORDER)
> +		return ret;

Maybe WARN() for page_order(page) > HPAGE_PMD_ORDER. It would be fun to
handle :P
>  
>  	/*
>  	 * Archs like ppc64 need additonal space to store information
> -- 
> 2.26.2
> 

-- 
 Kirill A. Shutemov
