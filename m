Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B832C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC36206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591740241;
	bh=flZ33ysLlKU45UAun+m9I+uL1J5SSmfePQ8hOU6DJfg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=inrqSYWJ/SKNd5gH0KxO27+AibjIpOEbwho/l5oRIAoMyaBxcc++dZdp3to7C4Ofh
	 ZdSJBHzIXks5le3OehNRhxk1FjmH9CZiu5N6Ml/pENtI+IeRcfU/7i/2Zd2RGY3o4+
	 oXSpnoOx837hIcQ1tZzB88mpoiW2O6H7D7joy7/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgFIWD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbgFIWD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:03:58 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FD12076A;
        Tue,  9 Jun 2020 22:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591740237;
        bh=flZ33ysLlKU45UAun+m9I+uL1J5SSmfePQ8hOU6DJfg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lkIALF/Bz5PHpbWDPE/TVnpI2c/G/+3TP5jdAxlBZenjXoI743llcFBTqAjEKIa2d
         mk3YMda7mIEGR7kVGu9J1XQi1oUtLlNrQTctAeflcrM3BX9rl37Vd9DR+QmZfHdYB8
         kpWx8xVi3QwABVCAkftswnHytL9YYHSyJfGQscPo=
Received: by mail-oi1-f169.google.com with SMTP id a3so210870oid.4;
        Tue, 09 Jun 2020 15:03:57 -0700 (PDT)
X-Gm-Message-State: AOAM5317PQEV4SnPsffI9DQfEifdbvXhDebbGyU6LRZaj4SM9Of9BL2U
        JhEDkclksIl8rZ/3ABE7yAZzgCJBYVy9UvfqHw==
X-Google-Smtp-Source: ABdhPJzUR9iieM8EaueMmaUiEVRgOMVztBfW1AHBkxHha+Gjto8AsBpZQbvbkHWaNeJrgkpACTnHBYgdAkwtI7Cit6Y=
X-Received: by 2002:aca:d943:: with SMTP id q64mr294871oig.147.1591740236611;
 Tue, 09 Jun 2020 15:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200609110136.GJ4106@dell>
In-Reply-To: <20200609110136.GJ4106@dell>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 9 Jun 2020 16:03:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
Message-ID: <CAL_JsqK1BfYa2WfHFUwm9MB+aZVF5zehDSTZj0MhjuhJyYXdTA@mail.gmail.com>
Subject: Re: [RFC] MFD's relationship with Device Tree (OF)
To:     Lee Jones <lee.jones@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 5:01 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> Good morning,
>
> After a number of reports/queries surrounding a known long-term issue
> in the MFD core, including the submission of a couple of attempted
> solutions, I've decided to finally tackle this one myself.
>
> Currently, when a child platform device (sometimes referred to as a
> sub-device) is registered via the Multi-Functional Device (MFD) API,
> the framework attempts to match the newly registered platform device
> with its associated Device Tree (OF) node.  Until now, the device has
> been allocated the first node found with an identical OF compatible
> string.  Unfortunately, if there are, say for example '3' devices
> which are to be handled by the same driver and therefore have the same
> compatible string, each of them will be allocated a pointer to the
> *first* node.
>
> Let me give you an example.
>
> I have knocked up an example 'parent' and 'child' device driver.  The
> parent utilises the MFD API to register 3 identical children, each
> controlled by the same driver.  This happens a lot.  Fortunately, in
> the majority of cases, the OF nodes are also totally identical, but
> what if you wish to configure one of the child devices with different
> attributes or resources supplied via Device Tree, like a clock?  This
> is currently impossible.
>
> Here is the Device Tree representation for the 1 parent and the 3
> child (sub) devices described above:
>
>         parent {
>                 compatible = "mfd,of-test-parent";
>
>                 child@0 {

Just a note, unit-address implies there is a 'reg' property. Why
that's important below.

>                         compatible = "mfd,of-test-child";
>                         clocks = <&clock 0>;
>                 };
>
>                 child@1 {
>                         compatible = "mfd,of-test-child";
>                         clocks = <&clock 1>;
>                 };
>
>                 child@2 {
>                         compatible = "mfd,of-test-child";
>                         clocks = <&clock 2>;
>                 };
>         };
>
> This is how we register those devices from MFD:
>
> static const struct mfd_cell mfd_of_test_cell[] = {
>         OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 0, "mfd,of-test-child"),
>         OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 1, "mfd,of-test-child"),
>         OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 2, "mfd,of-test-child")
> };
>
> ... which we pass into mfd_add_devices() for processing.
>
> In an ideal world.  The devices with the platform_id; 0, 1 and 2 would
> be matched up to Device Tree nodes; child@0, child@1 and child@2
> respectively.  Instead all 3 devices will be allocated a pointer to
> child@0's OF node, which is obviously not correct.
>
> This is how it looks when each of the child devices are probed:
>
>  [0.708287] mfd-of-test-parent mfd_of_test: Registering 3 devices
>  [...]
>  [0.712511] mfd-of-test-child mfd_of_test_child.0: Probing platform device: 0
>  [0.712710] mfd-of-test-child mfd_of_test_child.0: Using OF node: child@0
>  [0.713033] mfd-of-test-child mfd_of_test_child.1: Probing platform device: 1
>  [0.713381] mfd-of-test-child mfd_of_test_child.1: Using OF node: child@0
>  [0.713691] mfd-of-test-child mfd_of_test_child.2: Probing platform device: 2
>  [0.713889] mfd-of-test-child mfd_of_test_child.2: Using OF node: child@0
>
> "Why is it when I change child 2's clock rate, it also changes 0's?"
>
> Whoops!
>
> So in order to fix this, we need to make MFD more-cleverer!
>
> However, this is not so simple.  There are some rules we should abide
> by (I use "should" intentionally here, as something might just have to
> give):
>
>  a) Since Device Tree is designed to describe hardware, inserting
>     arbitrary properties into DT is forbidden.  This precludes things
>     we would ordinarily be able to match on, like 'id' or 'name'.
>  b) As an extension to a) DTs should also be OS agnostic, so
>     properties like 'mfd-device', 'mfd-order' etc are also not
>     not suitable for inclusion.
>  c) The final solution should ideally be capable of supporting both
>     newly defined and current trees (without retroactive edits)
>     alike.

