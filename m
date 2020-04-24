Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E9C2BA19
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:51:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9AF206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="fWyMKe13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgDXCvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgDXCvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:51:38 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8452DC09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:51:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k12so6839588qtm.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8QJoTXqVG0DZe/mQnKE8SNa8hRGYUaKenWzWiibacQo=;
        b=fWyMKe13DTH0WU39blr8r9fcIdg3WBh/22Qxi2N7/ZMi57uMaMHC/LswPiuSjuDGrM
         zAXBsVSEfj/DS2W4JCdcrTiZVmjoKokQ6z5mvtJNnXt7/kv+EPEP+dsi2RmQXk2NPSuM
         yTmXoyi+hqG1qYalmMWuPITt2paqd8GD9tZLfk7uhJDG1NdivLWI3Q5JJ6kGyMrLUiR4
         rfPqA28+wLh8IkDmjIOb6ygNjMVfna281My/tfr+rwPZoX3nJjW4AVXiJTycMOgdiI37
         bkhzmYKfjeH5tajFE8yKQguK2PGATn1ik7TlViwHPVLmrNN6hvRAjDx6Usw6Su+poqmg
         mPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8QJoTXqVG0DZe/mQnKE8SNa8hRGYUaKenWzWiibacQo=;
        b=lxyw6CK5SUf/o651Pyl0NmNeW5dNJkOt+HJ9ps+ZcaERcPUnWQXRQG4dL/BfsITj4+
         WXIzIgBKdMpvHoa3Y0WLMoT3arL8Yhc/Ac2AyD+C8ud0BFP8ayCjw/7BScWAXME8T2KQ
         PHGOAtppXE6XGTo0hMHGKSUFj3xfAu2Zc4xKPQ7/zszjNgD2bhC7SVxeXPK6lLitd2Nz
         6vCJSVdByWLokRYRKAd8Fk8wync8/9Mgt4hYO515i0qI9TCcVGguOo3fBPdyF3KGw4sy
         NpbTFLIT1uZpfPD6FpmZK42XatD91Nq7Cd027BqIdfWXRtBiwnf+bd26LKb9/maMShWl
         0vUA==
X-Gm-Message-State: AGi0Pub2Zgi3KKeMCDSUGAIfDviWIrTMH3KzuYRFORCcTeZRUkIIpUMu
        Y60pkwdoEv3M95RBj/zJ7+BoEg==
X-Google-Smtp-Source: APiQypINaEFha5KGIe0+/afOHGPj9jlzn31/ef9b0TwirU85PVQm6jcyrfBcvP+omZnqnjFXKevINQ==
X-Received: by 2002:ac8:1bbd:: with SMTP id z58mr7257252qtj.94.1587696697771;
        Thu, 23 Apr 2020 19:51:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id 205sm2851782qkj.1.2020.04.23.19.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 19:51:37 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:51:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Shakeel Butt <shakeelb@google.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 16/18] mm: memcontrol: charge swapin pages on
 instantiation
Message-ID: <20200424025135.GB464082@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-17-hannes@cmpxchg.org>
 <20200424004441.GF13929@js1304-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424004441.GF13929@js1304-desktop>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 09:44:42AM +0900, Joonsoo Kim wrote:
> On Mon, Apr 20, 2020 at 06:11:24PM -0400, Johannes Weiner wrote:
> > @@ -412,31 +407,43 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
> >  			 */
> >  			cond_resched();
> >  			continue;
> > -		} else if (err)		/* swp entry is obsolete ? */
> > -			break;
> > -
> > -		/* May fail (-ENOMEM) if XArray node allocation failed. */
> > -		__SetPageLocked(new_page);
> > -		__SetPageSwapBacked(new_page);
> > -		err = add_to_swap_cache(new_page, entry, gfp_mask & GFP_KERNEL);
> > -		if (likely(!err)) {
> > -			/* Initiate read into locked page */
> > -			SetPageWorkingset(new_page);
> > -			lru_cache_add_anon(new_page);
> > -			*new_page_allocated = true;
> > -			return new_page;
> >  		}
> > -		__ClearPageLocked(new_page);
> > -		/*
> > -		 * add_to_swap_cache() doesn't return -EEXIST, so we can safely
> > -		 * clear SWAP_HAS_CACHE flag.
> > -		 */
> > -		put_swap_page(new_page, entry);
> > -	} while (err != -ENOMEM);
> > +		if (err)		/* swp entry is obsolete ? */
> > +			return NULL;
> 
> "if (err)" is not needed since "!err" is already exiting the loop.

But we don't want to leave the loop, we want to leave the
function. For example, if swapcache_prepare() says the entry is gone
(-ENOENT), we don't want to exit the loop and allocate a page for it.

> > +
> > +	/*
> > +	 * The swap entry is ours to swap in. Prepare a new page.
> > +	 */
> > +
> > +	page = alloc_page_vma(gfp_mask, vma, addr);
> > +	if (!page)
> > +		goto fail_free;
> > +
> > +	__SetPageLocked(page);
> > +	__SetPageSwapBacked(page);
> > +
> > +	/* May fail (-ENOMEM) if XArray node allocation failed. */
> > +	if (add_to_swap_cache(page, entry, gfp_mask & GFP_KERNEL))
> > +		goto fail_unlock;
> > +
> > +	if (mem_cgroup_charge(page, NULL, gfp_mask & GFP_KERNEL, false))
> > +		goto fail_delete;
> > +
> 
> I think that following order of operations is better than yours.
> 
> 1. page alloc
> 2. memcg charge
> 3. swapcache_prepare
> 4. add_to_swap_cache
> 
> Reason is that page allocation and memcg charging could take for a
> long time due to reclaim and other tasks waiting this swapcache page
> could be blocked inbetween swapcache_prepare() and add_to_swap_cache().

I see how that would be preferable, but memcg charging actually needs
the swap(cache) information to figure out the cgroup that owned it at
swapout, then uncharge the swapcache and drop the swap cgroup record.

Maybe it could be done, but I'm not sure that level of surgery would
be worth the benefits? Whoever else would be trying to swap the page
in at the same time is likely in the same memory situation, and would
not necessarily be able to allocate pages any faster.
