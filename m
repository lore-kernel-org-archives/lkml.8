Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4228C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B217C206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595597004;
	bh=iz3emlIBboqj3w97xgTGWD2hmJOu1r/oD9Rp5zyVlU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jOkyeGpYgaFZ/tplMqmmEgDNsUs38DJhsWtdvhBt7iaTOsfdwqVQw5i8yZxJp8CU4
	 UBUsK3L/A4Ygl/e15vYwA/Q6ruTdY+pW197Ge6vvKWw9TOI4QrA2oYdL48TG3PVlhG
	 n2rOA65mIoSCWKZDPOai3tUPGhYsM9Hjlmxw40hc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGXNXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:23:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbgGXNXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:23:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4902E2065F;
        Fri, 24 Jul 2020 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595597001;
        bh=iz3emlIBboqj3w97xgTGWD2hmJOu1r/oD9Rp5zyVlU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=icY+uqCpVv5U6vQ2+hkHUjbgfepgkDpCiA6MFFX1vZGUx/yRBctOxSRG9Ou/kEAH9
         EbE/9v4c07AKTdxu5d1HEawH5rAqeXjZOmph/TmTk7N5C1u3YS8jWHTEMCIaSbOJby
         6Zllg0p0dA7nlcI6eW9Olw7E6kL4JVd/27ysiv5Q=
Date:   Fri, 24 Jul 2020 15:23:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] habanalabs pull request for kernel 5.9-rc1 (resend)
Message-ID: <20200724132323.GA316746@kroah.com>
References: <20200723191525.GA24516@ogabbay-VM>
 <20200724093259.GB4116407@kroah.com>
 <CAFCwf10r4eqO=6B=C_iKt17XcY7oVuRDEJs5_x9Anw_5Djig6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf10r4eqO=6B=C_iKt17XcY7oVuRDEJs5_x9Anw_5Djig6Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 02:35:17PM +0300, Oded Gabbay wrote:
> On Fri, Jul 24, 2020 at 12:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jul 23, 2020 at 10:15:25PM +0300, Oded Gabbay wrote:
> > > Hello Greg,
> > >
> > > (Re-sending this pull request)
> > >
> > > This is habanalabs pull request for the merge window of kernel 5.9. It
> > > contains many small improvements to common and GAUDI code. Details are in
> > > the tag.
> > >
> > > Thanks,
> > > Oded
> > >
> > > The following changes since commit 7a4462a96777b64b22412f782de226c90290bf75:
> > >
> > >   misc: rtsx: Use standard PCI definitions (2020-07-22 13:39:31 +0200)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-07-23
> >
> > {sigh}
> >
> > Commit: 961a7325e670 ("habanalabs: Fix memory leak in error flow of context init")
> >         Fixes tag: Fixes: 786c94810698 ("habanalabs: Use pending cs amount per asic")
> >         Has these problem(s):
> >                 - Subject does not match target commit subject
> >                   Just use
> >                                 git log -1 --format='Fixes: %h ("%s")'
> >
> > The scripts I use to check this are here:
> >         https://github.com/gregkh/gregkh-linux/blob/master/work/verify_fixes.sh
> >         https://github.com/gregkh/gregkh-linux/blob/master/work/verify_signedoff.sh
> >
> > And note, if I ignore these errors, you will just get the same response
> > from Stephen when it hits linux-next :(
> >
> > thanks,
> >
> > greg k-h
> 
> I'm sorry for all the trouble Greg, but I wanted to ask before I send
> it again, won't the fixed sha-id be wrong once you merge this pull
> request to your tree ?

Nope, that's because I am using git to merge it.

> Because this patch fixes a previous patch in this pull-request.
> Maybe I should just squash them ?

That's up to you.  If it was a different author, perhaps keep them
separate, it's your call.

thanks,

greg k-h
