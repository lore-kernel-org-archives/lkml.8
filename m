Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F71C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7099207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bt2hFTGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEHIMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:12:44 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBF2C05BD0B
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:12:44 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g35so344976uad.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 01:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3qSRHUifjbk+HUdGENBz7hCntYdpN9AnCceyczmR5K8=;
        b=bt2hFTGCydhLSFbkAe8V54kz5sIGzjphQmKjLWusmdrLinuBd/8MNgqUGb3Vcvyfz4
         5WOZZkzGVPztQScyPU4rjZYXRttK+2KB2vksoVsqbrTMEpvDkng2aUcmRdHrY1ckrhfd
         18tHqkEVFkXmU6FCT6zwz0WSiYZibxyL3TCzt8NDe4m4ub1tG28FwJ97Q8hm/N2yGbvc
         19amIqAYR6zjuPLLmi+xx8OtJDQErjZARzor78PKBD9d6sdve/6pYrrTmgAi94mr5oRr
         cr39P91QlCHlnRtJ0z4xHZP1yOOy3J40QslF60sEcdo1WD3f36NVZWUZ/73sT/9BrGrh
         p3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3qSRHUifjbk+HUdGENBz7hCntYdpN9AnCceyczmR5K8=;
        b=aBekYvq1FXvGkRNLTUJ66b+kIrTL+CMuymLckWhe7rHcraYDWHy2Urj3B8+z0St0AR
         0ltRNyucPe3i0dxFJGL0Uu0rKVal+o2UxIsLhFKjhsJzR8LCfuSUtpOxuclMz5UaSn2v
         mObEYl2rlCvOHtn+KYJD/qAocq5zyLMt9Q/tvOHyNb4Hl72hr/QjQrtlySAwDuryUitS
         x6cjQE59e28BnI8qJHOht8U6cqEnRFUS7rqIYcNjsbJsNRR2q68rwRn6tqyuFVYZuyV8
         N2rO1Wh1toAi5FNJ6NMJCrZzP+3ML5b/NyOgsHJwnVS4by1gmadZxGprjN9nvdrBDcEJ
         6Ukg==
X-Gm-Message-State: AGi0PuYvW0l2iSex2f9sEZ2NhG3xU20SsNpuQVUVBJYB3d+FsFHmiVbY
        OnuLNRd1/mR/AlXuIzfh0vf7cAGuPAvRg06BUVKuaw==
X-Google-Smtp-Source: APiQypKnxqPoiIGzGmHjHQ5icfU4dREH6aBXxiWoN65/pfxFA66QolnDH/zeV4F47VJdX6STgPe/li/OREXUv5IJfW8=
X-Received: by 2002:a9f:26e2:: with SMTP id 89mr950098uay.104.1588925563578;
 Fri, 08 May 2020 01:12:43 -0700 (PDT)
MIME-Version: 1.0
References: <1588775643-18037-3-git-send-email-vbadigan@codeaurora.org> <1588868135-31783-1-git-send-email-vbadigan@codeaurora.org>
In-Reply-To: <1588868135-31783-1-git-send-email-vbadigan@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 May 2020 10:12:07 +0200
Message-ID: <CAPDyKFr=JEbRace-K1grWbKgn2jBiM5VXbknOj2DjeZDy4e8bQ@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: Fix recursive locking issue in CQE recovery path
To:     Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Sahitya Tummala <stummala@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Sarthak Garg <sartgarg@codeaurora.org>,
        "# 4.0+" <stable@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Andreas Koop <andreas.koop@zf.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 May 2020 at 18:15, Veerabhadrarao Badiganti
<vbadigan@codeaurora.org> wrote:
>
> From: Sarthak Garg <sartgarg@codeaurora.org>
>
> Consider the following stack trace
>
> -001|raw_spin_lock_irqsave
> -002|mmc_blk_cqe_complete_rq
> -003|__blk_mq_complete_request(inline)
> -003|blk_mq_complete_request(rq)
> -004|mmc_cqe_timed_out(inline)
> -004|mmc_mq_timed_out
>
> mmc_mq_timed_out acquires the queue_lock for the first
> time. The mmc_blk_cqe_complete_rq function also tries to acquire
> the same queue lock resulting in recursive locking where the task
> is spinning for the same lock which it has already acquired leading
> to watchdog bark.
>
> Fix this issue with the lock only for the required critical section.
>
> Cc: <stable@vger.kernel.org>
> Fixes: 1e8e55b67030 ("mmc: block: Add CQE support")
> Suggested-by: Sahitya Tummala <stummala@codeaurora.org>
> Signed-off-by: Sarthak Garg <sartgarg@codeaurora.org>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/queue.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 25bee3d..b5fd3bc 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -107,7 +107,7 @@ static enum blk_eh_timer_return mmc_cqe_timed_out(struct request *req)
>         case MMC_ISSUE_DCMD:
>                 if (host->cqe_ops->cqe_timeout(host, mrq, &recovery_needed)) {
>                         if (recovery_needed)
> -                               __mmc_cqe_recovery_notifier(mq);
> +                               mmc_cqe_recovery_notifier(mrq);
>                         return BLK_EH_RESET_TIMER;
>                 }
>                 /* No timeout (XXX: huh? comment doesn't make much sense) */
> @@ -127,18 +127,13 @@ static enum blk_eh_timer_return mmc_mq_timed_out(struct request *req,
>         struct mmc_card *card = mq->card;
>         struct mmc_host *host = card->host;
>         unsigned long flags;
> -       int ret;
> +       bool ignore_tout;
>
>         spin_lock_irqsave(&mq->lock, flags);
> -
> -       if (mq->recovery_needed || !mq->use_cqe || host->hsq_enabled)
> -               ret = BLK_EH_RESET_TIMER;
> -       else
> -               ret = mmc_cqe_timed_out(req);
> -
> +       ignore_tout = mq->recovery_needed || !mq->use_cqe || host->hsq_enabled;
>         spin_unlock_irqrestore(&mq->lock, flags);
>
> -       return ret;
> +       return ignore_tout ? BLK_EH_RESET_TIMER : mmc_cqe_timed_out(req);
>  }
>
>  static void mmc_mq_recovery_handler(struct work_struct *work)
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc., is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
