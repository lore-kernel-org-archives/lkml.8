Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C090BC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98ABB21D6C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594738320;
	bh=yBb5NwYoawydc+4SE8fRGu7VyXAWbEb+g0AP6WC6mFc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vf3o0+ODAV4z1I4+KVNdmuyutN7CmJQF28pGHTQgVEi564Q+vNLvFTgrgzrM1nSSc
	 WYLYNAvYPqHsAu6qvcxBPn5W/Gqa09oOgf5nHegfE66a2wO5YD0i0CefFiBWVpBOoi
	 K6zSNH+p+ptrXCQdC1OPXKzhq3WEzuBP+sV40cAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgGNOv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:51:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbgGNOv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:51:58 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF73C21973;
        Tue, 14 Jul 2020 14:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594738318;
        bh=yBb5NwYoawydc+4SE8fRGu7VyXAWbEb+g0AP6WC6mFc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ExIYtMs8JLqxwbj6nNae6eHnbYrvDYP541mY1ltF6anHWu+bVCKIuwonfQ8bolWwo
         M1jqUoMWjVDZ0zMdYu2r22PNYJKQP0HIX7KUKdoB0lkauYgHJcWb/YtvIkeWpiIll/
         /hGntYFS6PsAi0fD5K6FyrdUTkfYQoDbDfYu4BWo=
Received: by mail-ot1-f47.google.com with SMTP id n24so13192540otr.13;
        Tue, 14 Jul 2020 07:51:57 -0700 (PDT)
X-Gm-Message-State: AOAM532SXy19f2eUz7X/OHR52VEtv1vNeRuT6+iNJnlp9Rwr638ofLIS
        S7hpEK3yTK+2AD9yt/MGzcmNlF/eoXjAmXqK4g==
X-Google-Smtp-Source: ABdhPJxu9bDpxj3Hu09V0IUmiMju7QCn1apEa8gYBelufC7LjqgI1XuYmXKWxWiuIqZ3DwQLWjG/IWRcqN1eIQ909Gg=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr4155072otb.107.1594738317260;
 Tue, 14 Jul 2020 07:51:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200708074035.31595-1-luca@lucaceresoli.net> <20200708074035.31595-4-luca@lucaceresoli.net>
 <20200714031109.GA1210492@bogus> <6177ebd1-b39a-3b53-3f5b-92f8d1f9881b@lucaceresoli.net>
In-Reply-To: <6177ebd1-b39a-3b53-3f5b-92f8d1f9881b@lucaceresoli.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 14 Jul 2020 08:51:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKCQJjAoZciQOv+Ksb885E9MSR9FB1dEAkUh7DbqM_gcg@mail.gmail.com>
Message-ID: <CAL_JsqKCQJjAoZciQOv+Ksb885E9MSR9FB1dEAkUh7DbqM_gcg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: clk: versaclock5: convert to yaml
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Adam Ford <aford173@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 3:15 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Rob,
>
> thanks for you review!
>
> On 14/07/20 05:11, Rob Herring wrote:
> > On Wed, Jul 08, 2020 at 09:40:35AM +0200, Luca Ceresoli wrote:
> >> Convert to yaml the VersaClock bindings document. The mapping between
> >> clock specifier and physical pins cannot be described formally in yaml
> >> schema, then keep it verbatim in the description field.
> >>
> >> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>
> [...]
>
> >> +  reg:
> >> +    maxItems: 1
> >> +    description: I2C device address, shall be 0x68 or 0x6a.
> >
> > Can be a schema:
> >
> > enum: [ 0x68, 0x6a ]
>
> Nice, will fix.
>
> >> +
> >> +  '#clock-cells':
> >> +    const: 1
> >> +
> >> +patternProperties:
> >> +  "^OUT[1-4]$":
> >> +    type: object
> >> +    description:
> >> +      Description of one of the outputs (OUT1..OUT4). See "Clock1 Output
> >> +      Configuration" in the Versaclock 5/6/6E Family Register Description
> >> +      and Programming Guide.
> >> +    properties:
> >> +      idt,mode:
> >> +        description:
> >> +          The output drive mode. Values defined in dt-bindings/clk/versaclock.h
> >> +        enum:
> >> +          - VC5_LVPECL
> >
> > This is defining a string. Can't use defines here.
>
> How do I use the defines from include/dt-bindings then? Or should I just
> use the numeric values then, like:
>
>   idt,mode:
>     description:
>       The output drive mode. Values defined in
>       dt-bindings/clk/versaclock.h
>     minimum: 0
>     maximum: 6
>
> ?

Yes.

>
> >> +      idt,voltage-microvolts:
> >> +        description: The output drive voltage.
> >> +        $ref: /schemas/types.yaml#/definitions/uint32
> >
> > Standard unit suffixes have a type already, so drop.
>
> Ok.
>
> >> +allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - idt,5p49v5933
> >> +              - idt,5p49v5935
> >> +    then:
> >> +      # Devices with builtin crystal, optional external input
> >> +      properties:
> >> +        clock-names:
> >> +          const: clkin
> >> +        clocks:
> >> +          maxItems: 1
> >> +    else:
> >> +      # Devices without builtin crystal
> >> +      properties:
> >> +        clock-names:
> >> +          anyOf:
> >> +            - required: [ xin ]
> >> +            - required: [ clkin ]
> >
> > This isn't valid. I think you want:
> >
> > clock-names:
> >   minItems: 1
> >   items:
> >     - const: xin
> >     - const: clkin
> >
> > This would mean 'xin' is always required, clkin is optional.
>
> No, what I wanted to mean is that allowed cases are:
>  * for idt,5p49v5933 and idt,5p49v5935:
>    - only 'xin' (required)

For this you need an if/then schema. There are plenty of examples in
the tree, but this is what you need:

if:
  properties:
    compatible:
      enum:
        - idt,5p49v5933
        - idt,5p49v5935
then:
  properties:
    clocks:
      maxItems: 1
    clock-names:
      const: xin

>  * for the other parts one of these:
>    - only 'xin'
>    - only 'clkin'
>    - both 'xin' and 'clkin'
>
> How do I express that?

For the 2nd part:

clock-names:
  minItems: 1
  maxItems: 2
  items:
    enum: [ xin, clkin ]

> A general note: as a newcomer to yaml bindings I found a steep learning
> curve. Finding a correct construct (not to mention the best one) for
> each situation is time consuming and frustrating. I've been looking at
> existing files for suitable examples but it doesn't work very well.
>
> Is there any guide to yaml bindings for beginners with examples of
> typical cases? It would greatly help in producing better patches and
> saving time for everybody.

bindings/example-schema.yaml is intended to do that. No doubt it could
use more examples. Though from my perspective people already don't
read and follow things it says there.

The problem I think is not the typical cases, but the atypical ones. I
don't think we can enumerate all the atypical cases. At that point you
really need some understanding of json-schema which I agree has a bit
of a learning curve if you've never used anything like it (I hadn't).

Rob
