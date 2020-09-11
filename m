Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5DFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC2521D40
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 08:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYQMaZJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgIKITu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 04:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgIKITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 04:19:47 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA56C061573
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:19:47 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id p15so4260369qvk.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 01:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LyN0IjmsHwavnL72AyGhxA2PceM0193RLDzNcCwxkJw=;
        b=fYQMaZJN1SXjCj1hdOHLPagG/CreN9QGAkYOR+hfQDg6i9OhyTAWOkscNnnVOhTjrL
         TLqcdwU0JQa6sg0ka1Dt/X8vF86qF6/aaf30dU3YLpbX7C5DT0i1MOgwqUMhAGBXYhHS
         R8fApsrN7FdU6FVy66n/Bcqabpyc6M4i0as4+mM2L7NP/zr6bQqnGWiBdDa6dg/OTom/
         Lv/pD/efWe5L54+mSGhYmm8ydWDitlTtTWqCeVLgi2YKqdLHEHBO7XAIvkSJVL/lB47a
         EjOsG+tyfcVyHW9yLOpPwkU4zAgDYp8UAcrf2U87yTjoLoho9RMXjP5Ow3DZw49nZgP9
         TptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LyN0IjmsHwavnL72AyGhxA2PceM0193RLDzNcCwxkJw=;
        b=XPOGaZXZ45oerHWEzYSWwccj2q6TOJaatBiTjJop9tqtt7JOIAQ0dli4FDJl1ogTrr
         pWbiuZYdj7TmOm6oiLZB/ADwa6KRgr9sHv4xHkvfyX2wlPgbVLxIrmEEQ0LPbfhnbQZQ
         6v5EV+AVGe6YRhnsNjVkDHxjQgqnEpmfpXCd8AHW+dRU8NvFJVdgv3chsjW/fLO+Xwbu
         XvZUQA7uktr34ALUbijhCauaBTOqv5W2rWO6OYiskKjxdZq+BO+rTIShss9AktWk1q7O
         peNf/jMK/MGS95+XCRupv8gJSXzqMeZdPRQlOjgDhXYyTnw/ye0bhTovHhHeHvPk5NDL
         jCew==
X-Gm-Message-State: AOAM533b7O8AXzNoMTTzpXpOHxFketEq12l8qoqGPiOljZBkGcgT8eb1
        H+Wr5+/41mETwLtS6t71CIvigvxtKDQZdZunt/8=
X-Google-Smtp-Source: ABdhPJyw1iphmZfPMSSJgI+rjWnh80T1rlqRDKzKA880DDYs84dQJcIkakAuHD7UmnAAzMXhKQsnB6YceJDThmis2qA=
X-Received: by 2002:a0c:8485:: with SMTP id m5mr875942qva.22.1599812387007;
 Fri, 11 Sep 2020 01:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <1599747032-20055-1-git-send-email-shengjiu.wang@nxp.com> <20200910142121.GC4898@sirena.org.uk>
In-Reply-To: <20200910142121.GC4898@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 11 Sep 2020 16:19:36 +0800
Message-ID: <CAA+D8AOo7rV0omvZdXNRK15ZdK+H-oU8SVxinZTGPusAzfv-Kw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: ak4458: Add DSD support for ak4458 and ak4497
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:23 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Sep 10, 2020 at 10:10:32PM +0800, Shengjiu Wang wrote:
>
> > ak4458 can't support DSD512 format, but ak4497 can, so add
> > a new variable in ak4458_drvdata to distinguish these two
> > platform.
>
> > In hw_params(), calculate bit clock according to different DSD
> > format and configure DSD register.
>
> > +     SOC_ENUM("AK4497 DSD Data Input Pin", ak4497_dsdp_enum),
>
> This control name doesn't seem to match up with the description - it's
> talking about a pin but the description sounds like setting a different
> format for the data?

I will add more description. Thanks.

best regards
wang shengjiu
