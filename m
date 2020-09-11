Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EA1C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:56:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A874C21D81
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="aKGHxqSK";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZlyozmQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKE4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:56:35 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39969 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgIKE4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:56:30 -0400
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Fri, 11 Sep 2020 00:56:29 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C8127580176;
        Fri, 11 Sep 2020 00:46:36 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Fri, 11 Sep 2020 00:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=JE4d8w98uqoH0zAX9kIMQF/kNdFrrfp
        5s+XGghxpu2Q=; b=aKGHxqSK44sAvbOa3O+hjcbg+0zGqEmMR955lFtPHVamz0v
        Vu0s0/ZTrpn6hOPp3gGp1dDwwabK0KDlrnfkXZ3ivtVIO62mZG6yadeKWwFJqJRD
        XjjW0SY434RBBzc9JYx/dLY6bPcU1utZu9KX5uEmV/3WxsiW0TFBXlPT3s4s5kym
        jk4zvIHdO8GdrfJmx9M8iGTNwaulSaMG1dkSUnCMQtaI3NuPDwdm8mqIg27yL+ZE
        l8GFApZEb2TiS9LHPntdP+1KeeuZf9npyx4sYGxoJe3ZdkED+bHxWs26Dv922yUG
        JKtCud21GlHAWlq63QkfYcEA+bQ6SGJ5Snejp+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JE4d8w
        98uqoH0zAX9kIMQF/kNdFrrfp5s+XGghxpu2Q=; b=ZlyozmQpKiuycVOB0JnTyV
        XZKViu2n590EBUbtsKRm+MjMgC6wPf0kl6HR8O9IwtLgfbY+DSo5Z3haYr1Wamoo
        n2IXzveW19opuXfbEeTzKs5xqiJDY1h+1Hd45xK6V0vhMTbI+Q0VyP2/S5I38Ogo
        JK7+3ZJD/9FOuCwamp48gOhfB3aypKI4VL5TXUNQBELZ9XV4URThwl6YjxN70U1Q
        uy2zEoukGSE19Dy0ze3wGmMhsN6ugaGYsFLFAiN6baOqmRCnWaLWQbfkzhmsmdrF
        PElIzLpDQoGlMGTZ9qzjFH54s0lYQ1TLEpbf2D5cQlS5zKBlbgxS7fDoHXZScoTA
        ==
X-ME-Sender: <xms:KgFbX4j6kPJyDp1yobpWlKLzpagPqplPT1QA6S15NP92E-JxTs9sdA>
    <xme:KgFbXxD4JrYV2lP8OARUCfqv2j2K6zzElA8Od9RP7CjIFdPl3qQy0zpXXogvAgopA
    awqDxclJ6JX3JsxIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetnhgu
    rhgvficulfgvfhhfvghrhidfuceorghnughrvgifsegrjhdrihgurdgruheqnecuggftrf
    grthhtvghrnhepudfftddvveekfffgteffffeuveegjeelgefhffejtdehtdfhlefgkeef
    hfefkeeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:KgFbXwFXlhd6LjWtR0lM_tDwvA-LJ-v1Z8vPww85vUzVbEYDhoRvVQ>
    <xmx:KgFbX5Rd_XS4aDwadS0KL9pTkfT1agrqBcFxOBDoQRaE0zGybk6H1g>
    <xmx:KgFbX1yUp0pNYnyt6zHTy-uaEP3dNinHbSU4W0hFHakR3IniauA47A>
    <xmx:LAFbX6r1y43zyjRpJIBQtxzKBS-0jzKr_qWWEyRXxsCQ7W4azcQxmg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B6B26E00A6; Fri, 11 Sep 2020 00:46:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-259-g88fbbfa-fm-20200903.003-g88fbbfa3
Mime-Version: 1.0
Message-Id: <551926fc-7bd4-4a0e-8fcf-4675dcdba22b@www.fastmail.com>
In-Reply-To: <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
References: <20200911034631.8473-1-chiawei_wang@aspeedtech.com>
 <CACPK8XcYvUj3W-CPzXKugp3wx7rcLEJ_8f2-Bi6V7QHZpopBbA@mail.gmail.com>
Date:   Fri, 11 Sep 2020 14:15:56 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Joel Stanley" <joel@jms.id.au>,
        "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>
Cc:     "Rob Herring" <robh+dt@kernel.org>,
        "Corey Minyard" <minyard@acm.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Haiyue Wang" <haiyue.wang@linux.intel.com>,
        "Cyril Bur" <cyrilbur@gmail.com>,
        "Robert Lippert" <rlippert@google.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "OpenBMC Maillist" <openbmc@lists.ozlabs.org>,
        "Ryan Chen" <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 0/4] Remove LPC register partitioning
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 11 Sep 2020, at 13:33, Joel Stanley wrote:
> Hello,
> 
> On Fri, 11 Sep 2020 at 03:46, Chia-Wei, Wang
> <chiawei_wang@aspeedtech.com> wrote:
> >
> > The LPC controller has no concept of the BMC and the Host partitions.
> > The incorrect partitioning can impose unnecessary range restrictions
> > on register access through the syscon regmap interface.
> >
> > For instance, HICRB contains the I/O port address configuration
> > of KCS channel 1/2. However, the KCS#1/#2 drivers cannot access
> > HICRB as it is located at the other LPC partition.

Thanks for addressing this, I've regretted that choice for a while now.

The split was rooted in trying to support pinmux while not being
across every detail of the LPC controller, and so I made some poor
decisions.

> >
> > In addition, to be backward compatible, the newly added HW control
> > bits could be added at any reserved bits over the LPC addressing space.
> >
> > Thereby, this patch series aims to remove the LPC partitioning for
> > better driver development and maintenance.
> 
> I support this cleanup. The only consideration is to be careful with
> breaking the driver/device-tree relationship. We either need to ensure
> the drivers remain compatible with  both device trees.
> 
> Another solution is to get agreement from all parties that for the LPC
> device the device tree is always the one shipped with the kernel, so
> it is okay to make incompatible changes.
> 
> While we are doing a cleanup, Andrew suggested we remove the detailed
> description of LPC out of the device tree. We would have the one LPC
> node, and create a LPC driver that creates all of the sub devices
> (snoop, FW cycles, kcs, bt, vuart). Andrew, can  you elaborate on this
> plan?

I dug up the conversation I had with Rob over a year ago about being
unhappy with what I'd cooked up.

https://lore.kernel.org/linux-arm-kernel/CAL_JsqJ+sFDG8eKbV3gvmqVHx+otWbki4dY213apzXgfhbXXEw@mail.gmail.com/

But I think you covered most of the idea there: We have the LPC driver
create the subdevices and that moves the details out of the devicetree.
However, I haven't thought about it more than that, and I think there are
still problems with that idea. For instance, how we manage configuration
of those devices, and how to enable only the devices a given platform
actually cares about (i.e. the problems that devicetree solves for us).

It may be that the only way to do that is with platform code, and that's
not really a direction we should be going either.

Andrew
