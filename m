Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73EFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95E37206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBwZoN4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbgC2VeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:34:07 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35631 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC2VeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:34:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id f74so8327521wmf.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 14:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UYYymRN1K169Z7gNSCvqd3FjnJg3VLBy6qvkZ/F2c3c=;
        b=fBwZoN4NdJySdoYnzO17+ef9G1oyuWbg2GdXXl5Uhud7wGkWIGuIxAEnyQB0rdCaTB
         eWQR5NKDqflIVxS1fo/ODgS+2Lz3hQwZZdY3pADWCstf/SOttIIIdBX22YRjilQPJIRd
         jKgYgQN5ZOTmCNjKGVCA/18D3rPesM+oQCes8GCJpAH77HHqm+DglwPF7h0ZQPu+O9BJ
         CMzV0eoVor1clhL7H9kMhrnEpyDsBsdcs1h8lxQjLGK3qIebVDRKJdNXavNoQDxCIYFF
         KGvDRQMRDFGcMbPkAC8Nhboqxq6xLWfw//Xf/dtt6XojByjHZuuVFqDZ3peuo1/tkKVK
         vyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UYYymRN1K169Z7gNSCvqd3FjnJg3VLBy6qvkZ/F2c3c=;
        b=Vqj2AfLiaik4ZZZC2oXbfqNfx5oVPGFVhnzH0PsM42BU0iSzg/eQkEcqI8IzrR4ffL
         c5NArDmixRIL/IHA2IhW/DTuYdalX1MmCNMyhB0HWa5GtJL1OUJc60mO6WgKoUu9pEQ0
         M/uEEV1+swRExBRxqcYDO4yU4AiyhCX8d4qxLtO1UpSGST1kvUSNB8labTkXDGf55XEB
         csu5mmgfxJi4rJ7hxk9BTOawCnpnCuQmiyPAzPDvEL43CS0n0SNEJ1slFxQCwAfULfId
         MzAmXRm/v4vDHWxjUP6WqHBkUXPyjQ4hoDR+lnrG/lnX3JKjGSr1qBWEPghvosiBWY4+
         q1Kw==
X-Gm-Message-State: ANhLgQ39wzZXSw+25JwdNv7tPlkY7FuYQeNcNhma3KYbW4jgmiMsXXLd
        ImjooZSOnVByYPF+O0/i3jS6nOToA9GarxXG+Yw=
X-Google-Smtp-Source: ADFU+vuLjfoldny3m1JWulHO6TuKShC4MkYuMXyqzLelccEgNlHrwFZvAwuWcZ6U3v7MTT7a7wrtygDTnxJ45HE3FBA=
X-Received: by 2002:a7b:c050:: with SMTP id u16mr10754316wmc.68.1585517642786;
 Sun, 29 Mar 2020 14:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200130192226.2776-1-krzk@kernel.org> <6e686a54-2e1c-b690-d465-369e0d712bba@cambridgegreys.com>
In-Reply-To: <6e686a54-2e1c-b690-d465-369e0d712bba@cambridgegreys.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 29 Mar 2020 23:33:51 +0200
Message-ID: <CAFLxGvyPRUPkEdntpiN34sviz4D275E_bYCqi0hkwmycZ+ZvTQ@mail.gmail.com>
Subject: Re: [PATCH] um: configs: Cleanup CONFIG_IOSCHED_CFQ
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um <linux-um@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 3:41 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 30/01/2020 19:22, Krzysztof Kozlowski wrote:
> > CONFIG_IOSCHED_CFQ is since commit f382fb0bcef4 ("block: remove legacy
> > IO schedulers").
> >
> > The IOSCHED_BFQ seems to replace IOSCHED_CFQ so select it in configs
> > previously choosing the latter.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >   arch/um/configs/i386_defconfig   | 2 +-
> >   arch/um/configs/x86_64_defconfig | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/um/configs/i386_defconfig b/arch/um/configs/i386_defconfig
> > index 73e98bb57bf5..fb51bd206dbe 100644
> > --- a/arch/um/configs/i386_defconfig
> > +++ b/arch/um/configs/i386_defconfig
> > @@ -26,7 +26,7 @@ CONFIG_SLAB=y
> >   CONFIG_MODULES=y
> >   CONFIG_MODULE_UNLOAD=y
> >   # CONFIG_BLK_DEV_BSG is not set
> > -CONFIG_IOSCHED_CFQ=m
> > +CONFIG_IOSCHED_BFQ=m
> >   CONFIG_SSL=y
> >   CONFIG_NULL_CHAN=y
> >   CONFIG_PORT_CHAN=y
> > diff --git a/arch/um/configs/x86_64_defconfig b/arch/um/configs/x86_64_defconfig
> > index 3281d7600225..477b87317424 100644
> > --- a/arch/um/configs/x86_64_defconfig
> > +++ b/arch/um/configs/x86_64_defconfig
> > @@ -24,7 +24,7 @@ CONFIG_SLAB=y
> >   CONFIG_MODULES=y
> >   CONFIG_MODULE_UNLOAD=y
> >   # CONFIG_BLK_DEV_BSG is not set
> > -CONFIG_IOSCHED_CFQ=m
> > +CONFIG_IOSCHED_BFQ=m
> >   CONFIG_SSL=y
> >   CONFIG_NULL_CHAN=y
> >   CONFIG_PORT_CHAN=y
> >
>
> Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Applied, thanks!

-- 
Thanks,
//richard
