Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62678C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317EB2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NXWKXJ6G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgGJS0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJSZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:25:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1204DC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:25:59 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z17so5367337edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mxvJ+Fty4K+1j3Y1eh6Bkx0XaBM+d2fy42IQC4UlRuo=;
        b=NXWKXJ6GQCKHQi13Z7gjc88eeS0hvvz4tGk2iYMcV5QSgNUJNYTnmS7BTx0yqrNtsz
         SFUJc1wRLVwL2p3HNbsfUm1WbLedW+TT+PyxxvwRydpPFVDDdOKPgKD0UySUkBqJrz5O
         bQrGlYWFWDaiujnsTzPboDZpoTdVs7RiQSGNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mxvJ+Fty4K+1j3Y1eh6Bkx0XaBM+d2fy42IQC4UlRuo=;
        b=MZORuV9KYg0pzDIEYeOynpSk4yCnYof4O2IyPgKa4Yko9FbgX0rg7gLiz3Do+VCII6
         ko83xJxj+EL8ZtIE3zbrFmkastigAlT/cI9gSVl26Oes4MHUYp12XdCBEiH2idAz9Y9z
         c15jJPiWteAiDpFQ9Gv4WfQ+FWxPheSDAW+Ok7QYiw51WQM7oGAw6RsBA8NglKwmsx0i
         Z2aZQA6cTKTb4WbhQyA5J5QeEMWNTjCWJDcAloHc3t7ufAj90jwbw/f+ZWeZP7klNfdI
         E7TXPAsyAMK+crCpxKoMovJQSG3KmdYrfwzB9GyRfXFwA1RtY9+SJ6XToToZ4NJFUEjB
         HD2Q==
X-Gm-Message-State: AOAM531deAnfOOmBYM3I0lWth7Vqrw4Oggf/vvnPXo/+lpyqAyhslasp
        HoefC+S7g7iiZqXaTHQ510kq43tIhu8=
X-Google-Smtp-Source: ABdhPJxsGAXlzB/A8ePob32XWMtDYaq14NPcBRvYeMjZ7EczPxbgrw5SoiGXlZl0Xir6LdVh+YUuHw==
X-Received: by 2002:a50:9f6a:: with SMTP id b97mr76752417edf.322.1594405557473;
        Fri, 10 Jul 2020 11:25:57 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id gu15sm4089614ejb.111.2020.07.10.11.25.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 11:25:56 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id w16so7114882ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 11:25:56 -0700 (PDT)
X-Received: by 2002:a17:906:c04d:: with SMTP id bm13mr53490468ejb.321.1594405555807;
 Fri, 10 Jul 2020 11:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200710002209.6757-1-apronin@chromium.org> <20200710114000.GD2614@linux.intel.com>
In-Reply-To: <20200710114000.GD2614@linux.intel.com>
From:   Andrey Pronin <apronin@chromium.org>
Date:   Fri, 10 Jul 2020 11:25:44 -0700
X-Gmail-Original-Message-ID: <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
Message-ID: <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 4:40 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jul 09, 2020 at 05:22:09PM -0700, Andrey Pronin wrote:
> > This patch prevents NULL dereferencing when using chip->ops while
> > sending TPM2_Shutdown command if both tpm_class_shutdown handler and
> > tpm_del_char_device are called during system shutdown.
> >
> > Both these handlers set chip->ops to NULL but don't check if it's
> > already NULL when they are called before using it.
> >
> > This issue was revealed in Chrome OS after a recent set of changes
> > to the unregister order for spi controllers, such as:
> >   b4c6230bb0ba spi: Fix controller unregister order
> >   f40913d2dca1 spi: pxa2xx: Fix controller unregister order
> > and similar for other controllers.
>
> I'm not sure I fully understand the scenario. When does thi happen?

This happens during system shutdown.
Here a sample stack trace from the panic:

BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
...
Call Trace:
 tpm_transmit_cmd+0x21/0x7f
 tpm2_shutdown+0x84/0xc6
 tpm_chip_unregister+0xa2/0xb9
 cr50_spi_remove+0x19/0x26
 spi_drv_remove+0x2a/0x42
 device_release_driver_internal+0x123/0x1ec
 bus_remove_device+0xe8/0x111
 device_del+0x1bf/0x319
 ? spi_unregister_controller+0xfc/0xfc
 device_unregister+0x12/0x28
 __unregister+0xe/0x12
 device_for_each_child+0x79/0xb8
 spi_unregister_controller+0x27/0xfc
 pxa2xx_spi_remove+0x45/0xb4
 device_shutdown+0x181/0x1d3
 kernel_restart+0x12/0x56
 SyS_reboot+0x16a/0x1e7
 do_syscall_64+0x6b/0xf7
 entry_SYSCALL_64_after_hwframe+0x41/0xa6

> Why does not tpm_del_char_device need this?

"Not" is a typo in the sentence above, right? tpm_del_char_device *does*
need the fix. When tpm_class_shutdown is called it sets chip->ops to
NULL. If tpm_del_char_device is called after that, it doesn't check if
chip->ops is NULL (normal kernel API and char device API calls go
through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
call tpm2_shutdown(), which tries sending the command and dereferences
chip->ops.

> The changes listed tell
> me nothing. Why they have this effect?

"spi: pxa2xx: Fix controller unregister order" adds a spi_unregister_controller
call to pxa2xx_spi_remove, which internally calls tpm_del_char_device, which
results in the stack trace leading to the panic above.

>
> I'm just trying to understand whether this could be a regression or
> not.
>
> I neither understand what you mean by "and similar for other
> controllers."

There was a series of spi unregister order changes for various
spi controllers, including the following:
1c6221b430a0 spi: bcm2835: Fix controller unregister order
f40913d2dca1 spi: pxa2xx: Fix controller unregister order
b4c6230bb0ba spi: Fix controller unregister order
54000d2e15e9 spi: dw: Fix controller unregister order
c8f309db490e spi: bcm2835aux: Fix controller unregister order

>
> NAK for the reason that I don't understand what I'm merging.
>
> /Jarkko
>
> >
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > ---
> >  drivers/char/tpm/tpm-chip.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 8c77e88012e9..a410ca40a3c5 100644
> > --- a/drivers/char/tpm/tpm-chip.c
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -296,7 +296,7 @@ static int tpm_class_shutdown(struct device *dev)
> >       struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
> >
> >       down_write(&chip->ops_sem);
> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >               if (!tpm_chip_start(chip)) {
> >                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> >                       tpm_chip_stop(chip);
> > @@ -479,7 +479,7 @@ static void tpm_del_char_device(struct tpm_chip *chip)
> >
> >       /* Make the driver uncallable. */
> >       down_write(&chip->ops_sem);
> > -     if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> > +     if (chip->ops && (chip->flags & TPM_CHIP_FLAG_TPM2)) {
> >               if (!tpm_chip_start(chip)) {
> >                       tpm2_shutdown(chip, TPM2_SU_CLEAR);
> >                       tpm_chip_stop(chip);
> > --
> > 2.25.1
> >



-- 
Andrey
