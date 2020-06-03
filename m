Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195E9C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 04:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6A772067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 04:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HDw5vz+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgFCEt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 00:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCEtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 00:49:25 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C25C05BD43
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 21:49:25 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id e125so466014lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 21:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9jneiIwhoTeX6/+oub23nloy5lCEM9fcOmaGR+FZzuQ=;
        b=HDw5vz+XXOVCtGvAKqFpoiuh+xys7OQHwn8q7cgtFrTWNO4on7NiHA2zOuapDLNoz1
         mDjMgphgtHbSP+nPF6r6uNuocnnul07gWzdPZKg8yeOA8I508mvPIQ38+zRSc5SMYV0k
         LCLxIsWN+n/GGOfSfY5u0ym046F9u1c1xzXxnkhmoYwjaBy/1gne1+eKYdxy0rdYn/z+
         yKwRLF9QzeGTweMPvwYCYmuUGONixe9NYeKX0NVITwGONe0hYXYj3JWcqnvtiGoBJ2Zl
         vssvHbI8KPS+mkk++mT+d5ETK3QPsoo5iSuEFm6Fatte6kJ6KlrunflI9hESwsSrrtqF
         lKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9jneiIwhoTeX6/+oub23nloy5lCEM9fcOmaGR+FZzuQ=;
        b=HbAj8EpDO8C7zsZG/x4MOvXpTK/KZ9UG3ApY5A7CbWHd2tR1VKmOcKc1GNEV4cyIlj
         T+qRQRgppLfGpI64NIYfLvH9J3XwMcHRGrDGQmXnZ/hzI4YStxbU1XEJ9tAWEaeuDQYU
         kGpAQGx3KZJRWJRHF01gE/NzBfJNhdRoAeJsMNvTIqlg9Yvl0r8c5Tv3WozIxL0xnk0O
         MoPCa4iYUbzTpcmtPCBqPCy/tO5msUWKONyG5i7/nJlghp4c3bU6wNTUqR+gV8zyHDrS
         IWyBhyMKmWnbh2mdCqI8oGaupM64gTmfcmKnH6gRBW1/EolSjjJ882IbEk2QYOz6cirI
         g2ew==
X-Gm-Message-State: AOAM532sONMJg3VmygnUr5V4oVLl0rRNBmI8iBiqiChO6cZrxmXniYzV
        R+k78WimD4PRGYGSbgE1Vs2Yo0fL7625dI2LsgQCUw==
X-Google-Smtp-Source: ABdhPJwDORogO1WFt2x81Zb6ZMcF+AGvh9D4jM0Bn9dfTEjME8ZsO1znUus+MzGiFrlhO1QElJ13xWV61TV6zvjE0M4=
X-Received: by 2002:ac2:44c1:: with SMTP id d1mr1384141lfm.37.1591159763530;
 Tue, 02 Jun 2020 21:49:23 -0700 (PDT)
MIME-Version: 1.0
References: <1590751607-29676-1-git-send-email-sumit.garg@linaro.org>
 <1590751607-29676-5-git-send-email-sumit.garg@linaro.org> <CAD=FV=WZwUx0SKO96g6vqh3qgwq5xeaAOoT-Qgx3JnEB3c1AkQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WZwUx0SKO96g6vqh3qgwq5xeaAOoT-Qgx3JnEB3c1AkQ@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Jun 2020 10:19:11 +0530
Message-ID: <CAFA6WYPfxMtykUES3MqhK++WC7EkfDdQRbMPsoEqPcdx41O6jA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] kdb: Switch to use safer dbg_io_ops over console APIs
To:     Doug Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Jason Wessel <jason.wessel@windriver.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 03:02, Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, May 29, 2020 at 4:27 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > In kgdb context, calling console handlers aren't safe due to locks used
> > in those handlers which could in turn lead to a deadlock. Although, using
> > oops_in_progress increases the chance to bypass locks in most console
> > handlers but it might not be sufficient enough in case a console uses
> > more locks (VT/TTY is good example).
> >
> > Currently when a driver provides both polling I/O and a console then kdb
> > will output using the console. We can increase robustness by using the
> > currently active polling I/O driver (which should be lockless) instead
> > of the corresponding console. For several common cases (e.g. an
> > embedded system with a single serial port that is used both for console
> > output and debugger I/O) this will result in no console handler being
> > used.
> >
> > In order to achieve this we need to reverse the order of preference to
> > use dbg_io_ops (uses polling I/O mode) over console APIs. So we just
> > store "struct console" that represents debugger I/O in dbg_io_ops and
> > while emitting kdb messages, skip console that matches dbg_io_ops
> > console in order to avoid duplicate messages. After this change,
> > "is_console" param becomes redundant and hence removed.
> >
> > Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  drivers/tty/serial/kgdb_nmi.c | 2 +-
> >  drivers/tty/serial/kgdboc.c   | 4 ++--
>
> I don't think this will compile against the "kgdboc_earlycon" patches
> that landed, will it?  Specifically when I apply your patch I still
> see "is_console" in:

Agree will fix this and rebase this patch-set onto Daniel's tree.

>
> static struct kgdb_io kgdboc_earlycon_io_ops = {
>   .name = "kgdboc_earlycon",
>   .read_char = kgdboc_earlycon_get_char,
>   .write_char = kgdboc_earlycon_put_char,
>   .pre_exception = kgdboc_earlycon_pre_exp_handler,
>   .deinit = kgdboc_earlycon_deinit,
>   .is_console = true,
> };
>
>
> > diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> > index b072aeb..bc0face3 100644
> > --- a/include/linux/kgdb.h
> > +++ b/include/linux/kgdb.h
> > @@ -273,8 +273,7 @@ struct kgdb_arch {
> >   * the I/O driver.
> >   * @post_exception: Pointer to a function that will do any cleanup work
> >   * for the I/O driver.
> > - * @is_console: 1 if the end device is a console 0 if the I/O device is
> > - * not a console
> > + * @cons: valid if the I/O device is a console.
>
> optional nit: add "; else NULL"
>

Okay.

>
> Other than that this looks great.  Feel free to add my Reviewed-by:
> tag once you've fixed the error that the bot found and resolved with
> kgdb_earlycon.
>

Thanks.

-Sumit

>
> -Doug
