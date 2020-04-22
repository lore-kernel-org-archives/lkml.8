Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F0EC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 527992082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQshYo20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgDVRAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDVRAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:00:12 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C190C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:00:12 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a6so2439954uao.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L/O5KwO3nOxDvXJ07hYZXiY7YmCfT4z0Qa9cSD5ewpg=;
        b=DQshYo20P818TEnP5OMd8H3N/OyBjq2JbqEAdVAeSVG8qrfaJSDjw+Qh7mdP/+O0EH
         DeSIxtiOvwukT7Vbuzi4cs1xbxXrloS5zpU/tkFrV2+KYIWQMzwJfPMszuojRD3cTSwp
         yz4TgDhBz8HtWMXdM/dtAqAk1tEwp/O07PtRgQ5KUFZA51Wk+o/JAcrENteopUj1+mML
         iKsOYqMdpq7FwVUcoYNJtL76eDwxbjneM2R3dJ6nlj8kng36ZVsQgh7gkHJF8GV6M6hy
         P1JV1Cal7V6v/nmSPGE3jHAXb2Baj54ghFVHyx3o4wcx+za6HU1KKnZJiRTIjrQs3zZ7
         cZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L/O5KwO3nOxDvXJ07hYZXiY7YmCfT4z0Qa9cSD5ewpg=;
        b=n8f05zNBi1H15SMHLHIw2Wyzo/rIPVGGIKhtaaHGkk1eCzcFuM3+p74IAKPGq4/fZl
         bDJ2dxj5ctP3UcWoZgaa3VthQk/uxlSdG+SGn2kXG9BU84+MK9eNKQUYaEMRIILuht9h
         zvVhekyBLNhHnwxp8QtV9kNHrE4UWFEHnoLgM9jPBADxzBFSjzV2OLh+HZNISjKMRSnh
         vgRGVo6gQGd/pWtaQsuE0Arc0zJWHhuabUSESabdjHQlY/444sGVMVzdZFXqcmD+47hM
         jvg51nwNQVm8lWx+dTqcegmikzD8lyR4pr63gBwZLEzALPf51h1yBPh49kIabRyo3XkA
         nzGw==
X-Gm-Message-State: AGi0PuZhlghUw5/VE9jOekh5kf9UCAiEJQRf7zXii/JifZ/agIGCklzM
        g9+icZ6McC2bB8yFAgegRgHEpOqOhmlshcPxg9hvTw==
X-Google-Smtp-Source: APiQypLa/e6Cqt7Vstz3uJ4c15sXDsUKYq/kUtlxRjycsoEPDwtCDz5D9ounDPaZ/qRG2Cvk2VsouvI8xzei/8uZjA4=
X-Received: by 2002:a67:8b09:: with SMTP id n9mr20446512vsd.191.1587574811418;
 Wed, 22 Apr 2020 10:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.811655681@infradead.org>
In-Reply-To: <20200422112831.811655681@infradead.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Apr 2020 18:59:35 +0200
Message-ID: <CAPDyKFo+qCZU=snj==4CFRfL9R0KLcG2RMYeFW_BMX=-Mo5rtg@mail.gmail.com>
Subject: Re: [PATCH 10/23] sched,mmc: Convert to sched_set_fifo*()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>, qais.yousef@arm.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        bsegall@google.com, mgorman@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
>
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
>
> In this case, use fifo_low, because it only cares about being above
> SCHED_NORMAL. Effectively no change in behaviour.
>
> Cc: ulf.hansson@linaro.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

FYI: I am slowly moving towards removing the entire kthread for the
sdio_irq_thread(). It shouldn't be too far off to be posted, one or
two kernel releases or so.

Kind regards
Uffe

> ---
>  drivers/mmc/core/sdio_irq.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -139,11 +139,10 @@ EXPORT_SYMBOL_GPL(sdio_signal_irq);
>  static int sdio_irq_thread(void *_host)
>  {
>         struct mmc_host *host = _host;
> -       struct sched_param param = { .sched_priority = 1 };
>         unsigned long period, idle_period;
>         int ret;
>
> -       sched_setscheduler(current, SCHED_FIFO, &param);
> +       sched_set_fifo_low(current);
>
>         /*
>          * We want to allow for SDIO cards to work even on non SDIO
>
>
