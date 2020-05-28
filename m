Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52FFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EEF208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNl9YAq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387815AbgE1KPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387785AbgE1KP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:15:26 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB47C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:15:26 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id l15so15461452vsr.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AzqkVBJAEezGbPEnQ6uyheJO4QQHaf1fZB6CgYZ5GhI=;
        b=TNl9YAq56NVOoL4WpJXdcweyHrJJZGLtV4nph0+3bV/dpqv5D/SjxK56d3U6e7qGqT
         xHzO6JegyIhHwvLwwcZCu3WaJPLS0lyHfPr2toQPJEmvUVw3QmvAVsQfnxLxm0Id8CZ8
         da+8BovUcJPMHdoK79SVAa82OHPlwOkqHdWctoTo+Db4/gxFZhBfbs7o0DDNh3jdkSfP
         YLtzY+4ucal9tH3M/IHuyng4oRKzYcLOSPe95P9uR6B8ShVwJwJuSUuNsup9TjqHzmuA
         Mp0CqkSXHY32HJY2qo5CS955oAgACWWwrS5pvimZn6ipnolyUFoHa0pNCR+NHHNrjweb
         LF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AzqkVBJAEezGbPEnQ6uyheJO4QQHaf1fZB6CgYZ5GhI=;
        b=SxqKnPYRG53JPiEbYxbIcCgKLLGI/rVNVVDkzLRtBar+KFxtSBxCjwMdHDyMNYRz19
         C6HU5u/kono0aG1vpWQ4OXtYWGiPZ7hUVJocUP6v0KIILChHEPHBAgwnUwYf+IW07iok
         lKS8AZ2dwlty5QhBoeVB3/SAZ5LIWO+swjMZ5biq5j+3BXKRyWO/VMfY+b/XrBYZRX63
         rBCNk7q2h/qcjICb0Gbg7ujOcNhCRWLoHPMwyB21i/UEVeu1zg9jWK43qIJvZrmhsgnK
         RGI71c1b2VmHTXGJjGj/dITS9gM0UmOXdHDDgtG/fmym2IVo+hu0yb4otO+Z4oU1sMYB
         Ofqw==
X-Gm-Message-State: AOAM5313/q4aAnAKlfeksTcSd4qAW8LoEw615bzEprC21cv3sMewJKF+
        Uo25VUfNP65SY2fGJh3RSkfbkG5cE2eEoeyGlJByfg==
X-Google-Smtp-Source: ABdhPJwknd/TqAO5JEEbX65YNKoBZH9XT7CwcVbXUlXdM+hW4Ksyx7qjx91yH/na5/7yPqt0RUdXIIJlNf0OgxgTToA=
X-Received: by 2002:a67:690e:: with SMTP id e14mr1366342vsc.34.1590660925499;
 Thu, 28 May 2020 03:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200527110858.17504-1-pali@kernel.org>
In-Reply-To: <20200527110858.17504-1-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:14:48 +0200
Message-ID: <CAPDyKFoA56NpRGyzWkc4N1288t=q8e7hqyCg_b-zDfeDEcwtAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: Do not export MMC_NAME= and
 MODALIAS=mmc:block for SDIO cards
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 13:09, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> SDIO non-combo cards are not handled by mmc_block driver and do not have
> accessible CID register which is used for MMC_NAME=3D construction.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>

Applied for next, thanks!

Kind regards
Uffe


>
> ---
> Changes in V2:
> * Use early returns pattern
> ---
>  drivers/mmc/core/bus.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 74de3f2dd..b1cb447da 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -93,6 +93,13 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_=
env *env)
>                         return retval;
>         }
>
> +       /*
> +        * SDIO (non-combo) cards are not handled by mmc_block driver and=
 do not
> +        * have accessible CID register which used by mmc_card_name() fun=
ction.
> +        */
> +       if (card->type =3D=3D MMC_TYPE_SDIO)
> +               return 0;
> +
>         retval =3D add_uevent_var(env, "MMC_NAME=3D%s", mmc_card_name(car=
d));
>         if (retval)
>                 return retval;
> --
> 2.20.1
>
