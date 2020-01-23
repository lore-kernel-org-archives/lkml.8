Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DD0C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1FF21734
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjK3dNrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgAWWP0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:15:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33520 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgAWWPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:15:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id 6so2104548pgk.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tXBwxhPJLlGlsNaOTHSkvCkjScA/qmIHT8AzKeFydO8=;
        b=sjK3dNrIhnT59AxIccgYBllx19BQGy09eIHs6Xza5RECBLrH81Q0N6IZNxqQsOUm4e
         2CeGJhJR5oByJjb7DAdHCzom/7osgyWHaVehLZF59dO05VIChggrcIa4b7UubLHPGtm9
         /p0hwCYEeFFyi7UWUv+6ahVXnReFYX1HDhjzYmMvx+lNRdPlRhAnRsWBTaUKS+MFk8in
         Z5cK+NAmrcy4thsvsX2HYP5yYWOHV7mKgi7M4eSRABul9JHpWWJx0F7zaYaMHmNxh6hn
         YokQmcOPSvM3I9n31XimMGfbUaLXzKaQIeaMVdmTJdA6EiMkxuhgrWhJN9LQm8oV2/iP
         2tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tXBwxhPJLlGlsNaOTHSkvCkjScA/qmIHT8AzKeFydO8=;
        b=Rh9+jwpqTW7P899aTXRbJeBQB72fKsfx7mRMKRxYyeWuZXdYOXspgoiKSjckiId4P2
         fKI7jua1fESvDlWFibOb+IgEgrvlXZnKt4R8GrQH6+N3+kjF35K5DDutA2rr/LI5hZgN
         fBgJRJmApGQdkQlmRVsgsIJixppMxTIKeIOwPkGxXJXxYghqOTFStseWn/4P9T+8A5mx
         9A+n/4Yo1FNR364xKcAAjiIQQh/7SbANtMYh+lzwVa/fauGyAMnU0mSr1cUxeTHDkUGH
         BWC5KN/uHPkAkDv5pSRwaCxdMqWi1HmYl1BVNmEzw1CAOzOuVbTIVR6XWSsc7XM//7li
         LLJw==
X-Gm-Message-State: APjAAAUSXljjrMsjjTPKTWwkRgyLBRWMtmFJhBz5G9vrrxHn3GE+Pmyq
        eimQ6pHYvwvitmxSPKHdcDB25e9HEzEtXf27YmxdQZRf
X-Google-Smtp-Source: APXvYqziuRWMnPljfz/bZp0L+T5uoyDPGMPlFhp5B6LWngEd1YcbHv5Z4Ye1FJte7JIRLPmklQwFeQrvOC+e+F9qqQM=
X-Received: by 2002:a63:597:: with SMTP id 145mr550696pgf.384.1579817724899;
 Thu, 23 Jan 2020 14:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-2-brendanhiggins@google.com> <CACRpkdaTJej2zFX0y7mAYymBdGNvHpp3VyU0kOd=ScA_gMAf-A@mail.gmail.com>
In-Reply-To: <CACRpkdaTJej2zFX0y7mAYymBdGNvHpp3VyU0kOd=ScA_gMAf-A@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 14:15:13 -0800
Message-ID: <CAFd5g44herz1-S-48NB=oKuTFhotHNodi7=S0Z-ffkPcqq08vQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/7] pinctrl: equilibrium: add unspecified HAS_IOMEM dependency
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for not getting to this before I went on vacation.

On Mon, Dec 16, 2019 at 2:39 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Dec 11, 2019 at 8:28 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>
> > Currently CONFIG_PINCTRL_EQUILIBRIUM=y implicitly depends on
> > CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> > the following build error:
> >
> > ld: drivers/pinctrl/pinctrl-equilibrium.o: in function `eqbr_pinctrl_probe':
> > drivers/pinctrl/pinctrl-equilibrium.c:908: undefined reference to `devm_platform_ioremap_resource'
> > ld: drivers/pinctrl/pinctrl-equilibrium.c:223: undefined reference to `devm_ioremap_resource'
> >
> > Fix the build error by adding the CONFIG_HAS_IOMEM=y dependency.
> >
> > Reported-by: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>
> Patch applied but I augmented it with the recently added
> OF dependency so it now says:
> depends on OF && HAS_IOMEM

Probably too late now to be helpful, but I can confirm that OF does
NOT depend on HAS_IOMEM, so this patch was still needed.

Thanks regardless!
