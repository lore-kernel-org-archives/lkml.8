Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D621AC2BA1E
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD79220719
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 07:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="W5l3m915"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgDDHbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 03:31:02 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38609 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgDDHbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 03:31:01 -0400
Received: by mail-vs1-f66.google.com with SMTP id x206so6498523vsx.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 00:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+hFFTj54X+dnGLSJAQeLYPL3M77XkjKUzoz85gYbcc=;
        b=W5l3m915mdUEF+QTl2zp5yRyUKce6jM87djRxO61GJvftQpKX913IH6irpyEW3vjWS
         aoJ74HTDM5wHmJc1Ma+iPzFwIZOukAqxaZuvmwVBrJNp48lcRfPDwVSa9X1Q21W304Qd
         cQyEYq73wnnrVPdxQKQdypk+J9xuqsRFRq4jiGBuX3JV5VLQqscYAjO5CIhd2QpYKeg8
         ucXeqxti4ZpwQIRdl5WsT7wAE3iyMCWBT7I3jHnfRCfBGVJzv6x5TpSdEoWKSrdjyxdG
         f1spuqj+Bi+5vaowZYujt3kJGE1qlJV5ermVTGj+U0Ek8M+nE+D+dkCSLgQ+wctRmDko
         RHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+hFFTj54X+dnGLSJAQeLYPL3M77XkjKUzoz85gYbcc=;
        b=PLs5lNVbD7gZoo+0wsevJyHBFzUidlgyGXSFwWxGVHzc9Gm9Ddzj/vmciBZTRv/zju
         JbYzIDH7qzzfcz8ojD2xAqMY8uSBLUpGTLF2jUZUIXvm3zUaCdsgVhG8fYwgdxIVdsmy
         BZ4ycsC5ay7MFttG6ONdIVIeuF3riXsB1e9iUH52CzU5wBuxt8UaQum1bZnXCcYlAqt3
         BLna9BREK5P2of86Yh2mF7ee8Jt7wZ9yNk+NmrtMZnaUU/9AXfWT4NPXl8oz1wycHuGe
         UG8XZGwdz5GYLCzNbRRZduhCpZtYNWFR//WBweFgHJcXZtn1FZ0r/XgdfUKpG4+26zxM
         rFKA==
X-Gm-Message-State: AGi0PuaYD3Nl5mRvBH4o0Lg9uwD+6kAqSWTCqhFENKHAR70QJsS1nywO
        0Uwgc6v1F26x98ZNfRILLTq8Fg4t57zJkd/qnGPzAg==
X-Google-Smtp-Source: APiQypKwCsok3pKZtYpKavnkMIyWFzjwvX+VhO/uzmDeq/p7hWUxGf25hzJLEtTfwGsf8hHS+ICVZnSZCzssbXJVdr8=
X-Received: by 2002:a05:6102:5c5:: with SMTP id v5mr9239819vsf.9.1585985460949;
 Sat, 04 Apr 2020 00:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200402142747.8307-1-daniel.lezcano@linaro.org> <20200402142747.8307-7-daniel.lezcano@linaro.org>
In-Reply-To: <20200402142747.8307-7-daniel.lezcano@linaro.org>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Sat, 4 Apr 2020 13:00:00 +0530
Message-ID: <CAHLCerNrAgOSO3DiFAr3rvD3Ar7N4SP7dLeURGNae7oqpzzEKA@mail.gmail.com>
Subject: Re: [PATCH V2 7/9] thermal: Change IS_ENABLED to IFDEF in the header file
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 7:58 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The thermal framework can not be compiled as a module. The IS_ENABLED
> macro is useless here and can be replaced by an ifdef.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  include/linux/thermal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 47e745c5dfca..12df9ff0182d 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -383,7 +383,7 @@ void devm_thermal_zone_of_sensor_unregister(struct device *dev,
>
>  #endif
>
> -#if IS_ENABLED(CONFIG_THERMAL)
> +#ifdef CONFIG_THERMAL
>  struct thermal_zone_device *thermal_zone_device_register(const char *, int, int,
>                 void *, struct thermal_zone_device_ops *,
>                 struct thermal_zone_params *, int, int);
> --
> 2.17.1
>
