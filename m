Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26A6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91952067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRV9AHva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGOWZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgGOWZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:25:57 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F25C061755;
        Wed, 15 Jul 2020 15:25:57 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so2744221pfu.1;
        Wed, 15 Jul 2020 15:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8N4u26oEktbEGWl54hQm2lN1LaijoMiaRFGU/9U8PDk=;
        b=MRV9AHvao9buHIp7pSx2ScrysbROrQGVZuE1ILnD7j5sTl79iB8MLUUor+N3O5AD8W
         QTkOt/JKFngpiaL29zGRyTR1F7cSrZZxIEvisVdXX3pY1Dy4oUPLqmeD7l/zHONQxBBo
         vcU9NESRTID3tqAUCx2XYbtkc0/VQ7qTUDpWHi2qKksSTKJD+fkpnNyFRWTf5+GkrmKX
         0H38wZ3IWWQiyUuLB9Agik9KuecvLc/3Z78Bb5cMMZBRhnql4uINk5QwNN1Vwjt2z7Um
         j/zUzAs8HNcrfhQy7h0laUfNr4AqhhcuSaTqvf8C4apTKwe9gvlmi3OAUYQ6zHDGso3D
         EHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8N4u26oEktbEGWl54hQm2lN1LaijoMiaRFGU/9U8PDk=;
        b=Usc8mmzrnngPI2dJ1Q4XuJyGmzbitRqCKM91DM3Op8Rgs9Dha7VTjKdWNUpWRUd+8V
         J3YzwRrPcb2RdoOh91+HBI136BFpN2nhcfg7D2k+qd9SuRBSen7dfXNSIWbjriur5BlM
         i5Cks7DBURk94stNgTiUHqFYlxYWvuUgr5Mi79zRta1bKLKfapF+6JlH6zvCfp/Suh0r
         UFXgVcyEVW0jeQwrbb3M5X/99jG5L/N8OPVcgveoba5LWlaUxeWCo/+NvWkDgWdMXtZA
         IYf8QALmdhvcxj+UqEQBRrYY5r3C6waZkc8P27kln3Xvso26wPeKmLrgwmktKFCn4v+f
         vSmQ==
X-Gm-Message-State: AOAM530EmPqicAozt0G4s7I3oedkaPahp6F55XI0sAFgBWAnmw/w+IbR
        IoXNvrSQ2vtFdgXi2vdFWOc=
X-Google-Smtp-Source: ABdhPJxDkkD4bbUCLfqvW61fzqrPSnllNfDvMB+WO4uNYZcZsniSxZticO0kR2wBlKIeTnYeQd1F6Q==
X-Received: by 2002:a63:225d:: with SMTP id t29mr1695049pgm.374.1594851955726;
        Wed, 15 Jul 2020 15:25:55 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b6sm3073434pfp.0.2020.07.15.15.25.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 15:25:55 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:25:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     "Daniel M. Weeks" <dan@danweeks.net>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Correct vendor for mcp980x
Message-ID: <20200715222554.GB231856@roeck-us.net>
References: <20200703153748.GA16156@dev.danweeks.net>
 <4884254c-4406-5c04-3df7-030541b7c201@roeck-us.net>
 <20200715214144.GB818608@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715214144.GB818608@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 03:41:44PM -0600, Rob Herring wrote:
> On Fri, Jul 03, 2020 at 02:59:12PM -0700, Guenter Roeck wrote:
> > On 7/3/20 8:37 AM, Daniel M. Weeks wrote:
> > > Signed-off-by: Daniel M. Weeks <dan@danweeks.net>
> > > ---
> > >  Documentation/devicetree/bindings/hwmon/lm75.txt | 2 +-
> > >  drivers/hwmon/lm75.c                             | 8 ++++----
> > >  2 files changed, 5 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
> > > index 273616702c51..e5bb554cd2c3 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/lm75.txt
> > > +++ b/Documentation/devicetree/bindings/hwmon/lm75.txt
> > > @@ -14,10 +14,10 @@ Required properties:
> > >  		"maxim,max6626",
> > >  		"maxim,max31725",
> > >  		"maxim,max31726",
> > > -		"maxim,mcp980x",
> > >  		"nxp,pct2075",
> > >  		"st,stds75",
> > >  		"st,stlm75",
> > > +		"microchip,mcp980x",
> > >  		"microchip,tcn75",
> > >  		"ti,tmp100",
> > >  		"ti,tmp101",
> > > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> > > index ba0be48aeadd..a8cfc7e4a685 100644
> > > --- a/drivers/hwmon/lm75.c
> > > +++ b/drivers/hwmon/lm75.c
> > > @@ -690,10 +690,6 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
> > >  		.compatible = "maxim,max31726",
> > >  		.data = (void *)max31725
> > >  	},
> > > -	{
> > > -		.compatible = "maxim,mcp980x",
> > > -		.data = (void *)mcp980x
> > > -	},
> > >  	{
> > >  		.compatible = "nxp,pct2075",
> > >  		.data = (void *)pct2075
> > > @@ -706,6 +702,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
> > >  		.compatible = "st,stlm75",
> > >  		.data = (void *)stlm75
> > >  	},
> > > +	{
> > > +		.compatible = "microchip,mcp980x",
> > > +		.data = (void *)mcp980x
> > 
> > Hmm, makes me wonder if we should replace this with correct chip names
> > since we are at it. After all, it only includes mcp980{0,1,2,3} and not mcp9805.
> > 
> > Rob, any thoughts ?
> 
> Do we need to distinguish the chips? Aren't there existing users?
> 

We don't specifically need to distinguish mcp908[0123], but "x"
does not represent [0-9], only [0-3]. This driver does not support
mcp9805, for example. I don't know how this kind of situation is
handled in other drivers.

Looks like there are no existing in-kernel users. The initial entry for
mcp980x was added back in 2008, with no DT support in mind.
"maxim,mcp980x" was added with of_device_id table in 2017, with no one
(including me) realizing that this is not a Maxim chip.

Guenter
