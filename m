Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DFEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A25E2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583388880;
	bh=+FpE/LMdtG5BhsGwvEKqTJMLpXq5lLNK2BRtoZJXypY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=qbpK9dCoTpT1XZ3NlykUhFJcyDrDom8OOLO6tNp3f+EbombcPVyiE+WTSQNwEtOut
	 Hhq77ANwCtCjE7RYmhB7eUa861PmDsUL/MZCHVtuJSp1m1dmmp2LYBGLMTJ1KZnD1k
	 BS/RNBUoxKeAEkt9V3AR3K3j+RrKZTgwOSMOXxOE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgCEGOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:14:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgCEGOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:14:38 -0500
Received: from coco.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18AB82073D;
        Thu,  5 Mar 2020 06:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583388877;
        bh=+FpE/LMdtG5BhsGwvEKqTJMLpXq5lLNK2BRtoZJXypY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HXXu8yPyVZYJa0yyyg+lJOIoxLTTughoUgC4k7QnWRZBwSzNMw1DS7kTqKqnZe6hv
         WxxD5eV6NZpJk9ckOzWL6vCUwIwkf31t9il/hx8YDxhpWEo4VVqG9x1PPqD996SJZl
         vbJd7CIlOn6GESTas7M/VBoZAnU0RZKsW/ouPjpk=
Date:   Thu, 5 Mar 2020 07:14:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust to filesystem doc ReST conversion
Message-ID: <20200305071431.66362e3c@coco.lan>
In-Reply-To: <ed040dd417d578e1ab4491d116c6ac1431142385.camel@perches.com>
References: <20200304072950.10532-1-lukas.bulwahn@gmail.com>
        <20200304131035.731a3947@lwn.net>
        <20200304212846.0c79c6da@coco.lan>
        <ed040dd417d578e1ab4491d116c6ac1431142385.camel@perches.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 04 Mar 2020 13:24:48 -0800
Joe Perches <joe@perches.com> escreveu:

> On Wed, 2020-03-04 at 21:28 +0100, Mauro Carvalho Chehab wrote:
> > Em Wed, 4 Mar 2020 13:10:35 -0700
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >   
> > > On Wed,  4 Mar 2020 08:29:50 +0100
> > > Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > >   
> > > > Mauro's patch series <cover.1581955849.git.mchehab+huawei@kernel.org>
> > > > ("[PATCH 00/44] Manually convert filesystem FS documents to ReST")
> > > > converts many Documentation/filesystems/ files to ReST.
> > > > 
> > > > Since then, ./scripts/get_maintainer.pl --self-test complains with 27
> > > > warnings on Documentation/filesystems/ of this kind:
> > > > 
> > > >   warning: no file matches F: Documentation/filesystems/...
> > > > 
> > > > Adjust MAINTAINERS entries to all files converted from .txt to .rst in the
> > > > patch series and address the 27 warnings.
> > > > 
> > > > Link: https://lore.kernel.org/linux-erofs/cover.1581955849.git.mchehab+huawei@kernel.org
> > > > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > > > ---
> > > > Mauro, please ack.
> > > > Jonathan, pick pick this patch for doc-next.    
> > > 
> > > Sigh, I need to work a MAINTAINERS check into my workflow...
> > > 
> > > Thanks for fixing these, but ... what tree did you generate the patch
> > > against?  I doesn't come close to applying to docs-next.  
> > 
> > I'm starting to suspect that maybe the best workflow would be to just 
> > apply the patches at docs-next keeping links broken, and then run
> > ./scripts/documentation-file-ref-check --fix by the end of a merge
> > window, addressing such breakages.  
> 
> I'm not sure at all that that script will always do the
> right thing with MAINTAINERS,

As it is based on some heuristics, whomever runs it should
double-check the results.

> but it seems to work OK
> except for some renames where a .txt file was directly
> renamed to a .rst file in the same directory where there
> was a similarly named file in a different directory.

Yeah, the script could be smarter to catch this case.

> Likely the direct rename of a filename extension from
> .txt to .rst should always be applied by the script.

Yeah, makes sense to me. Yet, I got one exception for this:
I found somewhere a case were there are both foo.txt and foo.rst,
both with different contents.

The solution I took were to rename foo.txt to bar.txt,
adjusting the cross-references, then convert bar.txt to
bar.rst.

In any case, we're close to finish the conversion. I have
already patches that convert everything to .rst (with a couple of
exceptions), and I took the care of doing the cross-reference fixes 
there. I'm still adjusting some things on this tree. My current plans
are to have them all applied up to Kernel 5.8, and then start looking
on better organizing the docs (I'm already doing that for media docs).

Once all of those patches get merged, .txt -> .rst will
be an exception.

> 
> Anyway, for -next as of today:
> 
> $ git diff --shortstat
>  64 files changed, 116 insertions(+), 116 deletions(-)
> 
> > There are usually lots of churn outside the merge window.
> > 
> > Another alternative would be to split the MAINTAINERS file on a
> > per-subsystem basis. If I remember well, someone proposed this once at
> > LKML. I vaguely remember that there were even a patch (or RFC)
> > adding support for such thing for get_maintainers.pl.  
> 
> Yeah.  get_maintainer.pl does work if the MAINTAINERS
> file is split up a few different ways.
> 
> There was also a tool to do the MAINTAINERS split.
> https://lore.kernel.org/patchwork/patch/817857/
> 
> I doubt that would matter at all given today's tools and
> the general mechanisms of maintainers renaming files and
> not running checkpatch in the first place.

Yeah, it may not produce any concrete results on some parts.
It may help to reduce the conflicts there, though. Also, I guess
some maintainers will take more care, if they start to have
their own */MAINTAINERS files.

Thanks,
Mauro
