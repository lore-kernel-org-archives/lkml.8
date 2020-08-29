Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C0BC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A81207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NO0oFEsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgH2ORq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgH2ORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:17:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3646EC061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:17:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id ay8so1608258edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=amOnBJfi9C9nYboXm63qVHBbqoT3lf+3WJlMeeBljmc=;
        b=NO0oFEsNUOIozTzwin7bx10m1QgCrWmLDZCKWZh1Cao9Dg85oDsUq0oQErzGJrnctP
         ai6BUNALGJT3YsdlA+k/yBOFury6vWvHFM9h3OSzVXOGsDn75MQamhTOtU95+LWtKV+/
         NC1o6PUIWzuuZMa2P/WPJ8ifSicQMOzLf9z71T6Yd8NAE3UDSHYpWlNvmvSAeANIMH3h
         cT+FVc3CobbAWvhChigjqtFx7ydvLT9vEll6kA5P7Coxuudv93Q3cpGFjekgO40M9Z6S
         62QI2qZlLfju8YsJx6JBeILkUX/vcJL3sLja7GGON4L/8n++buABK1xf3vNRl+3FmcEh
         64rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=amOnBJfi9C9nYboXm63qVHBbqoT3lf+3WJlMeeBljmc=;
        b=tYrO8lHgFEI+VyaroDPUXlW1hwdqd4L0MJPSaJArhu7rqisEznJIwrSy7lCQOz9T8h
         oRNhZDJIeaP5qAprLuv4q0cy8IEraVZ0Md3Mj13b7hQGgE4dmKOj5YvDCOUIG4asNrD4
         CcIsp/P0BvVUJdZ7m+8Bi4t6MJBC2EmpuLOuV+YX29HAIha7jC1VGTLw9BSxyCVt7tgZ
         xJTaLfmuKbIeMVWGHTwWqNvcrzPcugh+n7Y7ClDBJiq+D57tIethOa07fkKouAAfZjBR
         wYIgNs+2xX/rLqIMe0qgSpWpqt47S0TjOG8zXDMCjcSIYxjNmwIPZuBxGEc1ilWbrsgx
         fDDg==
X-Gm-Message-State: AOAM5302OeaJ6Q5PauH4wfqXZDoH6Qdmb4JOyLuikyBRe14uShMQukLv
        ey6ETuYLSHOQd4S4oU2GmdUX+g==
X-Google-Smtp-Source: ABdhPJwUV7R9h5h3EzhI3+fJWwMDtkF/1M7RjuXWJIl/zWcdObJ3QWm9KpNnDHl+yqcFic4ZVAhXgg==
X-Received: by 2002:a05:6402:6c1:: with SMTP id n1mr3661175edy.215.1598710660247;
        Sat, 29 Aug 2020 07:17:40 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id s11sm2217128edh.17.2020.08.29.07.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 07:17:39 -0700 (PDT)
References: <577e0129e8ee93972d92f13187ff4e4286182f67.1598629915.git.stefan@agner.ch>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Stefan Agner <stefan@agner.ch>, narmstrong@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, khilman@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v2] clk: meson: g12a: mark fclk_div2 as critical
In-reply-to: <577e0129e8ee93972d92f13187ff4e4286182f67.1598629915.git.stefan@agner.ch>
Date:   Sat, 29 Aug 2020 16:17:35 +0200
Message-ID: <1ja6yd7czk.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri 28 Aug 2020 at 17:52, Stefan Agner <stefan@agner.ch> wrote:

> On Amlogic Meson G12b platform, similar to fclk_div3, the fclk_div2
> seems to be necessary for the system to operate correctly as well.
>
> Typically, the clock also gets chosen by the eMMC peripheral. This
> probably masked the problem so far. However, when booting from a SD
> card the clock seems to get disabled which leads to a system freeze.
>
> Let's mark this clock as critical, fixing boot from SD card on G12b
> platforms.
>
> Fixes: 085a4ea93d54 ("clk: meson: g12a: add peripheral clock controller")
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Tested-by: Anand Moon <linux.amoon@gmail.com>

Applied Thx.

> ---
>  drivers/clk/meson/g12a.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
> index fad616cac01e..6d44cadc06af 100644
> --- a/drivers/clk/meson/g12a.c
> +++ b/drivers/clk/meson/g12a.c
> @@ -298,6 +298,17 @@ static struct clk_regmap g12a_fclk_div2 = {
>  			&g12a_fclk_div2_div.hw
>  		},
>  		.num_parents = 1,
> +		/*
> +		 * Similar to fclk_div3, it seems that this clock is used by
> +		 * the resident firmware and is required by the platform to
> +		 * operate correctly.
> +		 * Until the following condition are met, we need this clock to
> +		 * be marked as critical:
> +		 * a) Mark the clock used by a firmware resource, if possible
> +		 * b) CCF has a clock hand-off mechanism to make the sure the
> +		 *    clock stays on until the proper driver comes along
> +		 */
> +		.flags = CLK_IS_CRITICAL,
>  	},
>  };

