Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E22C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB4B21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583861997;
	bh=6FjAu21bPwSRBdA1VQ4xafI+DYfCjDLEQqCnSzn84jQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0heTOLug5piQXKsPwFKhnbLVVjes5okXxGgH3PtLmZHeEfAPrADXxi87ahhm/chjF
	 UkmewPWmTUs9gfoVg10yqHWyrnot3zdvJkZO4KmXOM3vVqfhE5ji7D/avPAxIS5V/n
	 y3c5fgR511qQUMz+SY686IUd2oV+16rXCrF4YWfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCJRjz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:39:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39146 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbgCJRjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:39:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id f7so2353978wml.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:39:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mi8lNzzOnKeYsD5u8ot6xkdW2xJgJMBQyDw8ffSdpAY=;
        b=Sc8YqEzgMyj+9jAsW15y1MGX58durmfcxD7UvIbvirQp5d8n5sG+HNF6C0AZUxbkOV
         3wYkSq6Vwge5XaosiqlTBk6g3a8EVykouLyxduyDMTw6tj/eFCtTL+sU1U1zEdhbfiip
         3I6Hb9ETeb2KLZOQ2Dy6n2GbY7k8iKgquPnVU7IdV0AOistFAiOUkscPhMXGLucXQnrE
         9LqB6GZfG2QoMsgYG4V5u1YGaVTJa3k3ppfaV/CHx6FHJPtQRBIAwlz6m51RaSG5RhtL
         Lci+HHs6gPfV9P/z3mrPg0Y5u7vozma5lRjc04S9GdDjkTjtsXsvH7ROaWd9W6XODFbu
         HiKg==
X-Gm-Message-State: ANhLgQ1tRQLrb02EuK0tFAGvYNgJEZ8c8xW5uGTpgKaDcDEJRO9bWyQm
        6P1W4bXYeswyHvfIWgIyrGA=
X-Google-Smtp-Source: ADFU+vteQx+Y6fhAAgT08Ei8v41vQmEuC4dL/8yPoVzAOVAO9xUONQ+PcE5PlmBE3Trjkl7MyKgqQQ==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr3048235wme.125.1583861993519;
        Tue, 10 Mar 2020 10:39:53 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id q6sm4893875wmj.6.2020.03.10.10.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:39:52 -0700 (PDT)
Date:   Tue, 10 Mar 2020 18:39:51 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310173951.GX8447@dhcp22.suse.cz>
References: <20200310002524.2291595-1-guro@fb.com>
 <20200310090121.GB8447@dhcp22.suse.cz>
 <20200310173056.GB85000@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310173056.GB85000@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 10:30:56, Roman Gushchin wrote:
> On Tue, Mar 10, 2020 at 10:01:21AM +0100, Michal Hocko wrote:
> > On Mon 09-03-20 17:25:24, Roman Gushchin wrote:
> > [...]
> > > 2) Run-time allocations of gigantic hugepages are performed using the
> > >    cma allocator and the dedicated cma area
> > 
> > [...]
> > > @@ -1237,6 +1246,23 @@ static struct page *alloc_gigantic_page(struct hstate *h, gfp_t gfp_mask,
> > >  {
> > >  	unsigned long nr_pages = 1UL << huge_page_order(h);
> > >  
> > > +	if (IS_ENABLED(CONFIG_CMA) && hugetlb_cma[0]) {
> > > +		struct page *page;
> > > +		int nid;
> > > +
> > > +		for_each_node_mask(nid, *nodemask) {
> > > +			if (!hugetlb_cma[nid])
> > > +				break;
> > > +
> > > +			page = cma_alloc(hugetlb_cma[nid], nr_pages,
> > > +					 huge_page_order(h), true);
> > > +			if (page)
> > > +				return page;
> > > +		}
> > > +
> > > +		return NULL;
> > 
> > Is there any strong reason why the alloaction annot fallback to non-CMA
> > allocator when the cma is depleted?
> 
> The reason is that that gigantic pages allocated using cma require
> a special handling on releasing. It's solvable by using an additional
> page flag, but because the current code is usually not working except
> a short time just after the system start, I don't think it's worth it.

I am not deeply familiar with the cma much TBH but cma_release seems to
be documented to return false if the area doesn't belong to the area so
the free patch can try cma_release and fallback to the regular free, no?

-- 
Michal Hocko
SUSE Labs
