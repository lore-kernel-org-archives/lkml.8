Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C99C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C67620A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEGRXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:23:10 -0400
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:43056 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGRXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:23:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1F229180171A8;
        Thu,  7 May 2020 17:23:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bikes15_1b6dd87a96010
X-Filterd-Recvd-Size: 2375
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 17:23:08 +0000 (UTC)
Message-ID: <acb0794c5ba71b4d6ddc0b6a71252a4dfbfd497d.camel@perches.com>
Subject: Re: [PATCH] MAINTAINER: Update my email address
From:   Joe Perches <joe@perches.com>
To:     himanshu.madhani@oracle.com, linux-kernel@vger.kernel.org
Date:   Thu, 07 May 2020 10:23:07 -0700
In-Reply-To: <0c9af33d-0101-119b-4512-7838a0e0e9a0@oracle.com>
References: <20200507161229.31448-1-himanshu.madhani@oracle.com>
         <f83a2eb7013d203eab4be27f27ca0d996bbc5b47.camel@perches.com>
         <0c9af33d-0101-119b-4512-7838a0e0e9a0@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 12:08 -0500, himanshu.madhani@oracle.com wrote:
> 
> On 5/7/20 11:57 AM, Joe Perches wrote:
> > On Thu, 2020-05-07 at 11:12 -0500, Himanshu Madhani wrote:
> > > I do not have access to my @marvell.com email ID anymore.
> > > Lets map my new email address correctly in .mailmap
> > 
> > Bad patch subject, this is a .mailmap patch.
> > 
> > Maybe [PATCH] .mailmap: Update address of Himanshu Madhani
> > 
> 
> Okay. Thanks for pointing that out. I noticed that most of the patches 
> submitted for .mailmap had MAINTAINER in there so i used that. I will 
> repost with updated patch subject.

That's because those patches also generally update MAINTAINERS
entries and update .mailmap at the same time.

cheers, Joe

> > > Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
> > > ---
> > >   .mailmap | 2 ++
> > >   1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/.mailmap b/.mailmap
> > > index db3754a41018..30d8c3f10ca7 100644
> > > --- a/.mailmap
> > > +++ b/.mailmap
> > > @@ -99,6 +99,8 @@ Henk Vergonet <Henk.Vergonet@gmail.com>
> > >   Henrik Kretzschmar <henne@nachtwindheim.de>
> > >   Henrik Rydberg <rydberg@bitmath.org>
> > >   Herbert Xu <herbert@gondor.apana.org.au>
> > > +Himanshu Madhani <himanshu.madhani@oracle.com>
> > > +Himanshu Madhani <hmadhani2024@gmail.com>
> > >   Jacob Shin <Jacob.Shin@amd.com>
> > >   Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@google.com>
> > >   Jaegeuk Kim <jaegeuk@kernel.org> <jaegeuk@motorola.com>

