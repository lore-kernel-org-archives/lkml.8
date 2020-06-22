Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB5FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A00D6206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:11:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6w/qFKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgFVPK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbgFVPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:10:58 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E19AC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:10:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so17011956wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 08:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uV5siP5rOK7AKV7K8bUEtLW/MxF14bsX1OTElpQtjFo=;
        b=o6w/qFKRTdLMyH9XbNFJ8kYVE0QmXKJ1zeCSgL/AbltwBneA9RPFZHbh+nTyCrzX+A
         M0MchT+49VEypV6KS8LzsmRBsuRYtsiF8O/D6fSPDyYjhiA4Bst9Swe09drQJStrnfK/
         ugKnmtFi3Xhr8UWttcsap6fRcsmeSuXL3tShXetDTYUT44gIOH0IXLDceVrnbOESiA94
         bPNLj3poRFpdCK0JB1h/oVAR+Rz2ZPZIUEIEc4XV+tL5dTI67dZVQWb2LuJCYDW+/5zp
         35g6uZoAxLoIBmQa3wQ3vrO6Q1jW7A+gwA87KxcJyJmlGCyfFv2Mss300QCen8Os1fKu
         eV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uV5siP5rOK7AKV7K8bUEtLW/MxF14bsX1OTElpQtjFo=;
        b=gF8HLgNJGBNRsv4qP8ZRRezRfPrztr5n5k76C+FFvkiMzkVtcaLTIGX1+DWyU3XZWg
         M0Uva7oomIVoNequgjSo80BVBsZFxGalzRs01qSw0r78ZhEuFOWjv25D76qznJCF9UUC
         ux0V1nVfHYIeU15mLpFBqgoO87NOXtjj9xMKptJ0fxWmrVGv4VPtfg9yVvr7l/k/1wJz
         1dpsztl/8o9GHj+hqI0VXffpKrbLNuwzPpkemjAR6s2/BqCc9V/eqNWpdfbPu6TosKK9
         nadnG0gGdgzI+bvejhe+dLYzJmaLIi7ulGodsxNJc+v+kLHJvXZqQnpTFVHGesxusJyV
         1Mqw==
X-Gm-Message-State: AOAM532kC5Ylu7Ri7S5kuXlaD/Wr0xhDQVwC4a2gulGUR7QPpzC7xRKv
        /cDJiOJkS7A40g/IQNhC0si7gQ==
X-Google-Smtp-Source: ABdhPJw7n1/fFE/sPLSFzFBFg5NSSCaw+2GydbupjXWzJ2RtDdb6OWmwGznwi/QrFZLCq+xVOWZGcg==
X-Received: by 2002:a5d:62cd:: with SMTP id o13mr8316837wrv.272.1592838656741;
        Mon, 22 Jun 2020 08:10:56 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id g16sm13068994wrh.91.2020.06.22.08.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 08:10:56 -0700 (PDT)
Date:   Mon, 22 Jun 2020 16:10:54 +0100
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
Message-ID: <20200622151054.GW954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
 <20200615092644.GA2608702@dell>
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
 <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020, Frank Rowand wrote:

