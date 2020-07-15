Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793C6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5463A2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 21:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594849311;
	bh=M0vdn4ImpbRmLWUHprEfsOm1Lnqfa4MWsb7TRDWyk04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uGsPkgS7NiOGtBI2lALQy/kqlgCu6A0//2yhhNDKLn8X2g29oP3/5ANJpBBhWJB9G
	 LK246+n+rM1qFNJfEyUBZytbXJHFiFZ1e0wGLe6LyjoH6ZInMzontDaPTeYhDN8hXS
	 POql2t/kNc0mGDBU/VPxAIPWsfT++T+5/gCeZ8sI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGOVlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 17:41:50 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:38875 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgGOVlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 17:41:46 -0400
Received: by mail-il1-f196.google.com with SMTP id s21so3318449ilk.5;
        Wed, 15 Jul 2020 14:41:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yRYOnV/rwceyYZSpb8vUPcnarY2UGlhf4+zHnRr772I=;
        b=Z4iMVplNS11Ou1PFGpPb9WbTEZtkvOxW/QxPURoIqbs+tLx7LGZ92qvBvnBp9ANpl3
         MFPlPpA3HjR3avMzGfJ3Q++tSyniun5dV3EJRnBoja79q4pkSm+qUJvLhKrtKsR7OWqH
         Trre+NumzvNPO2l7P6RSpy+M09dxqzDJfjddwZy0ZPCYLDUAoTECDRBk2QQGupSd9EAC
         MqOnKDT6pn22P2QbC5a4s4XQq/hzACXc4yRxqn/p5gNjMVRMR+O0MuBigA1By9PbC1gN
         SE3S/2dIutMIg5f3X61dfou535q22+6u9bltQmdnqff7O1BI5ZMprun5Z217MqinaQdC
         Ok3g==
X-Gm-Message-State: AOAM532j1i6AzDQ+ecC+ZypHxwgu3gbAeknfXjXtwsrCwRY2t5B6Qe+D
        J3Jec7hHQOBjMpjZyUj/IQ==
X-Google-Smtp-Source: ABdhPJwcFZ4oF6Mja4fmrG4CbiHZsJ4kXTXf9mMj+xjeoPfczGS+I+7x/BP3inh5UC1cBFaPibzm1w==
X-Received: by 2002:a92:db06:: with SMTP id b6mr1627423iln.228.1594849305560;
        Wed, 15 Jul 2020 14:41:45 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l17sm1615289ilm.70.2020.07.15.14.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 14:41:44 -0700 (PDT)
Received: (nullmailer pid 865406 invoked by uid 1000);
        Wed, 15 Jul 2020 21:41:44 -0000
Date:   Wed, 15 Jul 2020 15:41:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Daniel M. Weeks" <dan@danweeks.net>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Correct vendor for mcp980x
Message-ID: <20200715214144.GB818608@bogus>
References: <20200703153748.GA16156@dev.danweeks.net>
 <4884254c-4406-5c04-3df7-030541b7c201@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4884254c-4406-5c04-3df7-030541b7c201@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 02:59:12PM -0700, Guenter Roeck wrote:
> On 7/3/20 8:37 AM, Daniel M. Weeks wrote:
> > Signed-off-by: Daniel M. Weeks <dan@danweeks.net>
> > ---
> >  Documentation/devicetree/bindings/hwmon/lm75.txt | 2 +-
> >  drivers/hwmon/lm75.c                             | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/lm75.txt b/Documentation/devicetree/bindings/hwmon/lm75.txt
> > index 273616702c51..e5bb554cd2c3 100644
> > --- a/Documentation/devicetree/bindings/hwmon/lm75.txt
> > +++ b/Documentation/devicetree/bindings/hwmon/lm75.txt
> > @@ -14,10 +14,10 @@ Required properties:
> >  		"maxim,max6626",
> >  		"maxim,max31725",
> >  		"maxim,max31726",
> > -		"maxim,mcp980x",
> >  		"nxp,pct2075",
> >  		"st,stds75",
> >  		"st,stlm75",
> > +		"microchip,mcp980x",
> >  		"microchip,tcn75",
> >  		"ti,tmp100",
> >  		"ti,tmp101",
> > diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> > index ba0be48aeadd..a8cfc7e4a685 100644
> > --- a/drivers/hwmon/lm75.c
> > +++ b/drivers/hwmon/lm75.c
> > @@ -690,10 +690,6 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
> >  		.compatible = "maxim,max31726",
> >  		.data = (void *)max31725
> >  	},
> > -	{
> > -		.compatible = "maxim,mcp980x",
> > -		.data = (void *)mcp980x
> > -	},
> >  	{
> >  		.compatible = "nxp,pct2075",
> >  		.data = (void *)pct2075
> > @@ -706,6 +702,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
> >  		.compatible = "st,stlm75",
> >  		.data = (void *)stlm75
> >  	},
> > +	{
> > +		.compatible = "microchip,mcp980x",
> > +		.data = (void *)mcp980x
> 
> Hmm, makes me wonder if we should replace this with correct chip names
> since we are at it. After all, it only includes mcp980{0,1,2,3} and not mcp9805.
> 
> Rob, any thoughts ?

Do we need to distinguish the chips? Aren't there existing users?

Rob
