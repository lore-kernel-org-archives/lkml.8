Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C79CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022FE2053B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 16:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="lIGU5Nix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgFDQXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 12:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729540AbgFDQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 12:23:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F254C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:23:00 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id w3so6614245qkb.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nqdDkPxs64ydqRZazVkSDcMKoD2Di9Ao1rMLrjlRa40=;
        b=lIGU5Nixoiwye1ScjlGD3/K2YeYoQabVSjX04sSyQxDyvPaxKRT8TJj3xMOoOYk6yI
         81H5zLY2Bw16UbLU9Yg92hwWYnsCfRzMIYUvDKcVdQfkH+neTuaT7i3zrYwt023gjKHz
         YU2+uHXxTJaaQJ2Z7cgPvgNKV3LwmHsAWgog29FTR3ZQVbPOrfpqxElHvLq+VuIup8h+
         D95gQsIz3GGBSMcA+AkXywLvMguY0E5nHWqPAG8nzYOkrfT2h/0Vw9E/b7dn+QzLET2k
         egVe7UAUsf2Qn1efCfL6k9n2r2gtOV30t0i3RBkkp/qFnDkFXrbWLMUZA5YTP6fwumI+
         L+Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nqdDkPxs64ydqRZazVkSDcMKoD2Di9Ao1rMLrjlRa40=;
        b=hSuvLKRwS82Xh1bZC0zZf60qwCicaOKzxS56Xs29NBy2ZEvO33ToGDHYAnV+EkYrjg
         9iwol/5DSsj+H0B/eqZVW4AzTRCuy1Kmz3xeVcSbj6R0XMpvMieDZSNpcheEiV3fu8TB
         uhiLkq+t5gPO2BDMdHz9dQlaMCiZUEe3Vcp2rrMlYXiZ1nRmu1Au9RSmqfND+BeGJ0VW
         KEtTttsSulwa944XDMtf313DexnwHAD9pYJISfQupgeo/zdzgxMLbt0fJxdHmWzj3bQC
         GA7zFsl/QLaEwu1AdWj6G0SrmOXLvheLwb5f28Cw+Zl3qu+82iVELqa8unKPjaXAm8Xd
         or7A==
X-Gm-Message-State: AOAM533JTRrsqRpMwYj1MkMDCkQfVD2vLKHKt2ZwTIJ/87t5wUSWUAEQ
        0xvdaeoCDixxVSIqIS5is3US4HxhLyWUiBr8qUbwWsw1
X-Google-Smtp-Source: ABdhPJy4d7VT76E7k/ybcQ/SJ9K8NuFI9ReH3yPrZWlYI9gyMK/Mv0CjdvOtx3sY+E7UfFZlglY0CFoFUiaU4uJE7wU=
X-Received: by 2002:a37:5b47:: with SMTP id p68mr5596853qkb.120.1591287774973;
 Thu, 04 Jun 2020 09:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200602141048.1995-1-warthog618@gmail.com> <CAMpxmJUjYn5SHg3BpCeKbYc_OpCjd8d943yfYL_TF15wyTenfA@mail.gmail.com>
 <20200604141804.GA5050@sol>
In-Reply-To: <20200604141804.GA5050@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 4 Jun 2020 18:22:43 +0200
Message-ID: <CAMpxmJXyVO4unLQOzC0xf47CTmK6VurTk+Q=9RDWhcP0pu73pQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpiolib: split character device into gpiolib-cdev
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 4 cze 2020 o 16:18 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>
> >
> > Is this comment relevant for the character device?
> >
>
> True - that comment should stay in gpiolib, and gpiolib-cdev should get
> one of it's own.
>
> Any suggestions on how to maintain line history?
> I know you can trick git by moving the original file into two new ones,
> then moving one of those back to the old name, but not sure if that is
> what you would want to see in a patch.
>

People don't seem to care much about this in the kernel. Files get
moved and git blame results get lost all the time. Don't stress about
it.

Bart
