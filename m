Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1B4C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5033320718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vt9a75b6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgBQPdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:33:47 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37432 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728002AbgBQPdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:33:46 -0500
Received: by mail-ed1-f68.google.com with SMTP id t7so9455978edr.4;
        Mon, 17 Feb 2020 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cpDwgE9K4RX3YbsUsXFN1RxAexrY0yin13bDyT1Pydo=;
        b=Vt9a75b6ulHLYug9ORVv2qddFUbDqbV0qW9CtOGS4oDqSVs9nx21NosXzjxYJVxMnz
         Pu7nhiFxbbhjtAUjfyo5P+4RueOD0E/oVaELaFUW5l36zeXuWi+S7PCBLQ8v1a4Q9yXp
         1Aq8d59GNpz3RxJ13Rzlmwbb1bLbXCvKrbPlNX29pF3Wr0730Y0v5uMzH8llyNoah3W4
         z/TZA8eqBekmfAqV54oWYf1hPTjOXup5hzElFNxKmGJBG8bBIMYVEHKvRzIJZGDZR4//
         sC0GJzQPl18/wNWfZ5+lT+79A3KfPwE280NF++pr6knlLSsszJkFpHSBoTZUIu8U6Ws3
         E1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cpDwgE9K4RX3YbsUsXFN1RxAexrY0yin13bDyT1Pydo=;
        b=bPXdixltFLcclUSwt0vEN3zL1ITqYM862xPUigLWeOUlKToI1zRziCdZKkwWZQy1+Q
         PmaY1hXNo8IXhl/CeZO+c0p0PfGcwTpVljGgQPHL+tI6QIFmckpMucm2m3QmgbCFyn+R
         n/d4qQiDJV0dz6FD5tklO169XP5Pb4PF+AhnnZrNxTUEKjxNOfex2cgUgvGzrkugkRYc
         1UaZ6KpZD56GeFpXhfOENV3OVfEwJxznQk758nJDAa6SutapwAdn9QkcoyqQ0B4iiPgG
         R4ZhmAjbqPxqFgINqBcBrQRZi8kUnRWLFx+dAygZmjRcLjVfYt/2sx3q5jmHyLLXN0e1
         ItaQ==
X-Gm-Message-State: APjAAAUtIR7zA65Qu/Pfj6BaSOMciJUAm9QuRVAYqG2ntBWIZDe2dKJh
        nT6mbK8u3uL20bz4o8ppTCNr0AIcjBAG1ZeGL/M=
X-Google-Smtp-Source: APXvYqyEhbUMliSSuUHQSx5pNXCM3Cx87B6D7Hnl92XJYYx/7VuKSXcpeYZMT6j5RHmnc3Urzc5Q2GClWyL+yoXzUlw=
X-Received: by 2002:a17:906:31c3:: with SMTP id f3mr15005416ejf.239.1581953624846;
 Mon, 17 Feb 2020 07:33:44 -0800 (PST)
MIME-Version: 1.0
References: <20200217144414.409-1-olteanv@gmail.com> <20200217144414.409-4-olteanv@gmail.com>
 <20200217152912.GE31084@lunn.ch>
In-Reply-To: <20200217152912.GE31084@lunn.ch>
From:   Vladimir Oltean <olteanv@gmail.com>
Date:   Mon, 17 Feb 2020 17:33:33 +0200
Message-ID: <CA+h21ho29TRG8JYfSaaSsoxM-mg0-yOKBNCq9wbHDHCf2pkdUg@mail.gmail.com>
Subject: Re: [PATCH devicetree 3/4] arm64: dts: fsl: ls1028a: add node for
 Felix switch
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, 17 Feb 2020 at 17:29, Andrew Lunn <andrew@lunn.ch> wrote:
>
> Hi Vladimir
>
> > +                                     /* Internal port with DSA tagging */
> > +                                     mscc_felix_port4: port@4 {
> > +                                             reg = <4>;
> > +                                             phy-mode = "gmii";
>
> Is it really using gmii? Often in SoC connections use something else,
> and phy-mode = "internal" is more appropriate.
>

What would be that "something else"? Given that the host port and the
switch are completely different hardware IP blocks, I would assume
that a parallel GMII is what's connecting them, no optimizations done.
Certainly no serializer. But I don't know for sure.
Does it matter, in the end?

> > +                                             ethernet = <&enetc_port2>;
> > +
> > +                                             fixed-link {
> > +                                                     speed = <2500>;
> > +                                                     full-duplex;
> > +                                             };
>
> gmii and 2500 also don't really go together.

Not even if you raise the clock frequency?

>
>      Andrew

Thanks,
-Vladimir
