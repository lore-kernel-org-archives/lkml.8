Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50FCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B165020739
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="chbzR/Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgGFKHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFKHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:07:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4AFC061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:07:31 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id b25so40968010ljp.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fRxJulFmu9AlNtElSO/F+8/ObuCR2DVnY3HV66MXZyY=;
        b=chbzR/SxWlB99qHfrUpK6zYZczJOJ30TTX03MKQMa7LI84LqiNpJ9ffCASF5R7JkiV
         lj/5c1LZ2KTWjVz+l+kskv6+DPaG4kGPrUUygrDYQAAAGZ2qaM/ubnhS0EEMWAhDg5Zr
         26A5iTAqQG8/o6F4zuKDfxCwgJkLxRB6j/WHMyFUEyGjRoOis1qBllA0l/+OEYCmicDy
         zfJB9H1Fn6ehUyn/OP/sUkxNlM7oNgirW4/rVDDidSeP+lv7i+lNqEiEZTrELiYiiU/0
         1XljSbRM2GcaECzu6TNqmYMPKaVYysl0aDjw7bNyVuZPW+4mnaqLun5uSrKwLpHkh/SX
         MWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fRxJulFmu9AlNtElSO/F+8/ObuCR2DVnY3HV66MXZyY=;
        b=UiCSf0loLmbGiyP+oQj2XCuDMNtoIGKXmfSrVycfpiIQV++N8u+czvZAoevQJhEnoP
         BjPpReAR1sSCDdniFIUGUvacmcMS+uEcSzHupUQmCPRHtlyLbyFYPQ3tE/F7fSIzhEUT
         vvPSLBjsfhl10Ppj8d/1W998myRyHT8fkFNAoeKfXCfwIpXsaW628nx5wibBw5tGIccr
         qPzFHCWLSaP1O/n9vhlInnsr96K5vU6kjBFbvlH9L2YhIt6HIXxXM47fBTH+fc17CeNS
         v7q1SeO+sAvCyW9OXSCd1irlutg3WsvDcd85zH14KFwTaUta4ECpQKT+I9EPKisuL22c
         hRFA==
X-Gm-Message-State: AOAM5333kKxu7XAjDU3KXbpKHxQSZAOYhEdC6cMl+3FJ25kC8Z6Wj/0O
        0y5srdLWv51BGjmvb0hirM84EQ==
X-Google-Smtp-Source: ABdhPJxkXlC7clzgoUJpZjQqzJu5/VxmsYKbYbd3zTtyOhk2pgEWLXuP0pz1Yday8XOx2GUCHmburg==
X-Received: by 2002:a2e:87c2:: with SMTP id v2mr16511842ljj.78.1594030049586;
        Mon, 06 Jul 2020 03:07:29 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id r23sm7736363ljh.76.2020.07.06.03.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:07:28 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2B40610220C; Mon,  6 Jul 2020 13:07:29 +0300 (+03)
Date:   Mon, 6 Jul 2020 13:07:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 3/4] mm/mremap: calculate extent in one place
Message-ID: <20200706100729.y2wbkpc4tyvjojzg@box>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
 <20200626135216.24314-4-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626135216.24314-4-richard.weiyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:52:15PM +0800, Wei Yang wrote:
> Page tables is moved on the base of PMD. This requires both source
> and destination range should meet the requirement.
> 
> Current code works well since move_huge_pmd() and move_normal_pmd()
> would check old_addr and new_addr again. And then return to move_ptes()
> if the either of them is not aligned.
> 
> In stead of calculating the extent separately, it is better to calculate
> in one place, so we know it is not necessary to try move pmd. By doing
> so, the logic seems a little clear.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> Tested-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  mm/mremap.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index de27b12c8a5a..a30b3e86cc99 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -258,6 +258,9 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  		extent = next - old_addr;
>  		if (extent > old_end - old_addr)
>  			extent = old_end - old_addr;
> +		next = (new_addr + PMD_SIZE) & PMD_MASK;

Please use round_up() for both 'next' calculations.

> +		if (extent > next - new_addr)
> +			extent = next - new_addr;
>  		old_pmd = get_old_pmd(vma->vm_mm, old_addr);
>  		if (!old_pmd)
>  			continue;
> @@ -301,9 +304,6 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
>  
>  		if (pte_alloc(new_vma->vm_mm, new_pmd))
>  			break;
> -		next = (new_addr + PMD_SIZE) & PMD_MASK;
> -		if (extent > next - new_addr)
> -			extent = next - new_addr;
>  		move_ptes(vma, old_pmd, old_addr, old_addr + extent, new_vma,
>  			  new_pmd, new_addr, need_rmap_locks);
>  	}
> -- 
> 2.20.1 (Apple Git-117)
> 

-- 
 Kirill A. Shutemov
