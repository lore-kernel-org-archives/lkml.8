Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F085C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 18:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716172070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 18:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jnhVI0AC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgAYSMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 13:12:15 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39746 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgAYSMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 13:12:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id c84so2670751wme.4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 10:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eF2OUCFn8RXfuPcwbgeBQlCI+YW26selKCHUMVhWZwI=;
        b=jnhVI0AC7nJ/o836vPGnFVXVOi7ROc8LnQ7lOYUAGtggE1kk/SF7n82HCKQnPvgsfV
         2ejWwuN5Uz+LfQPWJO2WC/07k1q/YZx9vAACJF4eYwzyQHr+oKlMZ0tc3pq4iImmdx1z
         3WNyE+KFv/fnwcETR/GQWpffXu+3VLUaHVPdOdXtrSKI0k7zIu+wnaigwdHshFWJLKWv
         0Xo1Hsn3qJxDV9TZP8WzAeedM8ddFdW58WbZAoCSF0ergdhMItd5ZaIb5OipyKS7gG0n
         v/tsa+eKEu8IGdHVqByD3xEeoP+H/M+5LXdmkFBzHBEj3SCvrS2hsOUdYWW80UlYXSyd
         NtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eF2OUCFn8RXfuPcwbgeBQlCI+YW26selKCHUMVhWZwI=;
        b=ccEV8pt7Qx4l1x10z8/mgNIKrbvdcBdb7hN96K2K1NCLz2vlIvKG1Jm6SYDV0ihnrx
         JFRdjBeKHZyU/B3GGFLwOZanGtHgdzl5b85GBuD0BakbGgVxMIuZ9yzMwcKblhnrkA6/
         tmQif3gnKVWEW8vhucLYC6jv2U+IE0P6JnvvumpBLqeTyTkwziBGpvFPEhSqhuTHYbY2
         0bu8ddNRaGOy7QKX+ddISPci98/Oqyz1DDeSUhpT3NDEqlAFL51GQfeR3s9V1PpFbDdI
         K3dZ2m3KVV4xkCphi+HlRevChJnI+inhuaU3cs/IXtsDzRulKMZ7sciVYcp8HHJ0NKSc
         LSmQ==
X-Gm-Message-State: APjAAAUeR0l6ORe01w3iW1ckWmtJcwn8os8SjOMdL5CotN0cpMeO01D3
        X9mrwD5Ip2gNgBUwbPgMdfRLuAi+9YaRIwjffGjC2A==
X-Google-Smtp-Source: APXvYqxSKxGhkxt7MQWWCjOMYviEF8rXOqjrXEu8a4fLOtQXjB/HoMwzih7ccjKRwo7fBxjk5pfLiq8vIkLUkqUzDLU=
X-Received: by 2002:a05:600c:248:: with SMTP id 8mr5114444wmj.1.1579975934034;
 Sat, 25 Jan 2020 10:12:14 -0800 (PST)
MIME-Version: 1.0
References: <20200125173950.GA19126@roeck-us.net> <20200125180613.GR25745@shell.armlinux.org.uk>
In-Reply-To: <20200125180613.GR25745@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Sat, 25 Jan 2020 19:12:02 +0100
Message-ID: <CAKv+Gu-_6oX-AyOdy7ii=3Y3Bf07+YvH7zp9J3x7ckAY5nxRvQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: 8936/1: decompressor: avoid CP15 barrier
 instructions in v7 cache setup code
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Jan 2020 at 19:06, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sat, Jan 25, 2020 at 09:39:50AM -0800, Guenter Roeck wrote:
> > Hi,
> >
> > On Fri, Nov 08, 2019 at 01:44:32PM +0100, Ard Biesheuvel wrote:
> > > Commit e17b1af96b2afc38e684aa2f1033387e2ed10029
> > >
> > >   "ARM: 8857/1: efi: enable CP15 DMB instructions before cleaning the cache"
> > >
> > > added some explicit handling of the CP15BEN bit in the SCTLR system
> > > register, to ensure that CP15 barrier instructions are enabled, even
> > > if we enter the decompressor via the EFI stub.
> > >
> > > However, as it turns out, there are other ways in which we may end up
> > > using CP15 barrier instructions without them being enabled. I.e., when
> > > the decompressor startup code skips the cache_on() initially, we end
> > > up calling cache_clean_flush() with the caches and MMU off, in which
> > > case the CP15BEN bit in SCTLR may not be programmed either. And in
> > > fact, cache_on() itself issues CP15 barrier instructions before actually
> > > enabling them by programming the new SCTLR value (and issuing an ISB)
> > >
> > > Since all these routines are specific to v7, let's clean this up by
> > > using the ordinary v7 barrier instructions in the v7 specific cache
> > > handling routines, so that we never rely on the CP15 ones. This also
> > > avoids the issue where a barrier is required between programming SCTLR
> > > and using the CP15 barrier instructions, which would result in two
> > > different kinds of barriers being used in the same function.
> > >
> > > Acked-by: Marc Zyngier <maz@kernel.org>
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> >
> > This patch causes all qemu emulations for ARM1176 to fail hard (stall with
> > no console output even with earlycon enabled). This affects witherspoon-bmc,
> > ast2500-evb, romulus-bmc, and swift-bmc. It does not affect emulations
> > for other CPU types, even with the same kernel configuration (such as
> > ast2600-evb).
>
> Hmm, looks like we're going to have to drop 8936/1, 8941/1 and 8942/1
> in that case.
>

8941 was intended as an alternative approach to 8936, as the latter is
flawed, given that the v7 cache maintenance routines are shared with
CPUID capable non-v7 CPUs such as the ARM1176. So it was never the
intention for both to be applied.

It should be sufficient to revert 8936. Apologies for the confusion.
