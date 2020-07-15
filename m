Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 571862064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 22:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7/jal1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgGOWTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 18:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOWTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 18:19:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930A4C061755;
        Wed, 15 Jul 2020 15:19:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so2721395pfm.4;
        Wed, 15 Jul 2020 15:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L5GmY7L5HiAC8HqdYtfQXZjWPSkTCivraVGIeIH6xEE=;
        b=f7/jal1vkki2RMNvTtMvqlOoaX3OnyJjnqEf2IOuHHcNk+elT7V1peCYtakcnQKvYz
         39UUvOvtcTCYIB+/jO1Jf4tjL8ODVmiqKj9ck5jrqyXMND8A4CjUVcduigaso+4NfTd6
         TB+GHfya+bAw1mZrIKRkTf9IShgncIbmPM5TRxpHKQwaQ8HNL6SaMkja76angsIUZqrF
         Y65OiLeLbz5HB7rgtYxavkaQY6VgFVbM7f/ZC2hI0fXc/uF0yAHfcHbAkdeui+/jBIxj
         /PcrpON+lxb9qnc9pag2p7b3+GoCZ4W/FHQ8hNnfm6FuwF1YeQAAT4AVkX7HEY3r/yL9
         iGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=L5GmY7L5HiAC8HqdYtfQXZjWPSkTCivraVGIeIH6xEE=;
        b=E1bgmzGLQf4bxFutbI5TzhxbOx1wZvfeD7pXVWf2oVbjXhkvjkU2F1dwMEVFyxpEZ4
         qhBZdg0aY2AQh3wX9jT89d6ES1NYw/ffsu8uxI5xnlh9RayarnRjUqNVQLTbxqsdYU67
         BvlOttxdacxEV8zdYpplqVg/e52r1nk4wHz3S8F7xA+asrOPjVtwiSXqg43Tagt3pouh
         3aq+Bx71YebHwueQv5I790tut7K1TxZjp1ZIPRaxYm1bHQtLa9OrHudPoFxnFvnUmbsU
         epUb1CCiDQ7XGQAInkwzrVAGPFN07m0EqcP8mCWeNRJNmyAMgQZKTo7D2b6YR9QkoV5S
         YTLg==
X-Gm-Message-State: AOAM532ewkC445dPJx8nKrX7IjzUL/6w9QTUN0GIOgmJOKFU3kXLlsJt
        R5gGiwbeguZpTzuMKt7YSXM=
X-Google-Smtp-Source: ABdhPJzHPKvV0aI6JxTWi/oUAVWq5l+4QlNduI5iAu8bPUuehKV+rdPs5HKsHkBQkH22ybvdvFQBOw==
X-Received: by 2002:a63:6884:: with SMTP id d126mr1530707pgc.341.1594851553028;
        Wed, 15 Jul 2020 15:19:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m68sm3299747pje.24.2020.07.15.15.19.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Jul 2020 15:19:12 -0700 (PDT)
Date:   Wed, 15 Jul 2020 15:19:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh@kernel.org>
Cc:     "Daniel M. Weeks" <dan@danweeks.net>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: hwmon: Correct vendor for mcp980x
Message-ID: <20200715221911.GA231856@roeck-us.net>
References: <20200703153748.GA16156@dev.danweeks.net>
 <20200715213917.GA818608@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715213917.GA818608@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 03:39:17PM -0600, Rob Herring wrote:
> On Fri, Jul 03, 2020 at 11:37:48AM -0400, Daniel M. Weeks wrote:
> > Signed-off-by: Daniel M. Weeks <dan@danweeks.net>
> 
> Commit message? Isn't this going to break any users? Or we rely on i2c 
> stripping the vendor?
> 
Looks like there are no in-kernel users.

Guenter

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
> > +	},
> >  	{
> >  		.compatible = "microchip,tcn75",
> >  		.data = (void *)tcn75
> > -- 
> > Daniel M. Weeks