> On 2020-06-22 03:50, Lee Jones wrote:
> > On Thu, 18 Jun 2020, Frank Rowand wrote:
> > 
> >> On 2020-06-15 04:26, Lee Jones wrote:
> >>> On Sun, 14 Jun 2020, Frank Rowand wrote:
> >>>
> >>>> Hi Lee,
> >>>>
> >>>> I'm looking at 5.8-rc1.
> >>>>
> >>>> The only use of OF_MFD_CELL() where the same compatible is specified
> >>>> for multiple elements of a struct mfd_cell array is for compatible
> >>>> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
> >>>>
> >>>>         OF_MFD_CELL("ab8500-pwm",
> >>>>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
> >>>>         OF_MFD_CELL("ab8500-pwm",
> >>>>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
> >>>>         OF_MFD_CELL("ab8500-pwm",
> >>>>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
> >>
> >>          OF_MFD_CELL("ab8500-pwm",
> >>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
> >>
> >>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
> >>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
> >>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
> >>
> >>>>
> >>>> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
> >>>> are:
> >>>>
> >>>>    arch/arm/boot/dts/ste-ab8500.dtsi
> >>>>    arch/arm/boot/dts/ste-ab8505.dtsi
> >>>>
> >>>> These two .dtsi files only have a single node with this compatible.
> >>>> Chasing back to .dts and .dtsi files that include these two .dtsi
> >>>> files, I see no case where there are multiple nodes with this
> >>>> compatible.
> >>>>
> >>>> So it looks to me like there is no .dts in mainline that is providing
> >>>> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
> >>>> is expecting.  No case that there are multiple mfd child nodes where
> >>>> mfd_add_device() would assign the first of n child nodes with the
> >>>> same compatible to multiple devices.
> >>>>
> >>>> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
> >>>> Am I missing something here?
> >>>>
> >>>> If I am correct, then either drivers/mfd/ab8500-core.c or
> >>>> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.
> >>>
> >>> Your analysis is correct.
> >>
> >> OK, if I'm not overlooking anything, that is good news.
> >>
> >> Existing .dts source files only have one "ab8500-pwm" child.  They already
> >> work correcly.
> >>
> >> Create a new compatible for the case of multiple children.  In my example
> >> I will add "-mc" (multiple children) to the existing compatible.  There
> >> is likely a better name, but this lets me provide an example.
> >>
> >> Modify drivers/mfd/ab8500-core.c to use the new compatible, and new .dts
> >> source files with multiple children use the new compatible:
> >>
> >>          OF_MFD_CELL("ab8500-pwm",
> >>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
> >>
> >>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
> >>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
> >>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
> >>
> >> The "OF_MFD_CELL" entry is the existing entry, which will handle current
> >> .dts source files.  The new "OF_MFD_CELL_REG" entries will handle new
> >> .dts source files.
> > 
> > Sorry, but I'm not sure what the above exercise is supposed to solve.
> > 
> > Could you explain it for me please?
> 
> The OF_MFD_CELL() entry handles all of the existing .dts source files
> that only have one ab8500-pwm child nodes.  So existing .dtb blobs
> continue to work.
> 
> The OF_MFD_CELL_REG() entries will handle all of the new .dts source
> files that will have up to 3 ab8500-pwm child nodes.
> 
> Compatibility is maintained for existing .dtb files.  A new kernel
> version with the changes will support new .dtb files that contain
> multiple ab8500-pwm child nodes.

I can see *what* you're trying to do.  I was looking for an
explanation of *how* you think that will work.  FWIW, I don't think
what you're proposing will work as you envisage.  I thought that
perhaps I was missing something, which is why I requested further
explanation.

> >> And of course the patch that creates OF_MFD_CELL_REG() needs to precede
> >> this change.
> >>
> >> I would remove the fallback code in the existing patch that tries to
> >> handle an incorrect binding.  Just error out if the binding is not
> >> used properly.
> > 
> > What fallback code?
> 
> Based on reading the patch description, I expected some extra code to try
> to handle the case where the compatible in more than one struct mfd_cell
> entry is "stericsson,ab8500-pwm" and there are multiple ab8500-pwm child
> nodes.
> 
> Looking at the actual code (which I had not done before), I see that the
> "best effort attempt to match" is keeping a list of child nodes that
> have already been used (mfd_of_node_list) and avoiding re-use of such
> nodes.  This allows an invalid .dtb (one with multple "stericsson,ab8500-pwm"
> child nodes) to possibly be assigned unique child nodes for multiple
> struct mfd_cell entries to be "stericsson,ab8500-pwm".
> 
> So it is confusing for me to call that "fallback code".  It really is
> "best effort attempt to match" for a broken .dtb code.
> 
> There should be no best effort for a broken .dtb.  The broken .dtb should
> instead result in an error.

The problem is, how can you tell the difference between a valid and a
broken FDT without pre-processing - which, as I explained in the
commit message, I am not prepared to do.  We cannot test individually
since all configurations (e.g. no 'reg' property are valid on an
individual basis.

The best we can do is "best effort", to try and match each cell with
its requested OF node.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
