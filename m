Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944822063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm8nNzEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbgF2VnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgF2Shx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:53 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B03C02F035
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:02:06 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n5so15826917otj.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1rA5138g73IgTvkP7mopL0WHcrbS6bYnkDgAhMEKZNg=;
        b=nm8nNzEBeU/HUKWuqmuIjlS3zM5djhEybNPdmwWe4JBEyPwbk37rbc3imTXCHv5O2H
         LlQmSUOM2k7r9VEwjPCTT4rDHfURp+Mi4QW/TcYSGsBmIvC6eHB5CdgzrZrCOUB38ajr
         uzpngJVt2pxPoYZzLRsyDMdjCRakT0A3+7hs3UQBXSPJpQo4mYaebGrBgdUwZUIsRQzq
         Ih9pgl5V+z+1xQ2tGaxcGLjHGXMMxSf5xU8zFn4sOSiZoakaxemDckZn43Ke0XtUVOXC
         MoDGRxKzD6Z9bMQ61Ofuw7qR1AeR7z2JwsqjZJeWcGAxkFFB4VwvKZTHLAFrM15KMbI1
         Rdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1rA5138g73IgTvkP7mopL0WHcrbS6bYnkDgAhMEKZNg=;
        b=j1Oh8t5PuonT5TNRkIXZYrav1kO0UPFm2u6LNaGR7v/siI1b+SPwrN6qLY2XZ9/adS
         ieTl3YUsUHa4+a4QjZqsZY51nmzO0B4N7LEdPxN22GxacJI6vMtHN8jF1JXQJzEom7Gz
         NiTphX0nL/FC9PYQWCyvgaglW5KVyn20adv7A1UDP/lQU6gywP/T6yP8vuuAGk9rRlg1
         QRyXkvM0svIhG8z7dp/m1hhYNbrNhzBO3m0tP6IlFwleRk++KEPhj9wFwpHKJxj+sqhw
         hJ/oZOLNrC3f3AKNEf1KfVfxSkHYQz+oWYYK5OiK+n8nqq8+3u1+PAjrBeL3jnpiiDD1
         xR9w==
X-Gm-Message-State: AOAM530CN4ORhsFCr0lwNnqC1lmzkIEpRGCILOZRaI7bg7dFQksOrDod
        EE+hkclMlyGlNLtijKeF2N/QRT8ObPccFBcnZN8=
X-Google-Smtp-Source: ABdhPJzk+3BAdTU8SeCGVQKhyttqR4bui+UeoUg70gTk9OlGkl4ZOWEjtc4BoUMl6w4yo7cKdQWTybbgKMv9kS2YHLY=
X-Received: by 2002:a9d:6254:: with SMTP id i20mr13648498otk.145.1593442925827;
 Mon, 29 Jun 2020 08:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140442.1043957-1-lee.jones@linaro.org> <20200629140442.1043957-10-lee.jones@linaro.org>
In-Reply-To: <20200629140442.1043957-10-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 29 Jun 2020 18:01:37 +0300
Message-ID: <CAFCwf11Tmw4cGr2UMY=dnJFPj6d+PLG2F1ThExvA8bM7wVNb=g@mail.gmail.com>
Subject: Re: [PATCH 09/20] misc: habanalabs: gaudi: Remove ill placed asterisk
 from kerneldoc header
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 5:04 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> W=1 kernel builds report a lack of description of gaudi_set_asic_funcs()'s
> 'hdev' argument.  In reality it is documented, but the formatting
> was not as expected '@.*:'.  Instead, there was a misplaced asterisk
> which was confusing the kerneldoc validator.
>
> Squashes the following W=1 warning:
>
>  drivers/misc/habanalabs/gaudi/gaudi.c:6746: warning: Function parameter or member 'hdev' not described in 'gaudi_set_asic_funcs'
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 61f88e9884ce9..bdb9c0080c464 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -6739,7 +6739,7 @@ static const struct hl_asic_funcs gaudi_funcs = {
>  /**
>   * gaudi_set_asic_funcs - set GAUDI function pointers
>   *
> - * @*hdev: pointer to hl_device structure
> + * @hdev: pointer to hl_device structure
>   *
>   */
>  void gaudi_set_asic_funcs(struct hl_device *hdev)
> --
> 2.25.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
