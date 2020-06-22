Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D4BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B435520732
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jH12bvlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgFVTLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgFVTLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:11:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEADC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:11:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g18so8771692wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8wWKIKLl62YvxE5aJzOwwPk1paC8wJY238BgG0fGcg8=;
        b=jH12bvlETu4WQchE3dVyLhWqGLJr/JA0FNKBqj/g+1C39iTTzu9fmY47a550ltXpCi
         gOHutBX20RipGjWNar2tQsjZzWXY2s/ybGazOZJPAO+sxyhl9n4SLGpkXPZMznygB1c5
         SpjpeDE73oU8NOUGgk+vDAf8zVLcEo6s9KYR6uNehDfNsZ2sS+BJ09frHaPswgWAClSu
         hdBQZwFxTi8TaRKFvrjWH3Kuxp+2NTau5X0PZL98Vqmt0g3mUZOu+6GfhygZa1J++/co
         Qza0XJTFNnxz0IqgPLrRafkqxzWBp7tMt+L62gGfJJiDDsPawVHs/zPk48iRRpT6agVT
         Pm8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8wWKIKLl62YvxE5aJzOwwPk1paC8wJY238BgG0fGcg8=;
        b=H4SOKE0SeClSqB0Szy6kgWIcwDMZdqvRFdfhVWe9yLqIN/8jdMbFA/tsFFhWGizkOa
         Jg8nH2AoqHr0xvtvB1C3/kDCoSLTamh18xCG61YX13k3Ra2r3Aq59iWL8WCy433d8GHZ
         kz9jEbFTEE6plGCAtWNrfl6IVeAmp1mC0ZviAOU3IcPB42c6nDPNnyslI8l+QKn0fkXM
         nuo/cgeM27xuR4X4RucjFyn18DjX27L7CkGZSif//qMRn1pCen4NcOfmjW7zNWKAzvCu
         9q//IE7BLKZa7Zam37JdYfbc5NzbANI1sJQAsw2mqrcQqJ3IDpP/n6rLhjNDhl/mLxz5
         +dLg==
X-Gm-Message-State: AOAM530rr27i59iyEY/UmswW/nNDHeivcUQJPDmZLt4Wp0lPOHK4N957
        aislvJtTKcSyb81LjzCMzgb4VQ==
X-Google-Smtp-Source: ABdhPJyUNdg2X6juP+ha+wkXAdVR309klPO6g5E3pnk+GrQ7sLTFyXrhXPnKKqhBV1X2Sl8JQIqnVg==
X-Received: by 2002:adf:e648:: with SMTP id b8mr21197299wrn.386.1592853095745;
        Mon, 22 Jun 2020 12:11:35 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id q4sm585574wmc.1.2020.06.22.12.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:11:34 -0700 (PDT)
Date:   Mon, 22 Jun 2020 20:11:33 +0100
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
Message-ID: <20200622191133.GY954398@dell>
References: <20200611191002.2256570-1-lee.jones@linaro.org>
 <4b188fb5-6667-720d-46e1-6f103efe8966@gmail.com>
 <20200615092644.GA2608702@dell>
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
 <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
 <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020, Frank Rowand wrote:

