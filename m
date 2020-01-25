Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160A2C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FB82075E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIFWBPE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgAYRkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 12:40:02 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:46332 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAYRkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 12:40:01 -0500
Received: by mail-yb1-f193.google.com with SMTP id p129so2706575ybc.13
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 09:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FzRNhKCyQFTPPqqxfbfkSWcbEtMhXqGYIj7TNM51DBQ=;
        b=lIFWBPE6bUK2D0d+0DTG8G3oqGxMe6fU/8x7U1NCdLqW5uy3GFIc99beEAEyWk/L0T
         ZkkD7DUZNcDqLyVBXHWZzDLn0osF0x3DnrdwZlV/EE1T8ksOkB43biTQHlNB8vXXW+w+
         2Yg5S49TvwZ7peDUwbAHQm3TU7eMw/H6qZthlJ4bn9mbjogDgb9X3CSeQ1yYvQ8G+rqk
         ujUHhiIs1FagsXbJSL8M2helCAtTomKGUKUurOOQq3T+eMH8Pcw3V3Ug2mtDnve3MKvK
         +qZiSwPbRyQ8avY1EvE5GIT/vjoZYOmRaw0gd0oH+l5BRLEbNV6/O9v/N0jzxXrHN8Rb
         wl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FzRNhKCyQFTPPqqxfbfkSWcbEtMhXqGYIj7TNM51DBQ=;
        b=LSHvnf2Q5YIWWFVottixh+0Yr1ucjbucrgaEvAjkBiqm3QnpUphHacyqjRireQik7c
         aLisuiG3mVChw5OdBuv6kfbaI6Ytn9pBXNwMhyACwGPlmAyuV/ZC/xsdKwP9R55Cz2gP
         HXSFHUz0LPJmm+9Be2OB/kQv7XX++G3ziDBhJQ14i3ZrKt3cnpoUdSdM6ZySCvXJRI6g
         lAv+9XEjg78DFDudfzM9umhtT3qRSlxsY2WlN1OSdzMbJlsaGgeEfD2LpvN1A/ViKOuv
         8R09HIcsjcDKeSRAMyWpFx9NlmMjgqsOFFJFqnnHdDX/paFKI8KPVT4zCYzdOgN3ft1p
         X7Fw==
X-Gm-Message-State: APjAAAULFP5Em3W8Y4FIk5RggzJW3sOgPjWTPh9JvH38KoOdNLU/EF3q
        8rNXMkz/lrLKMC7TU02LkJU=
X-Google-Smtp-Source: APXvYqw7RahH4I7/pNf9bgIrss3bR38XyTiZPFwol1J4r5qXQehLyazhFm47BydCPC89DUIB/tWUvA==
X-Received: by 2002:a25:8451:: with SMTP id r17mr5538206ybm.207.1579974000348;
        Sat, 25 Jan 2020 09:40:00 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u136sm3776960ywf.101.2020.01.25.09.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Jan 2020 09:39:59 -0800 (PST)
Date:   Sat, 25 Jan 2020 09:39:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH] ARM: 8936/1: decompressor: avoid CP15 barrier
 instructions in v7 cache setup code
Message-ID: <20200125173950.GA19126@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Nov 08, 2019 at 01:44:32PM +0100, Ard Biesheuvel wrote:
> Commit e17b1af96b2afc38e684aa2f1033387e2ed10029
> 
>   "ARM: 8857/1: efi: enable CP15 DMB instructions before cleaning the cache"
> 
> added some explicit handling of the CP15BEN bit in the SCTLR system
> register, to ensure that CP15 barrier instructions are enabled, even
> if we enter the decompressor via the EFI stub.
> 
> However, as it turns out, there are other ways in which we may end up
> using CP15 barrier instructions without them being enabled. I.e., when
> the decompressor startup code skips the cache_on() initially, we end
> up calling cache_clean_flush() with the caches and MMU off, in which
> case the CP15BEN bit in SCTLR may not be programmed either. And in
> fact, cache_on() itself issues CP15 barrier instructions before actually
> enabling them by programming the new SCTLR value (and issuing an ISB)
> 
> Since all these routines are specific to v7, let's clean this up by
> using the ordinary v7 barrier instructions in the v7 specific cache
> handling routines, so that we never rely on the CP15 ones. This also
> avoids the issue where a barrier is required between programming SCTLR
> and using the CP15 barrier instructions, which would result in two
> different kinds of barriers being used in the same function.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

