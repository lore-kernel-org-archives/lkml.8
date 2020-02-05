Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFEADC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B211D21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFTdhdan"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgBELvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:51:03 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39959 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgBELvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:51:02 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so1780339iop.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 03:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=jbvFbTCcGrej2Z1q0WqVOHNoYPlE1j6xMMdkGm4J5S4=;
        b=HFTdhdaniQlnrhPAgrhMtT98C5czzMG7MHRBGfuzEJ2UKcbPJeMrQbKyZUjbPhSoe/
         aBwoHArL4/66pz7PkrKuCxGw50/weOugAe4rqEKul8l9lB9AaxkNB8CL35kG0XIM/BgH
         zWuZtUveFhvveP8sJXW6tbExAF0pmserA7hZC1Th7dGr4Km2R47hlLujSxI/fO/6aA3T
         /M3Bszi/i1aGbgfyFUgYXr2tsdr8ej1fEbpJlAwlpvXcEuTzn9sk+rKTMFXR/p1xCE4X
         b5uJAz6Ugp6HblWI9k33Y5FxpQbmzTgFv0KlfG309eDWqj8YgLK4VH1GtDoUVOuRGW93
         5cpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=jbvFbTCcGrej2Z1q0WqVOHNoYPlE1j6xMMdkGm4J5S4=;
        b=doF2y9BCaBcDgmazhp95KB67WJtXkKcOtQzuid6RFss5jJS7IvLSJ8do6iJ9SPVA9b
         twOv8Lrs9azbJjrbTtsCEVuehqz0cqjnwnG1Siy9T+5zl6Z9lPJekkx2CMkAwo86ynvq
         B5hzbP4hEvMRXPKLrFUMqWvWHTkT/jUzlLoGpUWvSSsUrjHCnPLbMxFdqAS3zdYjThmY
         k9jhQD0eFerQpplZ+wNMTX0CeNmzpXdGxgWzYKTbQ3lRPoyHiD+IgoGbDlnRKgP+cf3C
         +FZ1T2NBC9D6Br+G5tOgE7/BExnJA4t3PZhVlT4vzc/Uvxuw9hDoBprTqMdv+4C2URz1
         IVAQ==
X-Gm-Message-State: APjAAAVlfAFJ+9J5S6l8RBUxA3QLS1V1EjNb/8zvjCFNT+4MMthr4145
        wN+s0UAx8rc3Gq/soIE9rOUlFCFoBr8Clsg/0oQ=
X-Google-Smtp-Source: APXvYqyIGNEpCyFkODEuwf42IYwIDOrbccKwlZvVbZuKpGFo6lTYAIdITP9G244fLlhS+2Il0SQfwan73f+LVeOh/lA=
X-Received: by 2002:a5e:8214:: with SMTP id l20mr28855258iom.168.1580903462078;
 Wed, 05 Feb 2020 03:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20200126195619.27596-1-tiny.windzz@gmail.com>
In-Reply-To: <20200126195619.27596-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 5 Feb 2020 19:50:50 +0800
Message-ID: <CAEExFWvifzdxbZSYMoP7tAC3RmuXOE8PrNuNg_G04pS1AsXR7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] nvmem: core: add nvmem_cell_read_common
To:     Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...

On Mon, Jan 27, 2020 at 3:56 AM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> Now there are nvmem_cell_read_u16 and nvmem_cell_read_u32.
> They are very similar, let's strip out a common part.
>
> And use nvmem_cell_read_common to simplify their implementation.
>
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  drivers/nvmem/core.c | 54 ++++++++++++++++----------------------------
>  1 file changed, 19 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 9f1ee9c766ec..f4226546e49a 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1071,16 +1071,8 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
>  }
>  EXPORT_SYMBOL_GPL(nvmem_cell_write);
>
> -/**
> - * nvmem_cell_read_u16() - Read a cell value as an u16
> - *
> - * @dev: Device that requests the nvmem cell.
> - * @cell_id: Name of nvmem cell to read.
> - * @val: pointer to output value.
> - *
> - * Return: 0 on success or negative errno.
> - */
> -int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
> +static int nvmem_cell_read_common(struct device *dev, const char *cell_id,
> +                                 void *val, size_t count)
>  {
>         struct nvmem_cell *cell;
>         void *buf;
> @@ -1095,17 +1087,31 @@ int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
>                 nvmem_cell_put(cell);
>                 return PTR_ERR(buf);
>         }
> -       if (len != sizeof(*val)) {
> +       if (len != count) {
>                 kfree(buf);
>                 nvmem_cell_put(cell);
>                 return -EINVAL;
>         }
> -       memcpy(val, buf, sizeof(*val));
> +       memcpy(val, buf, count);
>         kfree(buf);
>         nvmem_cell_put(cell);
>
>         return 0;
>  }
> +
> +/**
> + * nvmem_cell_read_u16() - Read a cell value as an u16
> + *
> + * @dev: Device that requests the nvmem cell.
> + * @cell_id: Name of nvmem cell to read.
> + * @val: pointer to output value.
> + *
> + * Return: 0 on success or negative errno.
> + */
> +int nvmem_cell_read_u16(struct device *dev, const char *cell_id, u16 *val)
> +{
> +       return nvmem_cell_read_common(dev, cell_id, val, sizeof(*val));
> +}
>  EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
>
>  /**
> @@ -1119,29 +1125,7 @@ EXPORT_SYMBOL_GPL(nvmem_cell_read_u16);
>   */
>  int nvmem_cell_read_u32(struct device *dev, const char *cell_id, u32 *val)
>  {
> -       struct nvmem_cell *cell;
> -       void *buf;
> -       size_t len;
> -
> -       cell = nvmem_cell_get(dev, cell_id);
> -       if (IS_ERR(cell))
> -               return PTR_ERR(cell);
> -
> -       buf = nvmem_cell_read(cell, &len);
> -       if (IS_ERR(buf)) {
> -               nvmem_cell_put(cell);
> -               return PTR_ERR(buf);
> -       }
> -       if (len != sizeof(*val)) {
> -               kfree(buf);
> -               nvmem_cell_put(cell);
> -               return -EINVAL;
> -       }
> -       memcpy(val, buf, sizeof(*val));
> -
> -       kfree(buf);
> -       nvmem_cell_put(cell);
> -       return 0;
> +       return nvmem_cell_read_common(dev, cell_id, val, sizeof(*val));
>  }
>  EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
>
> --
> 2.17.1
>
