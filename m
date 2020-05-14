Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222F3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7783206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589478945;
	bh=YuV4JmNCFxZTXRRZDTourQqWeIzvbe4ZSXIszNZz9GA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XAxW7JfYRAOmJnNR5rYGT1oR5sg3VX2F5mZrAXZnJ2gogw+yrc/VU1T15kjcXzHOp
	 OoOJzWiV3SIo41Gtbmu9J3PMcX/3V80tdo3irQAgVStxE5xrCdYgvZ1LJ/3jZLr5iv
	 +FZUpSh0nE2cfz9l6IlR+6QMCzpCI2EN//Xf+kgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbgENRzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:55:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgENRzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:55:43 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9689206DC;
        Thu, 14 May 2020 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589478943;
        bh=YuV4JmNCFxZTXRRZDTourQqWeIzvbe4ZSXIszNZz9GA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qk0qfM6N9/BYlt8vhnlziu5fJ2+hOhGJEWF6m2LEC+7om7iytJH/k4q2cTG4oZN8n
         yiW6yUweL151sXQTBt7Y8q6ov+iS15+MQ+V14DHZXd5ADbc5rs4SmsQNlarrP1H9/Y
         y1CXJBHRie4MdgEjWs7rJ+63hfpeKuin7pqCfZw8=
Received: by mail-oo1-f43.google.com with SMTP id u190so905177ooa.10;
        Thu, 14 May 2020 10:55:42 -0700 (PDT)
X-Gm-Message-State: AOAM530ZM0MnjH73JLF5vIDzMut9GkB9GDiClqS27X6zj3CiuIPvSVc4
        DSiECRVRIDDfXa6lNrygk2aXL9/JhDtl55/thA==
X-Google-Smtp-Source: ABdhPJyYQ1f7xwVyNWr/S3JB/4XJ/2dszYIEcPkkumlKlHYG1FOqs0/y0vGXRbvvDqR04i1DfUOOMXv5SZ6p1Vso3BA=
X-Received: by 2002:a4a:894d:: with SMTP id g13mr4522354ooi.81.1589478941954;
 Thu, 14 May 2020 10:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
 <1588756279-17289-7-git-send-email-christophe.kerello@st.com>
 <20200514150028.GB28489@bogus> <9ffc04cf-137f-5ee5-57ff-39a876abfb34@st.com>
In-Reply-To: <9ffc04cf-137f-5ee5-57ff-39a876abfb34@st.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 14 May 2020 12:55:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLTyDHBHncrQqtPdkCNgKDkEbp+ts7BOeqWmGv64kcAsg@mail.gmail.com>
Message-ID: <CAL_JsqLTyDHBHncrQqtPdkCNgKDkEbp+ts7BOeqWmGv64kcAsg@mail.gmail.com>
Subject: Re: [PATCH v4 06/10] dt-bindings: mtd: update STM32 FMC2 NAND
 controller documentation
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 11:35 AM Christophe Kerello
<christophe.kerello@st.com> wrote:
>
> Hi Rob,
>
> On 5/14/20 5:00 PM, Rob Herring wrote:
> > On Wed, May 06, 2020 at 11:11:15AM +0200, Christophe Kerello wrote:
> >> These bindings can be used on SOCs where the FMC2 NAND controller is
> >> in standalone. In case that the FMC2 embeds 2 controllers (an external
> >> bus controller and a raw NAND controller), the register base and the
> >> clock will be defined in the parent node. It is the reason why the
> >> register base address and the clock are now optional.
> >>
> >> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> >> ---
> >>   .../devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml   | 19 ++++++++++---------
> >>   1 file changed, 10 insertions(+), 9 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> >> index b059267..68fac1a 100644
> >> --- a/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> >> +++ b/Documentation/devicetree/bindings/mtd/st,stm32-fmc2-nand.yaml
> >> @@ -18,13 +18,15 @@ properties:
> >>
> >>     reg:
> >>       items:
> >> -      - description: Registers
> >> +      - description: Registers (optional)
> >
> > The only thing that can be optional are the last entries. You have to do
> > a 'oneOf' with 6 entries and 7 entries.
>
> Ok, so the way to describe the reg property in my case should be:
>         reg:
>           oneOf:
>             - description: FMC2 embeds the NFC controller in standalone.
>               items:
>                 - description: Registers
>                 - description: Chip select 0 data
>                 - description: Chip select 0 command
>                 - description: Chip select 0 address space
>                 - description: Chip select 1 data
>                 - description: Chip select 1 command
>                 - description: Chip select 1 address space
>
>             - description: FMC2 embeds the NFC controller and the EBI
>                 controller.
>               items:
>                 - description: Chip select 0 data
>                 - description: Chip select 0 command
>                 - description: Chip select 0 address space
>                 - description: Chip select 1 data
>                 - description: Chip select 1 command
>                 - description: Chip select 1 address space
>
> >
> > And where's your new compatible string for this different h/w?
>
>  From NFC controller point of view, it is the same HW.

That's what everyone says until they have some quirk or integration
difference to handle.

> In the case that we have 2 controllers embedded, the register base is
> shared.
> The NFC driver will check at probe time the compatible string of its
> parent node.
> In case that it is "st,stm32mp1-fmc2-ebi", then the driver will find the
> register base in the parent node (EBI node), otherwise it will find it
> in the NFC node.
> Is it better to have 2 compatible strings (one for each reg description)
> than checking the parent's compatible string and have only one
> compatible string?

Why not just put the register base into the child node too? While
overlapping 'reg' regions for siblings is bad, it's fine for child
nodes. I guess since there are chip selects for the child nodes that
may not work here.

It doesn't hurt to have another compatible. You can always make the
old one a fallback. With different compatibles you can make sure reg
has the right number of entries.

Rob
