Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E6EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60F5020842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=foundries-io.20150623.gappssmtp.com header.i=@foundries-io.20150623.gappssmtp.com header.b="sr0mHcaF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgHEUAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgHEQkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:40:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A2C0A3BDC
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 06:34:43 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q76so6359579wme.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=foundries-io.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jUm96D8c3KBJ6s62BHerMk/IRi7rhmWP25W/0OLk1ZU=;
        b=sr0mHcaFg3/B+cuW/APq4vgco/kRUKHGPN8ruB0hAt74JLypp6gI0mmL4/QMzOgpPZ
         xX1Chxnnu4QLipjFo6IFNfNjaZjq98LJRBn4EIPSCzF/pqCAXI22oAVUVKy+yAOYe2gC
         nz8b0qiJ8r5foCm/fMq1gaFXi97wA9uPx90RB5rqCFvDC9X64J9d9pfuSHdfHMXDmotg
         KJ84Q85TUeoNXYyMq7hWD9y0ujzl8hCBZaOGr8LlOnFFrTL4R126pLFooZuVeJoR0EOO
         tcJlbJ6IhM7cTQ6bH/2wlMm/iVAzf7XJvlDA7AaU0t3HAxjh2Z8ZEHCN/sc21xmgP7Mk
         GXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jUm96D8c3KBJ6s62BHerMk/IRi7rhmWP25W/0OLk1ZU=;
        b=FwsUusJHYBJO9JZyVyvC2b0EgeR/swKfjZRSAh768rnCwTJfT1M5iuPJTj7X4sTrak
         Y6PkZoW7ZIRhFgVwJUWrHUUGTrvYc4aJa7h9iW8/7yl3Dlt2Liy0INvrziIyLH+s3GvX
         bx8XQ684X74meXoCoKev79E2R5jUN7UNN2FLaclw4nY4iOOEYgZ2/7vP2a3cxQ3byM/l
         IqAfG5ZwoA3itz6xRnDioNiR2rDF/thtWp6//A4tcJQ/yHB01yB0r8o2spHK9oVX71WD
         r8ZsTssSF3ZxHzg3cXo9amR2X6U8PB5ffmuS10RFAArSOrwSiy4dEsY2f/85cVQ7gFr1
         ukEg==
X-Gm-Message-State: AOAM532yHU7PqFxNafZuOsgb3RwFDm7mN6gxT+KfMRv9AK57l41yXdmB
        LQNYXCE0zarIzlO7wtUv5d4EBA==
X-Google-Smtp-Source: ABdhPJyRcs7JRyS8/812me57oeRdjLSDfD7mFLhAWXcdCLI8E9eJI4aXg9Szz5CIpD7pOchaqXtHgg==
X-Received: by 2002:a1c:9803:: with SMTP id a3mr3193427wme.57.1596634462319;
        Wed, 05 Aug 2020 06:34:22 -0700 (PDT)
Received: from trex (239.red-83-34-184.dynamicip.rima-tde.net. [83.34.184.239])
        by smtp.gmail.com with ESMTPSA id j2sm2973661wrp.46.2020.08.05.06.34.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 06:34:21 -0700 (PDT)
From:   "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
X-Google-Original-From: "Jorge Ramirez-Ortiz, Foundries" <JorgeRamirez-Ortiz>
Date:   Wed, 5 Aug 2020 15:34:20 +0200
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>
Cc:     sumit.garg@linaro.org, mpm@selenic.com,
        herbert@gondor.apana.org.au, jens.wiklander@linaro.org,
        arnd@arndb.de, ricardo@foundries.io, mike@foundries.io,
        gregkh@linuxfoundation.org, op-tee@lists.trustedfirmware.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] hwrng: optee: fix wait use case
Message-ID: <20200805133420.GA8276@trex>
References: <20200723084622.31134-1-jorge@foundries.io>
 <20200723084622.31134-2-jorge@foundries.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723084622.31134-2-jorge@foundries.io>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/07/20, Jorge Ramirez-Ortiz wrote:
> The current code waits for data to be available before attempting a
> second read. However the second read would not be executed as the
> while loop exits.
> 
> This fix does not wait if all data has been read and reads a second
> time if only partial data was retrieved on the first read.
> 
> This fix also does not attempt to read if not data is requested.
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
>  	if (max > MAX_ENTROPY_REQ_SZ)
>  		max = MAX_ENTROPY_REQ_SZ;
>  
> -	while (read == 0) {
> +	while (read < max) {
>  		rng_size = get_optee_rng_data(pvt_data, data, (max - read));
>  
>  		data += rng_size;
>  		read += rng_size;
>  
>  		if (wait && pvt_data->data_rate) {
> -			if (timeout-- == 0)
> +			if ((timeout-- == 0) || (read == max))
>  				return read;
>  			msleep((1000 * (max - read)) / pvt_data->data_rate);
>  		} else {

any comments please?
