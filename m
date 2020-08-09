Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BF8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BDA206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 19:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbLG+4ED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgHITo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 15:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgHITo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 15:44:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B432DC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 12:44:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t23so7378942ljc.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 12:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4szbnufHQF2HK5pviSPitVDKxjvvCLZrgBO3PzVaDDg=;
        b=SbLG+4EDjGYXnzmZ7ginX4OdN5TAAOvQz1lG3gmnuLEugh5tiQpVasccdKer+S98HD
         NYd9f/ugN33J3Af9QOweklnnOJK63L6FEL2ygafhM/UE9ADudllLRwx0LiIYhNPhWI2Z
         Pr3twaBP8dOI0BNYuuPQ6X3vvlvPFwhpZu5jxeHJdOT9RxOms9TtBjFImfw/wrdEUalD
         QNdQfrJJpm9E6g6OHx/ddXW6WsJ98nbCTvCvMa2gQ9Joy91/DQbtD6Mmt/ljN49IJKpi
         G0nsk0PTvIlJvliuwfTBbgI8gKvpQC6qroJ49alIbdche1xbrIbJSNWVcXJVm/5ntIL6
         v7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4szbnufHQF2HK5pviSPitVDKxjvvCLZrgBO3PzVaDDg=;
        b=p4BsX/wS/Em2uBUOEPueNr4dy6ZrC7bU5JcM3fAmv2sYeLtO7kpYsPsLf8dVwrYCnh
         Hd286pc9natyhLUvSRNiFCYD45d4Qprz7pglg+ZvBFHljRT6fwrZFJvR6T0YAhTcPLjG
         SWPuxesVIQlWOD01qclPYbO8rFjZPbjCxozt09GG+lWt98eJ69nAl1qN4t4GEkBisAFY
         tySIH0xCj/ut5wXzwlNbGAyCMgxtiNhX7FcREmCFtYu9aHIbfsYx7wH9wuLzQEVdOqZe
         m8h+gwrWIjXVIKL8ltRMfSVAJdXLXf6N11852niUJK42PuR2jMqz0BGG3Z04JsPB8gYW
         x+Lg==
X-Gm-Message-State: AOAM530Yi59oXaNEb7UiQEItYvc23EXlBY4AfUUwAVevvHOM7J2WQyeP
        yUbr+3l0QiDjvzKUWapYM71EpAI9
X-Google-Smtp-Source: ABdhPJxZdbdMahR1o14qFC5IQGT5HLbw1UYhP9/vHyR9O7povccGjjyNPPLctYLejWwI/M9DIPs/1w==
X-Received: by 2002:a2e:9c59:: with SMTP id t25mr10418764ljj.402.1597002266869;
        Sun, 09 Aug 2020 12:44:26 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id z20sm8238087ljk.97.2020.08.09.12.44.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 12:44:26 -0700 (PDT)
Subject: Re: [PATCH] regulator: fix pointer table overallocation
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <407fbd06a02caf038a9ba3baa51c7d6d47cd6517.1597000795.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5ef51b56-c533-46c8-621d-7907129594e9@gmail.com>
Date:   Sun, 9 Aug 2020 22:44:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <407fbd06a02caf038a9ba3baa51c7d6d47cd6517.1597000795.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.08.2020 22:21, Michał Mirosław пишет:
> The code allocates sizeof(regulator_dev) for a pointer. Make it less
> generous. Let kcalloc() calculate the size, while at it.
> 
> Cc: stable@vger.kernel.org
> Fixes: d8ca7d184b33 ("regulator: core: Introduce API for regulators coupling customization")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 75ff7c563c5d..9e18997777d3 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -5011,20 +5011,20 @@ static void regulator_remove_coupling(struct regulator_dev *rdev)
>  
>  static int regulator_init_coupling(struct regulator_dev *rdev)
>  {
> +	struct regulator_dev **coupled;
>  	int err, n_phandles;
> -	size_t alloc_size;
>  
>  	if (!IS_ENABLED(CONFIG_OF))
>  		n_phandles = 0;
>  	else
>  		n_phandles = of_get_n_coupled(rdev);
>  
> -	alloc_size = sizeof(*rdev) * (n_phandles + 1);
> -
> -	rdev->coupling_desc.coupled_rdevs = kzalloc(alloc_size, GFP_KERNEL);
> -	if (!rdev->coupling_desc.coupled_rdevs)
> +	coupled = kcalloc(n_phandles + 1, sizeof(*coupled), GFP_KERNEL);
> +	if (!coupled)
>  		return -ENOMEM;
>  
> +	rdev->coupling_desc.coupled_rdevs = coupled;
> +
>  	/*
>  	 * Every regulator should always have coupling descriptor filled with
>  	 * at least pointer to itself.
> 

Hello, Michał! Thank you for the patch! Not sure whether it's worthwhile
to backport this change since it's an improvement, I'll leave it to Mark
to decide, otherwise looks good to me.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
