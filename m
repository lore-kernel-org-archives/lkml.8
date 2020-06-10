Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2107AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82FD2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:43:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WpAdeT9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgFJGn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFJGnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:43:21 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E1FC03E96B
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 23:43:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so881765wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 23:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=50byfSUtLO2L1CsGut80+OISi/Nz9nsAC9YkkMqMXOM=;
        b=WpAdeT9dbF9UyWDJZv0gWHAQMuuBqmw5us09gBqWv+GWgq+kxrUfIl8gfsmGhALYRN
         9U88mTavWdGgeMiEitVvkwac8h/MigSeJesciURuMINjhqnylY868I+AXmLy3CHeKK4P
         Xe+AlqVbHt4WBnTG1f8JhdVuwbTMAbJOjy5TFxeEHF5cXMmFTDwyPmEaDiqrwZ5X6ZU9
         O2hrYZYEQdr60oSPRqLkRvGI8eXrcyplPOevfujiGJYbUm9lfLo0lFaFzifhAsL09oDj
         QJXOxBR3qtn+1jT1b8rXZcqpYHhumFRmVcFCr3GMMys3xSzduKC41iTYvv9r9E5MMR3d
         n+DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=50byfSUtLO2L1CsGut80+OISi/Nz9nsAC9YkkMqMXOM=;
        b=BdMXwuPjqCHfBJjB+8TzOh1perH4pFl004yonh1bm9o7A1LwHEK3NjrzFAwCLLpBdh
         G88w5EuOYqHhxlqUJd/JtklVwMDg+pLXmAqGnMBUpe+oAkYERYF91c9P1pkGkPSPJeh6
         Mq19hM0u+Y2TGVip66t+crk3N+p4ubekdS69iCsr6t38Pej+e9ocyUj6kiXJL4l4lHG/
         2xjm9bbazzK1qQRTliDU2quYKelwqqOiL1qINYh3gK/b5JmVy6heFR+LrOCsDpNpXGkh
         ObT27uAOCeCiqqah0YJrTQjfDekhNWlo0q3YbmV8ut5SAIZaLKBix12ik2ripJBiaTWI
         Uwaw==
X-Gm-Message-State: AOAM530AxVxtj2Byqij5U/Y8lobiFol9d+ztTucX7mjVWZeNSOOMwmwI
        jkHpSelTUNI+b7Ep8aPUKXBp1A==
X-Google-Smtp-Source: ABdhPJwaoQK+X0lo6GNX+4YH4LmVZ34yndsRQ2O8DgNG6DNYc2XV0ST4pDrJrPqXkHWMBQcWpVJ2Mg==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr1828741wrt.298.1591771398313;
        Tue, 09 Jun 2020 23:43:18 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id y14sm5513504wma.25.2020.06.09.23.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 23:43:17 -0700 (PDT)
Date:   Wed, 10 Jun 2020 07:43:15 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        GregKroah-Hartmangregkh@linuxfoundation.org
Subject: Re: [RFC] MFD's relationship with Device Tree (OF)
Message-ID: <20200610064315.GR4106@dell>
References: <20200609110136.GJ4106@dell>
 <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Jun 2020, Rob Herring wrote:

Thanks for replying Rob.

> On Tue, Jun 9, 2020 at 5:01 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Good morning,
> >
> > After a number of reports/queries surrounding a known long-term issue
> > in the MFD core, including the submission of a couple of attempted
> > solutions, I've decided to finally tackle this one myself.
> >
> > Currently, when a child platform device (sometimes referred to as a
> > sub-device) is registered via the Multi-Functional Device (MFD) API,
> > the framework attempts to match the newly registered platform device
> > with its associated Device Tree (OF) node.  Until now, the device has
> > been allocated the first node found with an identical OF compatible
> > string.  Unfortunately, if there are, say for example '3' devices
> > which are to be handled by the same driver and therefore have the same
> > compatible string, each of them will be allocated a pointer to the
> > *first* node.
> >
> > Let me give you an example.
> >
> > I have knocked up an example 'parent' and 'child' device driver.  The
> > parent utilises the MFD API to register 3 identical children, each
> > controlled by the same driver.  This happens a lot.  Fortunately, in
> > the majority of cases, the OF nodes are also totally identical, but
> > what if you wish to configure one of the child devices with different
> > attributes or resources supplied via Device Tree, like a clock?  This
> > is currently impossible.
> >
> > Here is the Device Tree representation for the 1 parent and the 3
> > child (sub) devices described above:
> >
> >         parent {
> >                 compatible = "mfd,of-test-parent";
> >
> >                 child@0 {
> 
> Just a note, unit-address implies there is a 'reg' property. Why
> that's important below.

Right.  This is just an example to express the problem more easily.

> >                         compatible = "mfd,of-test-child";
> >                         clocks = <&clock 0>;
> >                 };
> >
> >                 child@1 {
> >                         compatible = "mfd,of-test-child";
> >                         clocks = <&clock 1>;
> >                 };
> >
> >                 child@2 {
> >                         compatible = "mfd,of-test-child";
> >                         clocks = <&clock 2>;
> >                 };
> >         };
> >
> > This is how we register those devices from MFD:
> >
> > static const struct mfd_cell mfd_of_test_cell[] = {
> >         OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 0, "mfd,of-test-child"),
> >         OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 1, "mfd,of-test-child"),
> >         OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 2, "mfd,of-test-child")
> > };
> >
> > ... which we pass into mfd_add_devices() for processing.
> >
> > In an ideal world.  The devices with the platform_id; 0, 1 and 2 would
> > be matched up to Device Tree nodes; child@0, child@1 and child@2
> > respectively.  Instead all 3 devices will be allocated a pointer to
> > child@0's OF node, which is obviously not correct.
> >
> > This is how it looks when each of the child devices are probed:
> >
> >  [0.708287] mfd-of-test-parent mfd_of_test: Registering 3 devices
> >  [...]
> >  [0.712511] mfd-of-test-child mfd_of_test_child.0: Probing platform device: 0
> >  [0.712710] mfd-of-test-child mfd_of_test_child.0: Using OF node: child@0
> >  [0.713033] mfd-of-test-child mfd_of_test_child.1: Probing platform device: 1
> >  [0.713381] mfd-of-test-child mfd_of_test_child.1: Using OF node: child@0
> >  [0.713691] mfd-of-test-child mfd_of_test_child.2: Probing platform device: 2
> >  [0.713889] mfd-of-test-child mfd_of_test_child.2: Using OF node: child@0
> >
> > "Why is it when I change child 2's clock rate, it also changes 0's?"
> >
> > Whoops!
> >
> > So in order to fix this, we need to make MFD more-cleverer!
> >
> > However, this is not so simple.  There are some rules we should abide
> > by (I use "should" intentionally here, as something might just have to
> > give):
> >
> >  a) Since Device Tree is designed to describe hardware, inserting
> >     arbitrary properties into DT is forbidden.  This precludes things
> >     we would ordinarily be able to match on, like 'id' or 'name'.
> >  b) As an extension to a) DTs should also be OS agnostic, so
> >     properties like 'mfd-device', 'mfd-order' etc are also not
> >     not suitable for inclusion.
> >  c) The final solution should ideally be capable of supporting both
> >     newly defined and current trees (without retroactive edits)
> >     alike.
> 
> Presumably anything current already works. If you had the above
> example already, requiring updating the DT to make it work seems fine.

