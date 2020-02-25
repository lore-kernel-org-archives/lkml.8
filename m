Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E66DDC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A74A0218AC
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 08:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="leF+SeHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgBYIWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 03:22:35 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40981 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgBYIWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 03:22:35 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so6502065pgf.8;
        Tue, 25 Feb 2020 00:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYvdy1dlyG33XXcH8cycU4rJytEQhmpUSBqvZa/d8dQ=;
        b=leF+SeHkU9KHPJujKtFktQqfyi7nBtzEEvxTt7zXhwN9GEl7gxArJzC/ba7zAve7/8
         r30o8coHvD1mIXbONeS2j2D0h+zKvU4JW6qe+OtCI2tJZc8qmIJwrHcd3UjnWxG+hk3a
         DJ8+hD+EKWTZbIrVA8xFCn+2WBAwGb9wVzeG4TxDsdMEJIzMlN3k8PmpoqzHv0n/5e4V
         Q/z9W3cjSfu0IR7RKuurJVTiF16/LZ+BDuvJUqSnA6tggZG1zQLMvNz9Ijzl6XJ9nzkf
         8/VOTUAGg9Mj8eC1zAXA1hgFkJH8q0QUsgKjLcOPdmSltABPbrivS3Z6tU6SQPzWWAIG
         rQWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYvdy1dlyG33XXcH8cycU4rJytEQhmpUSBqvZa/d8dQ=;
        b=c/2OMqgjnmMzFEwZMIRN6pZM2ZTfxIgyalI4OmR7AVf0LlR2o5E+n0lHtzYxzicZl0
         N5nqJ72NzLXAzuAO+nzaJMC7CGb8SLfTcmqTClwcwzlV/UIHUGZDUsHWl8RZLtKaGbB0
         0z5M/YabUlCgdwq3pdACR7kDKQIyk61ENqBw5zXSqii8ulEnN5vDBJ7UhzZf3uTFoA/R
         qh/4RqOUkDkTawNMvHBccS9q/2ouZtKxdYlRiB9EpCOKmJ7L9+fUrsRf0N1v1BuoMl/7
         KvEkM4PwdJD3dmSteDTnpBkVZiDNV7a7ZSyOFxmK3hhnVE71Vakkb3K7UP2m5ijoqA88
         LsAw==
X-Gm-Message-State: APjAAAVfDAjQzTMfMYMz+KgJjSunBtpK3czutRRFQ26za0W5whHRd6bT
        +CMrHpinvtCywVVSNrqoCKF5WDaPmAQm9M3Wt8c=
X-Google-Smtp-Source: APXvYqx4fDstjE6svyQGrI6q6r4kT9nzOqn1UVbhnEtq+Pn6utzOkdfpkg0toXU8mnGTj66irjefgr/49LcAJA8yFY0=
X-Received: by 2002:a65:6459:: with SMTP id s25mr22565585pgv.74.1582618954453;
 Tue, 25 Feb 2020 00:22:34 -0800 (PST)
MIME-Version: 1.0
References: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
In-Reply-To: <1582498270-50674-1-git-send-email-schaecsn@gmx.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 25 Feb 2020 10:22:23 +0200
Message-ID: <CAHp75Veoj8ZpqAoGGAphjPQDn0i+5c_WS3U+mRMiinCuK0YBYQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] i2c: imc: Add support for Intel iMC SMBus host controller.
To:     Stefan Schaeckeler <schaecsn@gmx.net>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:54 AM Stefan Schaeckeler <schaecsn@gmx.net> wrote:
>
> This patch is based on Andy Lutomirski's iMC SMBus driver patch-set
> https://lkml.org/lkml/2016/4/28/926. It never made it into the kernel. I hope
> this rewrite will:

Thanks for the patch!
I'll review the code later.

I think the better to have a documentation file where you describe
stuff like enumeration and so on for this drivers (under Documentation
folder).

> Stefan Schaeckeler (1):
>   i2c: imc: Add support for Intel iMC SMBus host controller.
>
>  MAINTAINERS                  |   5 +
>  drivers/i2c/busses/Kconfig   |  15 ++
>  drivers/i2c/busses/Makefile  |   1 +
>  drivers/i2c/busses/i2c-imc.c | 515 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 536 insertions(+)
>  create mode 100644 drivers/i2c/busses/i2c-imc.c
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
