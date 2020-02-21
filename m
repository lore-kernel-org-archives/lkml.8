Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1684C35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75192072C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582322700;
	bh=ixkaQsOyXc65L7U5cAzBy/t7QDxhcFt3SZW7c7F25dw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mgxh3oW9hzURE0yB+Z1X7Z+/dzzwsIBTxcUuKWLmi9Q2YQXMiEwP6Z9FuMG9jbzQc
	 6UsXryd1A28xciXWyXJcG6rlFc9g+dXRDl0syKNlwMC3SuON/7L/qZPActrNkzSkSl
	 h9+bCMRNnM/MVmWytgjIu4JbseUmidhJHdXbaJCQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBUWE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 17:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:49572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgBUWE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 17:04:59 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58CD72072C;
        Fri, 21 Feb 2020 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582322698;
        bh=ixkaQsOyXc65L7U5cAzBy/t7QDxhcFt3SZW7c7F25dw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hE+MPvG/9HlApVb7a1C28KlYECMfNuRDiN5O/RjQeGCMCTPwZif/S/YvJ3If4HBTr
         Zcf5e4RSkOSoTbbHRzOeqS1MPWOHar1v8y4TTptGKAnNkZlw4pcEM412p0OvN5oN2S
         N6+5cm3k6Gaukxa1iLXjUVY1CJuM9VvipF3t7LrA=
Received: by mail-qt1-f181.google.com with SMTP id n17so2428773qtv.2;
        Fri, 21 Feb 2020 14:04:58 -0800 (PST)
X-Gm-Message-State: APjAAAX5ccd/wo+Yi5RqNKmlZzcMfwAwJfJdzxQBsrVW/Yt432JeySLU
        q5OnmIU6fMdpNPPyoR4nERzfkFpV0GbVVluKLA==
X-Google-Smtp-Source: APXvYqzIdyYmWrgE2znfgfwuWRqr27wwCfU9j74qwfxNfJB8wFPqCO8UUY9xs6KKGgpRQQM31GBK5HGN7l7/vsKP0xo=
X-Received: by 2002:aed:2344:: with SMTP id i4mr34521971qtc.136.1582322697489;
 Fri, 21 Feb 2020 14:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
 <20200221041631.10960-4-chris.packham@alliedtelesis.co.nz>
 <CAL_JsqK+jKyRr98_YX1GGwk-rHrLMOq_v7Z_57dQWYYQPuLS7A@mail.gmail.com> <20200221155259.GA11868@roeck-us.net>
In-Reply-To: <20200221155259.GA11868@roeck-us.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Feb 2020 16:04:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK5MqD9vqS0A1oTDkMvVkBFM83_fLAp7M7zR5uEv+NEJw@mail.gmail.com>
Message-ID: <CAL_JsqK5MqD9vqS0A1oTDkMvVkBFM83_fLAp7M7zR5uEv+NEJw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: hwmon: Document adt7475 invert-pwm property
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 9:53 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Feb 21, 2020 at 09:40:00AM -0600, Rob Herring wrote:
> > On Thu, Feb 20, 2020 at 10:16 PM Chris Packham
> > <chris.packham@alliedtelesis.co.nz> wrote:
> > >
> > > Add binding information for the invert-pwm property.
> > >
> > > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > > ---
> > >
> > > Notes:
> > >     Changes in v4:
> > >     - use $ref uint32 and enum
> > >     - add adi vendor prefix
> > >
> > >     Cahnges in v3:
> > >     - new
> > >
> > >  Documentation/devicetree/bindings/hwmon/adt7475.yaml | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > > index e40612ee075f..6a358b30586c 100644
> > > --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > > +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > > @@ -50,6 +50,17 @@ patternProperties:
> > >       - $ref: /schemas/types.yaml#/definitions/uint32
> > >       - enum: [0, 1]
> > >
> > > +  "^adi,invert-pwm[1-3]$":
> > > +    description: |
> > > +      Configures the pwm output to use inverted logic. If set to 1
> > > +      the pwm uses a logic low output for 100% duty cycle. If set
> > > +      to 0 the pwm uses a logic high output for 100% duty cycle.
> > > +      If the property is absent the pwm retains it's configuration
> > > +      from the bios/bootloader.
> >
> > I believe we already have an inverted flag for consumers. That doesn't
> > work if you don't have a consumer described in DT, but then the
> > question is should you? Or is this something the user will want to
> > configure from userspace.
> >
>
> Normally that is a system property. It is difficult to imagine
> that it would ever have to be configured from userspace at runtime.
> Most of the time users won't have any idea, and the board datasheet
> (if avaible) won't list such information.

Yes, I agree and for those cases I'd expect the consumer is described
in DT too. I read and refreshed my memory on this binding after
sending this. I believe this is for a fan which I'd expect to be in DT
as fans need power and there's different types.

The userspace case I was thinking of was more the hobbyist boards with
PWM to a connector.

Rob
