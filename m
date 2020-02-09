Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF59C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 11:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A1D420726
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 11:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="rBmlLjSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbgBILvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 06:51:31 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37553 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgBILvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 06:51:31 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so4488422ioc.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 03:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sq5R9ahAL9Mr9V6FJNbQb8e+IZHCcD5EZ44nzkpqzUA=;
        b=rBmlLjSw4cvzylmGQGaWwEK/M4bf4HUZwDR+vV13sy12Hys6anu+hkbf665TNop6k3
         4gtgDSnKuZ4q4IauPnGHzDtp4ciXm7AQz/jexGEeuHX/8aKtrKCh9lN9PtzM3x0OUjUc
         GX9DC6VSBkKb2OUjyUgY8Gd9EWiVYqtj1Yox9YywAFnRIBUhIwLzZxz2EXPwaDB8281v
         YZtVQBu2VtIbOlXJJ3aQfFEbohYVEnlwzifOhebGdMF1iXwOFC5TYUhFa7Z8pOHHnSlu
         gUA7r3cuz6objWzk6dWGt8K6TZWlb7hcRNFVcZF0kDnT3nOJSDdt56152SGbxZ7OQc49
         7rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sq5R9ahAL9Mr9V6FJNbQb8e+IZHCcD5EZ44nzkpqzUA=;
        b=WCxHslu1Krnt2ws8YisJVKXDRgXxVMBDLnWcyaVDzhNtgL4xOemNCjA1kLVxO+yqqC
         Wv9aIC4cwEbvXKwK3XX8wm6I7WCO/iSCSyDIg3s3xLmLKoxJH+UM7axN1EhkGvuaReFW
         QtviHCkhaTLQSX9rUstHiKlW4CpeMcl99XNi/3XbybnJPHU1tYNm+RF30RufT5urUCRt
         Su/yBZS08y7t47MAoDS+d4guok6PgdatqKTkE0hyx6ZPMZKd5B7LIDOsHtophvIuSgE9
         ox+BTCuLV8mnAUNtarsR1TVd/9FMfW1BpUfYm+jcPum/Wyqxqn5AzQgCcsHXT1BlrmOA
         X9uw==
X-Gm-Message-State: APjAAAXz/1isoY1oWp6sZ6xWXNcsDJap1oYfelHFptxdor2k3mOo/fuW
        6knPPx0JrTGXyU/okVXwYVHXmSZ7RT9u+WuE2t3UeA==
X-Google-Smtp-Source: APXvYqyP38/P/44KzhWmMAfgVYgenviQtbgEKHBvrLKpW/Fper4GxgsFbB9OaHlLMZH9rSCS1/149yVurtFzf86rrTo=
X-Received: by 2002:a6b:b24c:: with SMTP id b73mr5153842iof.277.1581249088923;
 Sun, 09 Feb 2020 03:51:28 -0800 (PST)
MIME-Version: 1.0
References: <c6f76adc-b32f-a64f-c7b1-417a26de1667@st.com>
In-Reply-To: <c6f76adc-b32f-a64f-c7b1-417a26de1667@st.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Sun, 9 Feb 2020 12:51:17 +0100
Message-ID: <CAOesGMhxN3MW69EcJ_DigrvfruHzACNP8J-JOR9GmCnk4Tjodw@mail.gmail.com>
Subject: Re: [GIT PULL] STi DT update for v5.6 round 1
To:     Patrice CHOTARD <patrice.chotard@st.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "arm@kernel.org" <arm@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrice,

[Please also cc soc@kernel.org on pull requests, since they then end
up in our patchwork and we're less likely to miss them]

On Tue, Feb 4, 2020 at 1:37 PM Patrice CHOTARD <patrice.chotard@st.com> wrote:
>
> Hi Arnd, Olof, Kevin
>
> Please find STi dt update for v5.6 round 1:

The timing for this is bad. Material should arrive to our tree around
-rc6 timeframe for the previous release, for us to have time to merge
it and expose it in linux-next for a while before the merge window
opens.

>
> The following changes since commit d5226fa6dbae0569ee43ecfc08bdcd6770fc4755:
>
>
>   Linux 5.5 (2020-01-26 16:23:03 -0800)

... we also ask that the incoming branches are based on rc1 or rc2 of
the previous release, not the latest possible release (unless there's
a good reason for it).

>
> are available in the Git repository at:
>
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/pchotard/sti.git tags/sti-dt-for-5.6-round1

Please use the public git:// or https:// versions in pull requests.

> for you to fetch changes up to 21eebae9a11ff18fe6d6b43adccadd533abdf0d6:
>
>   ARM: stihxxx-b2120.dtsi: fixup sound frame-inversion (2020-02-04 11:21:37 +0100)
>
> ----------------------------------------------------------------
> STi dt fixes:
> -------------
>   - remove deprecated Synopsys PHY dt properties
>   - fix sound frame-inversion property
>
> ----------------------------------------------------------------
> Kuninori Morimoto (1):
>       ARM: stihxxx-b2120.dtsi: fixup sound frame-inversion
>
> Patrice Chotard (1):
>       ARM: dts: stih410-b2260: Remove deprecated snps PHY properties

It's a good idea to keep a reasonably consistent prefix usage. "ARM:
dts: <platform>:" is what we prefer, so feel free to touch that up for
patches that you apply.


-Olof
