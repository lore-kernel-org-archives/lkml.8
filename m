Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB037C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C23206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582299614;
	bh=+DoRoBMJXa06a9s5rF/Tg0R2Bb7OUU1w4NYR6LGt5us=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NiR62UiAbvaGRpJ7Tm2b6KpEdlkPTt5YP7PmvsUKClgf05G18UAHxS2NayTiEdh/c
	 OnqcUUnEfprG1o9ePfLL+NHDjmU2qpXAIOJ7VFpS8I3sj8ajiv1aSBKMDhPETb0dj9
	 C3ZSBKjKvjrN9hz0paqQAD6LeGGZF2JiIi48Y4cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgBUPkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:40:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728815AbgBUPkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:40:12 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3325F208E4;
        Fri, 21 Feb 2020 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582299612;
        bh=+DoRoBMJXa06a9s5rF/Tg0R2Bb7OUU1w4NYR6LGt5us=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C50UxxIIkUBAA2owQJBxXLzj5mfErfF8Pc2OBetl4t/cV2KyEMFMjn8eC4BwC7mmB
         kCwDosbSs53gE4Sdr5Fg43Ax+XA9Ho+WY/6Ra20KzNoV0s1vrbxL2eSWxW29kf/Mqk
         pkg+U+QsIhllO3E7zJbObensr46EDR31k4fiVQ/w=
Received: by mail-qk1-f176.google.com with SMTP id u124so2142822qkh.13;
        Fri, 21 Feb 2020 07:40:12 -0800 (PST)
X-Gm-Message-State: APjAAAVWTnkvg0TT+tYQ0dwv4VG90sEhb2AlHYq/UYKheOekFsdrUtva
        UyaKIOjoiDlVrAqb3AWsHyj9DjU4LPJxqKXl/g==
X-Google-Smtp-Source: APXvYqy0D6b0D+YPb02EPEVdZaz7+H9RHdQphCR7I5xx5+N9sBx4J8AdIN+Hdpb187sXHw7HfZ4TtvWRgV6uosWTKgo=
X-Received: by 2002:a05:620a:1237:: with SMTP id v23mr17847336qkj.223.1582299611320;
 Fri, 21 Feb 2020 07:40:11 -0800 (PST)
MIME-Version: 1.0
References: <20200221041631.10960-1-chris.packham@alliedtelesis.co.nz> <20200221041631.10960-4-chris.packham@alliedtelesis.co.nz>
In-Reply-To: <20200221041631.10960-4-chris.packham@alliedtelesis.co.nz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Feb 2020 09:40:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+jKyRr98_YX1GGwk-rHrLMOq_v7Z_57dQWYYQPuLS7A@mail.gmail.com>
Message-ID: <CAL_JsqK+jKyRr98_YX1GGwk-rHrLMOq_v7Z_57dQWYYQPuLS7A@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] dt-bindings: hwmon: Document adt7475 invert-pwm property
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
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

On Thu, Feb 20, 2020 at 10:16 PM Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
>
> Add binding information for the invert-pwm property.
>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     Changes in v4:
>     - use $ref uint32 and enum
>     - add adi vendor prefix
>
>     Cahnges in v3:
>     - new
>
>  Documentation/devicetree/bindings/hwmon/adt7475.yaml | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> index e40612ee075f..6a358b30586c 100644
> --- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
> @@ -50,6 +50,17 @@ patternProperties:
>       - $ref: /schemas/types.yaml#/definitions/uint32
>       - enum: [0, 1]
>
> +  "^adi,invert-pwm[1-3]$":
> +    description: |
> +      Configures the pwm output to use inverted logic. If set to 1
> +      the pwm uses a logic low output for 100% duty cycle. If set
> +      to 0 the pwm uses a logic high output for 100% duty cycle.
> +      If the property is absent the pwm retains it's configuration
> +      from the bios/bootloader.

I believe we already have an inverted flag for consumers. That doesn't
work if you don't have a consumer described in DT, but then the
question is should you? Or is this something the user will want to
configure from userspace.

The problem with 'invert' properties is they assume you know what the
not inverted state is. I would also make this an array:

adi,pwm-active-state = <1 0 0 1>; // PWM1 and PWM2 active low

And not present means <1 1 1 1>.

Rob
