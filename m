Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5643BC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 250B72072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583737540;
	bh=2KvCwHFsSQAdpSeO3Lrv4bLbVDryixX5cclnODTcftA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rCxd3WIXjm5HWJg3nYmttINTNTarRNr8IRNC4jaTEzO5p4fWBX8E3zlM3Q3LW5qLY
	 5GXBUtws2/mu8mObWdKW+ZW9HH0yjV4VhfzccWepbKoCAlVcMZzO/Eor1+nKOTNznt
	 hGsFxtP2XNmeYd32IaON9Tpxfp6oYQqNW/m7DXKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCIHFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:05:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:39020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgCIHFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:05:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F1620727;
        Mon,  9 Mar 2020 07:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583737538;
        bh=2KvCwHFsSQAdpSeO3Lrv4bLbVDryixX5cclnODTcftA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imf7ucjj9mMJnBpte57EShocWEVms4ljEkg/SztU53q07rUnwnBJbvVB11UYnPbyT
         /vf0MtvOtUA4s8D+LULFasg6rfyO6nsEmJzL5Hh5yELA4WyaPfD77oS5TnBmUAfR0m
         IP+9eFChq3WGfY1OEGqwMhktrqmq922r8dLxhzZo=
Date:   Mon, 9 Mar 2020 08:05:34 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Guenter Roeck <groeck@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] MAINTAINERS: include GOOGLE FIRMWARE entry
Message-ID: <20200309070534.GA4093795@kroah.com>
References: <20200308195116.12836-1-lukas.bulwahn@gmail.com>
 <CABXOdTcrxoBCz24Ap=YJYZnr+oLAmaR10xZ9ar2mYbE1=RAoug@mail.gmail.com>
 <5129f7dbd8506cc9fd5a8f76dc993d789566af6c.camel@perches.com>
 <alpine.DEB.2.21.2003090702440.3325@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003090702440.3325@felia>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 07:32:10AM +0100, Lukas Bulwahn wrote:
> 
> 
> On Sun, 8 Mar 2020, Joe Perches wrote:
> 
> > On Sun, 2020-03-08 at 15:32 -0700, Guenter Roeck wrote:
> > > On Sun, Mar 8, 2020 at 12:51 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > > > All files in drivers/firmware/google/ are identified as part of THE REST
> > > > according to MAINTAINERS, but they are really maintained by others.
> > []
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > []
> > > > @@ -7111,6 +7111,14 @@ S:       Supported
> > > >  F:     Documentation/networking/device_drivers/google/gve.rst
> > > >  F:     drivers/net/ethernet/google
> > > > 
> > > > +GOOGLE FIRMWARE
> > > > +M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > +M:     Stephen Boyd <swboyd@chromium.org>
> > > > +R:     Guenter Roeck <groeck@chromium.org>
> > > > +R:     Julius Werner <jwerner@chromium.org>
> > > > +S:     Maintained
> > > > +F:     drivers/firmware/google/
> > > > +
> > > 
> > > FWIW, I would not mind stepping up as maintainer if needed, but I
> > > think we should strongly discourage this kind of auto-assignment of
> > > maintainers and/or reviewers.
> > 
> > Auto assignment should definitely _not_ be done.
> > 
> > This is an RFC proposal though.
> > 
> > Sometimes it's better to not produce an RFC as
> > a patch, but maybe just show a proposed section
> > and ask if is appropriate may be a better style
> > going forward.
> >
> 
> Please interpret the RFC patch similar to an email as Joe wrote below, 
> simply reaching out to you.
> 
> There is no auto-assignment intended, nor did I expect the patch to be 
> picked up on the first attempt of uneducated guessing.
> 
> There are currently around 3,000 files identified being part of THE REST;
> so they are all assigned to Linus and LKML.
> 
> To confirm that they actually are maintained by someone else and reflect 
> that in MAINTAINERS, a bit of educated guessing who to contact and to 
> which entry to add the files to is required.
> 
> I am starting with the "bigger" clustered files in drivers, and then try 
> to look at files in include and Documentation/ABI/.
> 
> Here is a rough statistics on how many files from each directory are in
> THE REST:
> 
>    1368 include
>     566 tools
>     327 lib
>     321 Documentation
>     100 drivers
>      91 kernel
>      84 scripts
>      75 samples
>      13 ipc
>      13 init
>       8 usr
>       2 arch
>       1 virt

When you use the get_maintainer.pl script, it should find reasonable
people/lists for those files, so why not just stick with that?  Trying
to classify all of the kernel files to have MAINTAINERS entries seems
like a loosing proposition as there are file that no one has touched in
years.

thanks,

greg k-h
