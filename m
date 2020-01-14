Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F37C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D21F24673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579023993;
	bh=mXc8/w8tY8RXyg7swtRyAC0oYcXKe+2puA+wT86utiY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qcN3xrn4pzANAuQrLH4nwd/dtpwagPWL0AUYl0D+7SnZjBfBinrd365LEiVaCHRzA
	 cYTa+xGp7p84JLUZew0Z0GNInQc6xuRbXAFWBpEC7+W81jfa6U+MvFUFX+JpUsqH6F
	 89DKH8/JsIwILdDlRbhWihNWIErCWOVeCx6OoEtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgANRqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:46:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:53904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgANRqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:46:31 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D123C24681;
        Tue, 14 Jan 2020 17:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579023991;
        bh=mXc8/w8tY8RXyg7swtRyAC0oYcXKe+2puA+wT86utiY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jO2fxggsWM5N6fDuJsQiwOrF47A7M0Zj6PjohQnWobjCR2xHQjoywTjQap5QCKX8p
         iEHdg2y8Kch7ICsK2mTl/kaCOS2AZf0wjHLqfkXREssRjYVgcCkJO3lxmKlNWts9AG
         dRkXSvn9hiTVctu5Dd87ETssj41Oqiq2Rxjbt8u4=
Received: by mail-qv1-f52.google.com with SMTP id dc14so6037980qvb.9;
        Tue, 14 Jan 2020 09:46:30 -0800 (PST)
X-Gm-Message-State: APjAAAXkpB4KgiaGNEqeW/iP84Opo/o+5MG/ssKz862MTnAqtXW4W8eB
        aiReoBGJYseiQ3afaSaf84gLbjvUqHw+uSHZrw==
X-Google-Smtp-Source: APXvYqyzXMJ62ahYNuL6VK1Cf8ZGH/+06Kwo7FdWPAvSiMHBuwB7fFnCgD4KmcvFWnoyxKzjiFXuvKUl+MLXk2qpQcg=
X-Received: by 2002:a0c:f68f:: with SMTP id p15mr17346460qvn.79.1579023989888;
 Tue, 14 Jan 2020 09:46:29 -0800 (PST)
MIME-Version: 1.0
References: <20191127105522.31445-1-miquel.raynal@bootlin.com>
 <20191127105522.31445-5-miquel.raynal@bootlin.com> <20191209113506.41341ed4@collabora.com>
In-Reply-To: <20191209113506.41341ed4@collabora.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Jan 2020 11:46:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJP3-h7bPAommzt7KQKoohZpkk=RMxfN1j3rXbisD4eCA@mail.gmail.com>
Message-ID: <CAL_JsqJP3-h7bPAommzt7KQKoohZpkk=RMxfN1j3rXbisD4eCA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] mtd: Add driver for concatenating devices
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Bernhard Frauendienst <kernel@nospam.obeliks.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 4:35 AM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
> On Wed, 27 Nov 2019 11:55:22 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> > Introduce a generic way to define concatenated MTD devices. This may
> > be very useful in the case of ie. stacked SPI-NOR. Partitions to
> > concatenate are described in an additional property of the partitions
> > subnode:
> >
> >         flash0 {
> >                 partitions {
> >                         compatible = "fixed-partitions";
> >                         part-concat = <&flash0_part1>, <&flash1_part0>;
> >
> >                       part0@0 {
> >                               label = "part0_0";
> >                               reg = <0x0 0x800000>;
> >                       };
> >
> >                       flash0_part1: part1@800000 {
> >                               label = "part0_1";
> >                               reg = <0x800000 0x800000>;
>
> So, flash0_part1 and flash0_part2 will be created even though the user
> probably doesn't need them?

I don't follow?

>
> >                       };
> >                 };
> >         };
> >
> >         flash1 {
> >                 partitions {
> >                         compatible = "fixed-partitions";
> >
> >                       flash0_part1: part1@0 {
> >                               label = "part1_0";
> >                               reg = <0x0 0x800000>;
> >                       };
> >
> >                       part0@800000 {
> >                               label = "part1_1";
> >                               reg = <0x800000 0x800000>;
> >                       };
> >                 };
> >         };
>
> IMHO this representation is far from intuitive. At first glance it's not
> obvious which partitions are linked together and what's the name of the
> resulting concatenated part. I definitely prefer the solution where we
> have a virtual device describing the concatenation. I also understand
> that this goes against the #1 DT rule: "DT only decribes HW blocks, not
> how they should be used/configured", but maybe we can find a compromise
> here, like moving this description to the /chosen node?
>
> chosen {
>         flash-arrays {
>                 /*
>                  * my-flash-array is the MTD name if label is
>                  * not present.
>                  */
>                 my-flash-array {
>                         /*
>                          * We could have
>                          * compatible = "flash-array";
>                          * but we can also do without it.
>                          */
>                         label = "foo";
>                         flashes = <&flash1 &flash2 ...>;
>                         partitions {
>                                 /* usual partition description. */
>                                 ...
>                         };
>                 };
>         };
> };
>
> Rob, what do you think?

I don't think chosen is the right place to put all the partition
information. It's not something the bootloader configures.

This suffers from the same issue I have with the original proposal. It
will not work for existing s/w. There's only 1 logical partition that
concatenated. The rest of the partitions shouldn't need any special
handling. So we really only need some way to say 'link these 2
partitions into 1 logical partition'. Though perhaps one could want to
combine any number of physical partitions into logical partitions, but
then none of the proposals could support that. Then again, maybe
that's a userspace problem like with disks.

To throw out another option, what if the first device contains the
complete partitions for both devices with some property in one or both
devices pointing to the other device? That would make the partitions
in the 1st device still accessible to existing s/w (unless it bounds
checks the partitions).

Rob
