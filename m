Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D158C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F83F246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ExCJs9Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgB1JqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:46:24 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45534 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB1JqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:46:24 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9kA2p092506;
        Fri, 28 Feb 2020 03:46:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582883170;
        bh=c2o0KfeDE8LsXiUgyljzWzRxFOrZt7ujr7i1FEE6h+U=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ExCJs9PnvbMVgnP4NkPmcH7pk7Uz+kF0/vY453UC96M6L8DAjXSBIX3qSYs1iQ+9w
         QldOiOUVgNXNp8gRaBoAsfcE4h41dWejqyBMQw0xA5iiWYFTrK7d6KjHwoZf72dkjg
         /TCrLvDjM6H6kFEXsV00dN7y8TVoDgi7GwuzKGn8=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01S9kAeC013540
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 03:46:10 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:46:09 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:46:09 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01S9k9IA123014;
        Fri, 28 Feb 2020 03:46:09 -0600
Date:   Fri, 28 Feb 2020 15:16:08 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Message-ID: <20200228094606.fyxtlutq2aajfyyo@ti.com>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-2-p.yadav@ti.com>
 <CAMuHMdUGN8Yu6Tx0=OoLKzyOZ08fvjF6pEWi3ye02pr3Cgj=cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAMuHMdUGN8Yu6Tx0=OoLKzyOZ08fvjF6pEWi3ye02pr3Cgj=cg@mail.gmail.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On 27/02/20 05:29PM, Geert Uytterhoeven wrote:
> Hi Pratyush,
> 
> On Wed, Feb 26, 2020 at 10:37 AM Pratyush Yadav <p.yadav@ti.com> wrote:
> > Allow spi devices to express DTR receive and transmit capabilities via
> > the properties "spi-rx-dtr" and "spi-tx-dtr".
> >
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> 
> Thanks for your patch!
> 
> > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > @@ -120,6 +120,11 @@ patternProperties:
> >          description:
> >            Delay, in microseconds, after a read transfer.
> >
> > +      spi-rx-dtr:
> > +        $ref: /schemas/types.yaml#/definitions/flag
> > +        description:
> > +          Device supports receiving in DTR mode.
> 
> Please explain "DTR" in the document, at least once, e.g.
> 
>     Double Transfer Rate (DTR).

Will do.
 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Regards,
Pratyush Yadav
Texas Instruments India
