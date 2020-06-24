Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207EDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED4A520706
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593004221;
	bh=mbZPHUQba6BG0lJ28HQorVolz/PNkBErnBcBS+nEeNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TjwXvSYAczUg8Unr2EEtVltUIVaGuzSAqJ+l4Gl+I9bcEoljYSsog3/hqH3W6UP3C
	 uIg7WeyayFbSt7uEQ9cj52k4RfdAapDOKQB6uMGo0h17rwTiCr8zTPjS0EzEnpYF+L
	 5tHXhe2bkZu1QLQmMCruzTpo+00OHI4WmU9f1/To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403887AbgFXNKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:10:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgFXNKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:10:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D28F3206C3;
        Wed, 24 Jun 2020 13:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593004218;
        bh=mbZPHUQba6BG0lJ28HQorVolz/PNkBErnBcBS+nEeNs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K1Euf7Zo5LI3vSzQzd2/QYz4kv+sUQbd2zDMizOMqKv04r6KRWhIOKgwA8YqlRMBi
         YvZmUBdjT3cx6FRk5hlxAe+LAqwZJNaGoR8c4/XtCk2McSMvvA3ZfAGBarU14Ro9nv
         eu7RPGT4GonnvfOAnfUwffEWyVvB21vwC4UtdyIY=
Date:   Wed, 24 Jun 2020 15:10:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kars Mulder <kerneldev@karsmulder.nl>
Cc:     Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Writing to a const pointer: is this supposed to happen?
Message-ID: <20200624131016.GA1807770@kroah.com>
References: <20200623195520.GA24965@duo.ucw.cz>
 <db0-5ef34880-ab-10c623c0@12577330>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0-5ef34880-ab-10c623c0@12577330>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 02:34:45PM +0200, Kars Mulder wrote:
> On Tuesday, June 23, 2020 21:55 CEST, Pavel Machek wrote:
> > Odd, indeed... but not likely to cause immediate problems.
> >
> > You may want to cc relevant maintainers, or even run git
> > blame and contact author.
> 
> Thank you for your response.
> 
> The code was written by Kai-Heng Feng, whom I shall CC. The code is
> part of the usbcore module, which does not have a maintainer listed in
> MAINTAINERS, but the patch and most other recent patches to usbcore
> were signed off exclusively by Greg Kroah-Hartman, so I guess that
> makes him the de facto maintainer? I'll CC him as well.
> 
> I'm not sure whether it is easy to read the previous messages of this
> thread if you got CC'ed just now, so I'll repeat/paraphrase the
> important part of my initial mail for your convenience:
> 
> > In the file drivers/usb/core/quirks.c, I noticed that the function
> > quirks_param_set writes to a const pointer, and would like to check
> > whether this is ok with the kernel programming practices. Here are
> > the relevant lines from the function (several lines omitted):
> >
> > 	static int quirks_param_set(const char *val, const struct kernel_param *kp) {
> > 		char *p, *field;
> > 		for (i = 0, p = (char *)val; p && *p;) {
> > 			field = strsep(&p, ":");
> >
> > In here a const pointer *val is cast into a non-const pointer and
> > then written to by the function strsep, which replaces the first
> > occurrence of the ':' token with a null-byte. Is this allowed?
> 
> CC: Kai-Heng Feng <kai.heng.feng@canonical.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It's not the nicest thing, but as you have noticed, it all works just
fine, right?

Have you hit any runtime issues with this code doing this?  These
strings should be held in writable memory, right?  Or do you see a
codepath where that is not the case?  If so, please feel free to submit
a patch to fix this up (and probably fix up a number of other "set"
functions that deal with struct kernel_param as well.)

thanks,

greg k-h
