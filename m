Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30893C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09B70205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583755985;
	bh=CJ4cOSNiw9+8lA2WHDceh5TeqNHq/3gUmgmVDXVgwPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vf9eVJQDTiKM6gn7Ynwjmk6+t+N3d5bpjm2YGJOw3467Cf24nzBDM9rz2KFTjt7Vb
	 4bXC0agpbRAXG/qVl1RoVByIdfz25dHlHMfmsKDGpnyCx0ZfFxTbAv5q1YmiNqfTTm
	 PkWUmLFnKByv1vVlVFb9yVrX82eEv5T3SDQqxoTA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgCIMND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 08:13:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgCIMND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 08:13:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id v4so10783231wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 05:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/AnVazJT1to75hAodEIbyCnLvch4wjuOplZ+LEerA4=;
        b=ht449RXlmZD7/HyUc9LXYztokupP7KLhPqMQt7M9nVprdvpe5T0Zqfcvv1osNYmPRT
         Tlpr9Gu6pulAXJcljTKoJGT3CsXji4Jf+QiDnqfcwnHa1JzGvNoydtXkF3aKsZNNLP4P
         MUhbLVMOJ08sf7GGk+v/BVW8m/1uzs86vm4wzDLG/x+qUX04rQRiv1Vf5gs1WihhbGc7
         79cF8J+wgjrUaJux1c6FVTTRcJPSgMYQFpjre77phcTfgqe3Mq5saQr18A7CljTADS7Y
         xr0FgM+jQPxbHVlMwxfgKjoQIfoLfFxZpu7PumnNlTFFmjD09xxoffkgZLZ+hM6os1w7
         0ILg==
X-Gm-Message-State: ANhLgQ1LYqrTGBILbR0WEMhPX8Kc2MeckEPbpJs5YAVzhVRHYkqNXjy2
        wqCjSFeDHGJqa9riX1RYip0=
X-Google-Smtp-Source: ADFU+vvEt/BD9szUjhMRtS2lUukGoSi4Lw3Gceek5PIb+EfOLdKzhiRXkB0oMfhypj8LsYWD0UjW+Q==
X-Received: by 2002:adf:a2d9:: with SMTP id t25mr20488116wra.84.1583755981843;
        Mon, 09 Mar 2020 05:13:01 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j205sm25147878wma.42.2020.03.09.05.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 05:13:01 -0700 (PDT)
Date:   Mon, 9 Mar 2020 13:13:00 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V3] mm: Add PageLayzyFree() helper functions for
 MADV_FREE
Message-ID: <20200309121300.GL8447@dhcp22.suse.cz>
References: <20200309021744.1309482-1-ying.huang@intel.com>
 <68360241-eb18-b3d8-bf6f-4dbbed258ee6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68360241-eb18-b3d8-bf6f-4dbbed258ee6@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09-03-20 09:55:38, David Hildenbrand wrote:
> On 09.03.20 03:17, Huang, Ying wrote:
[...]
> > @@ -1235,7 +1234,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
> >  		 * Try to allocate it some swap space here.
> >  		 * Lazyfree page could be freed directly
> >  		 */
> > -		if (PageAnon(page) && PageSwapBacked(page)) {
> > +		if (PageAnon(page) && !__PageLazyFree(page)) {
> >  			if (!PageSwapCache(page)) {
> >  				if (!(sc->gfp_mask & __GFP_IO))
> >  					goto keep_locked;
> > @@ -1411,7 +1410,7 @@ static unsigned long shrink_page_list(struct list_head *page_list,
> >  			}
> >  		}
> >  
> > -		if (PageAnon(page) && !PageSwapBacked(page)) {
> > +		if (PageLazyFree(page)) {
> >  			/* follow __remove_mapping for reference */
> >  			if (!page_ref_freeze(page, 1))
> >  				goto keep_locked;
> > 
> 
> I still prefer something like
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index fd6d4670ccc3..7538501230bd 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -63,6 +63,10 @@
>   * page_waitqueue(page) is a wait queue of all tasks waiting for the page
>   * to become unlocked.
>   *
> + * PG_swapbacked used with anonymous pages (PageAnon()) indicates that a
> + * page is backed by swap. Anonymous pages without PG_swapbacked are
> + * pages that can be lazily freed (e.g., MADV_FREE) on demand.
> + *
>   * PG_uptodate tells whether the page's contents is valid.  When a read
>   * completes, the page becomes uptodate, unless a disk I/O error happened.
>   *
> 
> and really don't like the use of !__PageLazyFree() instead of PageSwapBacked().

I have to say that I do not have a strong opinion about helper
functions. In general I tend to be against adding them unless there is a
very good reason for them. This particular patch is in a gray zone a bit.

There are few places which are easier to follow but others sound like,
we have a hammer let's use it. E.g. shrink_page_list path above. There
is a clear comment explaining PageAnon && PageSwapBacked check being
LazyFree related but do I have to know that this is LazyFree path? I
believe that seeing PageSwapBacked has a more meaning to me because it
tells me that anonymous pages without a backing store doesn't really
need swap entry.  This happens to be Lazy free related today but with a
heavy overloading of our flags this might differ in the future. You have
effectively made a more generic description more specific without a very
good reason.

On the other hand having PG_swapbacked description in page-flags.h above
gives a very useful information which was previously hidden at the
definition so this is a clear improvement.

That being said I think that the patch is not helpful enough. I would
much rather see a simply documentation update.

-- 
Michal Hocko
SUSE Labs
