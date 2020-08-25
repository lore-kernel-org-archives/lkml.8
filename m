Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:59:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECFBC206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eI3+04vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgHYU7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726570AbgHYU7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598389155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaM1BniRdV7s6zyBckfA1mE3ZyTG9PC4cGNHi1/r0LU=;
        b=eI3+04vHTQETJaxPkhDLVq6J7XZpSlQkbOKvoG6nbmpA21zdG/jsnzIXIK2HacdLMRj075
        ALhtXKOWVFQ1qQfL3tenkTzrTmOXxweyRA9UIwiX24AH4RfeLvvZvkAxIEVfJ8Xu/kbuXI
        YTRsnLpm9iWRUkd74EaylKaKK0YjnHs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-cd4PSRnONWmsD5maJZEeHA-1; Tue, 25 Aug 2020 16:59:11 -0400
X-MC-Unique: cd4PSRnONWmsD5maJZEeHA-1
Received: by mail-qv1-f72.google.com with SMTP id f1so131149qvx.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:59:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xaM1BniRdV7s6zyBckfA1mE3ZyTG9PC4cGNHi1/r0LU=;
        b=n+Dm+WRcQvzDehexw8dhPnGwPAj/zHlYocYluH/VirXkr7OUwTzE5QQYfJRJ88UuW+
         M6GG0ynwwsxmasNZmUGwtG6FOxmJSPaCxwcn7lEIyMJRpPqBRMOfOut1xzeqw/lqvzXf
         0pTX0rINQiGKh5hJ+wZ3DZQ7hbHkfCq0J2ip5z6ktfVPPYpIdy9FWxv2dRnR3KEJHlTB
         u16Fgy91/xA908cqxfdJmCHfSJCtIxcNHr9UaCmvlzYcnWY5FdMJPY1NvaGmcuG2YDg2
         z1seorlssiIns55Vebqz+cWBlyUdy3BtOOkoe2qjHrIqiyb+4fxgNs/gkeb4oeIKs5FK
         E0wg==
X-Gm-Message-State: AOAM532yCQAt5rkg3BuKAobhijV5kVAVHYclHskXdQpLc/rGTWIGdOtl
        FjnENODyibMREF9Ct/lZAXl8ZOksdcLcEZ6CVHL4B6LBDYDsfIJi4FR84uzXoRcCevf5gSayFoo
        WvZb8OTmPV9D6L0pDATt6DfWw
X-Received: by 2002:a37:a011:: with SMTP id j17mr11600606qke.258.1598389150485;
        Tue, 25 Aug 2020 13:59:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx0NoiPkbiaDV/kCJQZdlozQUvTfCnzvSsS0NfWm4N4KroTsK/ZYDgUxBZJwZaMG89yIXBKJQ==
X-Received: by 2002:a37:a011:: with SMTP id j17mr11600581qke.258.1598389150110;
        Tue, 25 Aug 2020 13:59:10 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id l5sm20009qkk.134.2020.08.25.13.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:59:09 -0700 (PDT)
Date:   Tue, 25 Aug 2020 16:59:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Ming Mao <maoming.maoming@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        alex.williamson@redhat.com, cohuck@redhat.com,
        jianjay.zhou@huawei.com, weidong.huang@huawei.com,
        aarcange@redhat.com
Subject: Re: [PATCH V2] vfio dma_map/unmap: optimized for hugetlbfs pages
Message-ID: <20200825205907.GB8235@xz-x1>
References: <20200814023729.2270-1-maoming.maoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200814023729.2270-1-maoming.maoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:37:29AM +0800, Ming Mao wrote:
> +static long hugetlb_page_vaddr_get_pfn(unsigned long vaddr, long npage,
> +						unsigned long pfn)
> +{
> +	long hugetlb_residual_npage;
> +	long contiguous_npage;
> +	struct page *head = compound_head(pfn_to_page(pfn));
> +
> +	/*
> +	 * If pfn is valid,
> +	 * hugetlb_residual_npage is greater than or equal to 1.
> +	 */
> +	hugetlb_residual_npage = hugetlb_get_residual_pages(vaddr,
> +						compound_order(head));
> +	if (hugetlb_residual_npage < 0)
> +		return -1;
> +
> +	/* The page of vaddr has been gotten by vaddr_get_pfn */
> +	contiguous_npage = min_t(long, (hugetlb_residual_npage - 1), npage);
> +	if (!contiguous_npage)
> +		return 0;
> +	/*
> +	 * Unlike THP, the splitting should not happen for hugetlb pages.
> +	 * Since PG_reserved is not relevant for compound pages, and the pfn of
> +	 * PAGE_SIZE page which in hugetlb pages is valid,
> +	 * it is not necessary to check rsvd for hugetlb pages.
> +	 * We do not need to alloc pages because of vaddr and we can finish all
> +	 * work by a single operation to the head page.
> +	 */
> +	atomic_add(contiguous_npage, compound_pincount_ptr(head));
> +	page_ref_add(head, contiguous_npage);
> +	mod_node_page_state(page_pgdat(head), NR_FOLL_PIN_ACQUIRED, contiguous_npage);

I think I asked this question in v1, but I didn't get any answer... So I'm
trying again...

Could I ask why manual referencing of pages is done here rather than using
pin_user_pages_remote() just like what we've done with vaddr_get_pfn(), and let
try_grab_page() to do the page reference and accountings?

I feel like this at least is against the FOLL_PIN workflow of gup, because
those FOLL_PIN paths were bypassed, afaict.

> +
> +	return contiguous_npage;
> +}

-- 
Peter Xu

