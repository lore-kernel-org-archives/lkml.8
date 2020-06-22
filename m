Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887E2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 645F22068F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 08:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1czj5/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgFVIuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 04:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgFVIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 04:50:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:50:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so15775930wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 01:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2pe38k03Di4JjdcjaPHQ0TSLRnrktMq6M6UKWiJjYyg=;
        b=H1czj5/tMXsaUU8jQQLmo48P8FXGXM8lfjYElph8keBvcmynoIYkw0E/kw12Qs4yyc
         aKZUVFUeAr4xwDwwprzPZUYnnVQ8SD7aLLFMk+HhdohYt6MRABXL8V1whsNg/xR4D7MJ
         yEd9UUKTw/7Iayn7Ib1fEor3k2SJeS4R3q+9RirnkQ+CUrF5FYz8RMguG3ULwQBytL4A
         2giF7V5YClwVmgYBwRZUAOPPpiOdDJV0hj1KPD9RrkfgBXcF3Ejq8DIM7uPv52IzMpHL
         G/QTdlbqyUpfPstPjjVNiTlJDKE3elvdOFPjTEJpUvlSF66pUx+FAszQK28076qfdiCe
         WdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2pe38k03Di4JjdcjaPHQ0TSLRnrktMq6M6UKWiJjYyg=;
        b=ZSbeh8CxRQRT8+jvvuQPGsVSBLeHDElvkEbhGAbkbW/ldQQzALjtiUFH9cYMt7deWN
         GXL8vo0QfqWfLjwJkOMukL9YK5tI38udkOGka8EY5sXNwBbC4px/Rlq5WdO0ez51bHw6
         yVsUVqUmc0QFJLJpcB94yBIJ19kFJ2Tg/1HKlAqA1lEhWkh39Ks1UuJSsGl8jUH8fCBz
         dyfmB4SigrDrIsOdQMnFgRUFEFYMJzXtWNsKj8Tqtr3KUezPMsozZzB3+x72jIdIrBY6
         iRtH7T3tnXd0GavQzizHrMSS4qAtxkEoy+BdH90L5Q+r2R3l0PlEzzeuz8fv+GkbkQ+6
         c7iw==
X-Gm-Message-State: AOAM5306IUBUqvGeOw2J6EUwBDP5d89P5sWwVGAA2naE02bKPS2cWMfA
        QUCCvU68rEpv6Z62M8oUw1dsOg==
X-Google-Smtp-Source: ABdhPJwpmSXOor6kxYfD8+BD9tXBZQyiV+hdFCfcDxHCaiqLZmk8jIfRba/ngIRMDSLcC6TR3zEXhQ==
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr17565839wrv.162.1592815812390;
        Mon, 22 Jun 2020 01:50:12 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id i19sm10121054wrb.56.2020.06.22.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 01:50:11 -0700 (PDT)
Date:   Mon, 22 Jun 2020 09:50:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     andy.shevchenko@gmail.com, michael@walle.cc, robh+dt@kernel.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linus.walleij@linaro.org, linux@roeck-us.net,
        andriy.shevchenko@linux.intel.com, robin.murphy@arm.com,
        gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mfd: core: Make a best effort attempt to match
 devices with the correct of_nodes
Message-ID: <20200622085009.GP954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
 <20200615092644.GA2608702@dell>
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020, Frank Rowand wrote:

> On 2020-06-15 04:26, Lee Jones wrote:
> > On Sun, 14 Jun 2020, Frank Rowand wrote:
> > 
> >> Hi Lee,
> >>
> >> I'm looking at 5.8-rc1.
> >>
> >> The only use of OF_MFD_CELL() where the same compatible is specified
> >> for multiple elements of a struct mfd_cell array is for compatible
> >> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
> >>
> >>         OF_MFD_CELL("ab8500-pwm",
> >>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
> >>         OF_MFD_CELL("ab8500-pwm",
> >>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
> >>         OF_MFD_CELL("ab8500-pwm",
> >>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
> 
>          OF_MFD_CELL("ab8500-pwm",
>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
> 
>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
> 
> >>
> >> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
> >> are:
> >>
> >>    arch/arm/boot/dts/ste-ab8500.dtsi
> >>    arch/arm/boot/dts/ste-ab8505.dtsi
> >>
> >> These two .dtsi files only have a single node with this compatible.
> >> Chasing back to .dts and .dtsi files that include these two .dtsi
> >> files, I see no case where there are multiple nodes with this
> >> compatible.
> >>
> >> So it looks to me like there is no .dts in mainline that is providing
> >> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
> >> is expecting.  No case that there are multiple mfd child nodes where
> >> mfd_add_device() would assign the first of n child nodes with the
> >> same compatible to multiple devices.
> >>
> >> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
> >> Am I missing something here?
> >>
> >> If I am correct, then either drivers/mfd/ab8500-core.c or
> >> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.
> > 
> > Your analysis is correct.
> 
> OK, if I'm not overlooking anything, that is good news.
> 
> Existing .dts source files only have one "ab8500-pwm" child.  They already
> work correcly.
> 
> Create a new compatible for the case of multiple children.  In my example
> I will add "-mc" (multiple children) to the existing compatible.  There
> is likely a better name, but this lets me provide an example.
> 
> Modify drivers/mfd/ab8500-core.c to use the new compatible, and new .dts
> source files with multiple children use the new compatible:
> 
>          OF_MFD_CELL("ab8500-pwm",
>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
> 
>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
>          OF_MFD_CELL_REG("ab8500-pwm-mc",
>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
> 
> The "OF_MFD_CELL" entry is the existing entry, which will handle current
> .dts source files.  The new "OF_MFD_CELL_REG" entries will handle new
> .dts source files.

Sorry, but I'm not sure what the above exercise is supposed to solve.

Could you explain it for me please?

> And of course the patch that creates OF_MFD_CELL_REG() needs to precede
> this change.
> 
> I would remove the fallback code in the existing patch that tries to
> handle an incorrect binding.  Just error out if the binding is not
> used properly.

What fallback code?

> > Although it's not "broken", it just works when it really shouldn't.
> > 
> > I will be fixing the 'ab8500-pwm' case in due course.
> > 
> >> Moving forward, your proposed OF_MFD_CELL_REG() method seems a good
> >> approach (I have not completely read the actual code in the patch yet
> >> though).
> > 
> > Thanks.
> > 
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
