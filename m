Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4275C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB6A92063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 14:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5sZFLxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgGXOeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 10:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbgGXOeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 10:34:23 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1BC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:34:23 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a9so5316251pjd.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=c2V/aDkLFa3GDqPB+3GWdIQ/b6undSyDVc6WrBxCWeI=;
        b=R5sZFLxuSKH5tOMS4JgBpytpQY3CPYWjTJjIsFspIa+N1Sql5sgqTjED/NJn767Rvp
         Jx6eWXCqqug5pd9ae3InB+CiGqBnI/XXmh1+4th9Nig7ZPIWmUzvUjtZLySXdK6cc72d
         hLQdpwu0/qHkQz6ZgvEi6hsbjI9ju24ZUjyz+Ox03AFsBnG0/HOX/dPVkZV5rB+AVdGd
         +zonQ7md0O04HVEolfOkirHLqmWGedVDf2guMX0L6UWxDSipIrH0T82oBtsZ9oKrZ5xW
         9R0SfJ+AIyEroh09X0+Rl0Liu3A+uqb3g6MiOiSYCtkFR/KVVFlprXo3aUMR1803rUZV
         Dp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=c2V/aDkLFa3GDqPB+3GWdIQ/b6undSyDVc6WrBxCWeI=;
        b=M9SQScQ2GjG2lD7rlWIUwXZuvCOODQUearZdecL7znxmxCqYfVwYZAzAXUsL0pO3d0
         /6aMk2USAttla5H+7BIvAQMeDkpUVg260qe9vmYrNbKaOVeTBySZK33DriJJ9A3ROQb8
         qM220KOuTXRiy9w2LgRaPfbnOW51Q4ZiInJTnQU05d2c17ocVXm9SZzYarbLhdWVEh7G
         J7LOM831OHGOLcOO/ITiN7EdOlEAEiqdt/jPi8gdYCsHlieX5jEI1Gn/lnmJUY5D5ftA
         cvvUOOj6z9dczGeIR8oWcFaZ3kMpq/RT4qHdBMr2zuKxmCCTBxoKR2n0+VIVti9WkLFV
         bOYA==
X-Gm-Message-State: AOAM533Jjo/V2Id+r59eDZPdqhVHTdqbEG6lKaelB3kY6gz2M0vGwujo
        LqLc6daQO+mMbEVLQjsir4c=
X-Google-Smtp-Source: ABdhPJz5IMPhvtXrgRe8rDCf9vjLunqH1J32FV/6aBNmk0/bxeFxkxNvjmGyvd/uhCkQBKv7ycl53A==
X-Received: by 2002:a17:902:aa42:: with SMTP id c2mr8591082plr.218.1595601263113;
        Fri, 24 Jul 2020 07:34:23 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h9sm6338724pfk.155.2020.07.24.07.34.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 07:34:22 -0700 (PDT)
Subject: Re: [PATCH 2/2] fsi/sbefifo: Fix reset timeout
To:     Joel Stanley <joel@jms.id.au>, linux-fsi@lists.ozlabs.org
Cc:     Joachim Fenkes <fenkes@de.ibm.com>, linux-kernel@vger.kernel.org,
        Alistar Popple <alistair@popple.id.au>
References: <20200724071518.430515-1-joel@jms.id.au>
 <20200724071518.430515-3-joel@jms.id.au>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d5722caa-cf98-15c4-2e45-9c569ca959b3@roeck-us.net>
Date:   Fri, 24 Jul 2020 07:34:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724071518.430515-3-joel@jms.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 12:15 AM, Joel Stanley wrote:
> From: Joachim Fenkes <FENKES@de.ibm.com>
> 
> On BMCs with lower timer resolution than 1ms, msleep(1) will take
> way longer than 1ms, so looping 10k times won't wait for 10s but
> significantly longer.
> 
> Fix this by using jiffies like the rest of the code.
> 
> Fixes: 9f4a8a2d7f9d ("fsi/sbefifo: Add driver for the SBE FIFO")
> Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/fsi/fsi-sbefifo.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-sbefifo.c b/drivers/fsi/fsi-sbefifo.c
> index 655b45c1f6ba..3ad9510ad4a4 100644
> --- a/drivers/fsi/fsi-sbefifo.c
> +++ b/drivers/fsi/fsi-sbefifo.c
> @@ -325,6 +325,7 @@ static int sbefifo_up_write(struct sbefifo *sbefifo, __be32 word)
>  static int sbefifo_request_reset(struct sbefifo *sbefifo)
>  {
>  	struct device *dev = &sbefifo->fsi_dev->dev;
> +	unsigned long end_time;
>  	u32 status, timeout;
>  	int rc;
>  
> @@ -341,7 +342,8 @@ static int sbefifo_request_reset(struct sbefifo *sbefifo)
>  	}
>  
>  	/* Wait for it to complete */
> -	for (timeout = 0; timeout < SBEFIFO_RESET_TIMEOUT; timeout++) {
> +	end_time = jiffies + msecs_to_jiffies(SBEFIFO_RESET_TIMEOUT);
> +	while (!time_after(jiffies, end_time)) {
>  		rc = sbefifo_regr(sbefifo, SBEFIFO_UP | SBEFIFO_STS, &status);
>  		if (rc) {
>  			dev_err(dev, "Failed to read UP fifo status during reset"
> @@ -355,7 +357,7 @@ static int sbefifo_request_reset(struct sbefifo *sbefifo)
>  			return 0;
>  		}
>  
> -		msleep(1);
> +		cond_resched();

A hot loop ? Are you sure ? usleep_range() might make more sense here.

Thanks,
Guenter

>  	}
>  	dev_err(dev, "FIFO reset timed out\n");
>  
> 

