Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAB9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 08:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A01B20716
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 08:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596962658;
	bh=FzBnhqnOcz7n6saIf8jOZhcIJpzS41o/bnog+SRDe+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hwpEFg+oNJUxO0NJFzo9cRQIcuRh5bGWfWWG8QPvrOT/vBBotAxSKAEDZ4T+vVbym
	 Al+Nmyf9aHwlHOrlqjYTbRm9XvYZGJYjCL1zfbnKgwewg0QARPiPMfnhqYksfG4exO
	 9ise/OVmRcwGr/aX7sOTIFxuPYF06YTOrUrvUgg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgHIIoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 04:44:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42461 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgHIIoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 04:44:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so5391930wrx.9;
        Sun, 09 Aug 2020 01:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XTNoyFeYnEOkAJbw8iUBzSkCy3+i9xEDKg6ExpJpe58=;
        b=f1eVZXIFneTFqsfir7kKbKuuseMC/ZEIx+TXLkGnxI54px6nHzE/2TlYR1HNsf1N+z
         EleIf8mg0GCOs8PXpO7J7eoNF3BXAiBRNsWz4LukKM81oDnOmRE0Q9T5tleoTvG3+GaT
         qcALOhoATJ3sBhFOGZCiimhJ4LLkPJKjT9LrZd8In6lN/oqcWxfT/nHk+78SVdCMLpjW
         yMceQNb01guWHpJjcnFg68Nmk3T83wEo9NdtOmbvbVIhoEM9CKShF8Ls1LTOvv2aJ3Fs
         XSE9B9PrSx/4xob/iIVDqq3TVdP9VOcrCk0EKDxZbG55k2CVVeWLGWap+wNqe4qOE1/V
         r6ug==
X-Gm-Message-State: AOAM532nVZaCgklty5vJx+RMWvjPS2KQGoIWvgJTU4jZQ6+wTwWQnSpD
        ja8/7yKd11xXdhZTpUkC+eM=
X-Google-Smtp-Source: ABdhPJzR24fsvQn+bWapiKi1vT1VGMsKWHkAfPzOI1FgKJZqRX84iY++vZGIbOeWRK5zx5K/fvoPtQ==
X-Received: by 2002:adf:fac8:: with SMTP id a8mr19817671wrs.368.1596962650201;
        Sun, 09 Aug 2020 01:44:10 -0700 (PDT)
Received: from kozik-lap ([194.230.155.117])
        by smtp.googlemail.com with ESMTPSA id d23sm16745787wmd.27.2020.08.09.01.44.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Aug 2020 01:44:09 -0700 (PDT)
Date:   Sun, 9 Aug 2020 10:44:07 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Felipe Balbi <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        USB list <linux-usb@vger.kernel.org>
Subject: Re: [PATCH v2 09/41] usb: gadget: s3c-hsudc: remove platform header
 dependency
Message-ID: <20200809084407.GA7722@kozik-lap>
References: <20200806181932.2253-1-krzk@kernel.org>
 <20200806182059.2431-9-krzk@kernel.org>
 <87v9hupnf7.fsf@kernel.org>
 <CAK8P3a2UH2NELh8ifZj0s+Xv1vqURjwJWU5Qb2FQiOq7c=dcBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a2UH2NELh8ifZj0s+Xv1vqURjwJWU5Qb2FQiOq7c=dcBg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 07:42:30PM +0200, Arnd Bergmann wrote:
> On Fri, Aug 7, 2020 at 3:59 PM Felipe Balbi <balbi@kernel.org> wrote:
> > Krzysztof Kozlowski <krzk@kernel.org> writes:
> 
> > > +#include <linux/delay.h>
> > > +
> > >  #define S3C2443_CLKREG(x)            ((x) + S3C24XX_VA_CLKPWR)
> > >
> > >  #define S3C2443_PLLCON_MDIVSHIFT     16
> > > @@ -184,5 +186,52 @@ s3c2443_get_epll(unsigned int pllval, unsigned int baseclk)
> > >       return (unsigned int)fvco;
> > >  }
> > >
> > > +static inline void s3c_hsudc_init_phy(void)
> >
> > This should, really, be a PHY driver under drivers/phy, since the goal
> > is to make this platform-independent, might as well take the opportunity
> > to introduce a proper driver, no?
> 
> In theory, this is absolutely correct. I fear it will be hard to find anyone
> to make a larger scale cleanup of the file however. As my old changelog
> text says, there is only one board (smdk2416) in the kernel that registers
> the device. My change was the minimum to keep it working during the
> move to a multiplatform configuration, but if there is someone who has
> the hardware and volunteers to make a proper phy driver, that would also
> work.
> 
> As the board only exists as a reference for other boards, but none of those
> made it into the kernel, we could alternatively just decide to drop the
> driver. There is also a .dts file for the board, which is lacking a device node
> for the udc (and the driver lacks DT support), so that board file could also
> be dropped then, leaving only the DT version as a reference for the SoC.

All this is a work on a very old SoC with an unknown number of
current/real users. I don't have the hardware to test so I would prefer
to skip any big changes. As Arnd suggests, we could just drop this one
board and the driver... or if it does not harm/bother to much we could
keep it as is, just without platform header dependency. Someone still
might be using it.

Best regards,
Krzysztof

