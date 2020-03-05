Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4186EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13CAB20637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 16:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="XTQub9Ny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEQtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 11:49:41 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:38480 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgCEQtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 11:49:41 -0500
Received: by mail-io1-f66.google.com with SMTP id s24so7209158iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 08:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ELgp0+Vv43PvFwuT066GFbqjurDJh9gYaZikvQZEjzk=;
        b=XTQub9NyfCXzfsgvbIgQ3rjnqhlldYIyaVZ+MrBR5Y0gzxPQYE7PN/wlFUF1+VG+ci
         rmIdks6AeyN1FJyFvQfmMzygYaNGZoAHH0nibgS0SAZshOiRKpMdWR7BiCf5NNdyv1hL
         ZfrT117rZvbOsfbyzqLZHJfydNZtgAiYUmMs4JX8mNpLzxtbjUe5Y76mvTbSjU3XPFnY
         JouvIaWuOteSR2WlCboJXD9qXAQo6JaTCxYfEGgWH/1l1kNeA1kkrMy/V2I/kWNCqGMA
         5zFjUAJCF5smnlLvORkZDipt/p6dmoiTBuXLmRYciH36ortQ2h9MglbcnsCLOZAFsNB2
         MUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ELgp0+Vv43PvFwuT066GFbqjurDJh9gYaZikvQZEjzk=;
        b=TIzM82XElp8yteIZrz5Co+h5OorWW3AnyDwqjwibqEuKdbArmcPFVqulu2gPM7sajG
         gEcm3Yh0IL4dK1rXbkOJNNT2fMTceQ2owpkiZ4CBhhT6L6yLm7JTvc6fnyZGT1gPKICM
         qTbwyFq1lChzSypzVydMsI+CYjRZZXGlT18HHV/5s7EbGi7ZOaCxVu/S0e4KCdlQmVUt
         QG7fpyJ1A5J5KV5FKnFLpLQZa8eJdvdLPColmkao9Z1HN1b9ZLXLguFg+3FTU326hHTQ
         wyCJkdxcdegdPk8cjv4TO+6uzLf8vgycg8O48mNIs3+2iCiZZp5wxJNsfiGNb9upd6fg
         X0lA==
X-Gm-Message-State: ANhLgQ3/iLu6x0xooOsRxVYU8oy3mwFa1ukMaaGx59kmjZPA3LnAgQNJ
        So0yav91pa05KnNLddoGV5eahjUQdfRT4GhJIegoBw==
X-Google-Smtp-Source: ADFU+vvzrUvKBCm/F735xdH6v0/qAZSe9OHz1wp2FJZxfMJIfBzy4XqfCG30OLuLV889Z7fadhympU7j9ak0gBoQMZM=
X-Received: by 2002:a6b:3e07:: with SMTP id l7mr7197755ioa.287.1583426979686;
 Thu, 05 Mar 2020 08:49:39 -0800 (PST)
MIME-Version: 1.0
References: <20200224094158.28761-1-brgl@bgdev.pl> <20200224094158.28761-3-brgl@bgdev.pl>
In-Reply-To: <20200224094158.28761-3-brgl@bgdev.pl>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 5 Mar 2020 17:49:28 +0100
Message-ID: <CAMRc=MdbvwQ3Exa2gmY-J0p8UeB-_dKrgqHEBo=S08yU4Uth=A@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpiolib: use kref in gpio_desc
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Khouloud Touil <ktouil@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 24 lut 2020 o 10:42 Bartosz Golaszewski <brgl@bgdev.pl> napisa=C5=82(=
a):
>
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>
> GPIO descriptors are freed by consumers using gpiod_put(). The name of
> this function suggests some reference counting is going on but it's not
> true.
>
> Use kref to actually introduce reference counting for gpio_desc objects.
> Add a corresponding gpiod_get() helper for increasing the reference count=
.
>
> This doesn't change anything for already existing (correct) drivers but
> allows us to keep track of GPIO descs used by multiple users.
>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Linus,

This is in response to your suggestion under the previous version of this p=
atch.

I refreshed my memory on device links and reference counting. I think
that device links are not the right tool for the problem I'm trying to
solve. You're right on the other hand about the need for reference
counting of gpiochip devices. Right now if we remove the chip with
GPIOs still requested the only thing that happens is a big splat:
"REMOVING GPIOCHIP WITH GPIOS STILL REQUESTED".

We should probably have a kref on the gpiochip structure which would
be set to 1 when registering the chip, increased and decreased on
every operation such as requesting and releasing a GPIO respectively
and decreased by gpiochip_remove() too. That way if we call
gpiochip_remove() while some users are still holding GPIO descriptors
then the only thing that happens is: the reference count for this
gpiochip is decreased. Once the final consumer calls the appropriate
release routine and the reference count goes to 0, we'd call the
actual gpiochip release code. This is similar to what the clock
framework does IIRC.

This patch however addresses a different issue: I'd like to add
reference counting to descriptors associated with GPIOs requested by
consumers. The kref release function would not trigger a destruction
of the gpiochip - just releasing of the requested GPIO. In this
particular use-case: we can pass an already requested GPIO descriptor
to nvmem. I'd like the nvmem framework to be able to reference it and
then drop the reference once it's done with the line, so that the life
of this resource is not controlled only by the entity that initially
requested it.

In other words: we could use two kref objects: one for the gpiochip
and one for GPIO descriptors.

I hope that makes it more clear.

Best regards,
Bartosz
