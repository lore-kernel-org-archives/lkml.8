Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FC1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB962073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579274995;
	bh=YZjp0Jv/FarwmXtpG/0zEGCWxqBdu5edCWKytIt56VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y/GZ9RjysZOxl6HreCjFCQx8zCeoA3heeZSYjymj74UJlY8xqM95Yw9pKbP/pOPOZ
	 J+k5Sx2YO9O6pl4LHDYFmsZ2gLdWBKd2o7Z9BbYmKDp+SBKQ38n+uVD9f+WHLYyOop
	 eGbetqsn/sFYer5brrZjwxvVWYFj+Hcz+/XlMNyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbgAQP3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:29:54 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41418 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728884AbgAQP3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:29:51 -0500
Received: by mail-wr1-f65.google.com with SMTP id c9so23121291wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 07:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6t3yfFexJC6Tl9V+RJRNT0Pk0BtQCTtgmeoaWvyr77Q=;
        b=lfjO/iql30aJpyVt91VkQgJoAWQtvNtkDBAaZ7s52zwylmjvD2rNjjbD2OQAggX3jw
         GRC21lXtfYWTc5rMrtuRCiiAi8iU3qc49c7qW0igMXks3apv71lc4HB7/pVpzTBvw6cB
         BhDZu6EUhWvioQ1+BuW/8nMi42vOy7aBOVGGldS4s2obn9AlqqxwyXi0DxxAwkfmCKKr
         ZD6xsvmq6BvwfjrGAWYtks92cAl+MS07AlXt/g/20UuQrUVyGBVfuRGRGMPBDNLlPjaT
         wvxdQJ5Z6XHGJn1q/kM93M47cwSq5TrvvQt8Bi7bMiJtHd/rIi8XiIFh0AFJqsuoHb5J
         J4cA==
X-Gm-Message-State: APjAAAVw6GZnx/ykpuuEDk28KuBHVXj6F9gdoG2pHOPS4O6lXw8ZMcfK
        y426UnWqyKNHjyCjkyhBIS0=
X-Google-Smtp-Source: APXvYqyx9Wp89eN6+iz3QNoVLr7ZRoTCY6IXaZ4nazRJW+ejjPTRYu84zeOl+BMdPqNUU7H/RJKwYA==
X-Received: by 2002:adf:f885:: with SMTP id u5mr3700551wrp.359.1579274988805;
        Fri, 17 Jan 2020 07:29:48 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id s15sm32021764wrp.4.2020.01.17.07.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 07:29:48 -0800 (PST)
Date:   Fri, 17 Jan 2020 16:29:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Allison Randal <allison@lohutok.net>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        lantianyu1986@gmail.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC v1] mm: is_mem_section_removable() overhaul
Message-ID: <20200117152947.GK19428@dhcp22.suse.cz>
References: <20200117105759.27905-1-david@redhat.com>
 <20200117113353.GT19428@dhcp22.suse.cz>
 <c82a0dd7-a99b-6def-83d4-a19fbdd405d9@redhat.com>
 <20200117145233.GB19428@dhcp22.suse.cz>
 <65606e2e-1cf7-de3b-10b1-33653cb41a52@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65606e2e-1cf7-de3b-10b1-33653cb41a52@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 15:58:26, David Hildenbrand wrote:
> On 17.01.20 15:52, Michal Hocko wrote:
> > On Fri 17-01-20 14:08:06, David Hildenbrand wrote:
> >> On 17.01.20 12:33, Michal Hocko wrote:
> >>> On Fri 17-01-20 11:57:59, David Hildenbrand wrote:
> >>>> Let's refactor that code. We want to check if we can offline memory
> >>>> blocks. Add a new function is_mem_section_offlineable() for that and
> >>>> make it call is_mem_section_offlineable() for each contained section.
> >>>> Within is_mem_section_offlineable(), add some more sanity checks and
> >>>> directly bail out if the section contains holes or if it spans multiple
> >>>> zones.
> >>>
> >>> I didn't read the patch (yet) but I am wondering. If we want to touch
> >>> this code, can we simply always return true there? I mean whoever
> >>> depends on this check is racy and the failure can happen even after
> >>> the sysfs says good to go, right? The check is essentially as expensive
> >>> as calling the offlining code itself. So the only usecase I can think of
> >>> is a dumb driver to crawl over blocks and check which is removable and
> >>> try to hotremove it. But just trying to offline one block after another
> >>> is essentially going to achieve the same.
> >>
> >> Some thoughts:
> >>
> >> 1. It allows you to check if memory is likely to be offlineable without
> >> doing expensive locking and trying to isolate pages (meaning:
> >> zone->lock, mem_hotplug_lock. but also, calling drain_all_pages()
> >> when isolating)
> >>
> >> 2. There are use cases that want to identify a memory block/DIMM to
> >> unplug. One example is PPC DLPAR code (see this patch). Going over all
> >> memory block trying to offline them is an expensive operation.
> >>
> >> 3. powerpc-utils (https://github.com/ibm-power-utilities/powerpc-utils)
> >> makes use of /sys/.../removable to speed up the search AFAIK.
> > 
> > Well, while I do see those points I am not really sure they are worth
> > having a broken (by-definition) interface.
> 
> It's a pure speedup. And for that, the interface has been working
> perfectly fine for years?
> 
> >  
> >> 4. lsmem displays/groups by "removable".
> > 
> > Is anybody really using that?
> 
> Well at least I am using that when testing to identify which
> (ZONE_NORMAL!) block I can easily offline/re-online (e.g., to validate
> all the zone shrinking stuff I have been fixing)
> 
> So there is at least one user ;)

Fair enough. But I would argue that there are better ways to do the same
solely for testing purposes. Rather than having a subtly broken code to
maintain.
 
> > 
> >>> Or does anybody see any reasonable usecase that would break if we did
> >>> that unconditional behavior?
> >>
> >> If we would return always "true", then the whole reason the
> >> interface originally was introduced would be "broken" (meaning, less
> >> performant as you would try to offline any memory block).
> > 
> > I would argue that the whole interface is broken ;). Not the first time
> > in the kernel development history and not the last time either. What I
> > am trying to say here is that unless there are _real_ usecases depending
> > on knowing that something surely is _not_ offlineable then I would just
> > try to drop the functionality while preserving the interface and see
> > what happens.
> 
> I can see that, but I can perfectly well understand why - especially
> powerpc - wants a fast way to sense which blocks actually sense to try
> to online.
> 
> The original patch correctly states
>    "which sections of
>     memory are likely to be removable before attempting the potentially
>     expensive operation."
> 
> It works as designed I would say.

Then I would just keep it crippled the same way it has been for years
without anybody noticing.
-- 
Michal Hocko
SUSE Labs
