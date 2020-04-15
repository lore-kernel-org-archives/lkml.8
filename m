Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9778DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7030C20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="eNgPPZZH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbgDOW72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgDOW7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:59:17 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DB9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:59:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w145so4086283lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0GJj72rOV8U2EAUOLAErCfg2QdniBznpVj0ApYsgoJY=;
        b=eNgPPZZHcjefzt31MMwn1gNJJm0ooEAsvvYQ85TbXAuxt+32Q9aMwCQWftGnQQF4Yp
         gxr1pfT7WeJDHdM+AERbF7TX4P8unTnoVYFISyS0T3FAoQ45c64n6R9+bsqezBGNDCSv
         wSAq/ys+tOpcET5hOw0H5q04wkQYaiKo0UWpWAtfyJ5KeTdds6UlBRYs/CwI9eI1eYcq
         l9Ir4vfoLW+oqHByJzqwbCwpJrMuceqjff0o76STDz+s0CZmT4CJ+dBBV8TSgiefsAPL
         k2TZjvdjHHDe4nZ8CK0afIJIpE6AUEWSBlse9LrhFMSiklHGdChjnnbHVN9Sbf6w/FUt
         X7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0GJj72rOV8U2EAUOLAErCfg2QdniBznpVj0ApYsgoJY=;
        b=RYrcov38bGbQlYE0Qza7dmEyLlYonfL0QjbO3p3uSrRzr2eyiX/VI41kcpT9gRkgbb
         bOX0dn6FWG216u7J6RY5deHdyFxOkHca6OYCWcQDgxohz0c9ML/q3Du+6uJY5jZkKesW
         eGdcN4GaN+1GyZ8LvDT7JYyj4UZiobfKy2omEWJdMUTG038Qz6JDc0TVBz13jc94lTdq
         5/Wyj2RJF76v6MDkIZ2fqA48QbBiKuquGBcs+HjEVJJaaVQ9sqlaAY6S1Up2nRZ66XqL
         Di1hhgDqf4aFadeEI0h0ipVrFs3B38QlHQSvhikAe5BdzQv5tOMh6Og2834ydWlG3Kn0
         /XlQ==
X-Gm-Message-State: AGi0PuawJYo8HppDTj3ALQF/C0XxTuZsdA+bcJIAF3JcqK66m5MrTVN5
        EYeZA6ufhrt/Em86KZNBGW5zLxr12ho=
X-Google-Smtp-Source: APiQypIsNgpSZlzWvGdf1lVQnr06ejkzAv36hZyaHFMlHTUdzCW5I5M4tYgDSpF+RQm+MNs6SL3IzA==
X-Received: by 2002:a05:6512:318a:: with SMTP id i10mr4361753lfe.96.1586991552822;
        Wed, 15 Apr 2020 15:59:12 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id q9sm14922879ljm.9.2020.04.15.15.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 15:59:11 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 5FE04102C64; Thu, 16 Apr 2020 01:59:11 +0300 (+03)
Date:   Thu, 16 Apr 2020 01:59:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3, RESEND 6/8] khugepaged: Allow to collapse PTE-mapped
 compound pages
Message-ID: <20200415225911.ryybsmdrtwxngi5h@box>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-7-kirill.shutemov@linux.intel.com>
 <20200415144426.a146ef173140f5bc396a6dcd@linux-foundation.org>
 <20200415215205.eaihc5snfe4ffhju@box>
 <20200415155259.8be9887c64b1420cfc9b9655@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415155259.8be9887c64b1420cfc9b9655@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 03:52:59PM -0700, Andrew Morton wrote:
> On Thu, 16 Apr 2020 00:52:05 +0300 "Kirill A. Shutemov" <kirill@shutemov.name> wrote:
> 
> > On Wed, Apr 15, 2020 at 02:44:26PM -0700, Andrew Morton wrote:
> > > On Mon, 13 Apr 2020 15:52:18 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> > > 
> > > > We can collapse PTE-mapped compound pages. We only need to avoid
> > > > handling them more than once: lock/unlock page only once if it's present
> > > > in the PMD range multiple times as it handled on compound level. The
> > > > same goes for LRU isolation and putback.
> > > > 
> > > > ...
> > > >
> > > > --- a/mm/khugepaged.c
> > > > +++ b/mm/khugepaged.c
> > > > @@ -515,17 +515,30 @@ void __khugepaged_exit(struct mm_struct *mm)
> > > >  
> > > >  static void release_pte_page(struct page *page)
> > > >  {
> > > > -	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> > > 
> > > I have
> > > 
> > > 	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_lru(page));
> > > 
> > > here.  Is there some prerequisite which I wasn't able to find?
> > 
> > The patchset is on top of v5.6. It has been changed since. See
> > 9de4f22a60f7 ("mm: code cleanup for MADV_FREE").
> > 
> > Look like a trivial fixup is required.
> 
> [7/8] makes a big mess.  Can we please have a v4?

Sure. Give me a day.

-- 
 Kirill A. Shutemov
