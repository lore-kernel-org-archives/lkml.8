Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AABC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3C3222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 19:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582227251;
	bh=uJ4t90MUcm2Rs3FUpUGNuH1fKRXquVW7B2vhx0KhfMc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vC+o4gEgNiu9Gp+dTKZnqYjeJVFjMgyU3hJNJsPxXNVsVplysmMEIOVRUc+ULMqBj
	 cwiCpHx5uLKH/81lmf13WWxax9tbw6zk/dkkxXDIYT6IW72+MYYcX5pluw/t0z2KSN
	 JD1XRXCD1VatlekZHtGHE4m84u8QIC9vKCJmlBf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbgBTTeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:34:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:38384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728248AbgBTTeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 14:34:09 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9ACBC24673;
        Thu, 20 Feb 2020 19:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582227248;
        bh=uJ4t90MUcm2Rs3FUpUGNuH1fKRXquVW7B2vhx0KhfMc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qxTA3VvxXPxLF8Z2nqApQ9qHnQdlmBUcFu3dBI0dKwcTOaHsUssHFCENSeiXExcMD
         RztnMpZQh2syWiSgH59T3s9impKBC0BYqa/3jxG6aPRhopVYSQyVxqFSQeXw9sB5Gc
         52LzkLvlE5/o6kPHHuoHnRLL2A5GrRTJATosoAXc=
Received: by mail-qt1-f172.google.com with SMTP id t13so3745164qto.3;
        Thu, 20 Feb 2020 11:34:08 -0800 (PST)
X-Gm-Message-State: APjAAAX/LRx38IbhQIKeeLsiD/+nmBIICv0S9+Ir7ZAoF2D9rLxlMtgZ
        GEM5bWhJPcCuRiARIFAFA96/9mA63aRVw91wBQ==
X-Google-Smtp-Source: APXvYqwxk1I/GNoeG3uH+//blhvQnxUtBjf4k/wCoPfqEiz310MN6xdMjEU7XnKk0iB2OWKwSLEOArJ/Wwq5RoUwDpY=
X-Received: by 2002:ac8:5513:: with SMTP id j19mr28394295qtq.143.1582227247582;
 Thu, 20 Feb 2020 11:34:07 -0800 (PST)
MIME-Version: 1.0
References: <87d0ahzr9d.wl-kuninori.morimoto.gx@renesas.com>
 <20200219161732.GB25095@bogus> <874kvmt355.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874kvmt355.wl-kuninori.morimoto.gx@renesas.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 20 Feb 2020 13:33:56 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+VEQj9Nkyo_85RM3Ku1-D73_ot5BTAjidnJzJv7r1_Sw@mail.gmail.com>
Message-ID: <CAL_Jsq+VEQj9Nkyo_85RM3Ku1-D73_ot5BTAjidnJzJv7r1_Sw@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: renesas,rsnd: switch to yaml base Documentation
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 8:16 PM Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
>
> Hi Rob
>
> Thank you for your review
>
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > >
> > > This patch switches from .txt base to .yaml base Document.
> > > It is still keeping detail explanations at .txt
> > >
> > > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > ---
> (snip)
> > > +  compatible:
> > > +    oneOf:
> > > +      # for Gen1 SoC
> > > +      - items:
> > > +        - enum:
> >
> > nit: Should be indented 2 more spaces.
>
> I couldn't understand this.
> Do you mean like this ??
>
>    compatible:
>      oneOf:
>        # for Gen1 SoC
>        - items:
> =>         - enum:

Yes.

>
> > > +  clock-frequency:
> > > +    description: for audio_clkout0/1/2/3
> > > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >
> > This already has a common definition and this conflicts with that.
> > 'clock-frequency' is a single uint32 or uint64.
>
> This needs clock array. Like this
>
>         clock-frequency = <12288000 11289600>;

Sorry, but the type is already defined in the spec. You'll still get
warnings from the common schema and you can't override that here.

Not sure what to suggest. Leave it with a fixme or move to
assigned-clocks-rates instead?

> > > +  # For OF-graph
> > > +  port:
> > > +    description: OF-Graph subnode
> > > +    type: object
> > > +    properties:
> > > +      reg:
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> >
> > No unit-address for 'port', so you don't need 'reg' here.
>
> But I got warning without reg ?

Yeah, because of your $ref from ports.

> And, renesas,rsnd and/or simple-card sometimes needs reg for port
> to handle sound path.
>
> > > +  # For multi OF-graph
> > > +  ports:
> > > +    description: multi OF-Graph subnode
> > > +    type: object
> > > +    patternProperties:
> > > +      "port(@.*)?":
> >
> > ^port(@[0-9a-f])?$"
> >
> > Perhaps there's max number of ports that's less than 0xf?
> >
> > > +        $ref: "#properties/port"
> >
> > Would be more simple to just always have 'ports'.
>
> Having "ports" or "port" are case-by-case, not always.

Why?

This:

port {};

and this:

ports {
  port {};
};

Are treated the same. It's perfectly valid to have 'ports' with a single port.

Rob
