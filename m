Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13503C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F76622B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Bn0GSK1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgHDHCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDHCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:02:45 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08AFC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:02:44 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id bo3so18604391ejb.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=CxNe4ekXK41HFrNyZNvqPeZW/VoZh3/7r8r8cDnp0R8=;
        b=Bn0GSK1XcbmY+FoSvGDiUY7XGgREUzvTuUFPwbE1eFIhb6ly7cFu8zM613uRg92vWu
         HNr4+C4pEMDykrOfkOQmA1poSdBsVMiD0mkRbZXk+ADcW7ESiw/0YOWf/7uieZo3Uq93
         +ljUpnJl8Aa2tf/CyU8LvMEE7bTnbDgOE94RU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CxNe4ekXK41HFrNyZNvqPeZW/VoZh3/7r8r8cDnp0R8=;
        b=gpmUVN8zoh17Tyr5ytWQeToXEGwQ9+HKCowmV2vPohvZIt+j0f06zf02eOraLwf+ON
         qMMFSuCezZ8K7qIXkJko3cWIp8JwMCrjwmxkbD2/V2Up8N4lYIgGVVH4KsYN6OLqevPH
         p89yVmjXlXStzpHkSGlaivIczRQLueiYY6qbvT2A2V8DIBKBEt+5Cnfx1QcD4mjgFd5m
         OvnG855v9xxy8sRoSYDBDMQeVsSbqQUV8hOYFnW8rKILvByWTeAlQQvK5GVxd1xu8ICC
         QO90ePu+ywMPHrn8T+s+rZ25yf6zs+/uDQCMhq1FqUmkxVYiY41RYZrKynPwVPDbidpu
         Tjdg==
X-Gm-Message-State: AOAM532zy3y5owO7/NcpAudfrBk7YDQaA0Z065knCc8cYTP7CEMCYk/k
        Y2LbSiCeGJ+BLT/eJeGNTyPfAxSSYmz33zu0+jk=
X-Google-Smtp-Source: ABdhPJyJwXFz9Q1N+i2iFCmBib0OII/RMvUKVgX86nV1xasykdNKD2DUbvo6UjX0XcATxyxY2TUlzLpWZ2XenUTauHc=
X-Received: by 2002:a17:906:1ed3:: with SMTP id m19mr19155545ejj.396.1596524563420;
 Tue, 04 Aug 2020 00:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a1vFJ+uUGPGifZGhECXvxA=2u745WrGNZb08s1nHkZQ9g@mail.gmail.com>
 <CAK8P3a2B5cxE512R0-ni6BJOnkgR7kGueqd3AU9E2PXh0unsmg@mail.gmail.com>
In-Reply-To: <CAK8P3a2B5cxE512R0-ni6BJOnkgR7kGueqd3AU9E2PXh0unsmg@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Tue, 4 Aug 2020 07:02:31 +0000
Message-ID: <CACPK8Xd++ZQx9hh21dV6qn73aoWvoFsOHq8Pmgbtpi-GD3ShmA@mail.gmail.com>
Subject: Re: [GIT PULL 3/5] ARM: SoC changes for v5.9
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 at 21:49, Arnd Bergmann <arnd@arndb.de> wrote:
> ARM: SoC changes for v5.9

> Andy Shevchenko (1):
>       ARM: orion/gpio: Make use of for_each_requested_gpio()

This change broke the arm build (I noticed it when building multi_v5_defcon=
fig):

../arch/arm/plat-orion/gpio.c:457:2: error: implicit declaration of
function =E2=80=98for_each_requested_gpio=E2=80=99
[-Werror=3Dimplicit-function-declaration]
  457 |  for_each_requested_gpio(chip, i, label) {
      |  ^~~~~~~~~~~~~~~~~~~~~~~

for_each_requested_gpio isn't in Linus (Torvalds) tree yet. It will be
fixed when he pulls Linus Walleij's GPIO tree which has the commit:

 b3337eb24831 gpiolib: Introduce for_each_requested_gpio_in_range() macro

Cheers,

Joel
