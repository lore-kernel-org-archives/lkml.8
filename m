Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB487C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CAE21D79
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599637067;
	bh=IO6r3KJjp/JFwGSMPo4xWi2ollridTbwoQYxHByZFVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=exQSAZzFwEV6RQ6eRLahLC4HYzployZvmRaWQoGqCH0gFHwwnv5OPz2TxdpkETwfc
	 w1S99i+Z9zxYFenjFtol8bIjkXyrCFc9pJMGwdt1Pd8WogkUvc/TNzCiMHFPSHP7Se
	 nIWpSzZNgRiB8sFX0TDM43GeUKI9SgUxs1q0xrH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIIHhk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:37:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730260AbgIIHhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:37:06 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7949620732;
        Wed,  9 Sep 2020 07:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599637026;
        bh=IO6r3KJjp/JFwGSMPo4xWi2ollridTbwoQYxHByZFVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRKeYoPdqKaLssElezrS6ihoIHfR2NnGSHiWt2UlFzmKIA0QrRUh4XFEkkWrWe6qv
         Vag/j/T4Br7kHkdOjNhRYkFZz8rFY6pHYOlT8Pe/ifeW3NGjYsW71soYB7iFP3q0EN
         Yiu/tFe+TcCaY2uSrRCFLTrX4lEP3YB5PgD4u6ps=
Date:   Wed, 9 Sep 2020 09:37:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with
 __must_check
Message-ID: <20200909073716.GA560912@kroah.com>
References: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
 <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
 <20200826155507.GV1891694@smile.fi.intel.com>
 <973f4d54da796db4fcc9b643b10889cbc8839989.camel@perches.com>
 <CAJKOXPcCAPy-v38dyY_74H_6vrgj0mmEf6KaupVKJb4E2Ha_Ug@mail.gmail.com>
 <20200909070244.GC311356@kroah.com>
 <CAJKOXPd=TfCNfHPdsQZ42VEcUZOFZroXg7xmA82zSA=AbADxKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPd=TfCNfHPdsQZ42VEcUZOFZroXg7xmA82zSA=AbADxKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 09:08:14AM +0200, Krzysztof Kozlowski wrote:
> On Wed, 9 Sep 2020 at 09:02, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Sep 09, 2020 at 08:29:25AM +0200, Krzysztof Kozlowski wrote:
> > > On Wed, 26 Aug 2020 at 18:18, Joe Perches <joe@perches.com> wrote:
> > > >
> > > > On Wed, 2020-08-26 at 18:55 +0300, Andy Shevchenko wrote:
> > > > > On Wed, Aug 26, 2020 at 08:44:30AM -0700, Joe Perches wrote:
> > > > > > On Wed, 2020-08-26 at 13:44 +0300, Andy Shevchenko wrote:
> > > > >
> > > > > ...
> > > > >
> > > > > > > -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > > > > > > +int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > >
> > > +Cc Stephen and Greg,
> > >
> > > Hi Andy,
> > >
> > > Did this patch ended up in next somehow? I am surprised because now I
> > > got warnings for perfectly fine code:
> > > https://lore.kernel.org/linux-next/20200909155654.76fe3bd6@canb.auug.org.au/T/#u
> > >
> > > This creates simply false warnings instead of hints for "optimization".
> >
> > Yes, it got merged into m y driver core tree.
> >
> > I'll fix up the tty build warning, should be easy enough, the patch is
> > below.
> 
> Yes, this fix suppresses the warning but the question is whether we
> really want the warning?
> Such fixes mean additional code which the compiler might not optimize
> (unless it inlines the dev_err_probe()). This additional code is
> purely for suppressing the warning, without any meaning on its own.
> Actually it might be even confusing for someone to see:
> if (ret)
>   ret = dev_err_probe(ret);

Yeah, that is dumb, as the patch I made shows :(

> warn_unused_result should point errors, not "optimization
> opportunities". If you want to have opportunity, add a coccinelle
> rule. Or a checkpatch rule. Not a compiler warning.

Ok, I now agree, I'll go revert this patch and trust that driver authors
will "do the right thing" here...

thanks,

greg k-h