"works" it a matter of opinion.  Some instances "work" out of luck.
Some "work" because they have been worked-around or an alternative
implementation sought.

For instance, 'ab8500-pwm' only has 1 DT node present, yet 3 devices
are registered via MFD.  Since MFD matches devices with DT nodes
containing identical compatible strings using first-found, all PWM
instances are assigned a pointer to the 1 existing DT node.
Fortunately in this case they all share the same clock, so it "works",
but that's clearly not the intended implementation.

> >  d) Existing properties could be used, but not abused.  For example,
> >     one of my suggestions (see below) is to use the 'reg' property.
> >     This is fine in principle but loading 'reg' with arbitrary values
> >     (such as; 0, 1, 2 ... x) which 1) clearly do not have anything to
> >     do with registers and 2) would be meaningless in other OSes/
> >     implementations, just to serve our purpose, is to be interpreted
> >     as an abuse.
> 
> Multiple instances of something implies you have some way to address
> them and 'reg' is what defines the address of something. 0,1,2,etc.
> looks suspiciously like just some kernel defined indexes, but if
> that's how things are defined in the datasheet I'm okay with them.
> 
> The one wrinkle is there's only one address space at one level, so
> gpio@0, gpio@1, pwm@0, pwm@1, etc. doesn't really work (well, it
> works, but having overlapping addresses is not good practice). Either
> we relax that in this case or we can add another level to group nodes.

All agreed.  Sounds promising.

> > Proposal 1:
> >
> > As mentioned above, my initial thoughts were to use the 'reg' property
> > to match an MFD cell entry with the correct DT node.  However, not
> > all Device Tree nodes have 'reg' properties.  Particularly true in the
> > case of MFD, where memory resources are usually shared with the parent
> > via Regmap, or (as in the case of the ab8500) the MFD handles all
> > register transactions via its own API.
> 
> Just to pick on ab8500, it should have had 'reg' property IMO. The
> 'bank' is clearly a h/w property and how you address each sub-device.
> 
> >
> > Proposal 2:
> >
> > If we can't guarantee that all DT nodes will have at least one
> > property in common to be used for matching and we're prevented from
> > supplying additional, potentially bespoke properties, then we must
> > seek an alternative procedure.
> >
> > It should be possible to match based on order.  However, the developer
> > would have to guarantee that the order in which the child devices are
> > presented to the MFD API are in exactly the same order as they are
> > represented in the Device Tree.  The obvious draw-back to this
> > strategy is that it's potentially very fragile.
> 
> I don't think we should use order.

If it's always possible to have a 'reg' property then we won't need
to.

> > Current Proposal:
> >
> > How about a collection of Proposal 1 and Proposal 2?  First we could
> > attempt a match on the 'reg' property.  Then, if that fails, we would
> > use the fragile-but-its-all-we-have Proposal 2 as the fall-back.
> 
> Yes, we should use 'reg' whenever possible. If we don't have 'reg',
> then you shouldn't have a unit-address either and you can simply match
> on the node name (standard DT driver matching is with compatible,
> device_type, and node name (w/o unit-address)). We've generally been
> doing 'classname-N' when there's no 'reg' to do 'classname@N'.
> Matching on 'classname-N' would work with node name matching as only
> unit-addresses are stripped.

Let me try and knock something up.

I'll get back to you when it's done.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
