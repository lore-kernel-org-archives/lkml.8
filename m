Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660C9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF9E2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 19:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CeTwP3xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387546AbgFWT7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 15:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733302AbgFWT7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 15:59:12 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5978EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:59:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g75so12152wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IPdMfNBCb3ooyKxisNbJboD6zq07Gvy74xhRp0EuCMo=;
        b=CeTwP3xdcLmwwCQ6Fp2yvYkY9zraSYXGspSaLBeT7GB1HENWbjidC+8alq/+trmwCQ
         H6x+05l6tmgMZyB/W/Fw1lMoUu5FmqlIETo88G3NEKWdUCJmkkwh6SD8EjoW7+HwO8Wx
         cB09rJhmKpH5lNzTtahGMVkTCCsUffCh6R7KCPG71F31fKynMeSM92ArlZf/Y/4471uJ
         lcM2UyMnz0thKKrSPzXZjDPWr/IuilFgGiwFchVIazg/tzu6YKyJ403YYPX4SCAHsqCj
         zCTDAAXh+VvuS1qrdKUgPhqaEELsOyBhijUUAGoXmtfGivUKXTH91NMDSiTtm/lLwLb2
         YACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IPdMfNBCb3ooyKxisNbJboD6zq07Gvy74xhRp0EuCMo=;
        b=EWQIECNwFSK1uPQGRWRz8eMabxODZ4lLDfhzSCJSSECQoWVsqOJVzlM/w9orb52ba4
         EmKQ0WoSMFjBsWvwc68wr65lp5hoolRalCnNrfm0oH5JosxC8AaO5Dr9MmXd9wPP1aMX
         lWDljBmyDivFqb5D+/kJvMFblftZqgBj2OJJIBoRCHDE1co2G0juCbxHjBVNPIntEZIC
         Kz52sIkJ5+Pzg+dkoAnsklWwxTdZ2J7Ydpt0dusQ1RybFquu/DPj1Hw7JoI24W+5H6AX
         nLMZ75MuTpjVNskxLSIBy2HtRWJ7rwa4sW9OzbqDyrsiigJyUI0abjeaftwwM3dDH3xE
         hDDA==
X-Gm-Message-State: AOAM531vJym4GZyy7LJoN52EcMrdoVlXTXwl88MByhv+wEDC+15JZ/9O
        zGsWqzWuE3+ADFdOtSINGQ8l5g==
X-Google-Smtp-Source: ABdhPJzzMvFH1YHMHYA8VnuOX5wd3xqPorM6dkBi3h6WAXZ4I87/hAdqvcVA9papKXzK0NCyfIp4KQ==
X-Received: by 2002:a05:600c:2201:: with SMTP id z1mr25363647wml.70.1592942349777;
        Tue, 23 Jun 2020 12:59:09 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id a81sm5485161wmd.25.2020.06.23.12.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 12:59:09 -0700 (PDT)
Date:   Tue, 23 Jun 2020 20:59:05 +0100
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
Message-ID: <20200623195905.GB954398@dell>
References: <20200615092644.GA2608702@dell>
 <eef50a78-8571-5600-4fee-c824fd4a7f69@gmail.com>
 <20200622085009.GP954398@dell>
 <cd8952da-cc55-8087-b9f6-876417beb188@gmail.com>
 <20200622151054.GW954398@dell>
 <037c0fd2-df35-5981-7ef2-c6199841650d@gmail.com>
 <20200622191133.GY954398@dell>
 <dc893ce4-8a4d-b7d9-8591-18a8b9b2ea2b@gmail.com>
 <20200623064723.GZ954398@dell>
 <83f2be78-1548-fa2b-199a-2391b2eceb47@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83f2be78-1548-fa2b-199a-2391b2eceb47@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggestion #2

