Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4471DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2130E2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 03:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cdrzd8DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHTDq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 23:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHTDq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 23:46:57 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:46:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c15so255365lfi.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 20:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MIchUN4tOHyQmoooHagLeI7lJ2WK7JXkWyfuUiGtb4U=;
        b=cdrzd8DIJ9+V4zbbpYRCDfD/ME6MRUgMWO1v+hngvJLZ6QUHqpxtZhfVChVn0KV1YI
         L16g+IBo/PcqaRGEJl1cra6LI2AVjcny64WifYbPZns6gz6+gFxxWmxtlYj9HZzTAjzi
         BLiUryBAwPeKKrJyDbZyYfUZn14Q00tasLilhAt3bb1/JduHvrKlC9mZ8Dy1D7L17NKj
         J/zdlCU1JZncuPj6GELWF7xGpoLwcnEEUUaZeVMFcp2KDqvBeq5sZJhL66J0DMYEsSH/
         4USCC9pPciz4YakEK4jaCTAAIs6B1to8yLLUVxaW6MFEgIPb3iymIqt865iHYfT68diA
         OPqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MIchUN4tOHyQmoooHagLeI7lJ2WK7JXkWyfuUiGtb4U=;
        b=KwNx3l/djh6YxN3Uor9ti9HSlJ8z+RwdBYdd+UivMzxMr25K4fAbTT6z5BYm01sv+5
         5t18P49uaGAmjhcjbM+TaGtTNlnkKOqerLrtOi1C5RLOYGg2dOaO5jsytbW4KoAM+w3s
         8KLxaeKPAccwFdET09xW5kLakMeWbCMJbFlUdlXFogUHdIjPBrk5ouV7wY8GMz7CbDOM
         QvBHQgCSCU5TyqHeoWATRo+5wZYs+/lDQjzYoQslwBMWTmoOtN8AZjKFz0Ae1/CkKl3g
         1JLpq8wffSyEXEOc4Khtb2pf1CNbnbBB++5vjT0MnzeD/MYWCLAyQdDudWcwd8XRhE8m
         dKow==
X-Gm-Message-State: AOAM530VJHPQK3lmdTyNPLqxBu9LAO58xxh1t74z0vfb7t0V2oF7KS8R
        voej9hUDvx5yZSKikT9N/E1ZWn56hr5+dsN/VnNUvQ==
X-Google-Smtp-Source: ABdhPJyh8nJHRDA1mfQUy8hmEEmCfXfd0QzynbDBcUhoqQgBHFkqmr86v4MdYm3HWWb1KXvShlGfk8bos1w9MFj/vlw=
X-Received: by 2002:ac2:5383:: with SMTP id g3mr576386lfh.45.1597895214380;
 Wed, 19 Aug 2020 20:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200819175134.19261-1-krzk@kernel.org>
In-Reply-To: <20200819175134.19261-1-krzk@kernel.org>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Thu, 20 Aug 2020 09:16:40 +0530
Message-ID: <CAO_48GGjS6rAU1ojTDc9RA6e8nS4PRKOJEBzu-Vpc69x+7ykyg@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/2] dma-buf: Fix kerneldoc of dma_buf_set_name()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Krzystof,

On Wed, 19 Aug 2020 at 23:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Fix W=1 compile warnings (invalid kerneldoc):
>
>     drivers/dma-buf/dma-buf.c:328: warning: Function parameter or member 'dmabuf' not described in 'dma_buf_set_name'

Thanks for the patch; I will apply it to drm-misc.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/dma-buf/dma-buf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 1699a8e309ef..58564d82a3a2 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -316,9 +316,9 @@ static __poll_t dma_buf_poll(struct file *file, poll_table *poll)
>   * name of the dma-buf if the same piece of memory is used for multiple
>   * purpose between different devices.
>   *
> - * @dmabuf [in]     dmabuf buffer that will be renamed.
> - * @buf:   [in]     A piece of userspace memory that contains the name of
> - *                  the dma-buf.
> + * @dmabuf: [in]     dmabuf buffer that will be renamed.
> + * @buf:    [in]     A piece of userspace memory that contains the name of
> + *                   the dma-buf.
>   *
>   * Returns 0 on success. If the dma-buf buffer is already attached to
>   * devices, return -EBUSY.
> --
> 2.17.1
>

Best,
Sumit
