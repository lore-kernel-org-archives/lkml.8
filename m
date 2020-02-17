Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C29C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3730D2464E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581956991;
	bh=EsYyewiCgEfKwPRCUKZl1Kg4p+gbDyMv0r1YSwvRpKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YIh2Kxs6K2clUEgu+r8C2Fr93R63uEf06WJEEXZoABxewSj355N30DQK/tVtiiKfI
	 qnHEBcR4XEdr6O6YegcdFspmv7szA6izuuY6oXcsiqkUlRUfhQ4UWmt894Xbrsnk0D
	 hA/+NvEsvNGRu6YDBEuvFMKdRbx5S/czT6JLNTK8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgBQQ3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:37604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgBQQ3t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:29:49 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F594214D8;
        Mon, 17 Feb 2020 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581956987;
        bh=EsYyewiCgEfKwPRCUKZl1Kg4p+gbDyMv0r1YSwvRpKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PYKA5FNITPtJeMhzm8IO0pT/LVtgCldu3tksSLOAZcrCpmeIWD6T63T/gqXQZMMne
         czK8ZiLeFZFExOehdR2b7Vo6BnQxx6qfZEKbhPcLvTDQ0RS/HW1Uy+l0D7grVkH9vH
         DTrsRbr6TvyBz9ccxbwp91u+JClv3t/oPfk93C4g=
Date:   Mon, 17 Feb 2020 17:29:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Anton Vorontsov <avorontsov@ru.mvista.com>,
        kbuild test robot <lkp@intel.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH] usb: host: fhci-hcd: annotate PIPE_CONTROL switch case
 with fallthrough
Message-ID: <20200217162945.GC1502885@kroah.com>
References: <20200213085401.27862-1-linux@rasmusvillemoes.dk>
 <20200213125659.GB3325929@kroah.com>
 <6ab68169-dde6-b5ba-0909-fa685bd24aac@rasmusvillemoes.dk>
 <20200217093836.GA37937@kroah.com>
 <a1f0f024-c1e5-8ff5-f717-f5098b4eb78d@rasmusvillemoes.dk>
 <20200217141831.GA1123892@kroah.com>
 <298629e3-40bb-9530-8292-7e2a9432cd4a@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298629e3-40bb-9530-8292-7e2a9432cd4a@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 10:15:09AM -0600, Gustavo A. R. Silva wrote:
> Hi!
> 
> Sorry for the late reply. I wasn't aware of this thread until now.
> 
> Please, see my comments below...
> 
> On 2/17/20 08:18, Greg Kroah-Hartman wrote:
> > On Mon, Feb 17, 2020 at 03:12:21PM +0100, Rasmus Villemoes wrote:
> >> On 17/02/2020 10.38, Greg Kroah-Hartman wrote:
> >>> On Thu, Feb 13, 2020 at 02:35:18PM +0100, Rasmus Villemoes wrote:
> >>>> On 13/02/2020 13.56, Greg Kroah-Hartman wrote:
> >>>>
> >>>>> Shouldn't this be /* fall through */ instead?
> >>>>>
> >>>>> Gustavo, what's the best practice here, I count only a few
> >>>>> "fallthrough;" instances in the kernel, although one is in our coding
> >>>>> style document, and thousands of the /* */ version.
> >>>>
> >>>> Yes, I went with the attribute/macro due to that, and the history is
> >>>> that Linus applied Joe's patches directly
> >>>> (https://lore.kernel.org/lkml/CAHk-=whOF8heTGz5tfzYUBp_UQQzSWNJ_50M7-ECXkfFRDQWFA@mail.gmail.com/),
> >>>> so I assumed that meant the Penguin decided that the attribute/macro is
> >>>> the right thing to do for new code, while existing comment annotations
> >>>> can be left alone or changed piecemeal as code gets refactored anyway.
> >>>
> >>> But, to be fair, Gustavo went and fixed up thousands of these, with the
> >>> /* */ version, not the attribute.
> >>>
> >>> Gustavo, can coverity notice the "fallthrough;" attribute properly?  I
> >>> don't want to start adding things that end up triggering
> >>> false-positives.
> >>
> >> I'm not Gustavo, and I don't know the answer, but 1.5 years ago some guy
> >> named greg k-h suggested that coverity does grok the fallthrough attribute:
> >>
> >> https://patchwork.kernel.org/cover/10651357/#22279095
> > 
> > I wouldn't trust anything that bum says :)
> > 
> > Ok, I don't remember saying that at all, but I'll wait a day or two to
> > get Gustavo's opinion befor applying the patch.
> > 
> 
> We are good to go with the 'fallthrough' pseudo keyword. Linus is OK with
> that.
> 
> The comment annotations will eventually be transformed to "fallthrough;"

Ok, thanks for the confirmation, will queue this up.

greg k-h
