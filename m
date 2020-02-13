Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA245C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786EA2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 14:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="psiuyPbQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730149AbgBMN77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:59:59 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44872 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgBMN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:59:59 -0500
Received: by mail-lj1-f194.google.com with SMTP id q8so6669912ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 05:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d+8KvklWJGXWjHgD35gpB8KFdd0PBjAC6j+lE4WHS6s=;
        b=psiuyPbQz1NHGk/uKAcko22FjVpQaBiPUQsZnLfMz8UcnqnCzhwomLXDyVAZL5Eu2u
         aMNMpiYcSoCKYYWJZfnits7z6Pxopm8MAEr7YpcWpFd2VcMG6kXMUtgnN1B996+O6m01
         2YWZ0j0AYJQu4O0peQTTJUlOJpkoomSWShV0+qWeFJi/IV6VsLqbhNlysAq5yC9Mhte6
         MlPCz72BcpYIRDA0Q6liWRRVkftLwlAWxPwCCU7gCqHeNKbDEnAGUl5A4jG2aBXmjC4S
         RoTaiyV2b7y2UI1e8C3P1D/cUHKXH0abvTuZ0WnA6TqGxZwLj4dd0rzGCKGL/S2uYv41
         MqiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d+8KvklWJGXWjHgD35gpB8KFdd0PBjAC6j+lE4WHS6s=;
        b=Aj68sn0O+KFFNP1XjFeoKxIr7LMju/8tyKd8SGi1BUtOU8ZPt+QeHIzYVN1qpqZ6g4
         lX45QFWbMopLIVZX+pFcYudXnjGptzGChf3U9mI8XP26KW9umkQB+par/aUffx0UR6Br
         +lNS7e9AZijv6gXQMRtoIGsxS3VJCgl88znsRjVjiLVOoDvNo0W2LlJyLlMhaVqdOp/h
         KiUo/kfQNFlqpqsSk1/CrhrOsAVXVs12GMUDRb1xGZflTsQGz2HdADv6uMNCFjlSes/p
         rRhBHGHU8RCRRFtD4XVa0vyJ2oU4waYtC9oTohunu11adw8VpM1568z/uN43tzej25Af
         ODCg==
X-Gm-Message-State: APjAAAWI+1KU+QNdUqgseJMStL+BOMRlMzcWFwJMAZXDjSY46o3fo5Pw
        oxnnQB4YrR+eBCuIslozFsjQbw==
X-Google-Smtp-Source: APXvYqy3MZCrg50lwTpOQ2nHdXM9qpNzZJvp69TAtFVoYduIuHyCUH1khFeVOUGwlcb9kbKq8ja8XQ==
X-Received: by 2002:a2e:b04b:: with SMTP id d11mr11336407ljl.248.1581602397526;
        Thu, 13 Feb 2020 05:59:57 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l12sm1522216lji.52.2020.02.13.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 05:59:56 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id DC75C100F25; Thu, 13 Feb 2020 17:00:18 +0300 (+03)
Date:   Thu, 13 Feb 2020 17:00:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/25] mm: Fix documentation of FGP flags
Message-ID: <20200213140018.fv2uj7knrd3chdgz@box>
References: <20200212041845.25879-1-willy@infradead.org>
 <20200212041845.25879-6-willy@infradead.org>
 <20200212074215.GF7068@infradead.org>
 <20200212191145.GH7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212191145.GH7778@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 11:11:45AM -0800, Matthew Wilcox wrote:
> On Tue, Feb 11, 2020 at 11:42:15PM -0800, Christoph Hellwig wrote:
> > On Tue, Feb 11, 2020 at 08:18:25PM -0800, Matthew Wilcox wrote:
> > > - * @fgp_flags: PCG flags
> > > + * @fgp_flags: FGP flags
> > >   * @gfp_mask: gfp mask to use for the page cache data page allocation
> > >   *
> > >   * Looks up the page cache slot at @mapping & @offset.
> > >   *
> > > - * PCG flags modify how the page is returned.
> > > + * FGP flags modify how the page is returned.
> > 
> > This still looks weird.  Why not just a single line:
> > 
> > 	* @fgp_flags: FGP_* flags that control how the page is returned.
> 
> Well, now you got me reading the entire comment for this function, and
> looking at the html output, so I ended up rewriting it entirely.
> 
> +++ b/mm/filemap.c
> @@ -1574,37 +1574,34 @@ struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
>  EXPORT_SYMBOL(find_lock_entry);
>  
>  /**
> - * pagecache_get_page - find and get a page reference
> - * @mapping: the address_space to search
> - * @offset: the page index
> - * @fgp_flags: FGP flags
> - * @gfp_mask: gfp mask to use for the page cache data page allocation
> - *
> - * Looks up the page cache slot at @mapping & @offset.
> + * pagecache_get_page - Find and get a reference to a page.
> + * @mapping: The address_space to search.
> + * @offset: The page index.
> + * @fgp_flags: %FGP flags modify how the page is returned.
> + * @gfp_mask: Memory allocation flags to use if %FGP_CREAT is specified.
>   *
> - * FGP flags modify how the page is returned.
> + * Looks up the page cache entry at @mapping & @offset.
>   *
> - * @fgp_flags can be:
> + * @fgp_flags can be zero or more of these flags:
>   *
> - * - FGP_ACCESSED: the page will be marked accessed
> - * - FGP_LOCK: Page is return locked
> - * - FGP_CREAT: If page is not present then a new page is allocated using
> - *   @gfp_mask and added to the page cache and the VM's LRU
> - *   list. The page is returned locked and with an increased
> - *   refcount.
> - * - FGP_FOR_MMAP: Similar to FGP_CREAT, only we want to allow the caller to do
> - *   its own locking dance if the page is already in cache, or unlock the page
> - *   before returning if we had to add the page to pagecache.
> + * * %FGP_ACCESSED - The page will be marked accessed.
> + * * %FGP_LOCK - The page is returned locked.
> + * * %FGP_CREAT - If no page is present then a new page is allocated using
> + *   @gfp_mask and added to the page cache and the VM's LRU list.
> + *   The page is returned locked and with an increased refcount.
> + * * %FGP_FOR_MMAP - The caller wants to do its own locking dance if the
> + *   page is already in cache.  If the page was allocated, unlock it before
> + *   returning so the caller can do the same dance.
>   *
> - * If FGP_LOCK or FGP_CREAT are specified then the function may sleep even
> - * if the GFP flags specified for FGP_CREAT are atomic.
> + * If %FGP_LOCK or %FGP_CREAT are specified then the function may sleep even
> + * if the %GFP flags specified for %FGP_CREAT are atomic.
>   *
>   * If there is a page cache page, it is returned with an increased refcount.
>   *
> - * Return: the found page or %NULL otherwise.
> + * Return: The found page or %NULL otherwise.
>   */
>  struct page *pagecache_get_page(struct address_space *mapping, pgoff_t offset,
> -       int fgp_flags, gfp_t gfp_mask)
> +               int fgp_flags, gfp_t gfp_mask)
>  {

LGTM:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
