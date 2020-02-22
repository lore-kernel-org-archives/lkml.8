Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1203C35671
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C711206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 17:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582394021;
	bh=YgKrm0xiETHM9Cmfn3YsYzVL6NnGHRbjPZ0LttoOZPs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GbaN8GfGMav4e6mgVEzvECow4mwO9KOWnh2QX0ThvheybU/WNW8vG3kspb8j7mH/2
	 BxRMmC/Phv2Lq6hD7emVVUydsBP/g+6QJgL05Vg4OvrjNEiOSYg/W+YxR1d18nJrli
	 RcLKtQf2V9BJC+vDy55j493Fl1qRWU5VRXwdLVCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgBVRxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 12:53:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbgBVRxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 12:53:38 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 919EC208C3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 17:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582394017;
        bh=YgKrm0xiETHM9Cmfn3YsYzVL6NnGHRbjPZ0LttoOZPs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WHBit2bA6T3EHwMhwqLDdrr2CZGcZ4tX4F/1r5Lyk9AQFzU/OqaIeMgyCzk97aE/7
         O6S595fJcXq5KtBCozs3jOWCnHfAra61DJEVNImt3IcPoHBp16EPEQ+CCjyiaNIa+j
         0fH3UOISh+mdmW2T186huegR4ms51t3JnWEZ/IrE=
Received: by mail-wr1-f45.google.com with SMTP id w12so5618161wrt.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 09:53:37 -0800 (PST)
X-Gm-Message-State: APjAAAUEoAD2Z+mdCSN7GWnx34gGaq3YrKMBn7og2HnWVp163ITi1cud
        wWfQycA1BsBB9AAwD/RO7Mc7b+OmDFFdn71RAASm5Q==
X-Google-Smtp-Source: APXvYqyWzaLbt4HYjpKwPlRQWQGBksiImz9hsJkpyk87ED2N2OOaMX24u0bAr90dNAd3Wc+csetD0svSTq78dij7MPk=
X-Received: by 2002:a5d:5188:: with SMTP id k8mr55791430wrv.151.1582394015897;
 Sat, 22 Feb 2020 09:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20200221191829.18149-1-xypron.glpk@gmx.de>
In-Reply-To: <20200221191829.18149-1-xypron.glpk@gmx.de>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Sat, 22 Feb 2020 18:53:25 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu_A1r7JYmUrgEyZjkiZam7oEB=rANuUiCfsFfkQAfxuCg@mail.gmail.com>
Message-ID: <CAKv+Gu_A1r7JYmUrgEyZjkiZam7oEB=rANuUiCfsFfkQAfxuCg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi/libstub: error message in handle_cmdline_files()
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 at 20:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> The memory for files is allocated not reallocated.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Queued in efi/next

Thanks,

> ---
>  drivers/firmware/efi/libstub/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
> index be78f64f8d80..d4c7e5f59d2c 100644
> --- a/drivers/firmware/efi/libstub/file.c
> +++ b/drivers/firmware/efi/libstub/file.c
> @@ -190,7 +190,7 @@ static efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
>                                                             &alloc_addr,
>                                                             hard_limit);
>                         if (status != EFI_SUCCESS) {
> -                               pr_efi_err("Failed to reallocate memory for files\n");
> +                               pr_efi_err("Failed to allocate memory for files\n");
>                                 goto err_close_file;
>                         }
>
> --
> 2.25.0
>
