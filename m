Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13CBC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A7A2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FUP49pW2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbgAOKZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:25:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37946 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgAOKZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:25:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so17950764ljh.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=eIMmN9FypxjNqmpeIFBlE1z4/mU3fOd3YNJQx4nSeTQ=;
        b=FUP49pW2W+3CTDREc02m6WvFNL9bp9CidBbIss1DBkvF6C7edTrt4tgHqQ+rCTuvFh
         2JwWlHDGLkyateSp4pRLnw3rQkGLCf40EjrO0mWcylUdMpWH1u0J38WwVd25NotK/sa/
         FlBVrBAj5To7L1Nnig91VjMLMn7rccdoj+vIfwQpoksmXAsfRaKjIGQTIa6epyasjfLy
         9yNrx7kHF6AWG576AaIDpFCjj1rpV+42haB6aNpj3hj0tQdJylgF3dnESy07xUKa6+D6
         Acv0MiG1zWbGVH9Sbg2og5fLa/BEAHEsz/gv2CpatUpAUNBYhv2SeJ9QhLXXZKRAzPtE
         ib3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=eIMmN9FypxjNqmpeIFBlE1z4/mU3fOd3YNJQx4nSeTQ=;
        b=PkvFY5s4nYMy5HsbZ+BNz8X6sr/hHkH5LaAK+0L9FqAKbTH9jzxLw70WiK1OIQ+GMr
         iZ6FXcUyJ/dgZ/SNgmcbVzhgfF4dSMeyjDZOMdQO4vxEgRUUqPdUybRG2JwYiYP+d0ic
         I73Kz6HxegrsV1H81efu2k8Ka+z5dTOSx9gtxtDfol+E1XsZLctWylb/Fxu5OUVqq7L/
         Hj93u+kn7sTAofhlrjd3OfrbWCFw42geCcJvlZiSKmpGdb2zqKWuT8Vdwd/oCkdRXgj0
         VCvCn1/nHE4xADeD5E3neCILV/Grk+e1OZa0fxBbSUqQ1bAdK4OpGd+JtnqF3Gwa88rh
         Xomg==
X-Gm-Message-State: APjAAAUv6wH79Vu+jLjSEXlh0wkI7D4BSoSSLtTIOv5LsOpKB6jYkqgM
        LBRhcpQtxBwtUq8LYx+g/OrMm2llO+vXuq3dfDeA7w==
X-Google-Smtp-Source: APXvYqzYC+eu0oRa36v1ki6wu6MdPaPpoxkLfIWQpqftXZ+1BuC8JAs7bz0oJooVKdJzWJ+V4rSKGroneRAPySFoQlA=
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr1349648ljg.168.1579083926262;
 Wed, 15 Jan 2020 02:25:26 -0800 (PST)
MIME-Version: 1.0
References: <1579009062-7154-1-git-send-email-zhangshaokun@hisilicon.com>
In-Reply-To: <1579009062-7154-1-git-send-email-zhangshaokun@hisilicon.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 11:25:15 +0100
Message-ID: <CACRpkdZQoc3O27enKiMPDCg_b9BL=+=kwK3jRYX14dMH-M2bxw@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: Remove the unused flags
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 2:38 PM Shaokun Zhang
<zhangshaokun@hisilicon.com> wrote:

> drivers/gpio/gpio-grgpio.c: In function =E2=80=98grgpio_remove=E2=80=99:
> drivers/gpio/gpio-grgpio.c:438:16: warning: unused variable =E2=80=98flag=
s=E2=80=99 [-Wunused-variable]
>   unsigned long flags;
>                  ^
> Fixes: 25d071b3f6db ("gpio: gpio-grgpio: fix possible sleep-in-atomic-con=
text bugs in grgpio_remove()")
> Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Patch applied with the ACKs!

Thanks!
Linus Walleij
