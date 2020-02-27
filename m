Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EABC35E15
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27782469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U4P8uy/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729501AbgB0SSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:18:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38649 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB0SSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:18:48 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so292304ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIrZq7zfi9d8Q+fOa28AhByDzOWhjJxxZS3b+/HMQXg=;
        b=U4P8uy/s4Ds1EkDDNGaWi1K9er6AUfeAf4VVGIvriAPWIb8H7ZO9oXIIyRLW+mfi8n
         mQb4nT0l6ksb6++c3tZjqKnQzqlPkj/Z0cbluKLEh2/M+IFiKQXtdTTDnavsmBv6PATU
         ZHd+VHFOeA9D8ICg70R5qVFgQEJnlAq7kzz0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIrZq7zfi9d8Q+fOa28AhByDzOWhjJxxZS3b+/HMQXg=;
        b=WytDbA9lRzIRVQ9BKRLfGZK7wSP5Y4CsSHHf4LQ2bo1Ujw3PohcnrAyeyYLar6X4px
         uDsXBr50QlW/FrBw/2IpmuQ/gFNIbYXr88zW30St08Wk+s7dn+LeEcfPPvkZ2m89QxDB
         qMIPSrCij73sxq9a4gQoUeoFi8Q7BlGSqKJ0LJYGw+grZvrGJy6O3L/lGGopVYk/nVoe
         3RtrtpVa5hDXN8k5/ehM7DBf2xEzdenWm5PSqyYDnKMczYiA/dsuscJBlax+TglRQXep
         loZ1uYbyt9pbDl4w2kKxVQiwR6aHzpZP4RtHIhDKcciIVhCb8N8V50QtZPIzWOHFI0Sl
         HFbg==
X-Gm-Message-State: ANhLgQ3YLpINmWaBOUk+5wUY0/W02ARsvWIX/4TMytXzxATqmVnt1ojo
        16Hrg/VHKLNEEpUTzdiTa3zVk9Kx6lU=
X-Google-Smtp-Source: ADFU+vuzvNBnFbOdTnP/gcaoL0DXzku7f+d1bA0w/Nx5Vtp1yBZUUpm1ex5XNCfFQRFm+u0qwKtLRg==
X-Received: by 2002:a2e:a58c:: with SMTP id m12mr176358ljp.141.1582827525115;
        Thu, 27 Feb 2020 10:18:45 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 5sm3728205lju.69.2020.02.27.10.18.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 10:18:43 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id h18so134320ljl.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:18:43 -0800 (PST)
X-Received: by 2002:a2e:81c7:: with SMTP id s7mr201688ljg.3.1582827523002;
 Thu, 27 Feb 2020 10:18:43 -0800 (PST)
MIME-Version: 1.0
References: <1582793785-22423-1-git-send-email-mkshah@codeaurora.org> <1582793785-22423-3-git-send-email-mkshah@codeaurora.org>
In-Reply-To: <1582793785-22423-3-git-send-email-mkshah@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 27 Feb 2020 10:18:06 -0800
X-Gmail-Original-Message-ID: <CAE=gft6VDMoTZ4mW7d7scUCtDowfJiCbOzx_1FaFkoz8tm99DQ@mail.gmail.com>
Message-ID: <CAE=gft6VDMoTZ4mW7d7scUCtDowfJiCbOzx_1FaFkoz8tm99DQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/3] soc: qcom: rpmh: Update dirty flag only when data changes
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 12:57 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>
> Currently rpmh ctrlr dirty flag is set for all cases regardless of data
> is really changed or not. Add changes to update dirty flag when data is
> changed to newer values.
>
> Also move dirty flag updates to happen from within cache_lock and remove
> unnecessary INIT_LIST_HEAD() call and a default case from switch.
>
> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> Reviewed-by: Srinivas Rao L <lsrao@codeaurora.org>
> ---
>  drivers/soc/qcom/rpmh.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> index eb0ded0..3f5d9eb 100644
> --- a/drivers/soc/qcom/rpmh.c
> +++ b/drivers/soc/qcom/rpmh.c
> @@ -133,26 +133,30 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>
>         req->addr = cmd->addr;
>         req->sleep_val = req->wake_val = UINT_MAX;
> -       INIT_LIST_HEAD(&req->list);

Thanks!

>         list_add_tail(&req->list, &ctrlr->cache);
>
>  existing:
>         switch (state) {
>         case RPMH_ACTIVE_ONLY_STATE:
> -               if (req->sleep_val != UINT_MAX)
> +               if (req->sleep_val != UINT_MAX) {
>                         req->wake_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }
>                 break;
>         case RPMH_WAKE_ONLY_STATE:
> -               req->wake_val = cmd->data;
> +               if (req->wake_val != cmd->data) {
> +                       req->wake_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }
>                 break;
>         case RPMH_SLEEP_STATE:
> -               req->sleep_val = cmd->data;
> -               break;
> -       default:
> +               if (req->sleep_val != cmd->data) {
> +                       req->sleep_val = cmd->data;
> +                       ctrlr->dirty = true;
> +               }
>                 break;
>         }
>
> -       ctrlr->dirty = true;
>  unlock:
>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>
> @@ -287,6 +291,7 @@ static void cache_batch(struct rpmh_ctrlr *ctrlr, struct batch_cache_req *req)
>
>         spin_lock_irqsave(&ctrlr->cache_lock, flags);
>         list_add_tail(&req->list, &ctrlr->batch_cache);
> +       ctrlr->dirty = true;
>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>  }
>
> @@ -323,6 +328,7 @@ static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
>         list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
>                 kfree(req);
>         INIT_LIST_HEAD(&ctrlr->batch_cache);
> +       ctrlr->dirty = true;
>         spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>  }
>
> @@ -456,13 +462,9 @@ static int send_single(struct rpmh_ctrlr *ctrlr, enum rpmh_state state,
>  int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>  {
>         struct cache_req *p;
> +       unsigned long flags;
>         int ret;
>
> -       if (!ctrlr->dirty) {
> -               pr_debug("Skipping flush, TCS has latest data.\n");
> -               return 0;
> -       }
> -
>         /* First flush the cached batch requests */
>         ret = flush_batch(ctrlr);
>         if (ret)
> @@ -488,7 +490,9 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>                         return ret;
>         }
>
> +       spin_lock_irqsave(&ctrlr->cache_lock, flags);
>         ctrlr->dirty = false;
> +       spin_unlock_irqrestore(&ctrlr->cache_lock, flags);

You're acquiring a lock around an operation that's already inherently
atomic, which is not right. If the comment earlier in this function is
still correct that "Nobody else should be calling this function other
than system PM, hence we can run without locks", then you can simply
remove this hunk and the part moving ->dirty = true into
invalidate_batch.

However, if rpmh_flush() can now be called in a scenario where
pre-emption is enabled or multiple cores are alive, then ctrlr->cache
is no longer adequately protected. You'd need to add a lock
acquire/release around the list iteration above, and fix up the
comment.
-Evan
