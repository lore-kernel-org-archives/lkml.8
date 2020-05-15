Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3091EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F02F0206DC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589510783;
	bh=H4e2zvT+YrcTjokdaWkwaWOlO3wYSMOzCWgE2xRGVcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D4p3Ru7C5QFNVbWexSwYwUi+JalY1pg3WKXRxrCYtmWT7gz86sbCkpvV8hYdWhSxh
	 77ElWjXsWYw7Li0DmXdfwoMte3DB7JQHjLhKGrtWDg9xULRWtnF9KoMkaDC6G/wEKO
	 c45luLlW+QZ9hLCgkFjnsaBoef8KmvJiQDy40jpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgEOCqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:46:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41099 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEOCqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:46:22 -0400
Received: by mail-ot1-f67.google.com with SMTP id 63so771579oto.8;
        Thu, 14 May 2020 19:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YN5xZpNt5GyNDO5nWG4auecH7ZpdMSla6Yt8yfouSQo=;
        b=rSrkGvuDNl3CdYHRznjxWdRUtNHcIOMVqdQn0DLhF1+MRrO/TT7HsFCo2/VklwuNaJ
         RcYlYjdXwxej9pQiEbM4lBKkW+wTrXnryKY0B4435Z1TG0M8g+LAqNIv9s1uYSqHnK9C
         P1PkbsptSS4D3EGpNlMA0s7UYSSoERsgbOShFMdBrYMrDoDsVyiGhyiHuEa2v3AczgaL
         UiaB7JXU4pGbZDUNbYEbhwY5F8NRPqXej59jQ/6oa0ojGN4Q8+PcMo//zx8WAzUSq4x3
         8nkDPyv80/FFCPiuZZVymkKDTVHKIr/Wo/+S3F/E44GHtPxQEf99Gy8raLocDRvmP6At
         TYIg==
X-Gm-Message-State: AOAM530AKctZdA9JV/nJBeHyLYZJeV0B14TPXZTt1gIvdynrHk84O04k
        AhorOVmib6fG2yN2pSMxLQ==
X-Google-Smtp-Source: ABdhPJzWUQeHtgBCeRll3WEGJbez6Twj+KxwB/s/mooUbl9KSh3g//aiLQ/rBnPQxzbOFgvzQqTiZQ==
X-Received: by 2002:a05:6830:18a:: with SMTP id q10mr163949ota.25.1589510779698;
        Thu, 14 May 2020 19:46:19 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s10sm232573otd.69.2020.05.14.19.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 19:46:19 -0700 (PDT)
Received: (nullmailer pid 23921 invoked by uid 1000);
        Fri, 15 May 2020 02:46:18 -0000
Date:   Thu, 14 May 2020 21:46:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Yoshihiro Kaneko <ykaneko0929@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3] dt-bindings: irqchip: renesas-intc-irqpin: Convert to
 json-schema
Message-ID: <20200515024618.GA20810@bogus>
References: <20200507075503.32291-1-geert+renesas@glider.be>
 <CAMuHMdVyFW-oWsDsOAC+H4f3oQZpwH=dPQHy3djgHnEJ-81+ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVyFW-oWsDsOAC+H4f3oQZpwH=dPQHy3djgHnEJ-81+ug@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:42:35PM +0200, Geert Uytterhoeven wrote:
> On Thu, May 7, 2020 at 9:55 AM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >
> > Convert the Renesas Interrupt Controller (INTC) for external pins Device
> > Tree binding documentation to json-schema.
> >
> > Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> > Co-developed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.yaml
> 
> > +  sense-bitfield-width:
> > +    allOf:
> > +      - $ref: /schemas/types.yaml#/definitions/uint32
> > +      - enum: [2, 4]
> > +        default: 4
> 
> The "allOf" is no longer needed.  Will remove for v4.

I'll fix up and apply.

Rob