This patch causes all qemu emulations for ARM1176 to fail hard (stall with
no console output even with earlycon enabled). This affects witherspoon-bmc,
ast2500-evb, romulus-bmc, and swift-bmc. It does not affect emulations
for other CPU types, even with the same kernel configuration (such as
ast2600-evb).

Reverting the patch fixes the problem.

Guenter

---
bisect log:

# bad: [702ccea170f07783bd002055a353a0866c062267] Add linux-next specific files for 20200124
# good: [def9d2780727cec3313ed3522d0123158d87224d] Linux 5.5-rc7
git bisect start 'HEAD' 'v5.5-rc7'
# bad: [70b03961bd9b391bd124731df1f92d3e6f1b91c5] Merge remote-tracking branch 'crypto/master'
git bisect bad 70b03961bd9b391bd124731df1f92d3e6f1b91c5
# bad: [fd2c516f2b10a23d2a86948b3fad0961038ce708] Merge remote-tracking branch 'v9fs/9p-next'
git bisect bad fd2c516f2b10a23d2a86948b3fad0961038ce708
# bad: [4c1bb3d9902fbbe24efea7bae47337e51f8f112a] Merge remote-tracking branch 'arm-soc/for-next'
git bisect bad 4c1bb3d9902fbbe24efea7bae47337e51f8f112a
# good: [9b0b308a1586f620a49c50605ae8abf509190661] Merge tag 'zynq-dt-for-v5.6-v2' of https://github.com/Xilinx/linux-xlnx into arm/dt
git bisect good 9b0b308a1586f620a49c50605ae8abf509190661
# bad: [fa534dfeb4e761e31ba833c6315e350e9ff4ba5f] Merge remote-tracking branch 'arm/for-next'
git bisect bad fa534dfeb4e761e31ba833c6315e350e9ff4ba5f
# good: [c6e2f4e0e8b40ac5a6c6084189ea3429c71b0b4c] Merge remote-tracking branch 'ide/master'
git bisect good c6e2f4e0e8b40ac5a6c6084189ea3429c71b0b4c
# good: [eecc70d22ae51225de1ef629c1159f7116476b2e] media: digitv: don't continue if remote control state can't be read
git bisect good eecc70d22ae51225de1ef629c1159f7116476b2e
# good: [2e30f8d480842313c3de748bedd0a469f131f12e] Merge remote-tracking branch 'pinctrl-intel-fixes/fixes'
git bisect good 2e30f8d480842313c3de748bedd0a469f131f12e
# good: [9c9aa8fdf306cd7329e0a68bbcbe2f71b397dac1] kbuild: remove 'Building modules, stage 2.' log
git bisect good 9c9aa8fdf306cd7329e0a68bbcbe2f71b397dac1
# good: [3460d0bc256a50b71dbdae8227c600761c502022] kconfig: distinguish between dependencies and visibility in help text
git bisect good 3460d0bc256a50b71dbdae8227c600761c502022
# bad: [290b9fa737f893f96602c158f22caacd942e1268] ARM: 8951/1: Fix Kexec compilation issue.
git bisect bad 290b9fa737f893f96602c158f22caacd942e1268
# bad: [44832877ea4c186460f42e48b1da98a08a29ffb5] ARM: 8942/1: Revert "8857/1: efi: enable CP15 DMB instructions before cleaning the cache"
git bisect bad 44832877ea4c186460f42e48b1da98a08a29ffb5
# bad: [dff03da7c2b0575b8112c2947f84521aad287ae7] ARM: 8941/1: ARM/decompressor: enable CP15 barrier instructions in v7 cache setup code
git bisect bad dff03da7c2b0575b8112c2947f84521aad287ae7
# bad: [bcb704e551fc4e5034b9fa319a3ef49d30cb84d9] ARM: 8936/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
git bisect bad bcb704e551fc4e5034b9fa319a3ef49d30cb84d9
# first bad commit: [bcb704e551fc4e5034b9fa319a3ef49d30cb84d9] ARM: 8936/1: decompressor: avoid CP15 barrier instructions in v7 cache setup code
