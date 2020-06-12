Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB69D2078C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce6EyEcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgFLEKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 00:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgFLEKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 00:10:42 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A786C08C5C1;
        Thu, 11 Jun 2020 21:10:41 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so7882475qkh.1;
        Thu, 11 Jun 2020 21:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=BX3C143A3POrmkr1aq3BVs/jgbxYgT9lNfcL1LZXEKE=;
        b=Ce6EyEcTASg05aRX64tIzLPc0Ldl21nX0gdkk7dHj5SV1ezpc5m8hh8vHOtsH+JToW
         DaMp+mFWljKSMJfR95OV3iaLOcY+6gLvacrCc7XVU0JEWHF4jXaFQHcbj9FHACzbe0gX
         frbOcTqf7xCByEeC82GrKS9avdSmtjvD8vL38WnBxHX1Jfksx0fkrXl21IEQknqWyQpe
         m8KUNAagjP4eYoGxp5RbJswUTD0/Z9O9u37+BXOVF2mwXzGOz9+SH+/lOYyZB9L7zCbO
         WCFs/Q48TOpToI6F737FBKW91eE3+JqcsDuW+RceVONtXQcS0O2B6mYlxqO4DWSYtqcT
         TXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BX3C143A3POrmkr1aq3BVs/jgbxYgT9lNfcL1LZXEKE=;
        b=KTkza075uWkItUVFJVNvAKHVkfxdsNHjQEtby9w3affNrMWrJPhgRNUGS5wKna3ht5
         bqYb3IIRs9sVyAzMrvROlkGHdAmWnhwV8xOBU3FpNW7nK3NwEXZHGajxQIcufjpe52aq
         ila2i7d8pvhKHtkG8xPgrI3y7VjEeZO8U1xoXvQKODKJU6KhZmRsvO7CFzFbH+RkRJTQ
         glAgQmmpARpZSQ/gvUZdK14pAGhOUn9kb9+3DRMvVs7gPpKqDlCGr7UwQDJcApQE1u+t
         zZGxSqgxX+kNXVkNQuHnhT9rIVajJfpzUX+d6B620BFJOQiUyTFXRXztKui3v0b1dLpi
         Z/ww==
X-Gm-Message-State: AOAM531KPzirPzyLPsx9hhOjoo6s8hMLAU9pBSZaYbmaWWsyjqtBiZsg
        ldYRqOgWmsYBTbmMFk8Tn0Q=
X-Google-Smtp-Source: ABdhPJwPPjDV9+Z/ZHy7CT2YOLdbfu1LEYgQSgWOVIRxMfBZM1OtC+Y6K34t5asj2+iAPjCWpVnH1w==
X-Received: by 2002:a05:620a:4fa:: with SMTP id b26mr1201057qkh.63.1591935040214;
        Thu, 11 Jun 2020 21:10:40 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id t188sm3820131qka.27.2020.06.11.21.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 21:10:39 -0700 (PDT)
Subject: Re: [RFC] MFD's relationship with Device Tree (OF)
To:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        GregKroah-Hartmangregkh@linuxfoundation.org
References: <20200609110136.GJ4106@dell>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <fba8c972-b96c-74ae-b858-c47f2765028f@gmail.com>
Date:   Thu, 11 Jun 2020 23:10:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200609110136.GJ4106@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 2020-06-09 06:01, Lee Jones wrote:
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
> 			clocks = <&clock 0>;
>                 };
> 
>                 child@1 {
>                         compatible = "mfd,of-test-child";
> 			clocks = <&clock 1>;
> 		};
> 
> 	        child@2 {
>                         compatible = "mfd,of-test-child";
> 			clocks = <&clock 2>;
>                 };
>         };
> 
> This is how we register those devices from MFD:
> 
> static const struct mfd_cell mfd_of_test_cell[] = {
>         OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 0, "mfd,of-test-child"),
>         OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 1, "mfd,of-test-child"),
> 	OF_MFD_CELL("mfd_of_test_child", NULL, NULL, 0, 2, "mfd,of-test-child")
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

You can not count on order.  There are no guarantees of node ordering in
compilation, modification by bootloader, and within Linux kernel data
structures.

-Frank

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
> 

