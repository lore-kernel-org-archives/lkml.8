Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F516C433F8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54D18207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594910399;
	bh=8iw2omV+8rcbIE2y5sg+rVi5KY6cy+c5PEsFn625WuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RRZKF7omK1Y5ElcqW1WcSf25cFH9Cd6sgrfKCgIc+upZrIcct29hfyxknC44z9xjH
	 UtecBr+9Tp444Aqf5w+eaZFqr/jFwRgbcH3BSrVrj0mzi9uV5mv6rR8qU4C5DQaKd5
	 COdbOxTeewi7kaldkrQ5HCKKE7o4SVOka1wqksw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgGPOj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:39:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:56378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728589AbgGPOj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:39:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 921A5206F4;
        Thu, 16 Jul 2020 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594910396;
        bh=8iw2omV+8rcbIE2y5sg+rVi5KY6cy+c5PEsFn625WuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTqQV6KUMnjpRsu1sz4//WWIEsxgic8HNIIfQe05WfEVGsAvcynFS7DsrPSkizuIB
         MzjhcxIOYPk1cDld8mdlE/11Pi2/xcEneZ9IDPOckuftgUI2K2hKFrWyHzAR8Yim71
         nPKtVOpo6CY6nidbg3xc87XIG6JxJWCx55F8urts=
Date:   Thu, 16 Jul 2020 16:39:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     B K Karthik <bkkarthik@pesu.pes.edu>
Cc:     devel@driverdev.osuosl.org, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michel Lespinasse <walken@google.com>,
        Divyansh Kamboj <kambojdivyansh2000@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v3] staging: comedi: comedi_fops.c: added casts to get
 rid of sparse warnings
Message-ID: <20200716143949.GA2230084@kroah.com>
References: <20200716141747.wewrnejrygosqhd5@pesu-pes-edu>
 <20200716142537.GA2176745@kroah.com>
 <CAAhDqq3EeWGOJHaW37iQN5UgmvTf3AP10fhrVdJ5GuYjBt8f3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhDqq3EeWGOJHaW37iQN5UgmvTf3AP10fhrVdJ5GuYjBt8f3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:28:06AM -0400, B K Karthik wrote:
> On Thu, Jul 16, 2020 at 10:25 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 16, 2020 at 10:17:47AM -0400, B K Karthik wrote:
> > > fixed sparse warnings by adding a cast in assignment from
> > > void [noderef] __user * to unsigned int __force *
> > > and a reverse cast in argument from
> > > unsigned int * to  unsigned int __user * .
> > >
> > > Signed-off-by: B K Karthik <karthik.bk2000@live.com>
> > > ---
> > >  drivers/staging/comedi/comedi_fops.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > What changed from previous versions?
> 
> As Ian Abbott said "Minor quibble: the reverse cast is actually from
> unsigned int * to"
> 
> Hence this is a change in the commit description.

How was anyone supposed to know this?  :)

> > That always goes below the --- line.
> 
> I did not understand this sir, can you please clarify?

Please read the documentation for how to properly version patches, it's
in the submitting patches document.  Do that and send a v4 for this.

thanks,

greg k-h
