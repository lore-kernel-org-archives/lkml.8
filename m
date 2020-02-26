Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D95C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E4D21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582708466;
	bh=vWt+x/oO0f54c1axhxBUadcsxr+FHREBDjj0oWw95qA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AIHG+W/39G+ycEiqO1G+VjL0pp1F3pUv5lx+lKEEJOHFTuMdvTfl09Va8VPI/lF/l
	 m7eGFT8vOWK7bkKXCPeXZB/diABSrgQWp3h0W2O1Jj/x8IHKxopYvRKnH0rqAKzZxF
	 uX5zbwxpV5AkTFGp1w/AlI6lqmsSi91ZRnnL9lwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBZJOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:14:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34047 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgBZJOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:14:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id z15so2019280wrl.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 01:14:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=90Gaup4GBl/WZhK+7p3+YI0kruzLG0IEp7O26cMJO1E=;
        b=OjjG5NdjjvXoXxveLrFLJgIAF8XcsBwYf/hyD9u3TR4xM0MB+6wHciuWyOu7N4fklx
         hPU6Lf74lqeNBCNP/YCfwNrm3CD7mU+LJLlKjdID+dVWWD7SV2/mlF3yEhUuGrA9nH3G
         RzEYCEXab0NSzdbuSRcLcn4F7Z2EaLrgJgbjE+C3Kc7+GxcXkl0PbuTYlFyDNuN47+Io
         ow/OgMxHaMQBdUDWD3WVA6gwIKLNwLK5trjYRoHkP5KK6gtAOJToKODhQXsrglcJSQcH
         RzE+ujJF829XIiHmp4Q6UhjpATYUo+ngPMkuNL/Shrv8GCMEVM6DOx2sCL0EzcJblkeD
         aVDw==
X-Gm-Message-State: APjAAAXcNdfWff/0axflgE6iZDnghLJZ2o7qkEz2fhAW/wp9BEnx8QEf
        aIaqFpvOQQxWHLJzYHJcgNk=
X-Google-Smtp-Source: APXvYqyU+AFLfI6C9bXoMHUATVgRno4Q4tuyNnRlEGnnnzJUedVksiuvqUK1i8VPkH85h89Js03b8g==
X-Received: by 2002:adf:ecc2:: with SMTP id s2mr4382833wro.263.1582708462718;
        Wed, 26 Feb 2020 01:14:22 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id o15sm2430534wra.83.2020.02.26.01.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 01:14:22 -0800 (PST)
Date:   Wed, 26 Feb 2020 10:14:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, osalvador@suse.de,
        dan.j.williams@intel.com, rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/7] mm/hotplug: Only use subsection map in VMEMMAP
 case
Message-ID: <20200226091421.GE3771@dhcp22.suse.cz>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220103849.GG20509@dhcp22.suse.cz>
 <20200221142847.GG4937@MiWiFi-R3L-srv>
 <75b4f840-7454-d6d0-5453-f0a045c852fa@redhat.com>
 <20200225100226.GM22443@dhcp22.suse.cz>
 <20200226034236.GD24216@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226034236.GD24216@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-02-20 11:42:36, Baoquan He wrote:
> On 02/25/20 at 11:02am, Michal Hocko wrote:
> > On Tue 25-02-20 10:10:45, David Hildenbrand wrote:
> > > >>>  include/linux/mmzone.h |   2 +
> > > >>>  mm/sparse.c            | 178 +++++++++++++++++++++++++++++------------
> > > >>>  2 files changed, 127 insertions(+), 53 deletions(-)
> > > >>
> > > >> Why do we need to add so much code to remove a functionality from one
> > > >> memory model?
> > > > 
> > > > Hmm, Dan also asked this before.
> > > > 
> > > > The adding mainly happens in patch 2, 3, 4, including the two newly
> > > > added function defitions, the code comments above them, and those added
> > > > dummy functions for !VMEMMAP.
> > > 
> > > AFAIKS, it's mostly a bunch of newly added comments on top of functions.
> > > E.g., the comment for fill_subsection_map() alone spans 12 LOC in total.
> > > I do wonder if we have to be that verbose. We are barely that verbose on
> > > MM code (and usually I don't see much benefit unless it's a function
> > > with many users from many different places).
> > 
> > I would tend to agree here. Not that I am against kernel doc
> > documentation but these are internal functions and the comment doesn't
> > really give any better insight IMHO. I would be much more inclined if
> > this was the general pattern in the respective file but it just stands
> > out.
> 
> I saw there are internal functions which have code comments, e.g
> shrink_slab() in mm/vmscan.c, not only this one place, there are several
> places. I personally prefer to see code comment for function if
> possible, this can save time, e.g people can skip the bitmap operation
> when read code if not necessary. And here I mainly want to tell there
> are different returned value to note different behaviour when call them.

... yet nobody really cares about different return code. It is an error
that is propagated up the call chain and that's all.

I also like when there is a kernel doc comment that helps to understand
the intented usage, context the function can be called from, potential
side effects, locking requirements and other details people need to know
when calling functions. But have a look at 
/**
 * clear_subsection_map - Clear subsection map of one memory region
 *
 * @pfn - start pfn of the memory range
 * @nr_pages - number of pfns to add in the region
 *
 * This is only intended for hotplug, and clear the related subsection
 * map inside one section.
 *
 * Return:
 * * -EINVAL	- Section already deactived.
 * * 0		- Subsection map is emptied.
 * * 1		- Subsection map is not empty.
 */

the only useful information in here is that this is a hotplug stuff but
I would be completely lost about the intention without already knowing
what is this whole subsection about.

-- 
Michal Hocko
SUSE Labs
