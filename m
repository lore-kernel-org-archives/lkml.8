Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B04DC2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFD32074F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Ex3D0PnD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgC0MLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:11:06 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44008 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0MLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:11:05 -0400
Received: by mail-qk1-f195.google.com with SMTP id o10so10401107qki.10
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ae32xXO67Uei3DTimjBj1wlAZ/pkH/el6Qiul9IT/30=;
        b=Ex3D0PnD7gDl3aSUB2klXnKG6WqRJ7QfwnM6N9ZGFL92WovcOuAzEFRyYweVO4bxtE
         7Xg8gqSK2Z3BuI8TP9K0fdhDNWpdwzHD/JkAmE9cJPZ0tZrDsJOHhAbWsH+vjsmkuIY6
         uwK5871CUpjZLzSstezfN/aBg5CasNqsGxP8A9EfPWuZRYdJDyWQBXQ7ttS6IiSCsthL
         ifCas0C0YCZ3fC4iuuQORU9gg8EUmyeqhcf3rCO0NRXcZ2xj0HrGTKS3hd6SWnksKhsW
         VFFIjipCV/rNC4HQApb3Vkke+23D5s7p4BGXZmNMTKFYNFv1sR1pllPZ8YXvdvs0uPyV
         9Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ae32xXO67Uei3DTimjBj1wlAZ/pkH/el6Qiul9IT/30=;
        b=Cqlam+IiDP7lHN40iptwrITQ6Sec3dblLEQt6VtBW5tv+dD8nECLxRSsHf1B+Qdebp
         GOO33rYOpLxgPofPGtLWp4MGdO+frPyA0Nf30zW2NuhD+OcfqaGAstrtPoHfhxPdAz0O
         7yGGO3EpzF/hCyTmfU8Wn/BGzFvK7OnLj1CfRYUndvgDKeoCmKoAekfFUK6ianVuWeXL
         nTL+DaF/RaQjfYgoLelvoigCJoPxaExG1TNN2u4Zt0mQOAP8HtOFq611I0FN09Y+CXgY
         CZiTtPjl1/Ib4bIsMuLra4q+XRf84yLyxNCHk+aCU0gMEZ5m4lj+/OHNC5V2X0Sxbk8W
         6UQA==
X-Gm-Message-State: ANhLgQ0Clf+1uV4HbqgvlVW1XdC62wlD8A0dLeNpuy0coAMm0DE8eDVc
        tO0QcvTd8ASJrpgb0Te6MvRT6g==
X-Google-Smtp-Source: ADFU+vu5etCsTsz6Y5TtfPSyk7GQigfbQaUBOkfH75rGPq30AeujH7DUKAa3E9WYmWw4syrKT0bbug==
X-Received: by 2002:a37:a746:: with SMTP id q67mr14014729qke.215.1585311063288;
        Fri, 27 Mar 2020 05:11:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t71sm3539359qke.55.2020.03.27.05.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 05:11:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jHnpE-0007MU-MC; Fri, 27 Mar 2020 09:11:00 -0300
Date:   Fri, 27 Mar 2020 09:11:00 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Longpeng(Mike)" <longpeng2@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kvm@vger.kernel.org, arei.gonglei@huawei.com,
        weidong.huang@huawei.com, weifuqiang@huawei.com,
        kirill.shutemov@linux.intel.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3] mm/hugetlb: fix a addressing exception caused by
 huge_pte_offset
Message-ID: <20200327121100.GR20941@ziepe.ca>
References: <20200327014007.1915-1-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200327014007.1915-1-longpeng2@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 09:40:07AM +0800, Longpeng(Mike) wrote:
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index dd8737a..d4fab68 100644
> +++ b/mm/hugetlb.c
> @@ -4909,29 +4909,33 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
>  		       unsigned long addr, unsigned long sz)
>  {
>  	pgd_t *pgd;
> -	p4d_t *p4d;
> -	pud_t *pud;
> -	pmd_t *pmd;
> +	p4d_t *p4g, p4d_entry;
> +	pud_t *pud, pud_entry;
> +	pmd_t *pmd, pmd_entry;
>  
>  	pgd = pgd_offset(mm, addr);
>  	if (!pgd_present(*pgd))
>  		return NULL;
> -	p4d = p4d_offset(pgd, addr);
> -	if (!p4d_present(*p4d))
> +
> +	p4g = p4d_offset(pgd, addr);

Why p4g here? Shouldn't it be p4d?

Jason
