Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE56C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D70B206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARuHTCHv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgE2IGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2IGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:06:38 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070DBC03E969;
        Fri, 29 May 2020 01:06:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x22so767085lfd.4;
        Fri, 29 May 2020 01:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sOxRbojjekNIVLIANuIbdPZ8vuRLDilJnBU5D6z6Gc0=;
        b=ARuHTCHvzl5pI1r2ksiKnlv/XQf2ZuP2puBHRogWZpZ+JSDk6spsZ6+Mi0HStWbjXp
         RwKrapD/bAonIza1jawgeaHmEp75nantmy/WX1mK7jeJZz6C56ATAKBtO11qN7BECv7Z
         D0rYzXDzvdn8VtHfMOuCM8Wyun1eLSue6t6iIBOvoh6D+6PifhHsutIgZ9GyWHfHcZL/
         ZsM9igl7Uohtzye+ZVK+DQr9vz/lSscpBm3Q+fPjhFde3yFgzTtQLjWyEn0ZQr/E/Dt+
         5QRGtr2efv0o59DkZlGinPFhE2tiD4eTO6cAOT07rMGXA8a+2uMjgRXCX2Aeyfmg3j8G
         2DPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sOxRbojjekNIVLIANuIbdPZ8vuRLDilJnBU5D6z6Gc0=;
        b=B0O2PVbTeGQPJ3UoWt0Xte39ORntG0KIIHF2V/CPjBM59SjtpSxa3JV/rqsfjxWoRc
         gukzbqilKMguPgwlSIjfyifEkyEbo2BY+LiUM7DlVgGwbbc9pn/B4tArywucfdmBXgBY
         iyIcB6bAZbS2XAp/ldoLWMdq68geabr1gn8530uI2JzoTnLTPSYuNpgdneS4WcuTyhz+
         uJJxyNAago33f6QZhYX4ga2gDQF1ddW4hM9dp6STlzkp9w+iIyfi98Kfu5RJ/41aCQ9Z
         U4pocUdrgba9FKN7KZYIEOPwjupWTTxxaYvtgbytx0bzK/HFZGohI+kyLRIRButGV6mv
         h+IQ==
X-Gm-Message-State: AOAM530jD27upxLlSdep/oO/2uJ8Erq3V5EoCr6T9zzD4lb2jfhDGReb
        AHISzY8NBw3V5IY1uC3lVzXrMO5ExD848NZS9PE=
X-Google-Smtp-Source: ABdhPJwNGmSiyiqlfKOfqM6p+BHUruML1hsN7pjim5eRRpQvgIZUZhgXAjo9nWuTkMHvfN6OZzHb0HtACLwONLoR4Lg=
X-Received: by 2002:a19:6a09:: with SMTP id u9mr3726110lfu.65.1590739596512;
 Fri, 29 May 2020 01:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200528103755.17381-1-steves.lee@maximintegrated.com> <20200528141542.GA4186430@bogus>
In-Reply-To: <20200528141542.GA4186430@bogus>
From:   Steve Lee <steves.lee.maxim@gmail.com>
Date:   Fri, 29 May 2020 17:06:24 +0900
Message-ID: <CABff4NRCfxo7MFvk72bOjPN5iJg5HaQk_U1nFpdPrJZ9nm5Jhw@mail.gmail.com>
Subject: Re: [V6 PATCH 1/2] dt-bindings: Added device tree binding for max98390
To:     Rob Herring <robh@kernel.org>
Cc:     Steve Lee <steves.lee@maximintegrated.com>, robh+dt@kernel.org,
        ryans.lee@maximintegrated.com, Mark Brown <broonie@kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        ryan.lee.maxim@gmail.com, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 11:15 PM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, 28 May 2020 19:37:55 +0900, Steve Lee wrote:
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
>
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/sound/maxim,max98390.yaml:  mapping values are not allowed in this context
>   in "<unicode string>", line 22, column 97
> Documentation/devicetree/bindings/Makefile:12: recipe for target 'Documentation/devicetree/bindings/sound/maxim,max98390.example.dts' failed
> make[1]: *** [Documentation/devicetree/bindings/sound/maxim,max98390.example.dts] Error 1
> make[1]: *** Waiting for unfinished jobs....
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/maxim,max98390.yaml: ignoring, error parsing file
> warning: no schema found in file: ./Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/maxim,max98390.yaml: ignoring, error parsing file
> warning: no schema found in file: ./Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> Makefile:1300: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1299651
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
>
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
>
> Please check and re-submit.
>
 Thanks for feedback. I re-submit with after dt binding check again.
