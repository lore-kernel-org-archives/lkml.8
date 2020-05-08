Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B26FC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B9E208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbgEHJUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:20:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:34438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbgEHJUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:20:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4FDBFB020;
        Fri,  8 May 2020 09:20:07 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 70DEF1E12A6; Fri,  8 May 2020 11:20:03 +0200 (CEST)
Date:   Fri, 8 May 2020 11:20:03 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Tan Hu <tan.hu@zte.com.cn>, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] lib/flex_proportions.c: aging counts when fraction
 smaller than max_frac/FPROP_FRAC_BASE
Message-ID: <20200508092003.GC20446@quack2.suse.cz>
References: <1588746088-38605-1-git-send-email-tan.hu@zte.com.cn>
 <20200507164614.4a816d2aa1b341be937b128a@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507164614.4a816d2aa1b341be937b128a@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for CC Andrew.

On Thu 07-05-20 16:46:14, Andrew Morton wrote:
> On Wed, 6 May 2020 14:21:28 +0800 Tan Hu <tan.hu@zte.com.cn> wrote:
> 
> > If the given type has fraction smaller than max_frac/FPROP_FRAC_BASE,
> > __fprop_inc_percpu_max should follow the design formula and aging
> > fraction too.
> > 
> > Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
> > ---
> >  lib/flex_proportions.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> > index 7852bfff5..451543937 100644
> > --- a/lib/flex_proportions.c
> > +++ b/lib/flex_proportions.c
> > @@ -266,8 +266,7 @@ void __fprop_inc_percpu_max(struct fprop_global *p,
> >  		if (numerator >
> >  		    (((u64)denominator) * max_frac) >> FPROP_FRAC_SHIFT)
> >  			return;
> > -	} else
> > -		fprop_reflect_period_percpu(p, pl);
> > -	percpu_counter_add_batch(&pl->events, 1, PROP_BATCH);
> > -	percpu_counter_add(&p->events, 1);
> > +	}
> > +
> > +	__fprop_inc_percpu(p, pl);

So the code is actually correct as is because if max_frac <
FPROP_FRAC_BASE, we call fprop_fraction_percpu() which calls
fprop_reflect_period_percpu(). So the 'else' is there to avoid calling the
function twice. That being said calling fprop_reflect_period_percpu() twice
as we would with your patch does no big harm as we'd just quickly bail on
pl->period == p->period test. So I think the code is easier to understand
the way you suggest without significant downside. But please update the
changelog to explain that this is just code cleanup (with the above
reasoning) and not a functional fix.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
