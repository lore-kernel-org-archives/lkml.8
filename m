Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5BDC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 17:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2CC206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 17:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yd3FcI+T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgF0RnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 13:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgF0RnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 13:43:06 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4104AC061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 10:43:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so6410457lji.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gSgvKoi8G4VJMQGHrpyGDqm81BfA5NfOfyYIB+GxuOo=;
        b=Yd3FcI+TF5ttPlgmz/FVconDLMEluWECcFaIwIr6L1Ca4/JG/AksUsC1fI4s2bdVJt
         iDjEqDVoGdGqorZxxvYJ7xgwW74pqPN5sngf9Lwgt7uYnveqnzjacO8AEfMAm39k52jW
         pH20hC3xsnt6htLc19XkWX+55CCJcfSg0QlpBQS5cBAA4yWxIWiCVG+oJ7gDmo05Ov8b
         /uyYZ1PWy7GO7Vj6JjUV1KRMhNoU4zOuydsILBp6xZugVe9q3SeLIpGtE5XhOIjeWa7b
         rd8rjGYPBXf6QAD0buLMpbXg2XwxZTqH8l7UlJpPPDl6JinekU9WsDXGXbJG9mXOfe17
         ZuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gSgvKoi8G4VJMQGHrpyGDqm81BfA5NfOfyYIB+GxuOo=;
        b=G1uVC8UMnowA1wASsB/LE8E4F9sLywdrHrYXjWZn+iPS6izgfl3XwhRUbnFnhM0NI3
         pNpuqP79DUbQ3aUnqOMHimLOKjKNo/ZwQWXprEzaaPXZYYy1NIa0nyWJNptA+ewn0ABu
         2N729jo1ZM6YFQrKVypAV7o97DUDeisTSYTDdxuDaGfz+gZknWv6hgI3XqnbPwX9KKWZ
         /pwp/sKWVHpLUjkLSpY5LmvYSM0ZnpfLqNaluVKTC/BbbNn8b1a7+meVFVtBReAa/WPd
         etfbeuGqVHx2MTWJk+hx99OFwDffRjUkbTLm21Da3P/Qr5VNUS5tFFH6F14ufRUfi0sq
         mvXQ==
X-Gm-Message-State: AOAM531+VkleZc5oHYGJWz2J8S0q+IXUp+b1BtAEMJVkLPVuxj9aOLr6
        ferBCTHXtQwtlezQhAFrFSr2QN/q+oh0mA1rQNA=
X-Google-Smtp-Source: ABdhPJx6hBa/cu1yII7uuXIyp5aFYbUQXzbHOLF6Z5trZh+dtVFSW/dDyPy8xJl2UMyiIyGWV8YoF5FQrzwFRIRIoUs=
X-Received: by 2002:a2e:50b:: with SMTP id 11mr3470506ljf.458.1593279781666;
 Sat, 27 Jun 2020 10:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <1592360843-3440-1-git-send-email-jrdr.linux@gmail.com> <1592360843-3440-3-git-send-email-jrdr.linux@gmail.com>
In-Reply-To: <1592360843-3440-3-git-send-email-jrdr.linux@gmail.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 27 Jun 2020 23:21:18 +0530
Message-ID: <CAFqt6zZgrBkwB8ZVn4Lescnvy0kspVoWgaA4oAHkdG1YA90ZzA@mail.gmail.com>
Subject: Re: [PATCH 2/4] staging: kpc2000: kpc_dma: Convert set_page_dirty()
 --> set_page_dirty_lock()
To:     Greg KH <gregkh@linuxfoundation.org>, jane.pnx9@gmail.com,
        pakki001@umn.edu, ldufour@linux.ibm.com, harshjain32@gmail.com,
        =?UTF-8?Q?Simon_Sandstr=C3=B6m?= <simon@nikanor.nu>,
        Michel Lespinasse <walken@google.com>
Cc:     "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Bharath Vedartham <linux.bhar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 7:50 AM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> First, convert set_page_dirty() to set_page_dirty_lock()
>
> Second, there is an interval in there after set_page_dirty() and
> before put_page(), in which the device could be running and setting
> pages dirty. Moving set_page_dirty_lock() after dma_unmap_sg().
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Bharath Vedartham <linux.bhar@gmail.com>
> ---
>  drivers/staging/kpc2000/kpc_dma/fileops.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
> index b136353..bcce86c 100644
> --- a/drivers/staging/kpc2000/kpc_dma/fileops.c
> +++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
> @@ -214,13 +214,13 @@ void  transfer_complete_cb(struct aio_cb_data *acd, size_t xfr_count, u32 flags)
>         BUG_ON(!acd->ldev);
>         BUG_ON(!acd->ldev->pldev);
>
> +       dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
> +
>         for (i = 0 ; i < acd->page_count ; i++) {
>                 if (!PageReserved(acd->user_pages[i]))

Question -> is PageReserved() used with specific purpose not PageDirty() ??

> -                       set_page_dirty(acd->user_pages[i]);
> +                       set_page_dirty_lock(acd->user_pages[i]);
>         }
>
> -       dma_unmap_sg(&acd->ldev->pldev->dev, acd->sgt.sgl, acd->sgt.nents, acd->ldev->dir);
> -
>         for (i = 0 ; i < acd->page_count ; i++)
>                 put_page(acd->user_pages[i]);
>
> --
> 1.9.1
>
