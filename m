Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5CC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D6F2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tlDQNkLZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgHaJR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgHaJRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:17:19 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02227C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:17:19 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id o2so1136133vke.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xPGNmRsw3clREJxbIhujJ9BVleZMZH++KW5cFLsU7tw=;
        b=tlDQNkLZggK8U/Lk6uMqpZ+lGjfqbCJSCUZb57Ym4MFnvUK/CBUKF7Yzan7RV9BUpc
         EsrsLsKnikuoGLXzZp42UGJBfBCoSSP3uIQVOZXVUsxVuukagyoL7alSoxX/5MxoWOv2
         FmcSbibxh9YvDoggCu3yQIEN6SN8Z/y9YnB4gSyt7VT7X7TAv3omICQpIrXxZ84m4fBp
         MJfGoSV5OjZk5Yx94DT2bGUoRR1yVCvvBUGfoN30eTkq9mgHfxmOqKzJeemfncdMkqrs
         /SUqInD/1dB7B1DfN/RJiWdEjpKMlgIPlUot1sCZ2bJ3kdOxhn1lSX8r4iAQm6okgw/s
         nVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xPGNmRsw3clREJxbIhujJ9BVleZMZH++KW5cFLsU7tw=;
        b=TG5pnQ4z1U0B0CsAVse+7EJ56fBK0feu49CGIY0CDaG76VvEdQdNZ+Vcst422Esd8S
         rb+yk1ivRw1gFhvvKrDia56W/m1y76lSMJUION4U8Cg05EsIXx9Pu5QA+ncbvSz9RPx2
         Bu/8uxE+QD92bbwqVE/Wzulmyi7ShMgPIesbUke2IuB5y1GoMy0SahQ+m4JO4aVwUzN9
         hLWeeAjeH6KAW3ZUKKipN5D/0OIMfNzViwVUCFUaZePxXARXFG9sq65Z7fiPElRWk7Zq
         bEmQwz6eM6MwbNbd7fxe9KcZKdRgyLlWNJ4qxLelE6ZjdX95pxO1VhsF1kt7BOatq0tA
         dHlw==
X-Gm-Message-State: AOAM531J63lVmF1JBbgyV44ZV7cd3RMSPyvG08tswBXhtD2lvPG/prgf
        G4ZPK1XPgrh3WCkk4xAoQPMg3OWZVvonZk9Bdtrw4Q==
X-Google-Smtp-Source: ABdhPJzS4H9cHKY3ezPrXkM8N+l+LltSj93sbk0pC64SOfwKVa7oGmMl3imZuK0I39yExSwEfnQ+mytHRmSIzO5o9X8=
X-Received: by 2002:a1f:c151:: with SMTP id r78mr238648vkf.44.1598865437983;
 Mon, 31 Aug 2020 02:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200825134441.17537-1-matthias.schiffer@ew.tq-group.com>
 <20200828222440.GA3507259@bogus> <4e1182d756a81e10b32b465bb36938cb62a98cdd.camel@ew.tq-group.com>
In-Reply-To: <4e1182d756a81e10b32b465bb36938cb62a98cdd.camel@ew.tq-group.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 31 Aug 2020 11:16:41 +0200
Message-ID: <CAPDyKFqH43VDvezTN_UPZvGNhfO=k69axF0nD4juFgdbAMNmpA@mail.gmail.com>
Subject: Re: [PATCH mmc-next v3 1/2] dt-bindings: mmc: add alias example
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Aug 2020 at 09:58, Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:
>
> On Fri, 2020-08-28 at 16:24 -0600, Rob Herring wrote:
> > On Tue, Aug 25, 2020 at 03:44:40PM +0200, Matthias Schiffer wrote:
> > > As for I2C and SPI, it now is possible to reserve a fixed index for
> > > mmc/mmcblk devices.
> > >
> > > Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
> > > >
> > > ---
> > >
> > > v3: new patch
> > >
> > >  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 8
> > > ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/mmc-
> > > controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-
> > > controller.yaml
> > > index b96da0c7f819..22ed4a36c65d 100644
> > > --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> > > @@ -367,6 +367,14 @@ examples:
> > >      };
> > >
> > >    - |
> > > +    /*
> > > +     * Optionally define an alias to reserve a fixed index for the
> > > +     * mmc and mmcblk devices
> > > +     */
> > > +    aliases {
> > > +        mmc0 = &mmc3;
> > > +    };
> >
> > This will break if we improve schemas because this node is actually
> > /example-1/aliases.
> >
> > So please drop. If you want, I'd really like to have a defined set
> > (i.e.
> > a schema) of alias names. This would require deleting a bunch on
> > some
> > platforms that just made up a bunch of them.
>
> Ulf suggested that I add some kind of documentation about the new mmc
> alias support to the binding docs.
>
> As long as we don't have a proper schema for aliases, should I just add
> an explanation to the toplevel description of
> Documentation/devicetree/bindings/mmc/mmc-controller.yaml, or maybe a
> comment?

I would prefer to add an explanation in the toplevel description,
although I have no strong opinion.

This is similar to what we already do for serial devices, see
Documentation/devicetree/bindings/serial/serial.yaml.

>
>
> >
> > > +
> > >      mmc3: mmc@1c12000 {
> > >          #address-cells = <1>;
> > >          #size-cells = <0>;
> > > --
> > > 2.17.1
> > >
>

Kind regards
Uffe
