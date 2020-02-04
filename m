Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B522C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AB42166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm6ioKZl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgBDVWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:22:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37134 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgBDVWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:22:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id c23so7811044plz.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rsg9HVfXQAKe0Tg/V+FvAP0DR1wDiYD8Kd+TXvbK47k=;
        b=Lm6ioKZlv4kS9wvsuGYCspXcmDNoFPwtCTKJlTz6aW+/nZyMXAoa9spHx0IaUHuUZw
         oNysBEQrp6Tge14s3UAd/7MaCLVIDWSW81icYYFbHWAaezTgSiYb5QfdChfmbGLbicvT
         FHAU5c6shIcO5+n+LuDI0+Rw5sUS398cSidjZ8rBDPJRU5TVQWsQ53qh1jOxRE29P8+3
         SFrvvBu0+kE8pV+HDKZj1C0ewMp2P5dxwYVgXm62GyaC5EqUfLrrCVoOQBaIfd5QED8j
         y1kFZXAyvSpyfH87A5fMwTu0RHieTN2w5A94Al/x5mgEqX9WsJcIOS77PYYqyWw8ZcZ0
         N7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rsg9HVfXQAKe0Tg/V+FvAP0DR1wDiYD8Kd+TXvbK47k=;
        b=C+aUT/XKmWILCpZS05xRNkLeZ2L2CqN1e7pp+aFduB54u00LBZsBMPiZem2zjhCvP7
         nuNm7cPP09+jMpGWBflwrn/VOfO0vSJQL+MJw+Mf+XRuXqWG5SgYQ/DkpmHM3uLq4ASa
         xkTf6KJH0F8Brfnh4IO9l59B9uZlzyqr08l9sNKolQJFyUhYNl5lj4vgT4knt7IdbSiF
         PvJR5UjyBq5BC1a4UTlrwbeydHhAJhwPc+nq7fefkv0cvNzLm6k4AMLjYIPeR+uwX2Hd
         fIvedQW3ODoXr5PFRI+7jOnRELCZpp5pW89mQwg4mZYcYgRY4og1MxuR+H8QD5JA3Mvm
         TrMQ==
X-Gm-Message-State: APjAAAXicR5QB0U6oefk1aWUB2tkLgUT0C3fep0/IXS+P5WA2YIwMhiO
        7eDWx/4gWSFoxA/HuRU7S38MNmeq1jtgXKsDTY0=
X-Google-Smtp-Source: APXvYqz/zk1iFEdO1YNsFb1g3FRAHUk50kjToVMbZeRSFV9YliWO/9vMazyoSpLrBUD9obkT6Sl6M7K7UNvqlEvYIsM=
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr1443831pjc.20.1580851337474;
 Tue, 04 Feb 2020 13:22:17 -0800 (PST)
MIME-Version: 1.0
References: <20200204201651.15778-1-tomas.winkler@intel.com>
In-Reply-To: <20200204201651.15778-1-tomas.winkler@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Feb 2020 23:22:06 +0200
Message-ID: <CAHp75VeC4R2XG3rfx3+G6po-JS6U0RPoXg2y+JMhd-s+E_sirA@mail.gmail.com>
Subject: Re: [PATCH] mfd: constify properties in mfd_cell
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 10:18 PM Tomas Winkler <tomas.winkler@intel.com> wrote:
>
> Constify 'struct property_entry *properties' in
> mfd_cell and platform_device. It is always passed
> around as a pointer const struct.
>

After

commit 277036f05be242540b7bfe75f226107d04f51b06
Author: Jan Kiszka <jan.kiszka@siemens.com>
Date:   Fri Jun 2 07:43:27 2017 +0200

    platform: Accept const properties

this one makes sense.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Does intel-lpss* compile with this change?

> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  include/linux/mfd/core.h        | 2 +-
>  include/linux/platform_device.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index d01d1299e49d..7e5ac3c00891 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -70,7 +70,7 @@ struct mfd_cell {
>         size_t                  pdata_size;
>
>         /* device properties passed to the sub devices drivers */
> -       struct property_entry *properties;
> +       const struct property_entry *properties;
>
>         /*
>          * Device Tree compatible string
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 276a03c24691..8e83c6ff140d 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -89,7 +89,7 @@ struct platform_device_info {
>                 size_t size_data;
>                 u64 dma_mask;
>
> -               struct property_entry *properties;
> +               const struct property_entry *properties;
>  };
>  extern struct platform_device *platform_device_register_full(
>                 const struct platform_device_info *pdevinfo);
> --
> 2.21.1
>


-- 
With Best Regards,
Andy Shevchenko
