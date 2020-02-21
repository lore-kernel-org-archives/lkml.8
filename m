Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CCFDC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61186206EF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:53:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAgWsNHl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbgBUPxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:53:03 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43022 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgBUPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:53:02 -0500
Received: by mail-pf1-f195.google.com with SMTP id s1so1408115pfh.10;
        Fri, 21 Feb 2020 07:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zyHw2W64cvX+gZNU0JO3HXnkgRvbxlvM1SKeLni6cTs=;
        b=cAgWsNHlhVZ52YNV+lMk+yxfR687FANqWvqcxuH/LRjVmW9r1Sy0COlP6gGenMgDmi
         oEv7UuSD0ed9WS2Cn7TU08wDNXqCcLPIxiEMwxt6jEMAFbgG2Az2QkNdU1aXk6wK9kJz
         VdsSwQnhy/y1CW1XBiKHApv4elCuLhr/za0lVjfKKfPG0VYOLX0oc8zK8pD30rZd4s2v
         BZ7P2iSOdXlXkqQP/0BY6kiPtQ7og2KpyJI/1eZUe6rz3aNK9MUlvogfa8+Fla1xR/KJ
         zlUqM8QMnUdkWXZnBMiQDFba8aKyeQSgpVVSZFGzzgFAFBUkx2EIjyelKPThkWk64TlH
         TsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zyHw2W64cvX+gZNU0JO3HXnkgRvbxlvM1SKeLni6cTs=;
        b=dpAK5aL7/t74ABtpRXan1Fgj4oSm7gVHI0239ajSgkncNjJh5xtT/KmE+d/wRLgHsA
         SV/GXxNuAfvf5elZzFA0th1TuRimEOQYtFYX+s0Nw3Gypm4FfatcKrv23hYsfG5XrHCJ
         1v98fIEujBGC8aW3L5bN3ubs2+6yOukRNVxVNWotduEup7aLdijUk2wFVVcQFBFhhpvi
         STUiEhGmWxL2fJYedRbltRJV8EmAq4XUqL2B7C8Mer8+Qq2o1IHyCpQHifeL3TVPHfXO
         7mMhKDZzTajEOm0MtK/5C8c7+o6uYkoKnpnahs8x3PejLvqabBAIr0pISoEshTYheIeF
         vqVw==
X-Gm-Message-State: APjAAAVciOyH2s2FGf2NqEJhmmDJvfEk9IIR7pBqDb24JBZXjzeLhJCZ
        RA4SsrZ9SL650Y/flEOiSDY=
X-Google-Smtp-Source: APXvYqw9chVujo9ni4QiEPGQ/fIVhBDYRty7frDynHbyaIrLdduSbIykbWqS0B3D4FnvEwa0WILBCQ==
X-Received: by 2002:a63:1a50:: with SMTP id a16mr38186561pgm.389.1582300382031;
        Fri, 21 Feb 2020 07:53:02 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3sm3034130pjg.27.2020.02.21.07.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:53:01 -0800 (PST)
Date:   Fri, 21 Feb 2020 07:52:59 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Logan Shaw <logan.shaw@alliedtelesis.co.nz>
Subject: Re: [PATCH v4 3/5] dt-bindings: hwmon: Document adt7475 invert-pwm
 property
Message-ID: <20200221155259.GA11868@roeck-us.net>
References: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz>
 <20200221041631.10960-4-chris.packham@alliedtelesis.co.nz>
 <CAL_JsqK+jKyRr98_YX1GGwk-rHrLMOq_v7Z_57dQWYYQPuLS7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqK+jKyRr98_YX1GGwk-rHrLMOq_v7Z_57dQWYYQPuLS7A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:40:00AM -0600, Rob Herring wrote:
> On Thu, Feb 20, 2020 at 10:16 PM Chris Packham
> <chris.packham@alliedtelesis.co.nz> wrote:
> >
> > Add binding information for the invert-pwm property.
> >
> > Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> > ---
> >
> > Notes:
> >     Changes in v4:
> >     - use $ref uint32 and enum
> >     - add adi vendor prefix
> >
> >     Cahnges in v3:
> >     - new
> >
> >  Documentation/devicetree/bindings/hwmon/adt7475.yaml | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > index e40612ee075f..6a358b30586c 100644
> > --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> > @@ -50,6 +50,17 @@ patternProperties:
> >       - $ref: /schemas/types.yaml#/definitions/uint32
> >       - enum: [0, 1]
> >
> > +  "^adi,invert-pwm[1-3]$":
> > +    description: |
> > +      Configures the pwm output to use inverted logic. If set to 1
> > +      the pwm uses a logic low output for 100% duty cycle. If set
> > +      to 0 the pwm uses a logic high output for 100% duty cycle.
> > +      If the property is absent the pwm retains it's configuration
> > +      from the bios/bootloader.
> 
> I believe we already have an inverted flag for consumers. That doesn't
> work if you don't have a consumer described in DT, but then the
> question is should you? Or is this something the user will want to
> configure from userspace.
> 

Normally that is a system property. It is difficult to imagine
that it would ever have to be configured from userspace at runtime.
Most of the time users won't have any idea, and the board datasheet
(if avaible) won't list such information.

Guenter
