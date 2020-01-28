Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236DDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96942173E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 23:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LpOh1pel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgA1XDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 18:03:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36002 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgA1XDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 18:03:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id 185so3650419pfv.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 15:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BQHjrKsw3mb8tLLCYB49BaKjx4tgpI3Vuluj4gny7rU=;
        b=LpOh1pelzzXYfkGWr73OW4OXkP6vJ+5tlOVGIrXHH0liSRTIYgs16JDRT8lIHZPSo+
         dzMCo+fDtdEyrfdhSOgOsUdx/PTzY7tK1vgYVxJyhCk5zIwDZ+SJOlUmyOxrOKqHkHUP
         +3y3cfByRw61fUuuU8kUXR2LYkUe4oaI/7WYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BQHjrKsw3mb8tLLCYB49BaKjx4tgpI3Vuluj4gny7rU=;
        b=AcsxCc8PpfEv3Owndw6ecte0iWP8cHDxuQpSofp4cvcKCMYDmBRiSjKwtY8xD4uvsJ
         e3na22yhsJ9MT2LnSvdT2va04xCXWaP8ev9jLzAU7MWUrhM44ONW79BkYHIO8IwOeNQ2
         OfzRha+vVHFdn1OcE5tNnORmMpMjlMFPcs4flw0njlv2J6/XDdQpcTwpzN6ENjDMGKP5
         IkgRt6kxRwP3ik+UlT7Kk+GzLDCegjau+ofI9SlQXc2YVfPHr0L65NXTHNtDoDh/0/RX
         u8f2mnenis/w8A5DGOh96Wo/I3IPN2fiwaTTDMUNsoY7DONS3BxRqwucEboWpPcCbCNx
         aj+A==
X-Gm-Message-State: APjAAAXJVJp62qEUKPy4QhO+uZd/V1OqjkkyjvqXEZiKMF05xzrV6sdX
        dNtdZiAwrC+rsAKYfNPLE2DO4Q==
X-Google-Smtp-Source: APXvYqxBE8zXnn4hcAXUvWOJwzaIofY8dogyTxZvG7W0vNnGypJIVDDTWkGEDLgwKSxuwL6sc71RNw==
X-Received: by 2002:aa7:9796:: with SMTP id o22mr6119730pfp.101.1580252592170;
        Tue, 28 Jan 2020 15:03:12 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a19sm3926515pju.11.2020.01.28.15.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 15:03:11 -0800 (PST)
Date:   Tue, 28 Jan 2020 15:03:10 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        notify@kernel.org
Subject: Re: [PATCH v2 1/1] lkdtm/stackleak: Make the test more verbose
Message-ID: <202001281502.F4977FD279@keescook>
References: <20200102234907.585508-1-alex.popov@linux.com>
 <e8f1b3e9-50ae-2482-3e10-32b21cd7ebb4@linux.com>
 <202001271514.345A5CC9C@keescook>
 <20200128075050.GC2105706@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128075050.GC2105706@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 08:50:50AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Jan 27, 2020 at 03:15:08PM -0800, Kees Cook wrote:
> > On Wed, Jan 22, 2020 at 02:58:44PM +0300, Alexander Popov wrote:
> > > On 03.01.2020 02:49, Alexander Popov wrote:
> > > > Make the stack erasing test more verbose about the errors that it
> > > > can detect.
> > > > 
> > > > Signed-off-by: Alexander Popov <alex.popov@linux.com>
> > > > ---
> > > >  drivers/misc/lkdtm/stackleak.c | 25 +++++++++++++++++--------
> > > >  1 file changed, 17 insertions(+), 8 deletions(-)
> > > 
> > > Hello!
> > > 
> > > Pinging about this version of the patch.
> > > 
> > > Kees, it uses dump_stack() instead of BUG(), as we negotiated.
> > 
> > Yup, this is in my queue -- I've just gotten back from travelling and
> > will get to it shortly. :)
> > 
> > Greg, feel free to take this directly if you want, too.
> 
> If I were to take it, it would have to wait until after 5.6-rc1, sorry.

Well, it has to go via drivers/misc anyway, so I think timing is no
different. I would consider this a feature patch, not a bug fix, too.

-- 
Kees Cook
