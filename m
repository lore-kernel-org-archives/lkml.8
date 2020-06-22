Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB6AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0E5720716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lN91PIUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgFVJQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbgFVJQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:16:09 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC9CC061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:16:09 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id h190so1145745vkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 02:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDecMwAQTCegGOg+vSBrgZxDNrHozXoTSFs1bBiYrhQ=;
        b=lN91PIUmbPojW0Q6OFXuhuvKqEvyu68NX4Wp7iVVvAnK7IbEXq2624awvXoLWjd7kj
         bwnimKaV65S3YO9zHn/ClNN30JziW9PbfGIUxVAj/cGZNsR2wTOyelWrH5stOq1SUATh
         8jCvXERB8Jqm+yjZqEbt5+YF78f9oJjY9GlnkfmxCc8rqzwQ8if69gcl8qPvOFccL+hR
         GL4Y1+iIPnEJ50yIxmUASnFzSe7Fyk5ciAMNEX5YpsdgdALTiKvyDsUQfCPv832nrnHW
         HhkITyW0ZfbohqF9Fpvf+rpYuHULlPCidRtuXWF5rkNQMXLdMjvhhC6Bw44vnbUggJPo
         aS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDecMwAQTCegGOg+vSBrgZxDNrHozXoTSFs1bBiYrhQ=;
        b=hN2qMez9wlOGovUsZYGNF8eoaxQ1Fpwob8aVdQAVwF9Y66ARoPLN0UmxD8HSc7cHl0
         JilTaqf1IF+i9FiZZlspkyAmClhoG6KC5A8xAcazRyEzjGKZjTE/i0xlHog/lgp8u3Fh
         8kMlk7LpCE7SSHUd33tfy+Hn6p2wxa2DnXt6ZZ7ImlwSKJsxSsBMSskL1O33zwI02wjo
         z1HsULPm7DpChQXOoDEuD6iqg4CZY5f5tsgyHfj8acMr/44JFuUkEDbwv+nPzZ2UAx3N
         xwkoUQrH0gdXV8Ei7m8x7GD8vOG2tv+/K25PBlsHfw2SWXLexsv2pyYb7wPYPci+Vrzx
         NrLg==
X-Gm-Message-State: AOAM530QFFhnGA16R0pa115qOKBsHVGhEItGAdLsz/WicsTUKZXizC7e
        5+0C2USg/5y0QHgS1KeBm45gR9f45Z7U1K8Mh6I3Mw==
X-Google-Smtp-Source: ABdhPJwAs3/P/4JqM3ZPC29AuUFUKFR3bS8J9Tr5EK/NjZ5gOqokqkyZfw2MTSUxBfm8xO+0EXisHhK9HU0yshQkctY=
X-Received: by 2002:ac5:c189:: with SMTP id z9mr5248794vkb.79.1592817368315;
 Mon, 22 Jun 2020 02:16:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200619015126.15002-1-finley.xiao@rock-chips.com>
In-Reply-To: <20200619015126.15002-1-finley.xiao@rock-chips.com>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 22 Jun 2020 14:45:57 +0530
Message-ID: <CAHLCerNnJELC=ZhiG7XFbRLk8GgkSSLEPncGt-Yf9yAeDe=9NA@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix wrong frequency
 converted from power
To:     Finley Xiao <finley.xiao@rock-chips.com>
Cc:     xf@rock-chips.com, Heiko Stuebner <heiko@sntech.de>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-rockchip@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        huangtao@rock-chips.com, tony.xie@rock-chips.com, cl@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 7:21 AM Finley Xiao <finley.xiao@rock-chips.com> wrote:
>
> The function cpu_power_to_freq is used to find a frequency and set the
> cooling device to consume at most the power to be converted. For example,
> if the power to be converted is 80mW, and the em table is as follow.
> struct em_cap_state table[] = {
>         /* KHz     mW */
>         { 1008000, 36, 0 },
>         { 1200000, 49, 0 },
>         { 1296000, 59, 0 },
>         { 1416000, 72, 0 },
>         { 1512000, 86, 0 },
> };
> The target frequency should be 1416000KHz, not 1512000KHz.
>
> Fixes: 349d39dc5739 ("thermal: cpu_cooling: merge frequency and power tables")
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  drivers/thermal/cpufreq_cooling.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 9e124020519f..6c0e1b053126 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -123,12 +123,12 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  {
>         int i;
>
> -       for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> -               if (power > cpufreq_cdev->em->table[i].power)
> +       for (i = cpufreq_cdev->max_level; i >= 0; i--) {
> +               if (power >= cpufreq_cdev->em->table[i].power)
>                         break;
>         }
>
> -       return cpufreq_cdev->em->table[i + 1].frequency;
> +       return cpufreq_cdev->em->table[i].frequency;
>  }
>
>  /**
> --
> 2.11.0
>
>
>
