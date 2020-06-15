Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC9EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F326207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GICjrX7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbgFON2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbgFON2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:28:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2FC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:28:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so19156233ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qTnUqQNd2eH1CmJ60tGdoC5I8fF8RTcE8IuM27x0hw=;
        b=GICjrX7IfQiuCFxkffqzRXau06xsxXfgbB3kyDFN9afGwqLxQMLGdxCpj4CwfaabKl
         nWyfXSR72jHaX0EbuqaRk+FTbpwfm1RHOI49ovnT5OhJy07bf563ssQFDGyFHkSfzw/h
         LplaCBaRb3Y+dnUZiyUnkPCsj+gqEpiJvydzSOWTa8QgRyI0y7TNrN03dTRJYKFQEQxY
         3N8dwhTXYlMfYs61Vc+SL8ZeS3Css94BX82JfR57dOCcZGDR+CUZLY3Gt0HGB3Npnb0p
         YMhpPJO6fVTrq7E52Oibr2jIQRRgjRwP+XZDo5L3ksmN8z3HGqGuenxCvKirRk86wG7l
         kNbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qTnUqQNd2eH1CmJ60tGdoC5I8fF8RTcE8IuM27x0hw=;
        b=A1ZWwSSZRK1evuKE06b4cDSizZox+OIFG+ACFRgRpFC6NRcPdnK2S+53BphfuFkk2b
         6F75sHu/axFlfevy/MdoVoXOeKs6sqcq9S/m2s1YOzumP5eFCx6snall2c7xz4d6iSg5
         +o54zlBNlqztwmiyN75tG8XRjzwbWwhGMpjOCK5nwOVwzySSO41375lOKXb5F25N9idb
         N+jvIOt/aDcA/hCp6xGM30f4A5H5PHqq14qwVL80xOCljAtNub3QeTSkvkB4M2REbOd+
         YQH+u0CnLKipXFqmhxItT2cfiVdKSQZHHEi/mevmJBRHlhAEx+0GsoetHEi3uBvRchwr
         wLVQ==
X-Gm-Message-State: AOAM530dU+DCbRrgGLyTXlQ5BXVD4psf0GAFRiRUecXH4klCYWrkI7pc
        Jxq2fl2Hp+Z+SLPrWIZ9cuzrOG3sPg8T+vFob8AB5A==
X-Google-Smtp-Source: ABdhPJyzwtrBmaHh5jJPIMWZixxN/HO4IzcwDk0Gaw5mAQ54n1rWOZ4P1ZTP+oLaltZGi9YxUTUG1MmNV5PSVhmJpUc=
X-Received: by 2002:a05:651c:106c:: with SMTP id y12mr7739172ljm.427.1592227694734;
 Mon, 15 Jun 2020 06:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200615131910.2276515-1-jens.wiklander@linaro.org>
In-Reply-To: <20200615131910.2276515-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 15 Jun 2020 18:58:03 +0530
Message-ID: <CAFA6WYM3fyvY-vj4xpDWwZo2F+2H0Fu9Z7vGvjvE=ZNGOn2AaA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: change tee mailing list
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020 at 18:49, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> The old TEE mailing list tee-dev@lists.linaro.org is about to be
> retired. From now on please use op-tee@lists.trustedfirmware.org
> instead.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  MAINTAINERS | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Acked-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 68f21d46614c..772448e36203 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12691,13 +12691,13 @@ F:    arch/mips/boot/dts/ralink/omega2p.dts
>
>  OP-TEE DRIVER
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> -L:     tee-dev@lists.linaro.org
> +L:     op-tee@lists.trustedfirmware.org
>  S:     Maintained
>  F:     drivers/tee/optee/
>
>  OP-TEE RANDOM NUMBER GENERATOR (RNG) DRIVER
>  M:     Sumit Garg <sumit.garg@linaro.org>
> -L:     tee-dev@lists.linaro.org
> +L:     op-tee@lists.trustedfirmware.org
>  S:     Maintained
>  F:     drivers/char/hw_random/optee-rng.c
>
> @@ -16759,7 +16759,7 @@ F:      include/media/i2c/tw9910.h
>
>  TEE SUBSYSTEM
>  M:     Jens Wiklander <jens.wiklander@linaro.org>
> -L:     tee-dev@lists.linaro.org
> +L:     op-tee@lists.trustedfirmware.org
>  S:     Maintained
>  F:     Documentation/tee.txt
>  F:     drivers/tee/
> --
> 2.25.1
>
