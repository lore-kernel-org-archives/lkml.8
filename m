Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2B76C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1C63206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xrzSeApf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgAOMvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:51:55 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43662 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgAOMvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:51:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id a13so18406373ljm.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 04:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsr/oi2XrIAmmbP163wTd/MCf3p12+DUNarrq/kg9sg=;
        b=xrzSeApfEb6DAeNeLYgX7j/LWntJQinaR4oIz/1UnnXu31QZuRkQ52mokkML3w8Th9
         JVP9mym3jJOxZFbTcKpBGqRYr07Rpg9oPhhSDckVL4EsjgxxDh3/hXwjCGteoDMIefKA
         pGfIEuCLB/Df5dpac286FNC1PHf+NkSl4HINYNkXJoeMO1uHTz3tJDmGOEgQK7sWlVFT
         ZK1UkQu6k8Soyq9q4i3Tp0N1aKP6UvvuGZA1nesiRI8PNDriNECKpTDTkV+Fu4NA2NXU
         fRjEYbkMP1JDI+CdFPuSoCJYALL41ulOLRNW6lpUezYXwr3DYKnTfd5SOPcPXzBJFDnV
         cl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsr/oi2XrIAmmbP163wTd/MCf3p12+DUNarrq/kg9sg=;
        b=nfeVXlEQWz/t3x7Cj1M5ydjEEEsfEYhAJbehEyL3BSPBoOMR6oeboF8FpRd7hCbdZ8
         QqtcitPpreU4RYM7/rLO4yCG/QCjFywJnTsdP7xvMPbocKFwZgUJBtcq63fnj0YTqA58
         BSCDGQl+4ZI8jCM9qZfxvD79IYlZhC9n+Uv8UENpsMmhiWZdBs1j7wvNDXzoxg4Q61J2
         66Kzfg8cfC2GQbRnGm31Hq3hEro465F1F257U47AmkiDpaCoGG0y7pNHhaWJAks2iV4w
         BI3gavmGhmo0jV4dim9QNth/gCQMdCiHUk0PApfc+0SDJoP3l+PmiWkNwTkKHBZSJsnm
         axZA==
X-Gm-Message-State: APjAAAUZocLCot2wYaIbEQg8na5sDIQlfcTfHW9vzT77JnjESuhSMrvo
        6n4uGVyyUbLsOYPDUaermp45jKmzXNNrDHvxDiAXIw==
X-Google-Smtp-Source: APXvYqyPLiNMYFjq+10C4y9GPJ4omzojNt3A/uO0N7XjKPjzPb413C4mDt6k4ydemhY/RqaqtsTUqp4qjoKTT9DRbqA=
X-Received: by 2002:a05:651c:111c:: with SMTP id d28mr1762433ljo.32.1579092712068;
 Wed, 15 Jan 2020 04:51:52 -0800 (PST)
MIME-Version: 1.0
References: <20200109094001.24343-1-jay.xu@rock-chips.com> <20200113011616.19791-1-jay.xu@rock-chips.com>
In-Reply-To: <20200113011616.19791-1-jay.xu@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 13:51:40 +0100
Message-ID: <CACRpkdY_EHQbF4rRyGwoxEk8LeWfmRzmCd=8=SY95LPXMHYOmw@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl/rockchip: splite soc data to separated driver
To:     Jianqun Xu <jay.xu@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     David Wu <david.wu@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 2:16 AM Jianqun Xu <jay.xu@rock-chips.com> wrote:

> * Decrease codes of pinctrl-rockchip.c from 4,000 lines to 2000 by
> separating soc data to a new file.
>
> * Move rockchip pinctrl related struct definations to a head file.
>
> * Keep legency pinctrl-rockchip.c under driver/pinctrl but not to
> compile it, conveniently for reviewers.
>
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>

This patch looks good, two things are missing:

- Review from Heiko

- A change to MAINTAINERS so that the file pattern still
  matches

Should someone from Rockchip also sign up as comaintainer
for this driver by the way? (Though the people at Rockchip
posting patches for this seem to change a bit.)

Yours,
Linus Walleij
