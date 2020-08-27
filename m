Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E584DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BABF020707
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="KPqGwrms"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgH0Oay (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgH0OX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:23:56 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3F7C061236
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:23:47 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id o2so2669229qvk.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 07:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BmSkU8kL1DJIMf//B6UvwY8ukjXeH0WHbYlFQli5/Kw=;
        b=KPqGwrmsmOIuf+JiWEW/k7gGWQ1y3K+MpxQ+GlJBR4JHV9vGFTTbjyFMl+FZ4Y0eR1
         K2BXbisksDsJdOWmVO1uqUYQ2h1rz6x4zhmDciS7F7QXhAv9oK2efTTjrKFY2lV0MX2h
         m+NX4PEHBJLAtiNCQ+E62vD9YoMqRVe4nQ2rLdY2M6j+IN9GUIPk+F93i5PMufggiU+5
         7qfQtxk5IGmbE2ZD7qvuDqJQO8zKxEiYo6gkbc90Yi69wGk+9eBBpz/JoSeL/G/aFyFt
         vrKHByeeVrxLF5cwGuOVUkygA2VuBjAX42oiZQSqxkRduIvG36gg5Hfhjg+H7Ukg95zP
         RpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BmSkU8kL1DJIMf//B6UvwY8ukjXeH0WHbYlFQli5/Kw=;
        b=JxehEUdDMIdNq5ku6L5lgfPGFZgywEm0TH3YYC+CfMBimpG3FeUncw5bABKLHtKaAk
         y5hy4tvYQjxHbZoK3X5CepYnoE8hunx93gWpfSRRtIM3QOiVnK0gkPI5+y8g4q/cuV20
         3rsxegXwYXx7w2HdiPhy2qWcn215BTq+6kEKRfiLwEnMoTs3cEDRnwVHA4VET/6aWyNs
         +sNiwnWnyAMln0gFafZ+5wla0mI8Dz2ePIW/D0t7CmhDUjib1dYPX1Abs8Qmrt78lZeS
         tGZ9qzUGw/OB5DkuO/uzFeaa4sZUB9G75Pd+58nste94s2m69CYMXX3yDUsCSrS197rA
         DVMw==
X-Gm-Message-State: AOAM531YWcYIyAdPz2gTKI4evaEmuL8+AhMz5xBZb6yrnAc+Vlk6YVax
        WEgDCBOiy4njRZ189zDYCfD5ow==
X-Google-Smtp-Source: ABdhPJxeJ4y+twhjLH2tJgCPbWVuyl+hfRB8UMwjlhngOikJ6bWHbwUXxgZd/BLJ9LZT047bUSDjHg==
X-Received: by 2002:a0c:ffa1:: with SMTP id d1mr19299175qvv.36.1598538226887;
        Thu, 27 Aug 2020 07:23:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:412a])
        by smtp.gmail.com with ESMTPSA id l64sm1953780qkc.21.2020.08.27.07.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:23:46 -0700 (PDT)
Date:   Thu, 27 Aug 2020 10:22:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Huang Ying <ying.huang@intel.com>,
        intel-gfx@lists.freedesktop.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] mm: Use find_get_swap_page in memcontrol
Message-ID: <20200827142229.GB1002856@cmpxchg.org>
References: <20200819184850.24779-1-willy@infradead.org>
 <20200819184850.24779-3-willy@infradead.org>
 <20200826142002.GA988805@cmpxchg.org>
 <20200827125941.GG14765@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827125941.GG14765@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 01:59:41PM +0100, Matthew Wilcox wrote:
> On Wed, Aug 26, 2020 at 10:20:02AM -0400, Johannes Weiner wrote:
> > The refactor makes sense to me, but the name is confusing. We're not
> > looking for a swap page, we're primarily looking for a file page in
> > the page cache mapping that's handed in. Only in the special case
> > where it's a shmem mapping and there is a swap entry do we consult the
> > auxiliary swap cache.
> > 
> > How about find_get_page_or_swapcache()? find_get_page_shmemswap()?
> > Maybe you have a better idea. It's a fairly specialized operation that
> > isn't widely used, so a longer name isn't a bad thing IMO.
> 
> Got it.  find_get_incore_page().  I was going to go with inmem, but that
> it matches mincore sold me on it.
>
> /**
>  * find_get_incore_page - Find and get a page from the page or swap caches.
>  * @mapping: The address_space to search.
>  * @index: The page cache index.
>  *
>  * This differs from find_get_page() in that it will also look for the
>  * page in the swap cache.
>  *
>  * Return: The found page or %NULL.
>  */

Nice work, that's perfect.

> I was focusing too much on what the function did, not why it was doing it.

Me too.
