Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55EAC3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A94B32467B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C2469RYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgB1REi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:04:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46904 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgB1REi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:04:38 -0500
Received: by mail-lf1-f66.google.com with SMTP id v6so2597448lfo.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 09:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ag++hFwSaxms76jjBY38O9GLxRcogtFcUqUmThhruMU=;
        b=C2469RYvzJFrDA9eyS6Q0P+WnOlCNLJOQIRhjG3dqYOVATCbRKm2zPLgh5AWsTm3KP
         lql3XEWQ7rl4DE+Z0YYr0jzNZ/of3pT7dXojWll72VKQqg7D4lHIuH7ualLVo7S+ZAo2
         PJhMph0IOaHKES7g4VbZBWwN2eEMZORVQw8oB1PASS4O/iTzFMuDMq/Nfb0Dpe+4Dhse
         YwIg3puzeX7NJnUVoVmMPAaTlEjcEohuttivdwlOt7h747uouCCKLoxSkfwhffB4NjdH
         Q5ZWrSxh8unJhw4Bvk6bIqHcfnIYVP23drraevUvNvl1HhnX9QCeRtge0Fg1IhSBrDep
         IRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ag++hFwSaxms76jjBY38O9GLxRcogtFcUqUmThhruMU=;
        b=cdoSZEUo/GbekG312vIv+wFG2rG7iKQJKcrDV/c1RYUvR77fbRLJPFj/qs//EMEZTu
         b0ZL+zYNFpjvYOCQ9JwyDXKsmC4icBEjOI35m4II/pP1ALijwu3zGS0GBht5bsBl3Qlo
         WDpMHYSK6svj9Z6KK017R2KfvfDe37IexM9COsH4/Zbe9rEJDHKbzoPbfIzwhiInBHiR
         h6I3edblJnW228Z+nDbfHj0lJxn5rW31mpHOeCkJnsnL4O3x4atRl8nRvk5CrD0ED0b/
         QuB5RADIKeF2F0iCdlp8M0ZpLfTMgtAICQ+He5F+Hzxr+itK8RTs8U4ayDdHTSM9oTlI
         TGBg==
X-Gm-Message-State: ANhLgQ2/XArNjmhAUG37VDRHxprf5S8rh23ohjllTxdNaS3v/Er9h19A
        J4etiuiJO3VF6lmuB8U6gg6Jz9ySNj2red96Ip1y0g==
X-Google-Smtp-Source: ADFU+vs45S3Va+IDiHfrOjaho98KADVTBz0BwybJiGifhTsu5xbRqNCGRyUgeTAyRPCpfyidi58SwUDNEuUSNHOt+P4=
X-Received: by 2002:a19:87:: with SMTP id 129mr3107760lfa.217.1582909476235;
 Fri, 28 Feb 2020 09:04:36 -0800 (PST)
MIME-Version: 1.0
References: <AM6PR10MB22635CBCBF559AEB9A5C2BFF80120@AM6PR10MB2263.EURPRD10.PROD.OUTLOOK.COM>
 <20200226010722.2042-1-shreyas.joshi@biamp.com>
In-Reply-To: <20200226010722.2042-1-shreyas.joshi@biamp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 Feb 2020 18:04:24 +0100
Message-ID: <CACRpkdbP5LqH_DehOfSRoF6_4xuXExB-uhkX-9ALK9yFHjC4NQ@mail.gmail.com>
Subject: Re: [PATCH V6] mfd: da9062: Add support for interrupt polarity
 defined in device tree
To:     Shreyas Joshi <shreyasjoshi15@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shreyas Joshi <shreyas.joshi@biamp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 2:08 AM Shreyas Joshi <shreyasjoshi15@gmail.com> wrote:

> The da9062 interrupt handler cannot necessarily be low active.
> Add a function to configure the interrupt type based on what is defined in the device tree.
> The allowable interrupt type is either low or high level trigger.
>
> Signed-off-by: Shreyas Joshi <shreyas.joshi@biamp.com>
> ---
>
> V6:
>   Changed regmap_reg_range to exclude DA9062AA_CONFIG_B for writeable
>   Added regmap_reg_range DA9062AA_CONFIG_A for readable

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
