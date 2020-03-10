Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80ACC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEC3F24692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgCJLMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:12:14 -0400
Received: from smtprelay0006.hostedemail.com ([216.40.44.6]:42301 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726186AbgCJLMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:12:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E15B6837F24D;
        Tue, 10 Mar 2020 11:12:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: worm72_6a6262640771f
X-Filterd-Recvd-Size: 2949
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Mar 2020 11:12:10 +0000 (UTC)
Message-ID: <7e2471ed71a42d74c0dbd9f2197034f5163d0eda.camel@perches.com>
Subject: Re: [PATCH] mm: Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Date:   Tue, 10 Mar 2020 04:10:29 -0700
In-Reply-To: <20200309064806.GB46830@google.com>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
         <20200308031825.GB1125@jagdpanzerIV.localdomain>
         <5f297e8995b22c9ccf06d4d0a04f7d9a37d3cd77.camel@perches.com>
         <20200309041551.GA1765@jagdpanzerIV.localdomain>
         <84f3c9891d4e89909d5537f34ea9d75de339c415.camel@perches.com>
         <20200309062046.GA46830@google.com> <20200309064806.GB46830@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-09 at 15:48 +0900, Sergey Senozhatsky wrote:
> On (20/03/09 15:20), Sergey Senozhatsky wrote:
> [..]
> > > <shrug, maybe>  I've no real opinion about that necessity.
> > > 
> > > fallthrough commments are relatively rarely used as a
> > > separating element between case labels.
> > > 
> > > It's by far most common to just have consecutive case labels
> > > without any other content.
> > > 
> > > It's somewhere between 500:1 to 1000:1 in the kernel.
> > 
> > I thought that those labels were used by some static code analysis
> > tools, so that the removal of some labels raised questions. But I
> > don't think I have opinions otherwise.
> 
> ... I guess GCC counts as a static code analysis tool :)
> 
> Looking at previous commits, people wanted to have proper 'fall through'
> 
> 
>     Replace "fallthru" with a proper "fall through" annotation.
>     This fix is part of the ongoing efforts to enabling
>     -Wimplicit-fallthrough
> 
> ---
> 
> -       case ZPOOL_MM_RW: /* fallthru */
> +       case ZPOOL_MM_RW: /* fall through */

That conversion was unnecessary.
(there are still 6 /* fallthru */ comments in today's kernel)

There are tens of thousands of consecutive case labels without
interleaving fallthrough comments in the kernel like:

	switch (foo) {
	case BAR:
	case BAZ:
		do_something();
		break;
	default:
		something_else();
		break;
	}

So gcc and clang handle consecutive cases without fallthrough
without uselessly emitting warnings just fine.

