Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4997EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 232D72053B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="QbB0yxVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404131AbgFYLFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404042AbgFYLFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:05:12 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3778C061573;
        Thu, 25 Jun 2020 04:05:11 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 9C6D522F99;
        Thu, 25 Jun 2020 13:05:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1593083108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ktSrrKbXLslgynx/5efSDeX5Ck6nMy0CNpq7qc6j8o=;
        b=QbB0yxVTSRmdjNJLoo0ThK6yKepD7s86nm96tNFFLzNr2I1CPGiBTa68C+6FmrsL89Onon
        y2iAdhMlVQVn0Z895OkcFzOS3qlCnSmsSkuqqE79uEjKCsPIdanhmxMgImLxcWE9UQSG7F
        uNjgt2TEVs2vuy1piCF8nS38Pz/XOMA=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 25 Jun 2020 13:05:01 +0200
From:   Michael Walle <michael@walle.cc>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        GregKroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC] MFD's relationship with Device Tree (OF)
In-Reply-To: <20200625061302.GK954398@dell>
References: <20200609110136.GJ4106@dell>
 <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
 <0709f20bc61afb6656bc57312eb69f56@walle.cc>
 <970bf15b1106df3355b13e06e8dc6f01@walle.cc>
 <0e9e25cc-b3f2-926a-31dd-c6fafa7d581b@gmail.com>
 <20200625061302.GK954398@dell>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <f938f7a02aa9638a784879d1e3c13dd2@walle.cc>
X-Sender: michael@walle.cc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-06-25 08:13, schrieb Lee Jones:
> On Wed, 24 Jun 2020, Frank Rowand wrote:
>> On 2020-06-22 16:03, Michael Walle wrote:
>> > Am 2020-06-14 12:26, schrieb Michael Walle:
>> >> Hi Rob,
>> >>
>> >> Am 2020-06-10 00:03, schrieb Rob Herring:
>> >> [..]
>> >>> Yes, we should use 'reg' whenever possible. If we don't have 'reg',
>> >>> then you shouldn't have a unit-address either and you can simply match
>> >>> on the node name (standard DT driver matching is with compatible,
>> >>> device_type, and node name (w/o unit-address)). We've generally been
>> >>> doing 'classname-N' when there's no 'reg' to do 'classname@N'.
>> >>> Matching on 'classname-N' would work with node name matching as only
>> >>> unit-addresses are stripped.
>> >>
>> >> This still keeps me thinking. Shouldn't we allow the (MFD!) device
>> >> driver creator to choose between "classname@N" and "classname-N".
>> >> In most cases N might not be made up, but it is arbitrarily chosen;
>> >> for example you've chosen the bank for the ab8500 reg. It is not
>> >> a defined entity, like an I2C address if your parent is an I2C bus,
>> >> or a SPI chip select, or the memory address in case of MMIO. Instead
>> >> the device driver creator just chooses some "random" property from
>> >> the datasheet; another device creator might have chosen another
>> >> property. Wouldn't it make more sense, to just say this MFD provides
>> >> N pwm devices and the subnodes are matching based on pwm-{0,1..N-1}?
>> >> That would also be the logical consequence of the current MFD sub
>> >> device to OF node matching code, which just supports N=1.
> 
> It's funny.  You reiterate things like "arbitrarily chosen" and
> "randomly chosen from the datasheet" but yet your suggestion is just
> that. The only difference is that you wish to place the numerical
> differentiator in the node name, rather than the reg property.

Correct, because from my understand, the N in the nodename-N form is
exactly that: arbitrarily chosen, or sequentially numbered. Doesn't
matter. Using the reg property instead, you would have to have
unique values; which are normally the addresses or some other kind
of property related to the parent bus. See below.

> Worse
> still, you are suggesting that you wish to just enumerate them off
> sequentially from some arbitrary base (likely 0).

Yes I suggested that, but you could choose any other number. I was
under the impression that the nodename-N is somehwhat sequentially
numbered.

> I don't know of many cases off, the top of my head at least, where
> this is a problem.  As you've mentioned, in the case of the AB8500,
> the bank is used which is semantically how the devices are actually
> addressed.  It's not random, it's physical.

You didn't get my point. The choice to use the bank address was random.
Why did you choose that in particular? Why didn't you choose the whole
register offset of the first register which belongs to that PWM, e.g.
0x1060? That is what I mean, it is arbitrary chosen by someone, what
the reg property contains. In the MFD case it doesn't matter, because
it is just there for node matching. Worse, it might not even be unique,
i.e. there might be multiple GPIOs and you choose the also the bank of
that which might overlap with the bank of the PWM and then you have
pwm@60 and gpio@60. Again, Rob suggested to relax that rule, but why
was this rule there in the first place? To my knowlegde, all other
uses of the reg field are precisely defined.

So my reasoning is: if it is up to the developer what to choose to
differentiate between the instances and you cannot guarantee that it
is unique among all the subdevices, why not use the nodename-N form.
Also, what do we gain if we have the reg property if you don't know
how to use it? It is just there to match an OF node to an mfd_cell.

> How are the identical devices addressed/identified/differentiated
> from each other on your H/W?  You must have a way of saying "I want
> PWM X to act in a different way from PWM Y".  What is 'X' and 'Y' in
> your datasheet?

There is no official datasheet, so I could say anything now which
would be in my favor, for example, that there is a table labeling
the PWMs sequentially starting from 0 ;) Would it be accepted then?
I really don't know, but it emphasize my point that the value is
"arbitrary chosen" (sorry to repeat myself..).
Yes there is some kind of internal datasheet or internal design
document and for the current implementation (as I said, this is
a more generic board controller where you can mix and match the
individual components per board, or even per flavor of the board).
But this document states that there are two PWMs, it tells you
the offsets which you have to use to if you want to access it
via I2C and what the PWMs are for, i.e. one is for the LCD
backlight and one is for general purpose, connected to the edge
connector of the processor module.

Sorry if I keep discussing this, but it looks wrong to me to have
the internal offset in both the MFD driver and in the device tree.
And I tried to start a discussion back in March [1] before
submitting my MFD patch series, but nobody replied back then.

-michael

[1] 
https://lore.kernel.org/linux-devicetree/0e3e8204ab992d75aa07fc36af7e4ab2@walle.cc/