> >>>> 2) Modify patch 1/3.  The small part of the patch to modify is:
> >>>>
> >>>> +static int mfd_match_of_node_to_dev(struct platform_device *pdev,
> >>>> +				    struct device_node *np,
> >>>> +				    const struct mfd_cell *cell)
> >>>> +{
> >>>> +	struct mfd_of_node_entry *of_entry;
> >>>> +	const __be32 *reg;
> >>>> +	u64 of_node_addr;
> >>>> +
> >>>> +	/* Skip devices 'disabled' by Device Tree */
> >>>> +	if (!of_device_is_available(np))
> >>>> +		return -ENODEV;
> >>>> +
> >>>> +	/* Skip if OF node has previously been allocated to a device */
> >>>> +	list_for_each_entry(of_entry, &mfd_of_node_list, list)
> >>>>
> >>>> Change:
> >>>>
> >>>> +		if (of_entry->np == np)
> >>>> +			return -EAGAIN;
> >>>>
> >>>> To:
> >>>>
> >>>> +		if (of_entry->np == np) {
> >>>> +			if (!cell->use_of_reg)
> >>>> +				return -EINVAL;
> >>>> +			else
> >>>> +				return -EAGAIN;
> >>>>
> >>>> There may be a better choice than EINVAL, but I am just showing the method.
> >>>>
> >>>> You may also want to refactor this section of the patch slightly
> >>>> differently to achieve the same result.  It was just easiest to
> >>>> show the suggested change the way I did it.
> >>>>
> >>>> The test that returns EINVAL detects the issue that the FDT does
> >>>> not match the binding (there is more one child node with the
> >>>> "stericsson,ab8500-pwm" compatible.

My reply to suggestion #2

> >>> So here, instead of just failing a single device, we fail everything?
> >>> Sounds a lot like throwing the baby out with the bath water.  How is
> >>> that an improvement?
> > 
> > [0]
> 
> Is "[0]" the patch series, especially patch 1/3?

No, this is my reply to your suggestion #2.

The [0] is referenced further down.

[...]

> >>>  * False positives can occur and will fail as a result
> >>
> >> ((What is an example of a false positive?))  Never mind, now that
> >> I see that the previous issue is a fatal flaw, this becomes
> >> academic.
> > 
> > That's okay, I don't mind discussing.
> > 
> > Ironically, the 'ab8500-pwm' is a good example of a false positive,
> > since it's fine for the DT nodes to be identical.  So long as there
> > are nodes present for each instance, it doesn't matter which one is
> > allocated to which device .Forcing a 'reg' property onto them for no> good reason it not a valid solution here.
> 
> I thought that one of the points of this patch series was to add a
> "reg" property to any mfd child that was described by the
> OF_MFD_CELL_REG() macro.

The OF_MFD_CELL_REG() macro didn't exist until this patch-set.

There are currently no users.

> And that was meant to fix the problem where multiple indistinguishable
> children existed.  The only instance I found of that (using the
> weak search on OF_MFD_CELL()) was of compatible "stericsson,ab8500-pwm"
> in drivers/mfd/ab8500-core.c.  You agreed with my email that
> reported that.

No, I agreed with you that there is a current problem with
"stericsson,ab8500-pwm", as identified by Michael.  I didn't actually
know about this issue until *after* drafting this patch-set.  To be
clear the "stericsson,ab8500-pwm" scenario is not the reason for this
set's existence.

Also, please forget about the OF_MFD_* macros, they are totally
agnostic to this effort.  The only relevance they have here is the
addition of 1 extra macro which *could* be used to provide the 'reg'
property where appropriate.

> So I thought that drivers/mfd/ab8500-core.c would be modified to
> replace the multiple instances of compatible "stericsson,ab8500-pwm"
> in OF_MFD_CELL() with OF_MFD_CELL_REG().

That is not my vision.  There is no need for "stericsson,ab8500-pwm"
to have 'reg' properties as far as I see it.

> This is another problem with the patch series: there is no user
> of OF_MFD_CELL_REG().  Please add one to the series.

That's not a problem with this patch-set, it's a problem with your
understanding of this patch-set. :)

As far as I know, there aren't any current users who would benefit
from this work.  Instead, it is designed to provide future submitters
with another tool to help them link their child devices to the correct
OF nodes.  That's not to say that current users can't and won't
benefit from this.  Just that they are not the target audience.

> >>> The above actually makes the solution worse, not better.
> >>>
> >>
> >> Patch 1/3 silently fails to deal with a broken devicetree.
> >> It results on one of the three ab8500-pwm child nodes in
> >> the hypothetical devicetree source tree not being added.
> >>
> >> That is not a good result either.
> > 
> > No it doesn't.  In the case of 'ab8500-pwm' the OF node is not set for
> > 2 of the devices and warnings are presented in the kernel log.
> 
> OK, I was wrong about "silent".  There is a warning:
>    pr_warn("%s: Failed to locate of_node [id: %d]\n",
> 
> > The
> > device will continue to probe and function as usual.
> 
> If the device probes and functions as usual without the child of_node,
> then why does the node have any properties (for the cases of
> arch/arm/boot/dts/ste-ab8500.dtsi and arch/arm/boot/dts/ste-ab8505.dtsi
> the properties "clocks" and "clock-names").

Because DT is meant to describe the hardware, not the implementation.

DT does not know, or care that in our case most operations that happen
on the platform are passed back via an API to a central controlling
location.  Or that in reality, the OF node in this situation is
superfluous.

Can we please stop talking about the AB8500.  It doesn't have anything
to do with this series besides the fact that if it (this set) had
existed *before* 'ab8500-pwm' was OF enabled, it wouldn't now be
wonky.

> Digging through that leads to yet another related question, or actually
> sort of the same question.  Why do the child nodes with compatible
> "stericsson,ab8500-pwm" have the properties "clocks" and "clock-names"
> since the binding Documentation/devicetree/bindings/mfd/ab8500.txt
> does not list them?

If you want to talk about the AB8500, please start a new thread.

> >> OK, so my solution #3 is a no go.  How about my solution #2,
> >> which you did not comment on?
> > 
> > I did [0].  You must have missed it. :)
> 
> But yes or no to my solution #2 (with some slight changes to
> make it better (more gracious handling of the detected error) as
> discussed elsewhere in the email thread)?

Please see "[0]" above!

AFAICT your solution #2 involves bombing out *all* devices if there is
a duplicate compatible with no 'reg' property value.  This is a)
over-kill and b) not an error, as I mentioned:

> > It also suffers with false positives.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
