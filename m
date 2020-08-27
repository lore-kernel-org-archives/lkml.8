Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6B4D20707
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PBp6loKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgH0Ihp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbgH0Ihp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:37:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01CCC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:37:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i10so5507048ljn.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tS9KV0OuL9H7jrZSJX0btlTIW7y0Qv2YervGw+OH1sw=;
        b=PBp6loKQM+EAP/ynTVNWiDbA+vMdlIkKJLjlkuZt12auZvNQR6iTDpvlLWt25w1Kwi
         CjBQZmwGsSDlbkJC8BDsYJylVvS+hSe8G4nCyOy0cjfSEVD4pwxjoMctbsjc5PQRCfMh
         WPC/i7nxQJdrYKeiZHr4PSwafvg8gLVX3RXTc8FkeEwEMzQQg4TDD+oa3ZmPJ21D/kCF
         gpLXlRSW71AJ1WDnBV/hZYTbgvYEnH9lJ7QzJlIEKavnCQ7P6uZxK85ni3SfAZ0AgKoo
         XC7VuGxeXxWYedXWq5uBU7rTuvm2NPft4tcLfOpt0HMcRbmZdHvu/s8cMHYQ70ORS35A
         VQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tS9KV0OuL9H7jrZSJX0btlTIW7y0Qv2YervGw+OH1sw=;
        b=hTo6gdVbbIqm/xszldsE9qP5P1PFAixHF3ZWWJgvIvtJz8joU0MI6j7+osr9lp8scK
         HC/aoRNImciYkhvVFHHb3n53HZayfIugqyGOCL/i52dcymfMKja+R6R0ElDlbEjPisVm
         GDSrG21yk0Age3CH1n83LDaOUxNAFUotaNsvtqLwyrzkamDKMGD4Gw1ZY3z8jipeEJ5I
         rgkZ8y9Z0NjOyxbMXP6xlB9LeZ69gp+sTpWaFv+gh6Fm/S+4dZJTlYx/yErDyndq5IZR
         5G/gHYTvfi8B2EWFlF9HsyL4ouY1Ee5u1446Lhe3lVpzBbmpBDVA/pHlDoG8HxbiZOEr
         NKfw==
X-Gm-Message-State: AOAM533QBNlxcSIVC6FTik6pV1+plHVxji6dn/uj2oyP/l3hFufrVyog
        pHLFhEXHBcaQI7XDVAP4/5lfhQun8GPebyOOHejbjw==
X-Google-Smtp-Source: ABdhPJynHFjeGEynN1vApsTcEGtpq8ohQGl7nDnXnVVPdhzYEtVtmDx4b4z7XkfNqC7a8qhSy3l1t3M3JJ7O8vPj6PA=
X-Received: by 2002:a2e:8e95:: with SMTP id z21mr9579073ljk.143.1598517463040;
 Thu, 27 Aug 2020 01:37:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200827151105.73c75040@canb.auug.org.au>
In-Reply-To: <20200827151105.73c75040@canb.auug.org.au>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Thu, 27 Aug 2020 10:37:32 +0200
Message-ID: <CADYN=9L8znDFuPOiXzoR_vm+FXYkVR-D5yOf9hwPuG1FyAqDSw@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 27
To:     Stephen Rothwell <sfr@canb.auug.org.au>, atish.patra@wdc.com,
        anup@brainfault.org, palmerdabbelt@google.com
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 at 07:11, Stephen Rothwell <sfr@canb.auug.org.au> wrote=
:
>
> Hi all,
>
> News:  There will be no linux-next releases next Monday or Tuesday.
>
> Changes since 20200826:
>
> The net-next tree gained a conflict against the net tree.
>
> Non-merge commits (relative to Linus' tree): 2901
>  3429 files changed, 100496 insertions(+), 37081 deletions(-)
>

I built riscv on todays tag and I see this error:
../arch/riscv/kernel/setup.c: In function =E2=80=98setup_arch=E2=80=99:
../arch/riscv/kernel/setup.c:74:2: error: implicit declaration of
function =E2=80=98early_ioremap_setup=E2=80=99; did you mean =E2=80=98early=
_memtest=E2=80=99?
[-Werror=3Dimplicit-function-declaration]
  early_ioremap_setup();
  ^~~~~~~~~~~~~~~~~~~
  early_memtest
cc1: some warnings being treated as errors

I think its due to commit 3d109b0e0949 ("RISC-V: Add early ioremap support"=
)

It builds with this fix:

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 5ab185130cae..41ef96d0d97a 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -19,6 +19,7 @@
 #include <linux/smp.h>

 #include <asm/cpu_ops.h>
+#include <asm/early_ioremap.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/sbi.h>


Cheers,
Anders
