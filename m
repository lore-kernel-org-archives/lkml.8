Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAA3C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:36:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2442074F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:36:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYVYUIdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgDZPge (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgDZPgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 11:36:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1C3C09B050
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:36:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b2so14882872ljp.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X77CRMCQDDgdc4Bur39RULXQxF3a/MrJ/qM13TQRcl0=;
        b=NYVYUIdXiXEUEPYYT3I/R1qAnkPPt3cT7aB7wcoSmtGOcWinkwL3B4FAZKsqUsBC+7
         EbE20jkfrnneUQiwAC3g3XB+K72YRxyC7g9/b3z8XqRwKEs7Phsfd9nQiLH0aY5a4sPy
         YpSzGv+bVifsrIV7RfYcYTkf/rKBasnwAMVUHprWphf0HsikZIOwrJ16GBbbvY1+ObKA
         VGvJ+y7WwtkxvVTJTuf8cZI1zMMyyY+sqfhGajVIPN+M2rDln91qxhZ+ewxRuOrRrKJV
         mdxDKAYaguUjc/Dg6MV3ccxQP/KAwqmIJPUqWulw+eEM1J2C6XmPJZ5zx39OHRyBhDOK
         qXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X77CRMCQDDgdc4Bur39RULXQxF3a/MrJ/qM13TQRcl0=;
        b=Mq/gk6ljG+4TDPpBLehddL4OykPmbfLCJVIhzjhuQ9+F2j20Cc4ZkQ4dsNJJf+7zQ4
         EMhFFHTBYcwFSyxKQsUb6BqxiugKfbfvQR1Z4ZTA6fAWhU/OSPgDihrHg5crIxnigQjn
         I5LsMDE0K+aOlbSwH3AM/jpLYp7hp2tf774ldlA7VSlMij2cyMOPyjjT9Pkh7oQhxTqy
         AcY053LCpCguZNLr1bYVb1GmoMWO7Oz7UQ+HvQEFascVwj+eE+bGmRdPUXxk4Ibcwyb9
         dRZhH69+qBtS+12knR17YenKRZrYV716IO1/nskWx/HHRKEcbkV38zqhjDR7Sy3KbsTb
         1/8Q==
X-Gm-Message-State: AGi0PuaEw7YFQ2hZ3jkOYVh2R1LpPOi8GCgLmz7mn+SyDsDJFUmw/ilI
        abNICYx1ON/TTffW/UNTUlzW4yVpg+fZB5dmIZzXAQ==
X-Google-Smtp-Source: APiQypKj/Im70RltLS80+jbqf0SqRD8efu2GTat9yvLZn+7xqD3hNXs33YaVw72fniLFc/ebyiVe0IHjroY93q9fxEE=
X-Received: by 2002:a2e:553:: with SMTP id 80mr11651325ljf.147.1587915391895;
 Sun, 26 Apr 2020 08:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200423064808.10468-1-etienne.carriere@linaro.org>
 <20200423064808.10468-2-etienne.carriere@linaro.org> <CAL_JsqKvQasaBCHC2s68WmtfwGN+t349tzmF=ySkuYz11HzksQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKvQasaBCHC2s68WmtfwGN+t349tzmF=ySkuYz11HzksQ@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Sun, 26 Apr 2020 17:36:20 +0200
Message-ID: <CAN5uoS-zizF_by6WDtF7j9MrGsRt1fir5w+r1cN1QNzDUf8zgQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: arm: Add secure-clocks binding description
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 at 00:06, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Apr 23, 2020 at 1:49 AM Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Describe how clocks property can leverage secure- property prefix
> > for clocks handled exclusively or shared by secure and non-secure
> > worlds.
> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/secure.txt        | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/secure.txt b/Documentation/devicetree/bindings/arm/secure.txt
> > index f27bbff2c780..9bc94921f2a6 100644
> > --- a/Documentation/devicetree/bindings/arm/secure.txt
> > +++ b/Documentation/devicetree/bindings/arm/secure.txt
> > @@ -53,6 +53,25 @@ Valid Secure world properties
> >     status = "disabled";                             /* disabled in both */
> >     status = "disabled"; secure-status = "disabled"; /* disabled in both */
> >
> > +- secure-clocks : specifies the Phandle list secure world shall use
> > +  for the related clocks whereas property "clocks" specifies the
> > +  clock Phandle list non-secure shall use for the that clocks.
> > +  This configuration can apply for example when a hardware clock is
> > +  shared by the 2 worlds and the hardware implements a specific interface
> > +  for each world, i.e.:
> > +
> > +  clocks = <&clk DMA_NS>;      /* NS relies on clock handle DMA_NS */
> > +  secure-clocks = <&clk DMA_S>;        /* S relies on clock handle DMA_S */
>
> The device has to know what it's clocks are for and should know if
> some clocks are secure only.
>
> > +  Another example where use of "clocks" and "secure-clocks" can apply
> > +  is when hardware implements a clock that secure and non-secure must
> > +  share, as a shared GPIO bank clock, and secure world relies on clock
> > +  device driver whereas non-secure world relies on a software service
> > +  exposed by secure world as SCMI clock device. I.e.:
> > +
> > +  clocks = <&scmi_clk 2>;      /* NS relies on SCMI resources */
> > +  secure-clocks= <&clk 5>;     /* S accesses the SoC reset interfaces */
>
> If you have this case, I don't think this is the solution. I don't
> think it scales well and you probably need separate DTs. It's
> something to solve in the system DT project.

Acked,

Thanks,
Etienne

>
> Rob
