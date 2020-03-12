Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EEDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F818206CD
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584045724;
	bh=IldsoTcaVed1weQXV1+e3dg6rmvKBGnpRg1cPXS+l7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uR+6LiGAtXwCMfwRS7uAGMy8lDzzdT/iYSZIz/c73JrT9PoIAg00MPsxtPO9Zdb5l
	 JWkazklJXsaWTNVuYgrO/CALqOvY9HyXDXZofiUkvi84x4Lj07jehxPxu7hCNs6GlI
	 uA+3C5M4v18N7uhsqMYFX5Irjx4heQ1p7KJrWdtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgCLUmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:42:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36492 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgCLUmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:42:02 -0400
Received: by mail-wr1-f65.google.com with SMTP id s5so9312253wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 13:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GOyUPEGrvjCpyOnL6OSyyemn025t1zSIlLcVN5M0V8=;
        b=jJFbJQHW9PABx08d+NHvqYDUcYv7VZ+u9wNrxWJShuSGw7xVDRRjSypYzUlkStPd4H
         9/fasxAjDLpZNnl+VvjtxXfKXwOgBXYSQOUJhz8db4uYqTeRJv4N76FgrhBJ8DsNzhz2
         Uypxq0Ew1J8S1oMEUWJ5WUpgZxDAPm5onS2FDRBLpad1i9zk/88AGC1EJONlgdzVz3Ob
         d+SmuXggyQKYb7vMZq9Gi9GjQTlQH8RhOmgTZqas5xQjHEJfp+w04TyUUZB9wRaanL8C
         ka7v7kKMLgShnQEYK6IsKk6azqG9DG8CkGdShv+yZX4bbquGIc7vPXMkWQ2qxA6tsrys
         fS+A==
X-Gm-Message-State: ANhLgQ0Jf95lNmCIrgtXOCgs5Xa993XTAYRemv1v0AqsVvOqE2QGq4Mo
        aUVNnSsf2S5zEtdKxDq7d2Q=
X-Google-Smtp-Source: ADFU+vvb04mJu44wUMzDGo4x9i4vJFR2V4homWxXiGO5dwhURp2Z2ZjgGJOqj2JJS+4T0phUZl0Wsg==
X-Received: by 2002:adf:fa8d:: with SMTP id h13mr3378044wrr.155.1584045720413;
        Thu, 12 Mar 2020 13:42:00 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id r23sm20870015wrr.93.2020.03.12.13.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 13:41:59 -0700 (PDT)
Date:   Thu, 12 Mar 2020 21:41:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200312204155.GE23944@dhcp22.suse.cz>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200312082248.GS23944@dhcp22.suse.cz>
 <20200312201602.GA68817@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312201602.GA68817@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-03-20 13:16:02, Minchan Kim wrote:
> On Thu, Mar 12, 2020 at 09:22:48AM +0100, Michal Hocko wrote:
[...]
> > From eca97990372679c097a88164ff4b3d7879b0e127 Mon Sep 17 00:00:00 2001
> > From: Michal Hocko <mhocko@suse.com>
> > Date: Thu, 12 Mar 2020 09:04:35 +0100
> > Subject: [PATCH] mm: do not allow MADV_PAGEOUT for CoW pages
> > 
> > Jann has brought up a very interesting point [1]. While shared pages are
> > excluded from MADV_PAGEOUT normally, CoW pages can be easily reclaimed
> > that way. This can lead to all sorts of hard to debug problems. E.g.
> > performance problems outlined by Daniel [2]. There are runtime
> > environments where there is a substantial memory shared among security
> > domains via CoW memory and a easy to reclaim way of that memory, which
> > MADV_{COLD,PAGEOUT} offers, can lead to either performance degradation
> > in for the parent process which might be more privileged or even open
> > side channel attacks. The feasibility of the later is not really clear
> 
> I am not sure it's a good idea to mention performance stuff because
> it's rather arguble. You and Johannes already pointed it out when I sbumit
> early draft which had shared page filtering out logic due to performance
> reason. You guys suggested the shared pages has higher chance to be touched
> so that if it's really hot pages, that whould keep in the memory. I agree.

Yes, the hot memory is likely to be referenced but the point was an
unexpected latency because of the major fault. I have to say that I have
underestimated the issue because I was not aware of runtimes mentioned
in the referenced links. Essentially a lot of CoW memory shared over
security domains.

> I think the only reason at this moment is just vulnerability.
> 
> > to me TBH but there is no real reason for exposure at this stage. It
> > seems there is no real use case to depend on reclaiming CoW memory via
> > madvise at this stage so it is much easier to simply disallow it and
> > this is what this patch does. Put it simply MADV_{PAGEOUT,COLD} can
> > operate only on the exclusively owned memory which is a straightforward
> > semantic.
> > 
> > [1] http://lkml.kernel.org/r/CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com
> > [2] http://lkml.kernel.org/r/CAKOZueua_v8jHCpmEtTB6f3i9e2YnmX4mqdYVWhV4E=Z-n+zRQ@mail.gmail.com
> > 
> > Signed-off-by: Michal Hocko <mhocko@suse.com>
> > ---
> >  mm/madvise.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 43b47d3fae02..4bb30ed6c8d2 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -335,12 +335,14 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> >  		}
> >  
> >  		page = pmd_page(orig_pmd);
> > +
> > +		/* Do not interfere with other mappings of this page */
> 
> 
> How about this?
> /*
>  * paging out only single mapped private pages for anonymous mapping,
>  * otherwise, it opens a side channel.
>  */

I am not sure this is much more helpful without a larger context. I
would stick with the wording unless you insist.
 
> Otherwise, looks good to me.

Thanks for the review.

-- 
Michal Hocko
SUSE Labs
