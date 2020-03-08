Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCF3C10F25
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 03:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71E2206D5
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 03:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgCHDUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 22:20:45 -0500
Received: from smtprelay0208.hostedemail.com ([216.40.44.208]:39390 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726174AbgCHDUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 22:20:45 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E3356180A5B05;
        Sun,  8 Mar 2020 03:20:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: night89_5d7274ac97a01
X-Filterd-Recvd-Size: 1736
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 03:20:42 +0000 (UTC)
Message-ID: <bfc9f9b69681c3ef285bf11b6506fa5b42b5917a.camel@perches.com>
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
Date:   Sat, 07 Mar 2020 19:19:04 -0800
In-Reply-To: <20200308031634.GA1125@jagdpanzerIV.localdomain>
References: <f62fea5d10eb0ccfc05d87c242a620c261219b66.camel@perches.com>
         <20200308031634.GA1125@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 12:16 +0900, Sergey Senozhatsky wrote:
> On (20/03/06 23:58), Joe Perches wrote:
> [..]
> > --- a/mm/zsmalloc.c
> > +++ b/mm/zsmalloc.c
> > @@ -424,7 +424,7 @@ static void *zs_zpool_map(void *pool, unsigned long handle,
> >  	case ZPOOL_MM_WO:
> >  		zs_mm = ZS_MM_WO;
> >  		break;
> > -	case ZPOOL_MM_RW: /* fall through */
> > +	case ZPOOL_MM_RW:
> >  	default:
> >  		zs_mm = ZS_MM_RW;
> >  		break;
> 
> Seems like missing fallthrough; for ZPOOL_MM_RW?

Consecutive case labels do not need an interleaving fallthrough


