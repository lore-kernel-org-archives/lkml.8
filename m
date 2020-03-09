Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A2CC3F2C6
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B954924654
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DffnC1G0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgCIXmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 19:42:44 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41625 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbgCIXmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 19:42:44 -0400
Received: by mail-vs1-f65.google.com with SMTP id k188so7260009vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/VkJDKvRwJ+qDbezBGZ4EAcxAnQeHrUS0YtzNe55OQ=;
        b=DffnC1G0RiMJ83ClulTUgVa6/8ydY2lac0+x2+f7iNT8mtQGQ26SMlH26sGK94FmXR
         gqwKGF9y3HjEiDOLL7OZBAyOUtd4XHl5ySXNIHlIWYKn6JQHkZs8vOZkhDa0Rxm2Lpm9
         vLUWdtcGnx9Z+I2TCIPbzBDhDg1m8rgKMgQZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/VkJDKvRwJ+qDbezBGZ4EAcxAnQeHrUS0YtzNe55OQ=;
        b=AibtgIP/dCNXr41y32k8rtmaci7nTGuAvZXz6pEykDuVgGSr/M7/wdHMK5eMSuMPPo
         L54hoqOomOxLdE0UL/ypXMeyhpg4k+OnSXVpmElrcaDRuHKjQg8DmugaW+xkFSKPpvqU
         oyZ0UH9J5qUV2pH1IibaFGpopeSmt0vUZpMvmyZJrEgzc/KHn1xkK5dkxhR0VmmFBW79
         NQau/r3OSNVVmSgM8DU1rOmxSadFN/BevTzU7sBvbBma7Dg8jrFOFhVXrQt7hROc3Pn/
         oXVYxFUARME1+FVBvzpnYdWWOridQbnESyE/MLTmBDtXp5E7R2hPkyOPrH4meh5rBPH7
         gSWA==
X-Gm-Message-State: ANhLgQ3pEiC6JnErS5h0mtf43FOAJnRw2ZE3V0xH+jxRa3uGB5/u+kiW
        VPss8W/fB0C/fRQaIMYm/jawCfZ8p+s=
X-Google-Smtp-Source: ADFU+vuWpDDILZdn2hKFYqzfb/qqTNR7ktUAZeHFbrQQtR9icgVz68i7s354CipxBrjzNNhYWpWdLg==
X-Received: by 2002:a67:d06:: with SMTP id 6mr8999987vsn.11.1583797363138;
        Mon, 09 Mar 2020 16:42:43 -0700 (PDT)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id m11sm12854122vkm.52.2020.03.09.16.42.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 16:42:42 -0700 (PDT)
Received: by mail-vk1-f173.google.com with SMTP id w67so3082717vkf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 16:42:41 -0700 (PDT)
X-Received: by 2002:a1f:97c8:: with SMTP id z191mr10591470vkd.0.1583797361399;
 Mon, 09 Mar 2020 16:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org> <1583746236-13325-4-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1583746236-13325-4-git-send-email-mkshah@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 9 Mar 2020 16:42:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xkqquyk907zAE-v7_QK_dOSmn1ooTzuXxP5Fckmhaw+Q@mail.gmail.com>
Message-ID: <CAD=FV=Xkqquyk907zAE-v7_QK_dOSmn1ooTzuXxP5Fckmhaw+Q@mail.gmail.com>
Subject: Re: [PATCH v13 3/5] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes
 before flushing new data
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Mar 9, 2020 at 2:31 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> TCSes have previously programmed data when rpmh_flush is called.
> This can cause old data to trigger along with newly flushed.
>
> Fix this by cleaning SLEEP and WAKE TCSes before new data is flushed.
>
> With this there is no need to invoke rpmh_rsc_invalidate() call from
> rpmh_invalidate().
>
> Simplify rpmh_invalidate() by moving invalidate_batch() inside.
>
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 36 +++++++++++++++---------------------
>  1 file changed, 15 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index 03630ae..5bed8f4 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -317,19 +317,6 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
>         return ret;
>  }
>
> -static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
> -{
> -       struct batch_cache_req *req, *tmp;
> -       unsigned long flags;
> -
> -       spin_lock_irqsave(&ctrlr->cache_lock, flags);
> -       list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
> -               kfree(req);
> -       INIT_LIST_HEAD(&ctrlr->batch_cache);
> -       ctrlr->dirty = true;
> -       spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> -}
> -
>  /**
>   * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
>   * batch to finish.
> @@ -467,6 +454,11 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>                 return 0;
>         }
>
> +       /* Invalidate the TCSes first to avoid stale data */
> +       do {
> +               ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
> +       } while (ret == -EAGAIN);
> +

You forgot to actually check the return value.

if (ret)
  return ret;


>         /* First flush the cached batch requests */
>         ret = flush_batch(ctrlr);
>         if (ret)
> @@ -503,19 +495,21 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>   *
>   * @dev: The device making the request
>   *
> - * Invalidate the sleep and active values in the TCS blocks.
> + * Invalidate the sleep and wake values in batch_cache.

Thanks for updating this.  It was on my todo list.  Can you also
update the function description, which still says "Invalidate all
sleep and active sets sets."  While you're at it, remove the double
"sets".
