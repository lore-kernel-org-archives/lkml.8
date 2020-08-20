Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35F1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CEF207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QwF4Uq6J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHTRob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgHTRo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:44:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57CEC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:44:27 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so3525472ejb.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FU6En4qmUD/ctr2fUy1I8lCvKwxV26SbLYN3IPmoL2U=;
        b=QwF4Uq6J4cmVOnKjgQDO/Gh3pml1zUPeAoraxo2RNrIbPPRDvep+UY2dX7pO441H1D
         btJSyb48CH82FjuGDC9p1aH5Cm7BK5CZY+W1kkP9RlBPQgkeC/WgxLlD6gWHDZvQPW2j
         ovQO4XQ2YXedgC/iD4BZsVdsZ33tDEwygryjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FU6En4qmUD/ctr2fUy1I8lCvKwxV26SbLYN3IPmoL2U=;
        b=Y1bzAy2PajojbZobnXjWU5WzJmOPrlGK5BCBMbbO+W3JvTvnkPmJPHFu8Zs2d83s+X
         HG4kfBcq64nPQdoyZznqNyPZGTrvAhUbRlvp1zP+So0XX0b8EQRiEblubdvspmBX7xuC
         ZhI2l+fzBSWN72cqgAQ/DzxpdzUV9rHHh4sJaRLj67CCLFmkia0/9rMIdcc7SiPzLje8
         qkcVbiKRt7ZLVQrSqK4UjV1HSrFEWwJPq0BmafMfMLYQZtVT4k4QsON3O9ah8DJErfyD
         /AeO9qyQneRj5uTwCOEK/1ymWtQjt6+Q0u20afz6a5wUDyw19Ldf72nCpkq9OBv5xHtm
         JtYg==
X-Gm-Message-State: AOAM532KAJENnf//wvTBVPh2sZkEOORbW4Dn4W5YKlXlCoBfB5VqPXbw
        jeY0+NZZ4ikj1MawFYtwRSF7ZJnIYj5tdc/P6qR66g==
X-Google-Smtp-Source: ABdhPJw5nNWB5ZG8Fw9y4cBwRus7mZTqyj52PsGl0eJZhC0hG3MDp3dg8ri3m89nH3J9gHXDGPwkf/uRd0hYUKxXIRY=
X-Received: by 2002:a17:906:8748:: with SMTP id hj8mr4482012ejb.477.1597945466273;
 Thu, 20 Aug 2020 10:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200820172118.781324-1-alex.dewar90@gmail.com>
In-Reply-To: <20200820172118.781324-1-alex.dewar90@gmail.com>
From:   Markus Mayer <markus.mayer@broadcom.com>
Date:   Thu, 20 Aug 2020 10:44:15 -0700
Message-ID: <CAGt4E5uTUnC+QQBWe_VV0keNYNjBDtPpzneq+nfRJncGauzECg@mail.gmail.com>
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: Fix memory leak
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 10:21, Alex Dewar <alex.dewar90@gmail.com> wrote:
>
> In brcmstb_dpfe_download_firmware(), memory is allocated to variable fw by
> firmware_request_nowarn(), but never released. Fix up to release fw on
> all return paths.

Thanks for the fix!

Acked-by: Markus Mayer <mmayer@broadcom.com>

> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
> v2: Don't assign ret unnecessarily (Krzysztof)
> ---
>  drivers/memory/brcmstb_dpfe.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 60e8633b1175..e08528b12cbd 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -647,8 +647,10 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
>                 return (ret == -ENOENT) ? -EPROBE_DEFER : ret;
>
>         ret = __verify_firmware(&init, fw);
> -       if (ret)
> -               return -EFAULT;
> +       if (ret) {
> +               ret = -EFAULT;
> +               goto release_fw;
> +       }
>
>         __disable_dcpu(priv);
>
> @@ -667,18 +669,20 @@ static int brcmstb_dpfe_download_firmware(struct brcmstb_dpfe_priv *priv)
>
>         ret = __write_firmware(priv->dmem, dmem, dmem_size, is_big_endian);
>         if (ret)
> -               return ret;
> +               goto release_fw;
>         ret = __write_firmware(priv->imem, imem, imem_size, is_big_endian);
>         if (ret)
> -               return ret;
> +               goto release_fw;
>
>         ret = __verify_fw_checksum(&init, priv, header, init.chksum);
>         if (ret)
> -               return ret;
> +               goto release_fw;
>
>         __enable_dcpu(priv);
>
> -       return 0;
> +release_fw:
> +       release_firmware(fw);
> +       return ret;
>  }
>
>  static ssize_t generic_show(unsigned int command, u32 response[],
> --
> 2.28.0
>
