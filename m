Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEE0C33CA3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE1820661
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FLgSitm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgAJRGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:06:43 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42467 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbgAJRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:06:42 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so2436516oin.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 09:06:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvMAZULjd+t6Z1IO7z3EeS0cYq8ZxzqfzhGty4Nz4qY=;
        b=FLgSitm39FYTcLuYRbsNts/aWHg4GhaKLHHRjdAR3hIJ0fpmEXM0Fi4fexFJOoxA2J
         q2WQ4hWQF6dKtx3BO8Y7AI+Jtfq7MrcV/yPV85pBLruRheP4hQjKvEOaoN1GdK1WmfKq
         BEZOjFehnKvUcDmI0W3Q/mIM132ofPkXXU7ZSj3eQbQwHJuDvwEfa9WTsn0ViS+AcuYf
         ZUFLD/xe63G7PvgoJwkNgzjuv9E20OGDGHHXpLe320K8yA371dMrbt8nNX41a+4DrdX6
         D2vD3NiCfmZrOHScFrHjpR9twekkziWZlmLFMLyZehlmk1hk7MX5q3+c8oI8zCw0vfS2
         fz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvMAZULjd+t6Z1IO7z3EeS0cYq8ZxzqfzhGty4Nz4qY=;
        b=L4KqJYKUxSRRJPHXbGKYI1hUWqzddkQ/KKZOwGgK4rmZIBH4PpGNO2TTT6yG709wYq
         4SnvP2mvDdX6Y0090P7xWOItpM5/vhbX4jbOxB4sVF5td8qrU1LamC0SbSY+HYehf6mn
         O9BqpI25BqabEmIwUKrQ+8p3wtiq1Zoql7+UF3HIKxQ6cd2bPCBW44YdQSspaW8FiBVi
         ibfrKDlA7iLgGvzrXh36km4RifIF3oi0VSoGN/TGUfumdbz7G3NSPeEoD4XoJ+bvbBhp
         rGuVTO+qJgWOTysCRmdqyKHQqDKTlZRYiPoPY0afJU0qK1DCzHwgn9wX3crEk10jkSX0
         vjfw==
X-Gm-Message-State: APjAAAVT2vVzvvu9iBUuUQelaauzGdglinnff9j6eGENqmA+tb4NGxIr
        FVEdMyKQ+4t1yKwu4vqDmjecXaJzPPy6IlSIwOePSg==
X-Google-Smtp-Source: APXvYqyg7WZSXB3wuilNJnIu0C1IW78TPsLDLu18fcxaEb8Xn+gwyErSQsJTAKiUpgwEXjnUDONAJqMuf2ylZ6GlMDE=
X-Received: by 2002:aca:ea43:: with SMTP id i64mr3103294oih.30.1578676001225;
 Fri, 10 Jan 2020 09:06:41 -0800 (PST)
MIME-Version: 1.0
References: <20200110030112.188845-1-saravanak@google.com> <CAKv+Gu-4jvME3cuPBDtTVFn+-ZzttneFuBkor+N3G0JpeO4BzA@mail.gmail.com>
In-Reply-To: <CAKv+Gu-4jvME3cuPBDtTVFn+-ZzttneFuBkor+N3G0JpeO4BzA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Jan 2020 09:06:05 -0800
Message-ID: <CAGETcx9b03SBKMcN7AokSOFRfVnr9G=vzSA4p5BXnmGPQ8JjHw@mail.gmail.com>
Subject: Re: [PATCH v3] efi: arm: defer probe of PCIe backed efifb on DT systems
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Android Kernel Team <kernel-team@android.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 10:41 PM Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
>
> On Fri, 10 Jan 2020 at 04:01, Saravana Kannan <saravanak@google.com> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > The new of_devlink support breaks PCIe probing on ARM platforms booting
> > via UEFI if the firmware exposes a EFI framebuffer that is backed by a
> > PCI device. The reason is that the probing order gets reversed,
> > resulting in a resource conflict on the framebuffer memory window when
> > the PCIe probes last, causing it to give up entirely.
> >
> > Given that we rely on PCI quirks to deal with EFI framebuffers that get
> > moved around in memory, we cannot simply drop the memory reservation, so
> > instead, let's use the device link infrastructure to register this
> > dependency, and force the probing to occur in the expected order.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Co-developed-by: Saravana Kannan <saravanak@google.com>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> > ---
> >
> > v1 -> v2:
> > - Rewrote the device linking part to not depend on initcall ordering
> > v2 -> v3:
> > - Added const and check for CONFIG_PCI
> >
>
> Thanks. I've queued this version in efi/next for v5.6

Awesome, thanks!

-Saravana
