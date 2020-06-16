Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E798CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B492120734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 06:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592289436;
	bh=5gCQ8SG/lezC0BcWNszXab3hq0C0HZPZZV+pMYNLOhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fXQ1UxBm3YoZsS3xBXRfW0GychoAX/BHmhheRSIMeOAv1OyR5j6WXWOucXpLFFVZ7
	 rucM5f/kpV+8bT1fx+WZYdnLwqXe0uPQmlu6/ICPQLT9ub+U6Qt3u9CKzg1OtvdslJ
	 gdgVxGbBSD6xKOhTUdKwOrcY/XhRI8BvzocFkRfE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgFPGhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 02:37:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgFPGhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 02:37:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6972B20734;
        Tue, 16 Jun 2020 06:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592289435;
        bh=5gCQ8SG/lezC0BcWNszXab3hq0C0HZPZZV+pMYNLOhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j/vx0MzOLKBApzZFJMcc+SxxuPTFl12E4sGrLi4DkoZcloKHi3gfUxB6qynFOOGEo
         o8lbLwBcH/sHynQLX9N4isNurgzlT55UupOeEf504coxPwqq7IO0j/2TfBV4vfg/ba
         MjWQBHhqn+aMlrBPfsGefDEUdDcvulY480H0vkXk=
Date:   Tue, 16 Jun 2020 08:37:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 23/24] kset-example: add pr_debug()s for easy
 visibility of its operation
Message-ID: <20200616063712.GA10274@kroah.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-24-jim.cromie@gmail.com>
 <20200614060501.GB2608744@kroah.com>
 <CAJfuBxyAYU+cE+JpE+T6+k0YhqG3pyk2ShPruX4A9yCTeKX3Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxyAYU+cE+JpE+T6+k0YhqG3pyk2ShPruX4A9yCTeKX3Jg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 04:18:38PM -0600, jim.cromie@gmail.com wrote:
> On Sun, Jun 14, 2020 at 12:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Jun 13, 2020 at 09:57:37AM -0600, Jim Cromie wrote:
> > > put pr_debug()s into most functions, to easily see code operate when
> > > module is loaded and used.
> > >
> > >   #> dmesg -w &
> > >   #> modprobe kset-example dyndbg=+pfml
> > >   #> cat /sys/kernel/kset-example/*/*
> > > ---
> 
> > >  static int __init example_init(void)
> > >  {
> > > +     pr_debug("called");
> >
> > Why???  If you want to do something like this, use ftrace, that is what
> > it is for.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> mostly I needed an easy place to try out pr_debug_n  in the next patch.
> if that next patch seems like a good anti-pattern for pr_debug_n use/misuse,
> then I could combine the 2, and add a 'dont do this, use ftrace' comment too.
> or not, of course.

This is not a good place to use it at all, as I do not want to see
people copying it.  Anything that does "called" is ripe to just be
removed entirely.

Which again leads me to the "are you sure you want to do any of this?"
question as almost always, complex debugging stuff like this is never
used once the driver is up and running properly.

thanks,

greg k-h
