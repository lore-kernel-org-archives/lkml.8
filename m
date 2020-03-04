Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9331DC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A65220705
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLjKlhhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387844AbgCDLJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:09:37 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:42801 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgCDLJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:09:37 -0500
Received: by mail-vk1-f193.google.com with SMTP id c126so420833vkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LGgNDzFM9+pZsPJxkq/f++BDXhgoGaKxsldF5IOKGLc=;
        b=vLjKlhhpEkXgDWiBCB0FFmFfnnl1pxnbZgdk62RSVMxiIQuRYNZK+C9swyOu+/aGCt
         6J+O89yf6K1OFpovk86IvKwB/53g0gnXkUK+Y1u9pibpgHjGGvzLsRivdzC9XmTsR+10
         AOR6TBHLTi1+4P2Xhm7FyGE2CQl+Y2dgXtpdphEkARt/IP2lt1mDKxvt2AOtB3Ch/ly3
         ITa8EY40ug/GGqrm1zqfxnjge3zBfyDklTb2shBFaPuqQ+Ol8QpPTYJshUSEr9fAiCQW
         IzGoJk71K3Mj+l14lENhmRTDlGW/ih/meG/EH44oSrYixv7JIIdwZgMjweQp0ZE78tqW
         KLlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGgNDzFM9+pZsPJxkq/f++BDXhgoGaKxsldF5IOKGLc=;
        b=lfUm6B8U6zK8eIAfew1RSOsPQdYFr9s3CMdE2HvVhXUW1NTs2FiMZ8N3BMX6CKGt02
         2wv0EECthkXFdttj+L0pBMh+AGwbLePeq6m+Z5xzSIrP+9pLxBY41+8wmYT1IN2E2pLU
         mh1iUuVFQClrDGtK063KoQEzbpQdYYMDf7d/pcxvkbkcz0UfoVN+iXtzBFmbkkZqeLqR
         qHJsvs2N72BtT/yOvpvGEwMLqb+TDNvZjcohbXWAkfJYTSVQsDdQky0MY9e5JIwi9Wcc
         umQcuO7D/xhRTZyds3VWJpNuSTiTplqF/Y5tr5B3RXNSazAqf3HvmRIP9cvLImVWdbhP
         89TQ==
X-Gm-Message-State: ANhLgQ0MItwRgj/Kb6RpvaflrMZ50bjopirhT7Hvq3WMAI9E0AY4qSmM
        FjWlXHT5vEU3NVsk9D6fW4ZWUlJhowDj4CexggyeSg==
X-Google-Smtp-Source: ADFU+vuZEa5rIaEwbGyzEV1W96822bRQFwK+BMvjTk+I/++e8CQ7jw9sUjRFKFVta8ECOqPDHKZ4l3a88vnAB0qpTOA=
X-Received: by 2002:ac5:c4fc:: with SMTP id b28mr1021594vkl.101.1583320175432;
 Wed, 04 Mar 2020 03:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20200212024220.GA32111@seokyung-mobl1>
In-Reply-To: <20200212024220.GA32111@seokyung-mobl1>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 12:08:59 +0100
Message-ID: <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
To:     Kyungmin Seo <kyungmin.seo@intel.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2020 at 03:40, Kyungmin Seo <kyungmin.seo@intel.com> wrote:
>
> The clock has to be changed after sending CMD6 for HS mode selection in
> mmc_hs400_to_hs200() function.
>
> The JEDEC 5.0 and 5.1 said that "High-speed" mode selection has to
> enable the the high speed mode timing in the Device, before chaning the
> clock frequency to a frequency between 26MHz and 52MHz.

I think that is based upon the assumption that you are using a lower
frequency to start with.

For example, assume that you are running with 400KHz during card
initialization, then you want to send the CMD6 to switch to HS mode
and that should be done, before updating the clock rate.

mmc_hs400_to_hs200() goes the opposite direction, so I think the
current code looks correct to me.

Kind regards
Uffe

>
> Signed-off-by: Kyungmin Seo <kyungmin.seo@intel.com>
> ---
>  drivers/mmc/core/mmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3486bc7fbb64..98640b51c73e 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1196,10 +1196,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>         int err;
>         u8 val;
>
> -       /* Reduce frequency to HS */
> -       max_dtr = card->ext_csd.hs_max_dtr;
> -       mmc_set_clock(host, max_dtr);
> -
>         /* Switch HS400 to HS DDR */
>         val = EXT_CSD_TIMING_HS;
>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL, EXT_CSD_HS_TIMING,
> @@ -1210,6 +1206,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>
>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>
> +       /* Reduce frequency to HS */
> +       max_dtr = card->ext_csd.hs_max_dtr;
> +       mmc_set_clock(host, max_dtr);
> +
>         err = mmc_switch_status(card);
>         if (err)
>                 goto out_err;
> --
> 2.17.1
>
