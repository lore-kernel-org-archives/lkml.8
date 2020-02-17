Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B4AC7619E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C832064C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Dqjt/y5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgBQIC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:02:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34872 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgBQICZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:02:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so17296735wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=l3DKox+qqztb4asvNOVtIBlg1suTqH8KA57WcRUyDeo=;
        b=Dqjt/y5qO0gWAFA+/BwiQiNhQnAs5jTW/fatxUCIn40u9KvZm+xZrPas0dS2viq7bb
         jgSlXwD9Suu+XUxmUNuKB+d41jrMD77xnjTrLbSIqa4rpt4hTuG1Vg6Z4PZf7vfR1y6M
         PZ7Bpfk3t0Ys/yTJcz2WswnxPbn+B1ZTgALvyA457dZ3sb0WFxc3i2SkN30NVfhEsrKn
         yjwGuobhZJuIsBjIXOX9C/RFy5ppYs4HMjiUY1y0tl983Am6BGddtiyrE5ozmCY/CSRh
         f8d7UZvXyRjgawetaECG7ERoPthoDmHd7MBqGqypHgUVhTfvROhg73+BQ+lZcKll+QrN
         JRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=l3DKox+qqztb4asvNOVtIBlg1suTqH8KA57WcRUyDeo=;
        b=nFu+wR4j4PBAx4zjpgjyKpWNyMttu48FBhFuSnX/ZbyLmYYNjJz6a75voQIWn/0gaZ
         IG6u6yUMODWXwW/gu4B2iB/ugSBZAIfA9Q04R/MEOc2W/UqBjOy7KhyhnLHEky5Ce9/1
         spX7VVnPFB0wnRWwpS+HbJUliMzyYRcNly3AMR39o7/lsMZOympFRAN1xlPKywKgWGil
         nTzavhmeaWKi8Ayjuebkxh9GZwK8V/apx5SPpuqskblUssluiLBRp+qz+20SRSAmBFhh
         fl0LrDSFppi818fTzMYea0GYSp+bkUzzLAAIJkDrK/ErXQzhwHmvXvq+tek5VKdZh5w2
         9rBQ==
X-Gm-Message-State: APjAAAUNnwehoaYZHspX6o4EpElIxpPqw7Gz3RXd4uNJIMtRu18yBgIH
        NSAl0mHWgIFiXmS934V6gojNzpRDOxw=
X-Google-Smtp-Source: APXvYqx9LI03PNOr2Q02TPi4B2aVKc1GmmsYFLd4WBERnUA2AA8pCg4ZZaiDAl6iYjkK/uI2Jjh6JA==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr21757452wmf.189.1581926543185;
        Mon, 17 Feb 2020 00:02:23 -0800 (PST)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id f11sm18834522wml.3.2020.02.17.00.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:02:22 -0800 (PST)
References: <20200216173446.1823-1-linux.amoon@gmail.com> <20200216173446.1823-4-linux.amoon@gmail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCHv1 3/3] clk: meson: g12a: set cpu clock divider flags too CLK_IS_CRITICAL
In-reply-to: <20200216173446.1823-4-linux.amoon@gmail.com>
Date:   Mon, 17 Feb 2020 09:02:21 +0100
Message-ID: <1jmu9hzlo2.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun 16 Feb 2020 at 18:34, Anand Moon <linux.amoon@gmail.com> wrote:

> Odroid N2 would fail to boot using microSD unless we set
> cpu freq clk divider flags to CLK_IS_CRITICAL to avoid stalling of
> cpu when booting, most likely because of PWM module linked to

Where did you see a PWM ?

> the CPU for DVFS is getting disabled in between the late_init call,

between the late_init call and what ?

> so gaiting the clock source shuts down the power to the codes.

what code ?

> Setting clk divider flags to CLK_IS_CRITICAL help resolve the issue.
>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Suggested-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>
> Following Neil's suggestion, I have prepared this patch.
> https://patchwork.kernel.org/patch/11177441/#22964889
> ---
>  drivers/clk/meson/g12a.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index d2760a021301..accae3695fe5 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -283,6 +283,7 @@ static struct clk_fixed_factor g12a_fclk_div2_div = {
>  		.ops = &clk_fixed_factor_ops,
>  		.parent_hws = (const struct clk_hw *[]) { &g12a_fixed_pll.hw },
>  		.num_parents = 1,
> +		.flags = CLK_IS_CRITICAL,

This makes no sense for because:
* This clock cannot gate and none of its parents can either. IOW, the
output of this clock is never disabled.
* I cannot guess the relation between fdiv2 and the commit description

>  	},
>  };
>  
> @@ -681,7 +682,7 @@ static struct clk_regmap g12b_cpub_clk = {
>  			&g12a_sys_pll.hw
>  		},
>  		.num_parents = 2,
> -		.flags = CLK_SET_RATE_PARENT,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,

Why not. Neil what do you think of this ?
If nothing is claiming this clock and enabling it then I suppose it
could make sense.


>  	},
>  };

