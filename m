Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AB2AC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 19:34:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6768206ED
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 19:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgAKTei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 14:34:38 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41793 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbgAKTei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 14:34:38 -0500
Received: by mail-oi1-f194.google.com with SMTP id i1so4884884oie.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 11:34:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kzPUFskPYF67uvQ48PsuGeDeO/lR4tRZnkBHPNyReQ=;
        b=ipAST4xk5pQ/SLDIPaNQX98wB1hcRrxNklplAx3/sVavlW4T8i+G8XBL5m+AOiMFz5
         CQKg8ExbgAa8EuIKr4a9G3A7c7+52u54OzMvzLLXgVNTR/HUX0JVm7x3gXCtVbwEmzoK
         bkmCzj9mOL5NN06WkJCbwHpxT7Xn2J8hwTlQTCodTfiYxceyVB0TFhpymYNkZ1/XQRTd
         +P4M21l8UIyjDnqo+UcNFz2qTuP4EGvdc2Lw1yolDgyCZuhOuaUc1xZ/zXFzEMZNFYy/
         kExko89NskzNr2OWcirLagVMq3fqWbtMMOw9dVSSi1ZrXvR9dbWJWU9mBI03enLfGhOz
         8xzA==
X-Gm-Message-State: APjAAAVhomyZr35mnjOtkeTWc9e9BknlokAv+d1FIj4ylX++sD2VZgEc
        C9QbQGbLaifiPEq7AtE66u+jFeVs2CoiMLO8Tjw478AD
X-Google-Smtp-Source: APXvYqwLXcbAsakZUaEFDSsuFl9fmtkoSI8uEH6El1cM0eP4mnI+swhvMAby8qGytkTrPQqtQq4CqGOsXO4np4RE1eI=
X-Received: by 2002:aca:48cd:: with SMTP id v196mr7512514oia.102.1578771277699;
 Sat, 11 Jan 2020 11:34:37 -0800 (PST)
MIME-Version: 1.0
References: <157867915825.30329.14197641774716750430.tip-bot2@tip-bot2>
In-Reply-To: <157867915825.30329.14197641774716750430.tip-bot2@tip-bot2>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 11 Jan 2020 20:34:26 +0100
Message-ID: <CAMuHMdWTuwuCuhZ0tFOAcDNEUHqgqvfATP-NG=G=oWJAb8+NAg@mail.gmail.com>
Subject: Re: [tip: x86/mm] mm/vmalloc: Add empty <asm/vmalloc.h> headers and
 use them from <linux/vmalloc.h>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On Fri, Jan 10, 2020 at 7:00 PM tip-bot2 for Ingo Molnar
<tip-bot2@linutronix.de> wrote:
> The following commit has been merged into the x86/mm branch of tip:
>
> Commit-ID:     1f059dfdf5d170dccbac92193be2fee3c1763384
> Gitweb:        https://git.kernel.org/tip/1f059dfdf5d170dccbac92193be2fee3c1763384
> Author:        Ingo Molnar <mingo@kernel.org>
> AuthorDate:    Thu, 28 Nov 2019 08:19:36 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 10 Dec 2019 10:12:55 +01:00
>
> mm/vmalloc: Add empty <asm/vmalloc.h> headers and use them from <linux/vmalloc.h>
>
> In the x86 MM code we'd like to untangle various types of historic
> header dependency spaghetti, but for this we'd need to pass to
> the generic vmalloc code various vmalloc related defines that
> customarily come via the <asm/page.h> low level arch header.

<asm/vmalloc.h>?

> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  arch/alpha/include/asm/vmalloc.h      | 4 ++++

Why not include/asm-generic/vmalloc.h, and add

    generic-y += vmalloc.h

in each arch/*/include/asm/Kbuild?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
