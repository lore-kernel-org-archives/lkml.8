Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B9BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79CB20734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 11:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZbUTrPHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgFPL0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 07:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgFPL0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 07:26:47 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CB4C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:26:47 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id z47so6763351uad.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 04:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kj8pBuEYbicEiYra/1MxsnxdNYdCIy/Xz738Lg8QI0g=;
        b=ZbUTrPHTGu4GwRh+DYfBRS103wLfZCo7oqvH3ERUV1WbxyzFR/liagSKZA7aO+Iln/
         poyaEIZX/9KHRofWYhS5/iTPpJDMkTYArJLh0qOlLaj3kxF/Ig3VoeQs64cUdVaVPtfh
         apJhsVaDPHBAs71yhuuMbPYLGVlTotvbI8AVAaQJ9Ngzaj/mnnhWzYwF4FCuEy5dS3OB
         8JwCCKvrFCCDYNIQrkQsHeIMZMz62awjR+L9+I9SSwzyuhf9RpPKB3jPhGI4UpaIO5MC
         VqFwFI1DJv4cmFI7JSJCN0+8UrjbrqoL6YXn5kgeLhzuoW7tYTuJIYJNEyfXrwAECPvR
         JuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kj8pBuEYbicEiYra/1MxsnxdNYdCIy/Xz738Lg8QI0g=;
        b=EWnxilxEdX9cnIdpf+E/I4efp7okaGHO1HNMc7i0M3e1ZXm3JAf22Ztc9NzLqcsWj9
         wYps2biwyPDXAr+kyUggw+YY5W/5OvNH4uyH4hHlJLihj6DGNKaDhNkdxdkWWCEVJg8x
         vA0mDK8kdYsLrIissP6qTkblvkqEzKvgbPYDBVJ3Sdosdj0KMvJCfkQlfrijrD9rfAwl
         mT4M4lzKef/5bzGvHstWWg+g5wSWbkNYK6/q5mF6rJyHaI0vr8LPLSmQgZBhhioUam8j
         PshqvfuLyCwhPRU9pFz7RCQAXDg7Ld6XxGBYjJYYQBf5TWnYEM9gnGhP13mhQUsVAfJo
         qHpQ==
X-Gm-Message-State: AOAM531UzogwzaTnTbvF1o73B5Btb/sqOK0JJ9m3R2uDckAPT9jl5gY2
        bl+bcEIGuncsWHY1Xy63S4IC/TtM3u40cLbfomFOHQQzIoA=
X-Google-Smtp-Source: ABdhPJy2Qd7oDX9DDcKEcby0eTov3HheRlbgolbFvrZxbuuTEf20dyHDgn1w9N0lmc2eLKKRZTcijY+l68vloRA9oNY=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr1391633ual.15.1592306806719;
 Tue, 16 Jun 2020 04:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200602172957.13592-1-gaoce123@gmail.com>
In-Reply-To: <20200602172957.13592-1-gaoce123@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 16 Jun 2020 13:26:10 +0200
Message-ID: <CAPDyKFrUNVryOCn0VqoATOgvJq5H7XPNb79tw+yxTV3wOqsVFQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Add error check to avoid kernel panic caused
 by NULL pointer
To:     Corey Gao <gaoce123@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jun 2020 at 19:31, Corey Gao <gaoce123@gmail.com> wrote:
>
> If __mmc_start_req(host, mrq) fails with error, the mrq->cmd->mrq will
> be NULL. This will cause kernel panic in the following
> mmc_wait_for_req_done(host, mrq). Add error check to cancle unnecessary
> mmc_wait_for_req_done(host, mrq) if __mmc_start_req(host, mrq) fails.

The above is a bit hard for me to follow, can you please try to
elaborate on the problem. Moreover, please, provide a stack trace, as
that is easier to follow for me.

Kind regards
Uffe

>
> Signed-off-by: Corey Gao <gaoce123@gmail.com>
> ---
>  drivers/mmc/core/core.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 2553d903a82b..b13b484e64aa 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -734,9 +734,11 @@ EXPORT_SYMBOL(mmc_start_req);
>   */
>  void mmc_wait_for_req(struct mmc_host *host, struct mmc_request *mrq)
>  {
> -       __mmc_start_req(host, mrq);
> +       int err;
>
> -       if (!mrq->cap_cmd_during_tfr)
> +       err = __mmc_start_req(host, mrq);
> +
> +       if (!mrq->cap_cmd_during_tfr && !err)
>                 mmc_wait_for_req_done(host, mrq);
>  }
>  EXPORT_SYMBOL(mmc_wait_for_req);
> --
> 2.17.1
>
