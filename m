Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CC5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7726620690
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589384889;
	bh=ADBkYyTyv3zcLAs/g1IPEX1psDgellntvCZZn+PLIWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=14bwnrXFHAYfBSxE6ncpq2eeRaTyN96MJMzKtnMQm7V8QbGvf7xMT4MXvAJ/OqHI5
	 2/SuCMwmtLe+ah2qM9dAr+eI2TkjNmCqPoonMYwJcIZ5pV9Sn39hLa1GAkICIdMrY3
	 4+j5H04wUa7iFX2tavemT8+cC+8RCPMNXHSmuA6s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389303AbgEMPsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:48:08 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44841 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729604AbgEMPsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:48:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id d22so8010603lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E0eWepkBc+wyH1dt54rBpIGFByPwRAmtQvTPXFRLG1M=;
        b=hA77KU35equ+RrYhpBli0Ug7bROHaT0KDSOKieDDJcMsN2a5xF3uKUdaRPrygxbPAD
         DbgvYGyVfsfbM2L4DWrL0mkwNUhDExuMxkdiYItEgftjACLKN6CqAzST8J8b7pZjGnNr
         mQXDzBDNQKHBEPspqScWyuxrsjK9bLyaWBrTfGSk5H+D/SwhRBJRoLn25p404CwzNaZG
         dOUV9cBknsfJRGJDImtQw54B1r9WhCZyenOiKlNTa2oleDvdFRwdIZGProekxxWBMiUv
         eoRHu6YeVRY2xp66kZq/u/Vjr/mLFZLRakMqlH06dlDF/n+jNEmMMnveRPWlmemZr9XI
         jxAA==
X-Gm-Message-State: AOAM533vTh+69MiJUwSxeRUueoycdYHEu/FYT4xPjWdhtE4IfLJnBL1j
        d8EIu9PHm3uArOpBopne6Htnrd24
X-Google-Smtp-Source: ABdhPJyYXWSK4bVajhB+UkPysvZo2jrccl8u1VTjaedjPyyacfCHOO2khVJxTWq8/B93x3YN98YPpg==
X-Received: by 2002:ac2:5212:: with SMTP id a18mr94069lfl.83.1589384885667;
        Wed, 13 May 2020 08:48:05 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f10sm6904lfl.82.2020.05.13.08.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:48:04 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jYtc7-0004rB-9k; Wed, 13 May 2020 17:48:07 +0200
Date:   Wed, 13 May 2020 17:48:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: Replace zero-length array with
 flexible-array
Message-ID: <20200513154807.GA25962@localhost>
References: <20200507185318.GA14393@embeddedor>
 <20200513150343.GZ25962@localhost>
 <20200513153918.GA1360420@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513153918.GA1360420@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:39:18PM +0200, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2020 at 05:03:43PM +0200, Johan Hovold wrote:
> > On Thu, May 07, 2020 at 01:53:18PM -0500, Gustavo A. R. Silva wrote:
> > > The current codebase makes use of the zero-length array language
> > > extension to the C90 standard, but the preferred mechanism to declare
> > > variable-length types such as these ones is a flexible array member[1][2],
> > > introduced in C99:
> > > 
> > > struct foo {
> > >         int stuff;
> > >         struct boo array[];
> > > };

> > >  drivers/greybus/arpc.h                    |    2 -
> > >  include/linux/greybus/greybus_protocols.h |   44 +++++++++++++++---------------
> > 
> > I noticed Greg just applied this one to his -testing branch, but do we
> > really want this in greybus_protocols.h, which is meant to be shared
> > with the firmware side? Perhaps not an issue, just figured I'd point
> > this out.
> 
> Why not, it should be the same thing, right?  No logic has changed that
> I see.

Yes, the structure's the same, but the firmware toolchain may not
expect flexible arrays. I believe we're holding back on these changes
for uapi headers as well for that reason?

Again, perhaps not an issue. We can just mandate fw toolchains that
support C99 if you want to use an unmodified header, I guess.

Johan
