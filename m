Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 973AFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D3DF207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 19:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20150623.gappssmtp.com header.i=@beagleboard-org.20150623.gappssmtp.com header.b="RPZS8L9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730133AbgEUTXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 15:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729475AbgEUTXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 15:23:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C18C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:23:44 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w7so7737090wre.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 12:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fo34Jyqqt3gxat3KrPs3T1U40ZqnzdXLMCRUHY0WScw=;
        b=RPZS8L9I1L4Hr5Yf3I0WZyvWE9tXEyfLro5fAWIp/dmJsPqh+Ut24o0bId4XRFvqDF
         CWNOVdYaeq+l9hSylp41TgmLZtINHkAcksO5wj5BcVbkedhQ49MX9tGUQ/3N+7eUgDkh
         QogS3XHbJg8Eig36uZmDP1zvm10EDs10g1lvXCbmiQ9nQHhVWBDbGS97ToTp8ubt08Ii
         2Xu4qeSds80NBbb1GviJwPnsTO6UbTvu7rXUIIbboDX7pCpmiEmYRoMAGp7jHrS7PIqo
         2hdkDWPEb62boxYvmm6V03Ouq21CCCrrDKietbbJl0gTjuFgBxqPRwLzp8a9BlKUFOeG
         8Rag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fo34Jyqqt3gxat3KrPs3T1U40ZqnzdXLMCRUHY0WScw=;
        b=tv0ZowH0mBAqliibuFZdB9UIOMptTSYbUpaWj1Kusu8ae4rPFmYkaEv491gVatkKZV
         U3Bg2rMNnTdV4UMOyI8Ozcc8Dc2HPmEBh4e6JbhO0KL42kcUTNipP+udYQ5OngYAl/1X
         0g9WKaXqZwA5eWr2+gLuM0FGKI+O8k0C/X/9cBJlEgCcDPVeR63OXXpFNmCFhIE8FX5o
         zAQDtNSbOnokMa8TJomNhjdS6I/a+JqzyOuMHkTqLgWi4QcSS8sCqqZbAXQUNmfEYyHJ
         v7HiqnE1WzIRR0DeASS1wxtlkUqhtkEkAIp0by0ugd+Ub1SkWvnbi78Rj3ai0UYUu/kr
         h4FQ==
X-Gm-Message-State: AOAM532JP705DDKxQUjKargth9dH6Sp9qI02KKDsKEf4fFh7Hox/G1DS
        3CTJA6jWOgXpnzFsQR4M4k79tg==
X-Google-Smtp-Source: ABdhPJy1sEiv5+j8jAF8WOiuIvxBcnPKzxFmdT9P/BihuQi5Njdrqu02Skt8Kb4CXk8rodOlNmPM3w==
X-Received: by 2002:a05:6000:85:: with SMTP id m5mr91049wrx.281.1590089022686;
        Thu, 21 May 2020 12:23:42 -0700 (PDT)
Received: from x1 (i59F66838.versanet.de. [89.246.104.56])
        by smtp.gmail.com with ESMTPSA id l18sm7208878wmj.22.2020.05.21.12.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 12:23:41 -0700 (PDT)
Date:   Thu, 21 May 2020 21:23:39 +0200
From:   Drew Fustini <drew@beagleboard.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Robert Nelson <robertcnelson@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux kernel <linux-kernel@vger.kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>
Subject: Re: [PATCH v2] arm: dts: am33xx-bone-common: add gpio-line-names
Message-ID: <20200521192339.GA429020@x1>
References: <20200520214757.GA362547@x1>
 <71dbf4e6-e65b-f001-319c-0b354f675568@ti.com>
 <CAOCHtYiw2jJuzbnW02FUmPy-xmmtErMmow46QQJUMs0VtX=cKg@mail.gmail.com>
 <cdf82f9c-48fb-49a0-99e4-926dc292c109@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf82f9c-48fb-49a0-99e4-926dc292c109@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 08:26:42PM +0300, Grygorii Strashko wrote:
> 
> 
> On 21/05/2020 17:41, Robert Nelson wrote:
> > > Not sure if it should be in am335x-bone-common.dtsi.
> > > 
> > > For example:
> > > am335x-boneblack.dts
> > >    #include "am335x-bone-common.dtsi"
> > >    #include "am335x-boneblack-common.dtsi" <-- hdmi defined only here
> > 
> > Ah crap, yeah that's a good point.. So if we stick it in...
> > am335x-boneblack-common.dtsi
> > 
> > Then the Black-Wireless now has Ethernet...
> > 
> > am335x-boneblack-wireless.dts
> > #include "am335x-bone-common.dtsi"
> > #include "am335x-boneblack-common.dtsi"
> > 
> > It's going to be ugly, copy and paste mess, but i guess we might as
> > well stick it in the device " am335x-boneblack.dts"?
> 
> Seems like.
> 
> Unfortunately, there is no way to partially overwrite "gpio-line-names"
> property.
> 
> -- 
> Best regards,
> grygorii

Thank you for pointing out that those gpio-line-names are really
specific to the BeagleBone Black and not applicable for other boards
like the BeagleBone Green which lack eMMC.

I will post a new patch for am335x-boneblack.dts.

After that is reviewed and applied, I will then create patches for the
the other BeagleBone models.

thanks,
drew
