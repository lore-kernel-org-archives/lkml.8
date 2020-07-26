Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C419C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BCB206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 02:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OvvfwJdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgGZCHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 22:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgGZCHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 22:07:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8826C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 19:07:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id il6so1615804pjb.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 19:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNDilay1sHPsEz4YR66Yr+U+zEImSfHeZ16zNl+dXoM=;
        b=OvvfwJdw+GjOACNErXcyicqxzDz/7C8Y47ka18cmdrDcvqXqw22EcV7KQUQWYJg9eF
         6nTa70zTxJqcVf1jPzvud8lx8RB2dzxgvYERrskJe7gObzxhkgZuB+Smp3E9VWrzoouk
         PB2moUvU8lM6WrkbK/TWNctP7yaEYw9kgL+C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNDilay1sHPsEz4YR66Yr+U+zEImSfHeZ16zNl+dXoM=;
        b=FwMmmuunrnbsazpnHQ89MA3vF8B6g30uTr9Q64L1bzJSyyOdSNN+JH2Tq8OPW6Pz5q
         SO32RrvSD4i9YtRcW8PhDHPE69xfptynmPg8BL7NCYPnOeOIkkpgW77jR1jWw77RYrx6
         OJm9cGHS17IumZK5l+9Jf0qiZx2z7k/lul60dQCi7lPgHKS6fEAIM0iu0aDPHZbmri2f
         d1kva8NbfSMy21/hATidqyGWBU9CxsUUO0MOlDRVTP2V7nZC3fjw+wn6gLhDxI0uD8Me
         C8Ntjaujm1skG1y6OMXKYchnOEGXwg/FZ7rheATj1T3yeXDFWgqzhJ2U6mTlkNiAf1Ak
         wXGA==
X-Gm-Message-State: AOAM532UqVMTH8rYuxhK31bQzMaFPoi0WLBrAt/P24G2ch1civ91fwLF
        pdgtNfcVCnV8CHbCxUihsfe0Lw==
X-Google-Smtp-Source: ABdhPJyEZIF2Gn+8JPOwHUz8cKkIkjw50rDFttEqH3jrT/4n8U+HCd1iDLANMuR4xdwSkBL6sYpE5w==
X-Received: by 2002:a17:902:c80c:: with SMTP id u12mr13809216plx.196.1595729260131;
        Sat, 25 Jul 2020 19:07:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q5sm10614791pfc.130.2020.07.25.19.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 19:07:38 -0700 (PDT)
Date:   Sat, 25 Jul 2020 19:07:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Christian Kujau <lists@nerdbynature.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org,
        klibc@lists.zytor.com, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: process '/usr/bin/rsync' started with executable stack
Message-ID: <202007251907.DC4D4C6C15@keescook>
References: <alpine.DEB.2.22.1.446.2006231023390.3892@trent.utfs.org>
 <20200624165148.GD31008@kadam>
 <202006241238.E9CB1CE85B@keescook>
 <20200625100429.GB2571@kadam>
 <202006251253.2893D4F67@keescook>
 <6898a5af75e165fb9524558804fca9f46f98b633.camel@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6898a5af75e165fb9524558804fca9f46f98b633.camel@decadent.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 10:27:56PM +0100, Ben Hutchings wrote:
> On Thu, 2020-06-25 at 13:20 -0700, Kees Cook wrote:
> > On Thu, Jun 25, 2020 at 01:04:29PM +0300, Dan Carpenter wrote:
> > > On Wed, Jun 24, 2020 at 12:39:24PM -0700, Kees Cook wrote:
> > > > On Wed, Jun 24, 2020 at 07:51:48PM +0300, Dan Carpenter wrote:
> > > > > In Debian testing the initrd triggers the warning.
> > > > > 
> > > > > [   34.529809] process '/usr/bin/fstype' started with executable stack
> > > > 
> > > > Where does fstype come from there? I am going to guess it is either
> > > > busybox or linked against klibc?
> > > > 
> > > > klibc has known problems with executable stacks due to its trampoline
> > > > implementation:
> > > > https://wiki.ubuntu.com/SecurityTeam/Roadmap/ExecutableStacks
> > > 
> > > Yeah.  It comes from klibc-utils.
> > 
> > This is exactly what I was worried about back in Feb:
> > https://lore.kernel.org/lkml/202002251341.48BC06E@keescook/
> > 
> > This warning, combined with klibc-based initrds, makes the whole thing
> > pointless because it will always warn once on boot for the klibc stack,
> > and then not warn about anything else after that.
> > 
> > It looks like upstream klibc hasn't been touched in about 4 years, and
> > it's been up to Ben to keep it alive in Debian.
> > 
> > A couple ideas, in order of my preference:
> > 
> > 1) stop using klibc-utils[1]. initramfs-tools-core is the only thing with a
> >    dependency on klibc-utils. Only a few things are missing from busybox.
> > 
> > 2) make the warning rate-limited instead?
> > 
> > 3) fix the use of trampolines in klibc
> 
> It only uses trampolines on alpha, m68k, parisc, s390, and sparc32.  As
> of today, the master branch should correctly enable executable stacks
> on these and only these architecture.
> 
> I have a development branch that sets sa_restorer and disables
> executable stacks on alpha, s390, and sparc32:
> 
> https://git.kernel.org/pub/scm/libs/klibc/klibc.git/log/?h=execstack-fixes

Awesome! Thanks for tackling this. :)

-- 
Kees Cook
