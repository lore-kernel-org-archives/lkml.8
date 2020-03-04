Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93594C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D27C215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 05:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583300540;
	bh=XnZr+3j6ZAuKpc/58P3pJj3X9aigMNVKC6LrvVhvag0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E4oVowIytyaix89eAA4Ujz+niFbpte4sKewRm6Ng/n7NEW24tzUcSuLyAsxrtlNZE
	 wZ65y3CZKSk+fJwkZQJJfsJZWabMrAyjfPI3xHhW2EIFVw0tDG0m9Lg0TaWsU3m2gv
	 HtbMKdr5TzFSwRM3HGBLh5YcqVNvKyJHMl+9o7y8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgCDFmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 00:42:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:37002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgCDFmT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 00:42:19 -0500
Received: from onda.lan (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 385DA214D8;
        Wed,  4 Mar 2020 05:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583300538;
        bh=XnZr+3j6ZAuKpc/58P3pJj3X9aigMNVKC6LrvVhvag0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJkd6I7+vjjhVlFWBda9F/DrWXkuGESju6H5wgK9p1dE3HnNWqsHcT7WICHT7zVsL
         pc3ZxDclxFaVRt4SG+YPIJYh5sitWAcLRVw/+H589KqITLt4wL9uIlORy23MdNGZ7f
         //qeV01LAYVbiXPLYDKIvCTqaSQ2zzw8aW3fKuWM=
Date:   Wed, 4 Mar 2020 06:42:14 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "tbird20d@gmail.com" <tbird20d@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
Message-ID: <20200304064214.64341a49@onda.lan>
In-Reply-To: <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
        <20200302130911.05a7e465@lwn.net>
        <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 3 Mar 2020 17:07:48 +0000
"Bird, Tim" <Tim.Bird@sony.com> escreveu:

> > -----Original Message-----
> > From: Jonathan Corbet <corbet@lwn.net>
> > 
> > On Mon, 24 Feb 2020 18:34:41 -0700
> > tbird20d@gmail.com wrote:
> >   
> > > With Ubuntu 16.04 (and presumably Debian distros of the same age),
> > > the instructions for setting up a python virtual environment should
> > > do so with the python 3 interpreter.  On these older distros, the
> > > default python (and virtualenv command) might be python2 based.
> > >
> > > Some of the packages that sphinx relies on are now only available
> > > for python3.  If you don't specify the python3 interpreter for
> > > the virtualenv, you get errors when doing the pip installs for
> > > various packages
> > >
> > > Fix this by adding '-p python3' to the virtualenv recommendation
> > > line.
> > >
> > > Signed-off-by: Tim Bird <tim.bird@sony.com>  
> > 
> > I've applied this, even though it feels a bit fragile to me.  But Python
> > stuff can be a bit that way, sometimes, I guess.  
> 
> I agree it seems a bit wonky.

Well, we could, instead, add some code that would be checking python and pip
versions, but still distros could be doing some backports with could
cause side-effects. So, checking for distro versions as done in this patch
seems a lot safer.

> The less fragile approach would have been to just
> always add the '-p python3' option to the virtualenv setup hint,
> but Mauro seemed to want something more fine-tuned.

Yeah, I asked for a more fine-tuned version.

Depending on python/pip version, adding a -p python3 seems to cause
troubles (at least I found some bug reports about that). I may be
wrong (it was a long time ago), but, before adding the logic that checks
for "python3" I guess I tried first add -p python3, but, back then,
I found some troubles (probably with some old Fedora version).

So, better to use this syntax only on distros we know it will
work as expected.

> As far as the string parsing goes, I think that the format of strings
> returned by lsb-release (and the predecesors that sphinx_pre_install
> checks) is unlikely to change.

Since when we added this script, we didn't have any troubles yet with
the part of the code with checks the distribution version. So, I guess
that the lsb-release related checks are pretty much reliable.

> 
> Thanks for applying it.
>  -- Tim
> 
> 
