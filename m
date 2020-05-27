Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01302C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F7C208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590595043;
	bh=6cRSjMiuKO7I5Toxo4IYbN7wvX7lkzCuWoxBX5GeODE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q2dPS0zwMu4StfFgSerD0pIEj59TnsdfuO0zhMZvb5WYjqT5/PgRGaeVxb/YrJD8B
	 /mU8fsfG+2Bten0wHHchFhPSFwM8VI62jIPVgGU4sMfglNkiiChHSblrCDCE/WGlKl
	 34Q7nJnrnFl/XPRk15CSrXlcfQh/10PYpTbd+DGM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390106AbgE0P5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:57:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44797 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730921AbgE0P5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:57:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id f18so19529384otq.11;
        Wed, 27 May 2020 08:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHXnsm9FgPRIvAJXm9vXdaP6dHYEAo0qih1OcX3Oy5Q=;
        b=tlcJYixA4V6MbXZbgQdShQ7bSJiIhPUh+kuq0hftpR2bMDS+T6l8ZXYwVSsN3CGX62
         2sNIojm/gT7G/78VGzSUSZGxMgpMBBj8oH8uYOgqSAICIJ9/CkatNo7iNGg783l7F+8u
         yn+J+9f/4rwR8LgUWdkg/2Qbgy1vVsQ6x5T76Z3C5c890lgbC7lThRGwClWEF+qzh3Dk
         AArGfWmVHbLls82YoI2OcBuX8Z2W6+xPXZA0AgA8LK5R12M37yxa1RSW6ju+KhfR+xhE
         UOK4max0syMqKn4NLRtK500nLsUIPsbPOObboNkBZpKUDNAZwxs9nfm9X10DCC9ZBXJK
         wPgQ==
X-Gm-Message-State: AOAM53261SNWJtirUYOmlCSkWQAeXcmdynhOOJ0m2YAxwzY8/XoAL7Y/
        8Ff6R5TH4diHWABmZAAUMVSmO7eTRetm/pEdQj4=
X-Google-Smtp-Source: ABdhPJwkP+hoFNQs/+ZP0moiGYxQtu0ohqp5UBCeH+ouDHvfNaOpL1CG4pf4SgqPt6RFs2DR/IW7QpMqt0HkpTp1Zfc=
X-Received: by 2002:a9d:3d05:: with SMTP id a5mr5174224otc.262.1590595033025;
 Wed, 27 May 2020 08:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200527113700.3579-1-ardb@kernel.org>
In-Reply-To: <20200527113700.3579-1-ardb@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 27 May 2020 17:57:02 +0200
Message-ID: <CAJZ5v0g_pHDN9iZP-pvcNZm6aZdkRkxgWfUmiXy7wtzCinf0EA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: GED: use correct trigger type field in _Exx / _Lxx handling
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 1:37 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Commit ea6f3af4c5e63f69 ("ACPI: GED: add support for _Exx / _Lxx handler
> methods") added a reference to the 'triggering' field of either the
> normal or the extended ACPI IRQ resource struct, but inadvertently used
> the wrong pointer in the latter case. Note that both pointers refer to the
> same union, and the 'triggering' field appears at the same offset in both
> struct types, so it currently happens to work by accident. But let's fix
> it nonetheless
>
> Fixes: ea6f3af4c5e63f69 ("ACPI: GED: add support for _Exx / _Lxx handler methods")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/acpi/evged.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/evged.c b/drivers/acpi/evged.c
> index 6d7a522952bf..ccd900690b6f 100644
> --- a/drivers/acpi/evged.c
> +++ b/drivers/acpi/evged.c
> @@ -94,7 +94,7 @@ static acpi_status acpi_ged_request_interrupt(struct acpi_resource *ares,
>                 trigger = p->triggering;
>         } else {
>                 gsi = pext->interrupts[0];
> -               trigger = p->triggering;
> +               trigger = pext->triggering;
>         }
>
>         irq = r.start;
> --

Applied, thanks!