Presumably anything current already works. If you had the above
example already, requiring updating the DT to make it work seems fine.

>  d) Existing properties could be used, but not abused.  For example,
>     one of my suggestions (see below) is to use the 'reg' property.
>     This is fine in principle but loading 'reg' with arbitrary values
>     (such as; 0, 1, 2 ... x) which 1) clearly do not have anything to
>     do with registers and 2) would be meaningless in other OSes/
>     implementations, just to serve our purpose, is to be interpreted
>     as an abuse.

Multiple instances of something implies you have some way to address
them and 'reg' is what defines the address of something. 0,1,2,etc.
looks suspiciously like just some kernel defined indexes, but if
that's how things are defined in the datasheet I'm okay with them.

The one wrinkle is there's only one address space at one level, so
gpio@0, gpio@1, pwm@0, pwm@1, etc. doesn't really work (well, it
works, but having overlapping addresses is not good practice). Either
we relax that in this case or we can add another level to group nodes.

>
> Proposal 1:
>
> As mentioned above, my initial thoughts were to use the 'reg' property
> to match an MFD cell entry with the correct DT node.  However, not
> all Device Tree nodes have 'reg' properties.  Particularly true in the
> case of MFD, where memory resources are usually shared with the parent
> via Regmap, or (as in the case of the ab8500) the MFD handles all
> register transactions via its own API.

Just to pick on ab8500, it should have had 'reg' property IMO. The
'bank' is clearly a h/w property and how you address each sub-device.

>
> Proposal 2:
>
> If we can't guarantee that all DT nodes will have at least one
> property in common to be used for matching and we're prevented from
> supplying additional, potentially bespoke properties, then we must
> seek an alternative procedure.
>
> It should be possible to match based on order.  However, the developer
> would have to guarantee that the order in which the child devices are
> presented to the MFD API are in exactly the same order as they are
> represented in the Device Tree.  The obvious draw-back to this
> strategy is that it's potentially very fragile.

I don't think we should use order.

>
> Current Proposal:
>
> How about a collection of Proposal 1 and Proposal 2?  First we could
> attempt a match on the 'reg' property.  Then, if that fails, we would
> use the fragile-but-its-all-we-have Proposal 2 as the fall-back.

Yes, we should use 'reg' whenever possible. If we don't have 'reg',
then you shouldn't have a unit-address either and you can simply match
on the node name (standard DT driver matching is with compatible,
device_type, and node name (w/o unit-address)). We've generally been
doing 'classname-N' when there's no 'reg' to do 'classname@N'.
Matching on 'classname-N' would work with node name matching as only
unit-addresses are stripped.

Rob
