Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44832C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E68C2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGfFL6Gm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgGXNWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgGXNWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:22:21 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02813C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:22:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b30so5166052lfj.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRL0UF3/43vslaJwWgTDYbt4jG2vWByUDB6sLPDuLgg=;
        b=zGfFL6GmKfCKONek4mgXwt+6vzxav2G7E3CLcuQNhfLYOlekFkhc+89MaxLAL7qw3X
         HCOc3/HQHMtRl9xxbUrickjMs0ht8tRG431uD01gRfGYYmKa5xK7K9tG2cuhV8230kf6
         TZPGub5Z/Qm6994apf7zqFR5JT7k/mmb/zuPV3EVQG2Cjy5atgiwXwuMtAegmdOyQ4Dl
         Muy2DFwUjK8YWKAamgBp0DieYGDljuUJI9aCweRWFLKxqXIGj5zpY6kP654hi8CLwwJ2
         kKC1ILn6FXoT+jAdBs7Q/zKSSYq0APnEvjaE2CW1f6xuz08/uOFTak44QG3iKkhJVvz/
         izQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRL0UF3/43vslaJwWgTDYbt4jG2vWByUDB6sLPDuLgg=;
        b=IAnT9YHkWUDEeN4h1Scw2uZ99niCmMyQx6OaVpRz6lvwANucdnvuoo2puwGFQRpyLC
         UCe/jZxDNjcmtlfMTTyjY5ysHeedRZO56qMqD1+HlChbUNEm2zOhNNF80xwRl08aUWSq
         Ch/r3fKMduZPR5IozCq9exatclEZMX6Rp+3eDR7YgeL8p0Vil+ShHKT10iuw+dmxJg7C
         d3yQGTzEtDlwokKUAj2yf0JhyLHoaEe5RZx+AaGkK5u/1nFTBTDIfUaordU5HGAr+wbV
         kXINa+mPMOfukh41sw2UTbOszABi31HFxDUdfjrl4oDcckI7olKCT5mrDsudBF4K7AxR
         Jpow==
X-Gm-Message-State: AOAM531kLYXBAH8dzIj+2Ai6QCYbUB10by/BrGzBMnfSXuXSaBYI3S6Q
        sjNQ2dTRXnigC2fxS9tXowf1O+cN8NJJ9DvqJTepxQNgq0g=
X-Google-Smtp-Source: ABdhPJzdYPF+cX3QXpVzwFZNMylvbWd3csH+Sajhbs6Ro6UfJ5+mgfxTXCDTtwTUBJA9hyU4+UKjUxUTeY3InVk+/Ho=
X-Received: by 2002:a19:86c3:: with SMTP id i186mr1625844lfd.59.1595596938380;
 Fri, 24 Jul 2020 06:22:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200723084622.31134-1-jorge@foundries.io> <20200723084622.31134-2-jorge@foundries.io>
In-Reply-To: <20200723084622.31134-2-jorge@foundries.io>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 24 Jul 2020 18:52:07 +0530
Message-ID: <CAFA6WYPQ3GGYostoHU=6qg4c_LqoqOZVbZ8gbQbGkNfyGydQjQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] hwrng: optee: fix wait use case
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, ricardo@foundries.io,
        Michael Scott <mike@foundries.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        op-tee@lists.trustedfirmware.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 at 14:16, Jorge Ramirez-Ortiz <jorge@foundries.io> wrote:
>
> The current code waits for data to be available before attempting a
> second read. However the second read would not be executed as the
> while loop exits.
>
> This fix does not wait if all data has been read and reads a second
> time if only partial data was retrieved on the first read.
>
> This fix also does not attempt to read if not data is requested.

I am not sure how this is possible, can you elaborate?

>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
>  v2: tidy up the while loop to avoid reading when no data is requested
>
>  drivers/char/hw_random/optee-rng.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> index 5bc4700c4dae..a99d82949981 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -122,14 +122,14 @@ static int optee_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
>         if (max > MAX_ENTROPY_REQ_SZ)
>                 max = MAX_ENTROPY_REQ_SZ;
>
> -       while (read == 0) {
> +       while (read < max) {
>                 rng_size = get_optee_rng_data(pvt_data, data, (max - read));
>
>                 data += rng_size;
>                 read += rng_size;
>
>                 if (wait && pvt_data->data_rate) {
> -                       if (timeout-- == 0)
> +                       if ((timeout-- == 0) || (read == max))

If read == max, would there be any sleep?

-Sumit

>                                 return read;
>                         msleep((1000 * (max - read)) / pvt_data->data_rate);
>                 } else {
> --
> 2.17.1
>
