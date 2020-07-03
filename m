Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EF5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B7A20724
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 19:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593803079;
	bh=4pNuCfQIqgQH3q0qc1Q3ebM/lBgF6HLbGev3V+Gg3Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Ev9xHf2UctFudrsQ6Gd2jjAKwkylGjXlK6Xj6co/O7HZYuK0DgfHOutfWtWr/iZbr
	 3O+hDTZSYEA4SD0caYUX0HWRTJkQz7fnJbii1yQgSZyAsRLxsxbL/V9wJaOWd0KEcd
	 /Pn1kevl81ua0377sx1cwNhj5B2KHDARLucw2U9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgGCTEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 15:04:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:47252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgGCTEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 15:04:37 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47E8F20724;
        Fri,  3 Jul 2020 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593803077;
        bh=4pNuCfQIqgQH3q0qc1Q3ebM/lBgF6HLbGev3V+Gg3Iw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fGZzcO/5l+ihymtMX7ExVRl++j9zpGqwlnEhhHiQ7yQh/37hgSTJv4wfEMhdyfLqa
         YffdWJZcD+4yC9HaaDIv1j9KMSvKHAVfquU7AqjMPjmtmTIUL8nT3HyXHYSlmUBNzx
         CtsviZnp3/WcL3iIzm2yYrOT7U5wbqTo8kzkPu9o=
Date:   Fri, 3 Jul 2020 12:04:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     trix@redhat.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: initialize return of vm_insert_pages
Message-Id: <20200703120436.4031b4ea23e28a3babca3d2d@linux-foundation.org>
In-Reply-To: <20200703155354.29132-1-trix@redhat.com>
References: <20200703155354.29132-1-trix@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  3 Jul 2020 08:53:54 -0700 trix@redhat.com wrote:

> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports a garbage return
> 
> In file included from mm/memory.c:84:
> mm/memory.c:1612:2: warning: Undefined or garbage value returned to caller [core.uninitialized.UndefReturn]
>         return err;
>         ^~~~~~~~~~
> 
> The setting of err depends on a loop executing.
> So initialize err.
>
> ...
>
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1601,7 +1601,7 @@ int vm_insert_pages(struct vm_area_struct *vma, unsigned long addr,
>  	return insert_pages(vma, addr, pages, num, vma->vm_page_prot);
>  #else
>  	unsigned long idx = 0, pgcount = *num;
> -	int err;
> +	int err = -EINVAL;
>  
>  	for (; idx < pgcount; ++idx) {
>  		err = vm_insert_page(vma, addr + (PAGE_SIZE * idx), pages[idx]);

If a caller were to ask vm_insert_pages() to insert zero pages, I
suspect we should just return zero and set *num to zero.

