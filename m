Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FF9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D55020810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6OoWEOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgE2JOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgE2JO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:14:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FACC03E969;
        Fri, 29 May 2020 02:14:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so1714617ljo.5;
        Fri, 29 May 2020 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ucA1gw/ho1zSjwgJBn04nUvtlOmcEkuOvqSSP+X35Y=;
        b=H6OoWEOF97lm2cCfXBbp3785Efsi+f15oMc4dJhbp7Z+m2oCo5HSkIANJ1dN2xCMtB
         3g9dQFGu8D/x21reKf6SKaOiGXFpzhQVHrRQAR6N22YNDXY/NPjdMVzCjf4CBev8BxUp
         5tX1usKImxyRwg3GLA9CrXVyZFI0cX8m4NryjxJyAZMdzJ7VMfjK/Gf20zYFqqXmd5zq
         lL7zxwv9kHLpP4Pr4ANVXJCXRUmOqzEm0sskrumRQONW/zQ2xbt+nbro/Rm0A9m+38VV
         FNzzarU+v3mZvD2Zalr/fSpLqZCw41mtQ9l1mi5cTTcRCJBOwrqIJ2gLiFufXoRR4O2x
         bWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ucA1gw/ho1zSjwgJBn04nUvtlOmcEkuOvqSSP+X35Y=;
        b=G5idfrrOnc5I8I5Xf2KUVatFOobOjUZk6ypWs7kH5uem/9qDnvFMwQ5jFxwKM9FLF8
         4REASY/ibFP/QLZ6bJin/KNglMRRp/HGVJPO41SRVxNT26xLiblXx3eaZXgrWXuJo5xQ
         q4iStVxPCY9KtefcujB143uq+mIAEL7LkPVHWhmkV9t0I0HOo3X2Oakl1jsGP2Qqn+ff
         ghTCc0oM1Hrgf4DtDcokxqLh+LDgxM4jJH0KuMSmsejydZ2uu56G6c3SB6QiW7+ADSeU
         e8/kbz/4HdsT8iVN9Kw2Vu/cnyz6jBB6jKbR2j2shbRT38mBJ3LAKQvcKudXBflwuk+F
         5big==
X-Gm-Message-State: AOAM530pvLjpY8hL5Oj/3uRWECkuVUwT1jQM9vCYF1WwRWfC+IjHFjxf
        cPP87icnYr3jc73A7JGSEgGPoXWXNYtZDlHUjNIGqSoF
X-Google-Smtp-Source: ABdhPJxQWYV58ZprSnFScmEouw+J5GBxzk0/Tb470NoRu5UW6cbA0I3QwIY8Y0lmCdsE+6ikpmy9GqsZI2ByGcmH1eA=
X-Received: by 2002:a2e:300d:: with SMTP id w13mr3789851ljw.245.1590743667722;
 Fri, 29 May 2020 02:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200528103755.17381-1-steves.lee@maximintegrated.com> <20200528141749.GB4186430@bogus>
In-Reply-To: <20200528141749.GB4186430@bogus>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Fri, 29 May 2020 18:14:16 +0900
Message-ID: <CABff4NTc1faPpuunzt6kwOk5YsA0drvkHFvNPhyG6uZZDrqc0w@mail.gmail.com>
Subject: Re: [V6 PATCH 1/2] dt-bindings: Added device tree binding for max98390
To:     Rob Herring <robh@kernel.org>
Cc:     Steve Lee <steves.lee@maximintegrated.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:17 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, May 28, 2020 at 07:37:55PM +0900, Steve Lee wrote:
> > Add DT binding of max98390 amplifier driver.
> >
> > Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> > ---
> > Changed since V5:
> >       * Change txt to yaml and fix up the examples.
> > Changed since V4:
> >       * No changes.
> > Changed since V3:
> >       * No changes.
> > Changed since V2:
> >       * No changes.
> > Changed since V1:
> >       * Modified sample text in example
> >
> >  .../bindings/sound/maxim,max98390.yaml        | 39 +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> > new file mode 100644
> > index 000000000000..1ed4ab9e1c37
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Maxim Integrated MAX98390 Speaker Amplifier with Integrated Dynamic Speaker Management
> > +
> > +maintainers:
> > +  - Steve Lee <steves.lee@maximintegrated.com>
> > +
> > +properties:
> > +  compatible:
> > +      const: maxim,max98390
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: I2C address of the device.
> > +
> > +  temperature_calib:
>
> s/_/-/

 This is follow as coreboot in Chromium OS case.
I'd follow this name unchanged.

>
> And missing 'maxim' prefix.

 Added missed prefix maxim prefix.

>
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12
>
> Any constraints? 0-2^32 are valid values?

 I added range of the values

>
> > +
> > +  r0_calib:
>
> Same here.

I added range of the values.

>
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description: This is r0 calibration data which was measured in factory mode.
> > +
> > +required:
> > +  - compatible
> > +  - reg
>
> Add:
>
> additionalProperties: false

I have added this.

>
> > +
> > +examples:
> > +  - |
> > +    max98390: amplifier@38 {
> > +            compatible = "maxim,max98390";
> > +            reg = <0x38>;
> > +            maxim,temperature_calib = <1024>;
> > +            maxim,r0_calib = <100232>;
> > +    };
> > --
> > 2.17.1
> >
