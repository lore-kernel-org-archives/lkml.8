Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16FCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C5F32063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZGXcj1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgF2VoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgF2Shq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:37:46 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C886FC02F027
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:58:12 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id s21so14596888oic.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qIceem+h4hEl/tJ04l9HZoi6zU5CRTZG4Umsn3mRaXc=;
        b=nZGXcj1U0WmyHL/RFeStL7uSISwmuW8Vf1A3s+OQM9J/sqxUaM4yiJ8VZ4xmRpWYOy
         W8OWynKS64uN2zYIr1zIISQs/omM/NeUadPYGo6mkqG5GuVo1Ul862pi26gTdhTVlMik
         tULuyEzlpeSWpGp/H4b9OWFE3loOoA+wmZ8SBlxv6U4mPDAlafIXO4iBWzQlvLcUzCtO
         HFW92b3GCgI2iItDuicgsLTH9Hb+Gd3OwgbIGglViUjNnF+ubEjQwjHo2u19Mw7RqL+P
         ElQpI6jrrehqsS6malxi/0R1FGYQp8GRe/k4EA6UjajoP5lPWUYYCNANo/H8Z3e7POLI
         2/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qIceem+h4hEl/tJ04l9HZoi6zU5CRTZG4Umsn3mRaXc=;
        b=oTXQP1mH8XhDjGB2cQlxy7+aBBOfR07UC0hNUATqnGhhCREnVTnd4HtR1ep3IC6GLr
         v++Rx/oanFC/X6JaciFUV5wfAcXeoWWS0v3GsUyTzuOT7J4ez0Y8GnwZx7yxod++eKfK
         KR3OHU0u3DAMEmrsW6o7TFuyaxWXjSpos7ufEne8B9icgPvv2iXu00vrpJ76UUXvOq4n
         Gk+U50hOz3D76TnWy+n7j7qV7aLEAHIyx473Wo0Q6dgFse/wWQ8LVjOe4kleezbRCCWz
         oQwCiz45FiQDu+KUmYxq1xSzKvDH/9G25fuer7ClcoQM2wXse8E6tG21Q+OAzFn/q2+X
         uHEQ==
X-Gm-Message-State: AOAM5307hY2ecK2rFmaFgj6Wo2mwpPcXaQjcT8iv5JVHnMvuh/KbYUaO
        qqD62s91r3iER0eDy76+TcMtgG4GBoN98ui10Nw=
X-Google-Smtp-Source: ABdhPJzCu10+mX5AkEDLheJEQFRjFXLQ7wvHluaa8dXoLjlYMpM12gOMFMhuflJc3ofank0Hp9OrjGmCB9O03BR283k=
X-Received: by 2002:a05:6808:b09:: with SMTP id s9mr11814027oij.130.1593442692101;
 Mon, 29 Jun 2020 07:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140442.1043957-1-lee.jones@linaro.org> <20200629140442.1043957-4-lee.jones@linaro.org>
In-Reply-To: <20200629140442.1043957-4-lee.jones@linaro.org>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 29 Jun 2020 17:57:44 +0300
Message-ID: <CAFCwf13J5T0h8Unq=Fz2s7N88N6OTQ22OQYmmVg2MrWZ4GBLug@mail.gmail.com>
Subject: Re: [PATCH 03/20] misc: habanalabs: firmware_if: Add missing
 'fw_name' and 'dst' entries to function header
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
> Looks as though documentation for these function arguments have
> been missing since the driver's inception last year.
>
> Fixes the following W=1 kernel build warnings:
>
>  drivers/misc/habanalabs/firmware_if.c:26: warning: Function parameter or member 'fw_name' not described in 'hl_fw_load_fw_to_device'
>  drivers/misc/habanalabs/firmware_if.c:26: warning: Function parameter or member 'dst' not described in 'hl_fw_load_fw_to_device'
>
> Cc: Oded Gabbay <oded.gabbay@gmail.com>
> Cc: Tomer Tayar <ttayar@habana.ai>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/habanalabs/firmware_if.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
> index baf790cf4b787..15e0793da6554 100644
> --- a/drivers/misc/habanalabs/firmware_if.c
> +++ b/drivers/misc/habanalabs/firmware_if.c
> @@ -15,7 +15,10 @@
>
>  /**
>   * hl_fw_load_fw_to_device() - Load F/W code to device's memory.
> + *
>   * @hdev: pointer to hl_device structure.
> + * @fw_name: the firmware image name
> + * @dst: IO memory mapped address space to copy firmware to
>   *
>   * Copy fw code from firmware file to device memory.
>   *
> --
> 2.25.1
>
This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