> On 2020-06-22 10:10, Lee Jones wrote:
> > On Mon, 22 Jun 2020, Frank Rowand wrote:
> > 
> >> On 2020-06-22 03:50, Lee Jones wrote:
> >>> On Thu, 18 Jun 2020, Frank Rowand wrote:
> >>>
> >>>> On 2020-06-15 04:26, Lee Jones wrote:
> >>>>> On Sun, 14 Jun 2020, Frank Rowand wrote:
> >>>>>
> >>>>>> Hi Lee,
> >>>>>>
> >>>>>> I'm looking at 5.8-rc1.
> >>>>>>
> >>>>>> The only use of OF_MFD_CELL() where the same compatible is specified
> >>>>>> for multiple elements of a struct mfd_cell array is for compatible
> >>>>>> "stericsson,ab8500-pwm" in drivers/mfd/ab8500-core.c:
> >>>>>>
> >>>>>>         OF_MFD_CELL("ab8500-pwm",
> >>>>>>                     NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
> >>>>>>         OF_MFD_CELL("ab8500-pwm",
> >>>>>>                     NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
> >>>>>>         OF_MFD_CELL("ab8500-pwm",
> >>>>>>                     NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
> >>>>
> >>>>          OF_MFD_CELL("ab8500-pwm",
> >>>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
> >>>>
> >>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
> >>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
> >>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
> >>>>
> >>>>>>
> >>>>>> The only .dts or .dtsi files where I see compatible "stericsson,ab8500-pwm"
> >>>>>> are:
> >>>>>>
> >>>>>>    arch/arm/boot/dts/ste-ab8500.dtsi
> >>>>>>    arch/arm/boot/dts/ste-ab8505.dtsi
> >>>>>>
> >>>>>> These two .dtsi files only have a single node with this compatible.
> >>>>>> Chasing back to .dts and .dtsi files that include these two .dtsi
> >>>>>> files, I see no case where there are multiple nodes with this
> >>>>>> compatible.
> >>>>>>
> >>>>>> So it looks to me like there is no .dts in mainline that is providing
> >>>>>> the three "stericsson,ab8500-pwm" nodes that drivers/mfd/ab8500-core.c
> >>>>>> is expecting.  No case that there are multiple mfd child nodes where
> >>>>>> mfd_add_device() would assign the first of n child nodes with the
> >>>>>> same compatible to multiple devices.
> >>>>>>
> >>>>>> So it appears to me that drivers/mfd/ab8500-core.c is currently broken.
> >>>>>> Am I missing something here?
> >>>>>>
> >>>>>> If I am correct, then either drivers/mfd/ab8500-core.c or
> >>>>>> ste-ab8500.dtsi and ste-ab8505.dtsi need to be fixed.
> >>>>>
> >>>>> Your analysis is correct.
> >>>>
> >>>> OK, if I'm not overlooking anything, that is good news.
> >>>>
> >>>> Existing .dts source files only have one "ab8500-pwm" child.  They already
> >>>> work correcly.
> >>>>
> >>>> Create a new compatible for the case of multiple children.  In my example
> >>>> I will add "-mc" (multiple children) to the existing compatible.  There
> >>>> is likely a better name, but this lets me provide an example.
> >>>>
> >>>> Modify drivers/mfd/ab8500-core.c to use the new compatible, and new .dts
> >>>> source files with multiple children use the new compatible:
> >>>>
> >>>>          OF_MFD_CELL("ab8500-pwm",
> >>>>                      NULL, NULL, 0, 0, "stericsson,ab8500-pwm"),
> >>>>
> >>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>>>                          NULL, NULL, 0, 0, "stericsson,ab8500-pwm", 0),
> >>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>>>                          NULL, NULL, 0, 1, "stericsson,ab8500-pwm", 1),
> >>>>          OF_MFD_CELL_REG("ab8500-pwm-mc",
> >>>>                          NULL, NULL, 0, 2, "stericsson,ab8500-pwm", 2),
> >>>>
> >>>> The "OF_MFD_CELL" entry is the existing entry, which will handle current
> >>>> .dts source files.  The new "OF_MFD_CELL_REG" entries will handle new
> >>>> .dts source files.
> >>>
> >>> Sorry, but I'm not sure what the above exercise is supposed to solve.
> >>>
> >>> Could you explain it for me please?
> >>
> >> The OF_MFD_CELL() entry handles all of the existing .dts source files
> >> that only have one ab8500-pwm child nodes.  So existing .dtb blobs
> >> continue to work.
> >>
> >> The OF_MFD_CELL_REG() entries will handle all of the new .dts source
> >> files that will have up to 3 ab8500-pwm child nodes.
> >>
> >> Compatibility is maintained for existing .dtb files.  A new kernel
> >> version with the changes will support new .dtb files that contain
> >> multiple ab8500-pwm child nodes.
> > 
> > I can see *what* you're trying to do.  I was looking for an
> > explanation of *how* you think that will work.  FWIW, I don't think
> > what you're proposing will work as you envisage.  I thought that
> > perhaps I was missing something, which is why I requested further
> > explanation.
> > 
> >>>> And of course the patch that creates OF_MFD_CELL_REG() needs to precede
> >>>> this change.
> >>>>
> >>>> I would remove the fallback code in the existing patch that tries to
> >>>> handle an incorrect binding.  Just error out if the binding is not
> >>>> used properly.
> >>>
> >>> What fallback code?
> >>
> >> Based on reading the patch description, I expected some extra code to try
> >> to handle the case where the compatible in more than one struct mfd_cell
> >> entry is "stericsson,ab8500-pwm" and there are multiple ab8500-pwm child
> >> nodes.
> >>
> >> Looking at the actual code (which I had not done before), I see that the
> >> "best effort attempt to match" is keeping a list of child nodes that
> >> have already been used (mfd_of_node_list) and avoiding re-use of such
> >> nodes.  This allows an invalid .dtb (one with multple "stericsson,ab8500-pwm"
> >> child nodes) to possibly be assigned unique child nodes for multiple
> >> struct mfd_cell entries to be "stericsson,ab8500-pwm".
> >>
> >> So it is confusing for me to call that "fallback code".  It really is
> >> "best effort attempt to match" for a broken .dtb code.
> >>
> >> There should be no best effort for a broken .dtb.  The broken .dtb should
> >> instead result in an error.
> > 
> > The problem is, how can you tell the difference between a valid and a
> > broken FDT without pre-processing - which, as I explained in the
> > commit message, I am not prepared to do.  We cannot test individually
> > since all configurations (e.g. no 'reg' property are valid on an
> > individual basis.
> 
> If my proposed changes are made, then there are at least 3 ways to detect
> a broken FDT or prevent the problem caused by the broken FDT.
> 
> 
> 1) Use the validation process that uses the bindings to validate the
> devicetree source.

Could you provide an example please?

> 2) Modify patch 1/3.  The small part of the patch to modify is:
> 
> +static int mfd_match_of_node_to_dev(struct platform_device *pdev,
> +				    struct device_node *np,
> +				    const struct mfd_cell *cell)
> +{
> +	struct mfd_of_node_entry *of_entry;
> +	const __be32 *reg;
> +	u64 of_node_addr;
> +
> +	/* Skip devices 'disabled' by Device Tree */
> +	if (!of_device_is_available(np))
> +		return -ENODEV;
> +
> +	/* Skip if OF node has previously been allocated to a device */
> +	list_for_each_entry(of_entry, &mfd_of_node_list, list)
> 
> Change:
> 
> +		if (of_entry->np == np)
> +			return -EAGAIN;
> 
> To:
> 
> +		if (of_entry->np == np) {
> +			if (!cell->use_of_reg)
> +				return -EINVAL;
> +			else
> +				return -EAGAIN;
> 
> There may be a better choice than EINVAL, but I am just showing the method.
> 
> You may also want to refactor this section of the patch slightly
> differently to achieve the same result.  It was just easiest to
> show the suggested change the way I did it.
> 
> The test that returns EINVAL detects the issue that the FDT does
> not match the binding (there is more one child node with the
> "stericsson,ab8500-pwm" compatible.

So here, instead of just failing a single device, we fail everything?
Sounds a lot like throwing the baby out with the bath water.  How is
that an improvement?

> 3) I'm not sure if the pre-parsing that is wanted is parsing of the
> devicetree or parsing of the struct mfd_cell array.  If the mfd_cell
> array then solution 3 is not acceptable.
> 
> A different change to a small part of patch 1/3.  In mfd_add_devices(),
> validate parameter "cells".  The validation could precede the existing
> code, or it could be folded into the existing for loop.  The validation
> is checking for any other element of the cells array containing
> the same compatible value if cell->use_of_reg is not true for an element.
> 
> If this validation occurs, then I think mfd_of_node_list, and all the
> associated code to deal with it is no longer needed.  But I didn't
> look at this part in detail, so maybe I missed something.
> 
> The validation is something like (untested):
> 
> 	if (IS_ENABLED(CONFIG_OF)
> 		for (i = 0; i < n_devs; i++) {
> 			this_cell = cells + i;
> 			if (!this_cell->use_of_reg) {
> 				for (j = 1; j < n_devs; j++) {
> 					if (j != i) {
> 						cell = cells + j;
> 						if (!strcmp(this_cell->of_compatible, cell->of_compatible))
> 							return -EINVAL;
> 					}
> 				}
> 			}
> 		}

I think I just threw-up a little. ;)

Did you read the commit message?

  "We could code around this with some pre-parsing semantics, but the
  added complexity required to cover each and every corner-case is not
  justified.  Merely patching the current failing (via this patch) is
  already working with some pretty small corner-cases"
  
Providing thorough pre-parsing would be highly complex and highly
error prone.  The example you provide above is not only ugly, there
are numerous issues with it.  Not least:

 * Only one corner-case is covered
 * Validation is only completed on a single mfd_cells struct
 * False positives can occur and will fail as a result

The above actually makes the solution worse, not better.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
