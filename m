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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9C2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 21:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9980206A2
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 21:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umebzz1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHIVkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgHIVkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 17:40:08 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD6AC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 14:40:07 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id v15so3683381lfg.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 14:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+ep4HojIQDcPfiGIdNJSmErIHNth9ZyqLjovwLChR98=;
        b=umebzz1A/fKNdhwy09ATaiKEGNk6aY1qV/L7qFryoORsJN0s4VhQLKbJCotKTfxmTB
         BxXLFUoD457Nb+PD4kKbd6xI5t4P5vDgIb2ZAd7aAQ0ExrElioJEkrkYaAmKDEIRYY8B
         2etoYNm28mEe1sn1QoOj5T41hcyBx28YpBoCBTurs9UxDUDYThI1zLNodZe46igFNV65
         KO2CT3TsyO2jWm4WljSCrLo0qQHtWds8IPF/3coLvNCKLQFtOQBWJwWeXjLXF1qa71BZ
         IPCtELmpWGA1stzqMmdqGfYXVBaSQ06oFAKt7zqz89OBE2tQfgQ0y9IwIiLdtiAvGuHa
         YQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ep4HojIQDcPfiGIdNJSmErIHNth9ZyqLjovwLChR98=;
        b=m318q0IlwMf267E+ZvNA4mA/O/c9VaIf6g8Z8npQw4V9xXpeqhObSNVr1YslwHl/tA
         XjfCFfAgHpCjDBAZbEAiqBMELtDfkYWquHJGCZCvgQnQvQmYYSaIuRr3W1ZGwgmG8n6I
         mwvTvYHt5R3ZPqZDJPLznU1dfaEwFpf7j+bK9V469zrVWmxuQ1LQNFNJpWGBwTMbMG+O
         FrvlFs1VCWgnrw23FE9autcuj8lVt1Jk6rSjmXdEC4yzDKQqCY4JcM2WAum5oFAZf8nb
         DvwqEAmV84SlZwtdIdmd4Gn5yLHRvOuMUPNrmcY9f/ms26VaClCOPqZkg5FMUS+4gKZH
         Avvw==
X-Gm-Message-State: AOAM530F8voPBTREYg9QOrFDaRwNsPDH9H3OEJLtRdbTl73SNhRkB7tJ
        eJStCwJh15pa7XxNol++vdrYxDrD
X-Google-Smtp-Source: ABdhPJxvRqCxkdqK4RhVC0L0JMyALNvVwiMye+l5FlVVQ1aqKx0OIQpNQNy/2RUaxhdTYe/N02HpSQ==
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr11435036lfo.31.1597009205791;
        Sun, 09 Aug 2020 14:40:05 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id w8sm8287705ljm.48.2020.08.09.14.40.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 14:40:05 -0700 (PDT)
Subject: Re: [PATCH] regulator: simplify locking
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <40871bc7-2d6c-10d4-53b3-0aded21edf3b@gmail.com>
Date:   Mon, 10 Aug 2020 00:40:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b22fadc413fd7a1f4018c2c9dc261abf837731cb.1597007683.git.mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 00:16, Michał Mirosław пишет:
> Simplify regulator locking by removing locking around locking. rdev->ref
> is now accessed only when the lock is taken. The code still smells fishy,
> but now its obvious why.
> 
> Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
> ---
>  drivers/regulator/core.c         | 37 ++++++--------------------------
>  include/linux/regulator/driver.h |  1 -
>  2 files changed, 6 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
> index 9e18997777d3..b0662927487c 100644
> --- a/drivers/regulator/core.c
> +++ b/drivers/regulator/core.c
> @@ -45,7 +45,6 @@
>  	pr_debug("%s: " fmt, rdev_get_name(rdev), ##__VA_ARGS__)
>  
>  static DEFINE_WW_CLASS(regulator_ww_class);
> -static DEFINE_MUTEX(regulator_nesting_mutex);
>  static DEFINE_MUTEX(regulator_list_mutex);
>  static LIST_HEAD(regulator_map_list);
>  static LIST_HEAD(regulator_ena_gpio_list);
> @@ -150,32 +149,13 @@ static bool regulator_ops_is_valid(struct regulator_dev *rdev, int ops)
>  static inline int regulator_lock_nested(struct regulator_dev *rdev,
>  					struct ww_acquire_ctx *ww_ctx)
>  {
> -	bool lock = false;
>  	int ret = 0;
>  
> -	mutex_lock(&regulator_nesting_mutex);
> +	if (ww_ctx || !mutex_trylock_recursive(&rdev->mutex.base))

Have you seen comment to the mutex_trylock_recursive()?

https://elixir.bootlin.com/linux/v5.8/source/include/linux/mutex.h#L205

 * This function should not be used, _ever_. It is purely for hysterical GEM
 * raisins, and once those are gone this will be removed.

I knew about this function and I don't think it's okay to use it, hence
this is why there is that "nesting_mutex" and "owner" checking.

If you disagree, then perhaps you should make another patch to remove
the stale comment to trylock_recursive().
