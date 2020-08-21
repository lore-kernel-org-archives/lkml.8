Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF1DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D7220738
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="SPXJPhyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgHUHDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgHUHDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:03:03 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E025AC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:03:02 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id s81so211280vkb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlOtHCZhTjkTOnIHeVcT4uedUfnkkWitrR4JY7ZgBs8=;
        b=SPXJPhylKpfuB6WJexBw/N2MHPIljRVjFESN3CI9zs4CMkxx0YI7Gw/GK5524t0XLt
         uDi5K46RnV2Z/SvpckTlcCwfhAIZaD9jCT05tMgc7JX/Vygmloh27a5Ikkx3+rfdSO6c
         Qp1W5ACXfhfaekUnx0C+BLks7hWk7+ItJ88wt4D+rUh+CJRpS8O493dN/ZqD7IWL0ZvI
         0SuKqwFH4jwfbJTBgJxEjPHb78It2GZFkm8piqZTnA2wR03RMiMzS//3Ub28/rvfFWXA
         1zVb/AGsUvJRhQepUxvPSQfeKW/jCTuqYrLgLThQiiiCqEQU0J/Lsxgr5mgjM4wBCTTP
         CH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlOtHCZhTjkTOnIHeVcT4uedUfnkkWitrR4JY7ZgBs8=;
        b=BPPrUcRQCsJjlIlKXLRh+xXTkfuJgEvA0T33WhYcUQ5IxrMDFsoJWRjtsW/GcQB84o
         bP6nmJPHQk3racsWbJevIXHz0uzPQRF08xEU7fAlikma6VKbM78j1PWdtwx4hEKr32Ex
         HuPDyIY/96ruUjJ6JFQC3HGttB+7hvHv68zHMIABMJ25Qy/2mRIXG53t+TNv9aC84K72
         v9GQzirrnHgAn7n4XdrFRbEmMXeo99BlVQu52qmG0yZ4sDm2tEzWUOzJtv3qAj+b8Em0
         23J/nfTPlKv0f23FYZWPa7jNen8ORp6uoi4uYWQV1UItW3iGoJHie4I8wHLl9qpov/9a
         orrQ==
X-Gm-Message-State: AOAM531CDGv3adL3M0nM6PnAxfPdGelZ7VF/u7vrpeYvzAkj/y2Fmw4f
        NgDO9DNlH18qo0buNhtm1zSvCF+OTN4nhn9gyUjVEw==
X-Google-Smtp-Source: ABdhPJzNBbKeKvzz93LZ4nUuQZ6yinuX7g4ApvU25n702PhdmBQYK0Kuii3dIyL+bE/CCKuso/edE92BtgQ379oqqKc=
X-Received: by 2002:a1f:36c2:: with SMTP id d185mr854844vka.9.1597993382082;
 Fri, 21 Aug 2020 00:03:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200821024406.10404-1-zbestahu@gmail.com>
In-Reply-To: <20200821024406.10404-1-zbestahu@gmail.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 21 Aug 2020 12:32:51 +0530
Message-ID: <CAHLCerN-MAOHvk6aZX9TRVWpzduSsg-q=8K3nv=UWuG1syka+Q@mail.gmail.com>
Subject: Re: [PATCH] thermal: sysfs: Fall back to vmalloc() for cooling
 device's statistics
To:     Yue Hu <zbestahu@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@yulong.com,
        zhangwen@yulong.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:14 AM Yue Hu <zbestahu@gmail.com> wrote:
>
> From: Yue Hu <huyue2@yulong.com>
>
> We observed warning about kzalloc() when register thermal cooling device
> in backlight_device_register(). backlight display can be a cooling device
> since reducing screen brightness will can help reduce temperature.
>
> However, ->get_max_state of backlight will assign max brightness of 1024
> to states. The memory size can be getting 1MB+ due to states * states.
> That is so large to trigger kmalloc() warning.
>
> So, let's use kvzalloc() to avoid the issue, also change kfree -> kvfree.
>
> Suggested-by: Amit Kucheria <amitk@kernel.org>
> Signed-off-by: Yue Hu <huyue2@yulong.com>

 Reviewed-by: Amit Kucheria <amitk@kernel.org>

> ---
>  drivers/thermal/thermal_sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
> index aa99edb..d1703ee 100644
> --- a/drivers/thermal/thermal_sysfs.c
> +++ b/drivers/thermal/thermal_sysfs.c
> @@ -16,6 +16,7 @@
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/slab.h>
> +#include <linux/mm.h>
>  #include <linux/string.h>
>  #include <linux/jiffies.h>
>
> @@ -919,7 +920,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>         var += sizeof(*stats->time_in_state) * states;
>         var += sizeof(*stats->trans_table) * states * states;
>
> -       stats = kzalloc(var, GFP_KERNEL);
> +       stats = kvzalloc(var, GFP_KERNEL);
>         if (!stats)
>                 return;
>
> @@ -938,7 +939,7 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
>
>  static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
>  {
> -       kfree(cdev->stats);
> +       kvfree(cdev->stats);
>         cdev->stats = NULL;
>  }
>
> --
> 1.9.1
>
