Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C8DC4BA1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9D224680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582738870;
	bh=7kHgEXUo3PkgLaDNy9BpjMW8nofraIVcGxHrX27TYGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LafUTsvkpwRTngPGkTsRt8tgqJyJMzEi5X/3LLOW3YfqC2o2wlgSKSDiZkWbNo8dP
	 LsJsl2RGJCyMmKlj9P0hAQX2JKBw+OydcVmPVg86GFtpWPIMFvtYXa+FOgRhGxvb4X
	 iUatu9eLHMyCrCMssKG4uZ5D+1neWxPQ/xpgkjGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgBZRlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:41:09 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54891 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgBZRlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:41:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id z12so143298wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GLdXH3d/s4CzQ24AaP/4zwhvm9lsjM7QDg7JcTBxQ2M=;
        b=V4i4OJoXKeHm/Fj0ckpzwWzn6GHKN0nUgwAkoPJcgP2q7jRU1rm+GHMM8iZf+h8sLx
         pvjpJ3iKFpY8p+uSu/AgooNFMOZ1koHN17hcncelAQn3RbDTLnNS1voAQMSfeC1Ie50f
         CYKCYZ/dfIqwIYXpmNyoi+kDM3D2FVVmRwFf0K/nSnM0xBYqYXajq3C0RKZRB/YpBd8v
         8vUQixdrZ0TtDGRUpxFiegmIRcxokD83lSRxawWg1GGjIg3pATMWK2rYQvmB+2dhq6uL
         HRG320hzQSthwXlRdeI226wIkMGRSyhkWOS4gcQLeFaBvCiIRjWrBoRcM9RzIrQIOVnA
         b7uw==
X-Gm-Message-State: APjAAAWUeddIUbeerIa9KO9mfGYZ5PpYcC2wbw3hso4OjOcqVrPT4lTj
        fb5FuObvpQikwxqPMvs8XPE=
X-Google-Smtp-Source: APXvYqylpyZuiLHPl0bgj+fB2vFtlDLbErc4bIIPVmc3BqJ2X95+q5TE1XNn04SZE/cv5ArUb+5fUg==
X-Received: by 2002:a7b:cc82:: with SMTP id p2mr6474200wma.159.1582738866620;
        Wed, 26 Feb 2020 09:41:06 -0800 (PST)
Received: from localhost (ip-37-188-190-100.eurotel.cz. [37.188.190.100])
        by smtp.gmail.com with ESMTPSA id e1sm4136706wrt.84.2020.02.26.09.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:41:05 -0800 (PST)
Date:   Wed, 26 Feb 2020 18:41:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200226174104.GO3771@dhcp22.suse.cz>
References: <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain>
 <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain>
 <20200221080737.GK20509@dhcp22.suse.cz>
 <20200221210824.GA3605@sultan-book.localdomain>
 <20200225090945.GJ22443@dhcp22.suse.cz>
 <CALvZod6MW62-+nEw-d0jKxFK9mspOY_tt2JRTDYOrOVyM9_QHw@mail.gmail.com>
 <20200226090853.GC3771@dhcp22.suse.cz>
 <CALvZod7BDcHTNY1-yc041nZnKHR2Wo0R-=QXAOYOUEPeyQG4DA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7BDcHTNY1-yc041nZnKHR2Wo0R-=QXAOYOUEPeyQG4DA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-02-20 09:00:57, Shakeel Butt wrote:
> On Wed, Feb 26, 2020 at 1:08 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 25-02-20 14:30:03, Shakeel Butt wrote:
> > > On Tue, Feb 25, 2020 at 1:10 AM Michal Hocko <mhocko@kernel.org> wrote:
> > > >
> > > [snip]
> > > >
> > > > The proper fix should, however, check the amount of reclaimable pages
> > > > and back off if they cannot meet the target IMO. We cannot rely on the
> > > > general reclaimability here because that could really be thrashing.
> > > >
> > >
> > > "check the amount of reclaimable pages" vs "cannot rely on the general
> > > reclaimability"? Can you clarify?
> >
> > kswapd targets the high watermark and if your reclaimable memory (aka
> > zone_reclaimable_pages) is lower than the high wmark then it cannot
> > simply satisfy that target, right? Keeping reclaim in that situations
> > seems counter productive to me because you keep evicting pages that
> > might be reused without any feedback mechanism on the actual usage.
> > Please see my other reply.
> >
> 
> I understand and agree with the argument that if reclaimable pages are
> less than high wmark then no need to reclaim. Regarding not depending
> on general reclaimability, I thought you meant that even if
> reclaimable pages are over high wmark, we might not want to continue
> the reclaim to not cause thrashing. Is that right?

That is a completely different story. I would stick with the pathological
problem reported here.  General threshing problem is much more complex
and harder to provide a solution for without introducing a lot of policy
into the reclaim.
-- 
Michal Hocko
SUSE Labs
