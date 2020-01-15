Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE55C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93D42081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579080146;
	bh=lMI89iUU0WchcVJyzJuG3Rpq1kpzlmKJnZ9ulYIGEGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JbaKURrc6ysgnO1xzNukqjogXugIYv+/vA3IHXvPkT2sNYHaVACumrbL8T52i9K8V
	 IFw/+Tjdn3wH+nSjfhMIiwSB+rAvoISkbXOuKZgz/+ezrLR4hg+xSSDsQmEdgvUgZy
	 BOKrtgHNq7d53liyQM6daQVU77d199NiQh6ZeRKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgAOJW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:22:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36569 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729274AbgAOJWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:22:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so14991262wru.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 01:22:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6Fx5eqaqV4mFfMkhI1kCNNjaUd3xOj+I29Cn8Tuc+M=;
        b=M9EfUV3O4VbEGQnnLexac7OWeE0G8Xp18Jzv8KZVHBW8xQlLLz5FkXykV/uqdHivaB
         hrL+1jOdf+FZjblmA60oomdSM6gHsU1md+X76Akl6m+TmD0hpkVToig6HmjB2SkANqA4
         zveczZcwYe4WLhlfApClnyfE136WG+3aUrUHZ+fiXPwXW354zP26zJ3HCjD6z0RcnFLC
         19rven3kencVs6CXO0pMuLt6FtFtTIhl5p3Q3mciuk7YUWe0RTFyqc1fHIW48Q/6gkbe
         /chl5KDS7O2yk8UlE2+rytCUqP/WwSJcKLHweifPuDDzZgL07EcdyCwKi6FyeVn8Tu5d
         k6eA==
X-Gm-Message-State: APjAAAUgPz4YYdtL6d31tg+BOV4d0vAh5wiDHWeaKVToyI8Fwloz1Ooa
        +SYllkeH0haBLsoVIbV7iqjiyhSH
X-Google-Smtp-Source: APXvYqzYN49FR1sFPCG2CULBNTV+pZPhfE+hHQPbGDilOx7rpmYmeEIFPuI8mZw0xSGw9fbalnTwyw==
X-Received: by 2002:adf:fc4b:: with SMTP id e11mr29777612wrs.326.1579080143950;
        Wed, 15 Jan 2020 01:22:23 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a5sm22343325wmb.37.2020.01.15.01.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 01:22:22 -0800 (PST)
Date:   Wed, 15 Jan 2020 10:22:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200115092221.GX19428@dhcp22.suse.cz>
References: <20200115053130.15490-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115053130.15490-1-cai@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-01-20 00:31:30, Qian Cai wrote:
> It is guaranteed to trigger a lockdep splat if calling printk() with
> zone->lock held because there are many places (tty, console drivers,
> debugobjects etc) would allocate some memory with another lock
> held which is proved to be difficult to fix them all.

This really should mention that most of them are false positives due to
early code intialization which cannot really cause a real lockup. AFAIR
you have also found some that really do allocate (GFP_ATOMIC) from the
console callback and those should be really fixed IMHO.

> A common workaround until the onging effort to make all printk() as
> deferred happens is to use printk_deferred() in those places similar to
> the recent commit [1] merged into the random and -next trees, but memory
> offline will call dump_page() which needs to be deferred after the lock.
> 
> So change has_unmovable_pages() so that it no longer calls dump_page()
> itself - instead it returns a "struct page *" of the unmovable page back
> to the caller so that in the case of a has_unmovable_pages() failure,
> the caller can call dump_page() after releasing zone->lock. Also, make
> dump_page() is able to report a CMA page as well, so the reason string
> from has_unmovable_pages() can be removed.

OK, this is slightly better than your previous attempts. Returing the
page without holding a reference is a quite subtle though. It should be
safe here because the page cannot go away because it is unmovable but
please add a comment that explains that the page _must not_ be used for
anything else than dumping its state.

> While at it, remove a similar but unnecessary debug-only printk() as
> well.

Because it doesn't really provide any useful information from the
practice.
[...]

> @@ -74,9 +75,9 @@ void __dump_page(struct page *page, const char *reason)
>  			page->mapping, page_to_pgoff(page),
>  			compound_mapcount(page));
>  	else
> -		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx\n",
> +		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx cma:%d\n",
>  			page, page_ref_count(page), mapcount,
> -			page->mapping, page_to_pgoff(page));
> +			page->mapping, page_to_pgoff(page), page_cma);

Is this correct? CMA pages cannot be comound? Btw. I would simply do

		pr_warn("page:%px refcount:%d mapcount:%d mapping:%px index:%#lx%s\n",
			...., page_cmap ? "CMA": "");
-- 
Michal Hocko
SUSE Labs
