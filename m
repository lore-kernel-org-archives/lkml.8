Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FB1C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277A621655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hc+hOxaB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCJTmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:42:17 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35259 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgCJTmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:42:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7so6784173pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Faw5f/0aAQ+aqO9SA24AijmLN0TGCfoZ4YURng0DYsw=;
        b=Hc+hOxaBvQ8jM8uWbzOGfnSGqWbhUdERsDAB13gVJqxTWu488Ku3NDjA5pPH88fBGT
         eyFk+6hMHP/sO6VSrghtF/r0oPccgxo2GbaiMj4kvrV4k5hdGWReGU4MuODDEaDh2d7Q
         x9f8o2MMMDiHRrZXI2+pxrlmHcVuwY44BFzYyDuvJhPzszY444NMr0ghGVC6JrY3EXYJ
         wp3eampknmG85TPEWD85kcdHD7RlE85QmV6SoYV2X00UxYgXbhlas264cJGRBt5jZ9eC
         bgxaY+o4zVQeCiIQH9NHnljKdv7SgsJdIu/smHHcxNPN6+7qyNz91c5S8iqh9ML5tfOe
         xwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Faw5f/0aAQ+aqO9SA24AijmLN0TGCfoZ4YURng0DYsw=;
        b=RAXjpZe4aMrGMQF6HYpxvrHZz07OZt+r7yexy8OjbG+H/xK6AwZhREXSEVgRkgx7UB
         8EQe00CZgrAQIC2MzyR1yDvYIbLt2R/ptQiCgZKN88ncc+VfoG/Jkm0FCXWP5o6n+cqb
         XTe0XaF9LB+8DRXvALxE+OwX9GS7ObkszbPqhE1sPUOEW0sHyTPwV1yZffsHZtezR109
         KsteB3SDpAg43v28IUxFFbEv6GNpoKWjuaQRG5XPm4ipFcFNKR9MKp6MwyL4fgLvTgPa
         idfMnwCSadpbN+FymYOKSVYM9YumvxySCa96dfziWZTmrO5tUiedMaV9P6VqNtH8FIWB
         zzEA==
X-Gm-Message-State: ANhLgQ1HVl7IV+J0Sqbuluk/C6Q6Vmza2l6gxPK3npHql2NBUMWaXzc0
        5iHBalW3eKC9JjSyDzO/o23g0Q==
X-Google-Smtp-Source: ADFU+vu1vysA8mw9UMy4v+FDwYPHMpR4+M/J15qbU9YwPpA/7zMSrgTLM7z/G9PePiRee813KT+2Pw==
X-Received: by 2002:a63:6944:: with SMTP id e65mr23573008pgc.406.1583869334246;
        Tue, 10 Mar 2020 12:42:14 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k5sm3024829pju.29.2020.03.10.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:42:13 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:42:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, linux-i2c@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 3/3] i2c: qcom-geni: Drop of_platform.h include
Message-ID: <20200310194211.GO264362@yoga>
References: <20200310154358.39367-1-swboyd@chromium.org>
 <20200310154358.39367-4-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310154358.39367-4-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10 Mar 08:43 PDT 2020, Stephen Boyd wrote:

> This driver doesn't call any DT platform functions like of_platform_*().
> Remove the include as it isn't used.
> 
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> index 2f5fb2e83f95..18d1e4fd4cf3 100644
> --- a/drivers/i2c/busses/i2c-qcom-geni.c
> +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> @@ -10,7 +10,6 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> -#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/qcom-geni-se.h>
> -- 
> Sent by a computer, using git, on the internet
> 
