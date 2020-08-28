Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FE7C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC63520848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="okKA5t+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgH1Lgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgH1Lde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:33:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AB1C061234;
        Fri, 28 Aug 2020 04:33:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q93so443419pjq.0;
        Fri, 28 Aug 2020 04:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOlDEU1BsYBbFWhmh59xuuWngnqIWmuc5c1z2N5X5iU=;
        b=okKA5t+819t4aL82S/1lPHpK0etGCZAg+DWAd3Aa+/Kfd0TPjmAiMHRr+BtuzqUrNw
         FQNIJW6q/u50hqueNTXZJF3fsD7RnkcRFhXLhUuF4mmD8NYK69Gw1D1ZDKMWqg+JvywU
         Gk/sJ4QZGcvZjNK3CQ76/z2vDWIpvEmDnkU7vJr8agn9cyNHgmgZtb9r67Ap0sh5i3gd
         nQnktlRbPIG4bQ0a36AnzchmeHGvqCyQa22RtOi5upQ7CwhZc5alUuUWe6DrDfWIo7Fi
         sxO/vQMTdzTbwOLookZJa0WJxb5rjL97X0f280Si6C281JKHUBFx1UATzKFNpxilEfFW
         eCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOlDEU1BsYBbFWhmh59xuuWngnqIWmuc5c1z2N5X5iU=;
        b=EjNOMZLg7DUaJMcCEtOj4xIz3EKRo2x2OH0MvixSryfBnfNBrDX4bJ5FHVAjzZ9IAs
         8RjHvKWGXICDiNagFwNX0gb6DV3P/k12LJptNqJed6f8ZGwLRRu5HpObpP4C3Xx0ii/+
         lKDhCsMI7A4jX8K2FhJqn8YrD+YaThiV6Fr3O9mEIeatRpJYs5j2/NVhdjfINuJ1ndgF
         cjaH7Xaz1fZ3+naNdpHDlywIoPrdgnz8hopEL3pvjAHfqYCOPvxfzSy0T5rl9ReRXy4m
         1Yaxyfs0Jbq+/xzRRkX/HgKbqo89+xNx/SrLCj8M0Crc+bEcz4F4J1qiObdLPwY4FPE7
         IfiQ==
X-Gm-Message-State: AOAM532JXC1DipmHolbSbQ2SMeBc1PkVVaHnjJb7aAJswGzsZoM5qO7/
        /op0zNzccESTevcfS0tmRZJ+L+FIAN1t2AAw7xw=
X-Google-Smtp-Source: ABdhPJyOnYN0eiYT1oRmZEPiOV986t4tAQMWHu343i5WBAGAYTZAwJTws/nQaqTHDZFMTTSFa9GlXpfA7djOWhFxvnw=
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr1007047pln.65.1598614380745;
 Fri, 28 Aug 2020 04:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200828110507.22407-1-peter.ujfalusi@ti.com>
In-Reply-To: <20200828110507.22407-1-peter.ujfalusi@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 28 Aug 2020 14:32:44 +0300
Message-ID: <CAHp75Vef=C=+Ck8T-TCp56TCjV-YsNGo9MWFsDQ=h6rn3cP-MQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: Mark dma_request_slave_channel() deprecated
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 2:03 PM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> New drivers should use dma_request_chan() instead
> dma_request_slave_channel()
>
> dma_request_slave_channel() is a simple wrapper for dma_request_chan()
> eating up the error code for channel request failure and makes deferred
> probing impossible.
>
> Move the dma_request_slave_channel() into the header as inline function,
> mark it as deprecated.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks for this vector of cleaning!

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/dmaengine.c   | 18 ------------------
>  include/linux/dmaengine.h | 15 +++++++++------
>  2 files changed, 9 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index a53e71d2bbd4..ac8ef6cf7626 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -871,24 +871,6 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
>  }
>  EXPORT_SYMBOL_GPL(dma_request_chan);
>
> -/**
> - * dma_request_slave_channel - try to allocate an exclusive slave channel
> - * @dev:       pointer to client device structure
> - * @name:      slave channel name
> - *
> - * Returns pointer to appropriate DMA channel on success or NULL.
> - */
> -struct dma_chan *dma_request_slave_channel(struct device *dev,
> -                                          const char *name)
> -{
> -       struct dma_chan *ch = dma_request_chan(dev, name);
> -       if (IS_ERR(ch))
> -               return NULL;
> -
> -       return ch;
> -}
> -EXPORT_SYMBOL_GPL(dma_request_slave_channel);
> -
>  /**
>   * dma_request_chan_by_mask - allocate a channel satisfying certain capabilities
>   * @mask:      capabilities that the channel must satisfy
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 011371b7f081..dd357a747780 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1472,7 +1472,6 @@ void dma_issue_pending_all(void);
>  struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>                                        dma_filter_fn fn, void *fn_param,
>                                        struct device_node *np);
> -struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
>
>  struct dma_chan *dma_request_chan(struct device *dev, const char *name);
>  struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
> @@ -1502,11 +1501,6 @@ static inline struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
>  {
>         return NULL;
>  }
> -static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
> -                                                        const char *name)
> -{
> -       return NULL;
> -}
>  static inline struct dma_chan *dma_request_chan(struct device *dev,
>                                                 const char *name)
>  {
> @@ -1575,6 +1569,15 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  #define dma_request_channel(mask, x, y) \
>         __dma_request_channel(&(mask), x, y, NULL)
>
> +/* Deprecated, please use dma_request_chan() directly */
> +static inline struct dma_chan * __deprecated
> +dma_request_slave_channel(struct device *dev, const char *name)
> +{
> +       struct dma_chan *ch = dma_request_chan(dev, name);
> +
> +       return IS_ERR(ch) ? NULL : ch;
> +}
> +
>  static inline struct dma_chan
>  *dma_request_slave_channel_compat(const dma_cap_mask_t mask,
>                                   dma_filter_fn fn, void *fn_param,
> --
> Peter
>
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>


-- 
With Best Regards,
Andy Shevchenko
