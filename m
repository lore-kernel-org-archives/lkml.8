Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083F62072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591251189;
	bh=ELubEYedLnFO0+uLYeRyxu6ZG/oqFjiB5RTNPuP1v1w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Qt4rMG/fPhmHmMwyuu0M8ipNVey38gQXKBM7pNXQT7RI2kS2yVyGe10jhjv4fQ9mF
	 /575H4HE7dR6r6HsTTGMR5KVfkcdYwTyeOKH5+Y4ExptAdR/WiInoKLLNwc89qIocO
	 uaAS/pTRnojhWsB9nPEV+arlTXQhHNe+IR50i2+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbgFDGNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:13:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726683AbgFDGNH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:13:07 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CFFB2072E;
        Thu,  4 Jun 2020 06:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591251186;
        bh=ELubEYedLnFO0+uLYeRyxu6ZG/oqFjiB5RTNPuP1v1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sPuO+2+8k0wlpBMQ0gUj9HR/SXvl5+CrXld8p776D/G+4DfcdbkRFCd+yDKEIDnQd
         u67XTmCbj/LaBggwgqI9xRIM02zrIWlJsTNWXrLAK8/375V+hGIn9oityzFiTpv2Yk
         /Hg7P+WLRMINiOVr5OIbdtloV71Pb4h8cKC9VKP8=
Date:   Thu, 4 Jun 2020 08:13:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL for v5.8-rc1] media updates
Message-ID: <20200604081302.1a36f358@coco.lan>
In-Reply-To: <CAHk-=wg=CTtNrxPeFzkDw053dY3urchiyxevHnUXHhTGbK=9OQ@mail.gmail.com>
References: <20200603100559.2718efba@coco.lan>
        <CAHk-=wg=CTtNrxPeFzkDw053dY3urchiyxevHnUXHhTGbK=9OQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 3 Jun 2020 21:13:21 -0700
Linus Torvalds <torvalds@linux-foundation.org> escreveu:

> On Wed, Jun 3, 2020 at 1:06 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > PS.: The diffstat is so big that I almost dropped it, as it is almost
> > useless for humans to read. I ended by not doing it just because perhaps
> > you could be using some sort of script to check diffstat.  
> 
> No, but I do compare the basics, and you don't have to more than scan
> it to see that "ok, it only touches area xyz".

Ok.

> And it turns out that it is huge for you partly because you have the
> default (fairly low) git rename detection limits, in order to avoid
> using a lot of CPU or memory for rename detection.
> 
> So you get:
> 
> >  2181 files changed, 260633 insertions(+), 106012 deletions(-)  
> 
> while I get
> 
>  1698 files changed, 161922 insertions(+), 7301 deletions(-)
> 
> which is a noticeable difference. Still a big diffstat, but quite a
> bit smaller than yours.
> 
> You also get a _lot_ more noise in the form of "create mode xyz" and
> "delete mode abc" notices, while for me a lot of them are just "rename
> abc => xyz". So there's a double whammy for you.
> 
> The reason is that your diff only has renames for the 100% matches like this:
> 
> >  rename Documentation/{media/v4l-drivers => admin-guide/media}/au0828-cardlist.rst (100%)  
> 
> which git can detect purely by seeing "oh, same exact SHA1".
> 
> But you don't have any non-100% renames.
> 
> In contrast, the diffstat I see also has the inexact renames like
> 
>  rename Documentation/{media/v4l-drivers =>
> admin-guide/media}/bttv-cardlist.rst (99%)
>  rename Documentation/{media/v4l-drivers => admin-guide/media}/bttv.rst (79%)
> 
> because I have done
> 
>    git config diff.renamelimit 0
> 
> to make the rename detection limit be infinite (alternatively, just
> edit your ~/.gitconfig file manually - it's often easier than
> remembering what the "git config" syntax is).
> 
> You want to see
> 
>   [diff]
>         renamelimit = 0
> 
> in your ~/.gitconfig file (or, alternatively, if you want the setting
> to be per-repo, in your .git/config file in your repository).
> 
> The default git limits for "should I spend CPU time and memory on
> detecting inexact renames" are fairly low, because people use git on
> fairly low-end machines.

I'm using renamelimit = 0 on one of my trees (the one I'm using for
the ReST conversion), and I even use -M1 there when sending patches
to docs (as some of the conversions require lots of indentation 
changes, for example, on files with lots of ascii artwork), but on
my merge tree, I was using some limit, as it is not common to have
this huge amount of changes.

> I bet your development machine isn't some kind of low-end toy, and
> rename detection is not _that_ expensive.

Probably not as nice as yours, but it is a comfortable machine,
with 32 GB RAM, an i7-8705G CPU and a fast SSD disk. 

Changing it to unlimited limit costed almost nothing here:

	real	0m1,210s
	user	0m1,009s
	sys	0m0,190s

I'll use this from now on. Thanks for the tip!

Thanks,
Mauro
