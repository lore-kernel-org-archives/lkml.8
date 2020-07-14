Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F07C43458
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBE6C221F3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594708647;
	bh=mR/muK3gdKl9gsxO9Ci2KinZJohaF23cu0yq+FvLps0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=k28yimanrHLw9RA1k61vzM2NmPKUFL4wOvdfsIT5rb5MwuXKKQFErEJHnIDJ7cioW
	 MrinNKtNmaO+bmxSDyx1TA3cbM18IZ1b6+G9/fvVVhYf+W+c3HsXPZ+7jGlc1OKhig
	 0xb16xszVtqoMpCdZjhHp31OPVb4PsySb2XcaIA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGNGgw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:36:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:36060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgGNGgu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:36:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD88C221F0;
        Tue, 14 Jul 2020 06:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594708610;
        bh=mR/muK3gdKl9gsxO9Ci2KinZJohaF23cu0yq+FvLps0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QAGH2SsOp/wFpBaV7D0dkvxmQA+0u7tS7NYE4A6jWdYh/p13Ht338I1SFAboXcqe/
         vsGSGVN91qmcBV/hiOuKpBuuPpSxD6A6fWLT48kOED/mMN8oH2vlDKJGU3K2SI6Sud
         KgcBhiqEujq56Cg1AjdhZvAhqXkEegdVLpA1Bs5A=
Date:   Tue, 14 Jul 2020 08:36:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SW_Drivers@habana.ai, Ofir Bitton <obitton@habana.ai>
Subject: Re: [PATCH 1/3] habanalabs: implement dma-fence mechanism
Message-ID: <20200714063648.GC662760@kroah.com>
References: <20200713155424.24721-1-oded.gabbay@gmail.com>
 <20200713155752.GC267581@kroah.com>
 <CAKMK7uH=Ch4ce-9D5e-RvVwq_oK6Doqtq5QbvpmQ8uPWkMCi2w@mail.gmail.com>
 <20200713190357.GC25301@ziepe.ca>
 <CAKMK7uEvehX2CV3Q5FJrF49-_Xe9gXJ11wDo7xyVsipyuZm23Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEvehX2CV3Q5FJrF49-_Xe9gXJ11wDo7xyVsipyuZm23Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 09:08:55PM +0200, Daniel Vetter wrote:
> On Mon, Jul 13, 2020 at 9:03 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Mon, Jul 13, 2020 at 08:34:12PM +0200, Daniel Vetter wrote:
> > > On Mon, Jul 13, 2020 at 5:57 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Jul 13, 2020 at 06:54:22PM +0300, Oded Gabbay wrote:
> > > > > From: Ofir Bitton <obitton@habana.ai>
> > > > >
> > > > > Instead of using standard dma-fence mechanism designed for GPU's, we
> > > > > introduce our own implementation based on the former one. This
> > > > > implementation is much more sparse than the original, contains only
> > > > > mandatory functionality required by the driver.
> > > >
> > > > Sad you can't use the in-kernel code for this, I really don't understand
> > > > what's wrong with using it as-is.
> > > >
> > > > Daniel, why do we need/want duplicate code floating around in the tree
> > > > like this?
> > >
> > > The rules around dma-fence are ridiculously strict, and it only makes
> > > sense to inflict that upon you if you actually want to participate in
> > > the cross driver uapi built up around dma-buf and dma-fence.
> > >
> > > I've recently started some lockdep annotations to better enforce these
> > > rules (and document them), and it's finding tons of subtle bugs even
> > > in drivers/gpu (and I only just started with annotating drivers:
> > >
> > > https://lore.kernel.org/dri-devel/20200707201229.472834-1-daniel.vetter@ffwll.ch/
> > >
> > > You really don't want to deal with this if you don't have to. If
> > > drivers/gpu folks (who created this) aren't good enough to understand
> > > it, maybe it's not a good idea to sprinkle this all over the tree. And
> > > fundamentally all this is is a slightly fancier struct completion. Use
> > > that one instead, or a wait_queue.
> > >
> > > I discussed this a bit with Oded, and he thinks it's easier to
> > > copypaste and simplify, but given that all other drivers seem to get
> > > by perfectly well with completion or wait_queue, I'm not sure that's a
> > > solid case.
> > >
> > > Also adding Jason Gunthorpe, who very much suggested this should be
> > > limited to dma-buf/gpu related usage only.
> >
> > Without all the cross-driver stuff dma_fence is just a
> > completion. Using dma_fence to get a completion is big abuse of what
> > it is intended for.
> >
> > I think the only problem with this patch is that it keeps too much of
> > the dma_fence stuff around. From what I could tell it really just
> > wants to add a kref and completion to struct hl_cs_compl and delete
> > everything to do with dma_fence.
> 
> Yeah, that's what I recommended doing too. error flag might be needed
> too I think, but that's it.

Ok, so this should be made much simpler and not use this copy/paste code
at all.  I can accept that :)

Ofir, care to redo this?

thanks,

greg k-h
