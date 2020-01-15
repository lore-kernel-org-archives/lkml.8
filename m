Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D148BC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E1E4206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i0Kvn+Ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729684AbgAOKNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:13:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40147 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgAOKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:13:34 -0500
Received: by mail-lf1-f68.google.com with SMTP id i23so12235846lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vO4qe02zao/A+ruoIXV88YhdBiNPhMumkEGKgg4RymM=;
        b=i0Kvn+Ey9/+U8pQ6/uBTFMH5I8IA+l8DqIupDU57PCn5oW+xM8FTvK9P7H8tLqGF5D
         cRk7hsCmntfXi0iXXggSozStVld6pLWOkD2y/Yqs4VSnXLYA2zx4an1gTT/j/30F7Enm
         hMmu7rUyi/ywMOG/7JsdqwIpD1sGfVL2aN9EHANJ+yWlIKA6x3J+iuOFXzqAE1ziZWQS
         goLWInYuXbPP6FAUWz9ROEzeW9jgydpzRLd82aBT9AQSx2NvCpCSGbaJmJnk97vFA/s/
         mKm3nQBzK4XkJYSohl7AB6oERKp8mwXOFi9brhB15oJluvGQw+MUkEhLZdqD6EtMEO3x
         tQoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vO4qe02zao/A+ruoIXV88YhdBiNPhMumkEGKgg4RymM=;
        b=Zu5PTBMZjyNlufBMH0GgC9LyAOxncBq2pIKoXKM/7IQ1fQUV7jInqXY97aTPaiHw6u
         IY0Fmf0XDa1EkKSsFHNitxdUF38ju4pg/SWO7NaJxz9l1sEDhNS73cawu44EyE8vzRsI
         y69VzCYbVhV+YOpUuWfW6H4PYLE9s9obRXB1M4DeeJbTR1bOy77nIw7U49gQBYCSeDN8
         8ZaaUouMBKQ2nOWIJnGjyXC3GIuGi8z0t000lVg4L9esTzgT5B6PlT0QxuwBe2NcjghE
         wGcKXSEpDWtXrPDE9hg6NxNSeLT7traYKjp+ijC0YMmdVHlzNDMI4ovndjV8ULIujlwp
         Yi6Q==
X-Gm-Message-State: APjAAAUjIvxZiayDjEELd2W7Y6bSRRLosYJB7rGSXWrkerfsc4q6ZOm4
        hzCR1wvFs+x7Gve7kqMHUESnJAg88w89Ft2u/iK4/g==
X-Google-Smtp-Source: APXvYqyjpPJG2PlBkvker2pjrEMpaojUIm0M1qm4uQATc9Ei5oB+Qf3k1pXdKzW50LZY13BsnF1kUP4nXB8QRKn3Zq0=
X-Received: by 2002:ac2:465e:: with SMTP id s30mr4450440lfo.134.1579083211682;
 Wed, 15 Jan 2020 02:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20200110174426.5463-1-krzk@kernel.org>
In-Reply-To: <20200110174426.5463-1-krzk@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 11:13:20 +0100
Message-ID: <CACRpkdY+wC3xx9r-4rsCeV3xJQbDoV8u9+9UGJ_9Kg9Swn87jg@mail.gmail.com>
Subject: Re: [GIT PULL] pinctrl: samsung: Pull for v5.6
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 6:44 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The following changes since commit e42617b825f8073569da76dc4510bfa019b1c35a:
>
>   Linux 5.5-rc1 (2019-12-08 14:57:55 -0800)
>
> are available in the Git repository at:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git tags/samsung-pinctrl-5.6
>
> for you to fetch changes up to 225a2ec19aac426ef29f0e4accfc890c87d38bdc:
>
>   pinctrl: samsung: Fix missing OF and GPIOLIB dependency on S3C24xx and S3C64xx (2019-12-15 12:47:52 +0100)

Pulled in to my "devel" branch, thanks!

Yours,
Linus Walleij
