Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D77EC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:27:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E055720757
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I4vZV4PA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD2G1c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgD2G1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:27:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF6EC035494
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 23:27:29 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b11so1030666wrs.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 23:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=wv05h1X7qRrPjYPf9y0VD7+PHwezUYitVP0Fh0igQuY=;
        b=I4vZV4PACb5f7K2uxifM99GPqkcfyrpLc74PzSrCUF61KrqkAGgKNBFNHr+XiC1Zzr
         XqIjNrgmZ91TIAda8FEWPq1gg3Xaa84/0qQWu5Ae3sW4csU35iEp2O/nwCWdMpbr7El6
         eoZD/tvPP5RteAWgnhbWIY/PMqJ+ssDOZvekrrEimOB3ENhCiVutsoNIJ5zLGgynqmXb
         8Rc5rpcdAkqbshwzs7C11AcGOjJ9hcJFu+NIFlqEadlAtAupqh+9vJ50K1QkhtgQmjWR
         R9djt4X9WtAHl95Nhhfz3sSbWTT0MATduTJ2F9hJdP0sNOI+tsziWlYROFDtUt7Fy1Op
         uYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=wv05h1X7qRrPjYPf9y0VD7+PHwezUYitVP0Fh0igQuY=;
        b=V4RFtXsGsICCIWbl4RircIm0OXtIGJhk55hU9IpasQoe9mosAqifWcBPDDUwUmg+IP
         tiU5dKiS9+D8XB4tcIG6vfLiSG64fI3yo/E9hZbsosWypYA9h1OU+Az3kac6x/tZEWJZ
         pFoSpWuJJhzJOXVgncbqgmmm9NM+ZnjA6IEsBLwNh8buuPAS9pK43+FcttWbwikGTqwM
         heH7jQ4u8e5QuMDqrAw4Gvh5M0FOnmhlkasEZ19hi/kB72CUBN8Up1eFk8JRDrITWhzB
         +6/l+wvM6xMJBn1zerqViwDdaQNkOiN+dCIzLOiJGa7MO67RqSARZxn9qoE++ie6TuX5
         ZuXQ==
X-Gm-Message-State: AGi0PuY/nIMEw/nQlZkgLBStuLaOZ+Gr+9UxlOCf2tKF8yyZJa9+ILpJ
        NGN6qrxW3QgYG2K9OFiVBoJAqA==
X-Google-Smtp-Source: APiQypKTqIt46QQB2nB/SSJZXWRFVeB9A294fdRkNMgBYLOeiiFcpBnVXBSKVh/jOHoB1iCbHHyjSA==
X-Received: by 2002:adf:f187:: with SMTP id h7mr37818290wro.331.1588141648280;
        Tue, 28 Apr 2020 23:27:28 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id t17sm27729510wro.2.2020.04.28.23.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 23:27:27 -0700 (PDT)
Date:   Wed, 29 Apr 2020 07:27:25 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 05/16] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200429062725.GU3559@dell>
References: <20200423174543.17161-1-michael@walle.cc>
 <20200423174543.17161-6-michael@walle.cc>
 <20200428125049.GU185537@smile.fi.intel.com>
 <5e2d486077f9e2ce8bd9b171cf806fd9@walle.cc>
 <20200428144958.GZ185537@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200428144958.GZ185537@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020, Andy Shevchenko wrote:

> On Tue, Apr 28, 2020 at 04:43:24PM +0200, Michael Walle wrote:
> > Am 2020-04-28 14:50, schrieb Andy Shevchenko:
> > > On Thu, Apr 23, 2020 at 07:45:32PM +0200, Michael Walle wrote:
> > > > This patch adds core support for the board management controller found
> > > > on the SMARC-sAL28 board. It consists of the following functions:
> > > >  - watchdog
> > > >  - GPIO controller
> > > >  - PWM controller
> > > >  - fan sensor
> > > >  - interrupt controller
> > > 
> > > ...
> > > 
> > > >  obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> > > > 
> > > >  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> > > > +
> > > > +obj-$(CONFIG_MFD_SL28CPLD)	+= sl28cpld.o
> > > 
> > > Perhaps keep an order?
> > 
> > I don't see any order in that makefile. Looked to me like every new
> > file was added at the end.
> 
> Okay, just didn't note from above context.

Yes, this is historical.  I've been meaning to visit this for ~7 years!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
