Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4B55206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ItMGHHfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgFVKjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgFVKjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:39:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C59C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:39:43 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g18so7072015wrm.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ppPSmD0W4LKyxlniJhYfTmLmk2R68Qbvb6wTB52e/f0=;
        b=ItMGHHfBn6t+/6rQdOvInje8umTE9Lh/8MQrHN1kBQmODoVSN1eOFW8HFLDcqWjRfz
         iW7RlpQQYT2m0DQT2L8tJ3Gbnm4FrrA0hZNu5go4Lzxd+kPhaBqaTFY0IdbGKfCHN12r
         YP6adtx7pTBj07Wd8/4VSZJYaO0d+iQIEliTdTqNbuLF6u1CILqsrtIFVQrBPp+mQWnZ
         77UOT6MgZnEhhklMWr44xbkquBvDL8ge3ILunTUUmfMpAACxHi/NSbC/poDK3u/A/9pa
         Bre5+xqACXaastiIzh4nSPQCMcFTumjfW7jnpw3XlMI2+YyVlzQ0krOo7HPcjQQ3bIh9
         S48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ppPSmD0W4LKyxlniJhYfTmLmk2R68Qbvb6wTB52e/f0=;
        b=J5rtddrm62P0FJCARGXAivBI0hIqL6S/AasYIX1gdNCWgnCUL5UiVgdg8IhdV+FPX+
         cZaONmz9Mf9HhwM/ZbKR6W5CNKo4hZD8nm02Rq/hNWpcZ5GzAOfy4Yf1TZQ/gDaktZ0m
         YgLJXgmn+/8zUctZN/hTdS947Z03AdwzrwRPTKSKt8gfR7DqrqTHUhOdx1guOa3XEeYr
         nDZTjb8lsKS6Z45XoF65yMzgJOl/kZkfQ9mkprY78TM7Vt7okWLe5/7qhlaX3PYRNjM7
         XjsxDRCXTodpuD0FdqfCuHtNH9vJzHgG5CpeLnxE/W+X5bPnj0AZ6MqqVeE9pkstd/Dz
         czng==
X-Gm-Message-State: AOAM530Wnhm2teM0/r4vXBSij0Dgqy7yGu9RMy77H+Cv9GJsYcOWOq29
        RNgiUd86Xmf3nLMxqjF5z0KSTg==
X-Google-Smtp-Source: ABdhPJzfjcLOl+6WBhcjg432De4rDwDj114xV3ZgmqkPIv2TBXFQeD+Fz+W7XZC3xVDWGcr5fxtuTQ==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr6752284wrp.315.1592822382351;
        Mon, 22 Jun 2020 03:39:42 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id e12sm17422241wro.52.2020.06.22.03.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:39:41 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:39:39 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: backlight: Convert common backlight
 bindings to DT schema
Message-ID: <20200622103939.goqysclrsxps344i@holly.lan>
References: <20200618224413.1115849-1-robh@kernel.org>
 <20200619215341.GA6857@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619215341.GA6857@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:53:41PM +0200, Sam Ravnborg wrote:
> Good to have these converted. A few comments in the following. One
> comment is for the backlight people as you copied the original text.

... and I've sliced out everything except that in this reply.

> On Thu, Jun 18, 2020 at 04:44:13PM -0600, Rob Herring wrote:
> > diff --git a/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
> > new file mode 100644
> > index 000000000000..ae50945d2798
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/leds/backlight/led-backlight.yaml
> > @@ -0,0 +1,58 @@
> > ...
> > +
> > +  default-brightness-level:
> > +    description: The default brightness level (index into the array defined
> > +      by the "brightness-levels" property).
>
> This description does not match my understading.
> The description says "index into", but in reality this is a value that
> matches somewhere in the range specified by brightness-levels.
> So it is not an index.
> 
> Maybe I just read it wrong and the description is fine. But when I read
> index the when it says 6 I would look for brightness-levels[6] equals
> 128 in the example below.

When the brightness-levels array is not present then backlight
brightness and led brightness have a 1:1 mapping. In this case the
meaning of "default brightness level" is (hopefully) obvious and the
parenthetic text does not apply.

When the array is present then we have two different scales of
brightness and it is important to describe which scale we use for the
default brightness. The language about "index into" was adopted to avoid
having to introduce extra terminology whilst making it clear that
setting the default brightness-level to 128 is invalid (because it is
not an acceptable index) and that a value of 6 will result in the LED
brightness being set to 128.


> And this is not how it is coded.

That had me worried for a moment but I think the code and bindings are
in agreement.

There is some code to map the LED scale (128) to the backlight scale (6)
but this used to ensure we supply the correct brightness level to user
space when an active backlight is handed over from bootloader to kernel.

If a default-brightness-level is provided then the above logic is
overridden and the value read from the DT gets placed directly into
props.brightness where it will act as in index into the brightness
table.


Daniel.
