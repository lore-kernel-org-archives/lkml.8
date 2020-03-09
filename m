Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B87C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 04:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6264120665
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 04:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgCIEwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 00:52:51 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:36497 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgCIEwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 00:52:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4D777837F24A;
        Mon,  9 Mar 2020 04:52:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: note65_52936ebc40606
X-Filterd-Recvd-Size: 2288
Received: from XPS-9350.home (unknown [47.154.118.177])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon,  9 Mar 2020 04:52:47 +0000 (UTC)
Message-ID: <84f3c9891d4e89909d5537f34ea9d75de339c415.camel@perches.com>
Subject: Re: [PATCH] mm: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org
Date:   Sun, 08 Mar 2020 21:51:07 -0700
In-Reply-To: <20200309041551.GA1765@jagdpanzerIV.localdomain>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
         <20200308031825.GB1125@jagdpanzerIV.localdomain>
         <5f297e8995b22c9ccf06d4d0a04f7d9a37d3cd77.camel@perches.com>
         <20200309041551.GA1765@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 13:15 +0900, Sergey Senozhatsky wrote:
> On (20/03/07 19:54), Joe Perches wrote:
> > On Sun, 2020-03-08 at 12:18 +0900, Sergey Senozhatsky wrote:
> > > On (20/03/06 23:58), Joe Perches wrote:
> > > [..]
> > > > --- a/mm/mempolicy.c
> > > > +++ b/mm/mempolicy.c
> > > > @@ -907,7 +907,6 @@ static void get_policy_nodemask(struct mempolicy *p, nodemask_t *nodes)
> > > >  
> > > >  	switch (p->mode) {
> > > >  	case MPOL_BIND:
> > > > -		/* Fall through */
> > > >  	case MPOL_INTERLEAVE:
> > 
> > Consecutive case labels do not need an interleaving fallthrough;
> > 
> > ie: ditto
> 
> I see. Shall this be mentioned in the commit message, maybe?

<shrug, maybe>  I've no real opinion about that necessity.

fallthrough commments are relatively rarely used as a
separating element between case labels.

It's by far most common to just have consecutive case labels
without any other content.

It's somewhere between 500:1 to 1000:1 in the kernel.



