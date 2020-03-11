Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B92C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C2D920873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="pNxDDKgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgCKI6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:58:07 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:36720 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKI6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:58:07 -0400
Received: by mail-vs1-f65.google.com with SMTP id n6so813797vsc.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gU9ErITT1QpCPjL82L11n7TGUqA4ycf13KZv8wmMFUs=;
        b=pNxDDKgBb9qmnTlpnjI08oEZvwCsHtVy6nFYbnGtUf+nLRY4z2KyI2VjERT72GdI4I
         L6GI7YXSQtT07fB1OTdwOQkEsLsIKvspk1bw6zURmukghssL6foEBt9BcxyxyJLv6grl
         2vTouZHCkvqXfKWmArJ9BrKfqY4305jpiWQ1UZ4D0DXxiOUadjY9LdsJ2GdphQCBxe56
         Q9bhQsWAqXRvI9zgYkfoiAfB2FyMjm7XytZrRwo/1x1SM3Lnf7f22Kmj7qhIPMaHBtfH
         /oqIs74MNOc9RVbolhE6iLDaZqUu/N59WvyEbsnhxRryrgsLvg+Pjmv/s/q6gWI09ut5
         i//Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gU9ErITT1QpCPjL82L11n7TGUqA4ycf13KZv8wmMFUs=;
        b=QQZA6+FqHh34ILcgPg8spJomeqRnl98Drxnt00weHWiolaTiaQkOs3+m0Jdg/vmkag
         8m3uetnyddgjHqKE3B29oQ4T0DoPJ/4DPrzhxUX6lRx7rbXoWzGsnFC0CRulndz75KkQ
         IbQ4OqiJDyUonLHC2YH7jLFdLqbdjBFrdmqFgv3448sH89euvR/0iDGXhBeWfQCGqinT
         V6igRlbVGw8BKi85My/5NC8ocZ2wvHGUHslCttsetHQIyLAhaLJohHva9V0Q/UjL1O+C
         Bg2CDj863CJ+CGcKYk1sQ/Zf19+dAJUwxjMWBuRpVli6IcNsECQjWCUm/wqRxrZXk2J0
         bk3Q==
X-Gm-Message-State: ANhLgQ22qGwVf0CbR6UkqQK+g8DjRnAJvfUaFPub9rTFTenqF0lTaa/F
        /Fxr69b9itaC7P8hstLMVyWupnUdW7tB5bOpGRVvfA==
X-Google-Smtp-Source: ADFU+vtOR68AAuws2jiKlsA3945WHYipYLNHGQ2Ef2RWnrCXylZalAG4BHR0y5+N6tGeQ66q3W76CQ/Cw+FS06wgxlw=
X-Received: by 2002:a67:870f:: with SMTP id j15mr1212241vsd.95.1583917085791;
 Wed, 11 Mar 2020 01:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <1583903252-2058-1-git-send-email-Anson.Huang@nxp.com> <1583903252-2058-2-git-send-email-Anson.Huang@nxp.com>
In-Reply-To: <1583903252-2058-2-git-send-email-Anson.Huang@nxp.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Wed, 11 Mar 2020 14:27:54 +0530
Message-ID: <CAHLCerOLaXqejgAZYB1_QZ5WiUK4p+nsmhfVQqgKDW--DSC0bA@mail.gmail.com>
Subject: Re: [PATCH 2/2] thermal: qoriq: Sort includes alphabetically
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Linux-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:44 AM Anson Huang <Anson.Huang@nxp.com> wrote:
>
> Sort includes alphabetically for consistency, and take this chance
> to remove unused include of of_address.h.


Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  drivers/thermal/qoriq_thermal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 67a8d84..028a6bb 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -3,12 +3,11 @@
>  // Copyright 2016 Freescale Semiconductor, Inc.
>
>  #include <linux/clk.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/err.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_address.h>
> +#include <linux/platform_device.h>
>  #include <linux/regmap.h>
>  #include <linux/sizes.h>
>  #include <linux/thermal.h>
> --
> 2.7.4
>
