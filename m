Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06C5C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C50BF2051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579184912;
	bh=RActrr21vzldNA4f02Toa0HllTrYwOjvT4l8PRKPFP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FFjXVovwEaa6mEH+xcT7cMAmSOEQk+RWG6kVWCQHj0y6BqYIL7LCeECLSB4X/B3vt
	 cdQYsHXB9heILkq5mlQ1ft3GP29vwhb7gv8HsDbkNpK3u/ONBWra5mAZy+yrFjvqcu
	 58vjcWjjmy2/Qz9JDBHr2lYQfdgtVpZaMrkd7c7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgAPO2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:28:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43304 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAPO2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:28:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so19360600wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 06:28:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OzG4Wm6WZrsrZXG7EsPNbNhDAoAsn+FlgzMhOZKK7Bw=;
        b=mz9E+xBxoTUaO6KVrmmTh1MBe2oJ3rX2yQ425/o9VvHif8bL5jPI7SM4Cvy4TvCHyR
         mVXO5mlIMpCReC9fqd+sByfqYSXda5GWj/qEmcfUZFzpIfpzVfZYzw7VdLPmLN2KS1KA
         +7ZI0O19CQm7GtYHFsaob6P5z/FQhMd64HtkLtkxjuQLZp9YqQFX4hWiK+ufsBJUqjkx
         BLVXeLZuyKq3PQXGuJalfuQclKTNu94R2Zt127KMHbZfneoR/KAsWxipwdKf1iMBrFZS
         evx45iHURl+Z+NLoAodzWLGXk62k/My0OL+4hEFUDOuYMbv8VlISHlY60rLz9eG7P4S2
         JXWw==
X-Gm-Message-State: APjAAAUqKpKw9lW9yJv9FaOcThT7MwIxYd9rZC/fPsS9OtiM7GX2a8YO
        ekqjdUXYrZUTJH+FB3wPKFU=
X-Google-Smtp-Source: APXvYqz9ml7zEul5JgtZtk5xrlAZN1wdyd+IOkJKp591wmb5Cwc09LYTQXX20MEd3rOfb7suiWzxjQ==
X-Received: by 2002:adf:f70b:: with SMTP id r11mr3846446wrp.388.1579184909342;
        Thu, 16 Jan 2020 06:28:29 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y17sm593663wma.36.2020.01.16.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 06:28:28 -0800 (PST)
Date:   Thu, 16 Jan 2020 15:28:27 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200116142827.GU19428@dhcp22.suse.cz>
References: <20200115172916.16277-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115172916.16277-1-cai@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-01-20 12:29:16, Qian Cai wrote:
> It is guaranteed to trigger a lockdep splat if calling printk() with
> zone->lock held because there are many places (tty, console drivers,
> debugobjects etc) would allocate some memory with another lock
> held which is proved to be difficult to fix them all.

I am still not happy with the above much. What would say about something
like below instead?
"
It is not that hard to trigger lockdep splats by calling printk from
under zone->lock. Most of them are false positives caused by lock chains
introduced early in the boot process and they do not cause any real
problems. There are some console drivers which do allocate from the
printk context as well and those should be fixed. In any case false
positives are not that trivial to workaround and it is far from optimal
to lose lockdep functionality for something that is a non-issue.
<An example of such a false positive goes here>
"

> A common workaround until the onging effort to make all printk() as
> deferred happens is to use printk_deferred() in those places similar to
> the recent commit [1] merged into the random and -next trees, but memory
> offline will call dump_page() which needs to be deferred after the lock.

I would remove this paragraph altogether. The real problem is that we do
not really want to make dump_page deferred.

> So change has_unmovable_pages() so that it no longer calls dump_page()
> itself - instead it returns a "struct page *" of the unmovable page back
> to the caller so that in the case of a has_unmovable_pages() failure,
> the caller can call dump_page() after releasing zone->lock.

Again this begs for some more explanation why this is ok. Something like
the following:
"
Even though has_unmovable_pages doesn't hold any reference to the
returned page this should be reasonably safe for the purpose of
reporting the page (dump_page) because it cannot be hotremoved. The
state of the page might change but that is the case even with the
existing code as zone->lock only plays role for free pages.
"

> Also, make
> dump_page() is able to report a CMA page as well, so the reason string
> from has_unmovable_pages() can be removed.
> 
> While at it, remove a similar but unnecessary debug-only printk() as
> well. A few sample lockdep splats can be founnd here [2].
> 
> [1] https://lore.kernel.org/lkml/1573679785-21068-1-git-send-email-cai@lca.pw/
> [2] https://lore.kernel.org/lkml/7CD27FC6-CFFF-4519-A57D-85179E9815FE@lca.pw/
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

With improved changelog and after addressing one more thing below, feel
free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks for working on this. I have to say I have disliked the initial
version because they were really hacky. This one can be reasoned about
at least. has_unmovable_pages returning an unmovable page actually makes
some conceptual sense to me.

[...]
> @@ -8302,12 +8304,10 @@ bool has_unmovable_pages(struct zone *zone, struct page *page, int migratetype,
>  		 */
>  		goto unmovable;
>  	}
> -	return false;
> +	return NULL;
>  unmovable:
>  	WARN_ON_ONCE(zone_idx(zone) == ZONE_MOVABLE);

You want to move this WARN_ON as well. Not only because it is using
printk as well but also because we do not really want to trigger the
warning from userspace via is_mem_section_removable. Maybe worth a patch
on its own?
-- 
Michal Hocko
SUSE Labs
