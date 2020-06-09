Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E23C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EF72078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="robkr4Je"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgFIOTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgFIOTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:19:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE65C05BD1E;
        Tue,  9 Jun 2020 07:19:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p21so10337726pgm.13;
        Tue, 09 Jun 2020 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TBM8UzUFQRAFXnadODNP4SC5I3SYQdfsI182+mdN99I=;
        b=robkr4JeDjRuxira1Rr1HMwmepK/jy5iMNR4VO2+sugmN2Qfs9w/G4u6YHgpnsUuKx
         0xrsGSyercM6BnkS802AGU4qBDrHJ9OLVViubfUx1QX8eUZiLXWod5C9gLXDtugSCRIi
         50cOjHrJ9PyMN+kCjAT+QSovuPV8AiLQRPXTKq761mFEa6q5/EqJdDeF/SEYEJSE1BNE
         J3gPdDMZtMIrLLmlZaKzHC6fO5ywUCMDQ+3wqBNvXq3HpkovNmuMHp3u7/NqmQysnh9k
         UXoFFtjAk3dwxlC9bqbLHGz6D8a161Ju2xuxJFblfyv22KZckKiMqRjBPc7ScQg4V1E2
         9wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TBM8UzUFQRAFXnadODNP4SC5I3SYQdfsI182+mdN99I=;
        b=qaTn0j9RZ55cZyYzOhX4bbxXoDAae2DZy0GMWlBwbIXa2+7Kw/g4vlQByazqS4e040
         Cm2qdbscce8fv4OMdhfD8JmgTZNktJhKrQtbkA/CWPhL/vmpc1fBr9ynSs2zmbVvB1y+
         EoglhFEhPGqiNo2YrmvFI9wdCbVfnYu5r1oHfiffhScYZaJm8vBfVAb24uVPAbaGZxEr
         Hj9ncdS0cVLo9UlAB32ARghHem/Evw3zXo6DZEWQ5oyeigc7OW6B3LJNZaFBltoTIQZN
         6qJtsePyoawCuJVcyqtyiSqAiuKMyiXFvBk1grYmvnpqlD+YxPYrCvUzVbdpvMP/qOHT
         vI2A==
X-Gm-Message-State: AOAM533WIBkpdUyX9KzXqvlf+udMbonXWAhOwF1BxL9Gl4YsbpJxnLxf
        QXSQXeIpBKdmqdgo3bt8XpuP5FJsN4C+1p0Vtn8=
X-Google-Smtp-Source: ABdhPJxStCJ8sGascE2rC3EJCjWx/Wwyx7yNwiY+l2i+Fbip9MDjYWBd+z97hidMXyAQuBXbm4qYdEPklBp+cUjoXkk=
X-Received: by 2002:a62:3103:: with SMTP id x3mr9005809pfx.130.1591712381739;
 Tue, 09 Jun 2020 07:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200609110136.GJ4106@dell>
In-Reply-To: <20200609110136.GJ4106@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Jun 2020 17:19:30 +0300
Message-ID: <CAHp75Vfy2siUikK7bN3iM=pj3B8XYWzszkKAFgBt0SFh26s+Sw@mail.gmail.com>
Subject: Re: [RFC] MFD's relationship with Device Tree (OF)
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
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

On Tue, Jun 9, 2020 at 2:01 PM Lee Jones <lee.jones@linaro.org> wrote:
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
>  d) Existing properties could be used, but not abused.  For example,
>     one of my suggestions (see below) is to use the 'reg' property.
>     This is fine in principle but loading 'reg' with arbitrary values
>     (such as; 0, 1, 2 ... x) which 1) clearly do not have anything to
>     do with registers and 2) would be meaningless in other OSes/
>     implementations, just to serve our purpose, is to be interpreted
>     as an abuse.
>
> Proposal 1:
>
> As mentioned above, my initial thoughts were to use the 'reg' property
> to match an MFD cell entry with the correct DT node.  However, not
> all Device Tree nodes have 'reg' properties.  Particularly true in the
> case of MFD, where memory resources are usually shared with the parent
> via Regmap, or (as in the case of the ab8500) the MFD handles all
> register transactions via its own API.
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
>
> Current Proposal:
>
> How about a collection of Proposal 1 and Proposal 2?  First we could
> attempt a match on the 'reg' property.  Then, if that fails, we would
> use the fragile-but-its-all-we-have Proposal 2 as the fall-back.
>
> Thoughts?

Just a side note, have you considered software nodes on the picture?
You can add properties or additional references to the existing
(firmware) nodes.

-- 
With Best Regards,
Andy Shevchenko
