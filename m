Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4261C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FD62076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEK4FfTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729905AbgHDHeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgHDHeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:34:06 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAE8C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:34:06 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id s26so19712235pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TfBl+J2iXjMzFAopD5gkMIMeSmOz+Z6N1I26aht09N0=;
        b=aEK4FfTNSDXlMbVvO+yp/XUnyL1QHwny3dnDRDqHCiVsIMycmzAuXrzHXZZDtWrhzO
         bL8btbiOqiAjTRU8aSKmcvgxlTRdDa+2t1YIG+2vbI11LldiI2kqG3ZuuR4FUWEoGSsW
         A1BJtaPMV55OCU5Sd13Mo5bply9QUKYL2Ahw9/B38GdCs40wQdffxYI08cg+ur1xBf5o
         dBMmBAorwppbPoLI3++rcA3JaetmaoRm2QJlSeuuSrZXY1jc4LsPAMeQIF7zkB5ZtTHk
         HO1Eh/EjIRzQnkuVrtP6ZoFDBp5NKrkW1Rx9xgrMj/chpo6hvqOjzUNdbVSykJBAFKBG
         vP3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TfBl+J2iXjMzFAopD5gkMIMeSmOz+Z6N1I26aht09N0=;
        b=h61Uc0J9oR+kuhJ8VcApM8cm/6o5cTYRQqgihmZ9HtYd+wQmGYRZiN7fNDxoxvzqLQ
         eZHnzTMuLvFpCZtli4c7pBpc8z2ZjSUQ6GEM+kjrqVX9QqCFdHxjythsJGlJbsMpVZJ9
         oM0GCfOFeNVNWpiK4eyXAOh1wBmgkXNwqaGoz2a04Jbf46aGfPh/84XUbs6JRjcXXA6N
         9yjIPmtgSfl0z40zojeen11EBpZNCe7gjE67D4Za3bJWcrWR2kHeFFEWhw4dIgOEcst4
         7WiuKVTw9JXXV7zd/INPllrDLYWYfmeR8Fq9OArkCmMh75YYcjNqhFVfvjPh/ePemaG2
         ao3A==
X-Gm-Message-State: AOAM533W27L3iXtRYtnj8eRO161lokXMM/7qZlmUyDUDT9ehOkA+LNi4
        ztR1whclDL+oFWMPAAEs5cB383ya8jcW/zz1+oM=
X-Google-Smtp-Source: ABdhPJyncNf7b6yVKptzBJjBmiCFWlbUTXJ9IKQ8dwvGryY3eRoWsNxFfBFJuuhUaYMbrbjrKw48+FWtqelaJG1xu00=
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr18680755pfc.130.1596526446246;
 Tue, 04 Aug 2020 00:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <CAK8P3a2B5cxE512R0-ni6BJOnkgR7kGueqd3AU9E2PXh0unsmg@mail.gmail.com> <CACPK8Xd++ZQx9hh21dV6qn73aoWvoFsOHq8Pmgbtpi-GD3ShmA@mail.gmail.com>
In-Reply-To: <CACPK8Xd++ZQx9hh21dV6qn73aoWvoFsOHq8Pmgbtpi-GD3ShmA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 Aug 2020 10:33:49 +0300
Message-ID: <CAHp75Vc8yXqCsZ79=YWZLJ3ObgA1AYLj0eqqK0e8sXvMWsf+Hg@mail.gmail.com>
Subject: Re: [GIT PULL 3/5] ARM: SoC changes for v5.9
To:     Joel Stanley <joel@jms.id.au>
List-Id: <soc.lore.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 10:02 AM Joel Stanley <joel@jms.id.au> wrote:
>
> On Mon, 3 Aug 2020 at 21:49, Arnd Bergmann <arnd@arndb.de> wrote:
> > ARM: SoC changes for v5.9
>
> > Andy Shevchenko (1):
> >       ARM: orion/gpio: Make use of for_each_requested_gpio()
>
> This change broke the arm build (I noticed it when building multi_v5_defc=
onfig):
>
> ../arch/arm/plat-orion/gpio.c:457:2: error: implicit declaration of
> function =E2=80=98for_each_requested_gpio=E2=80=99
> [-Werror=3Dimplicit-function-declaration]
>   457 |  for_each_requested_gpio(chip, i, label) {
>       |  ^~~~~~~~~~~~~~~~~~~~~~~
>
> for_each_requested_gpio isn't in Linus (Torvalds) tree yet. It will be
> fixed when he pulls Linus Walleij's GPIO tree which has the commit:
>
>  b3337eb24831 gpiolib: Introduce for_each_requested_gpio_in_range() macro

Linus W. specifically created an immutable branch [1] for this.
And I think I commented somewhere that entire branch should be pulled.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/=
log/?h=3Dib-for-each-requested


--=20
With Best Regards,
Andy Shevchenko
