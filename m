Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86788C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB79206EB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 11:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgHZLaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:30:16 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43880 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgHZL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 07:29:23 -0400
Received: by mail-oi1-f194.google.com with SMTP id j21so1178847oii.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 04:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FLY0eW4GFuoR8mTu1lJlREb+UEGmC42E+5Rra5UznE=;
        b=XU0hHOssQQ1fWDN//FfT7reueVj+pS4F1dFxIdtsvGFou3Ud5xpIx17zuyVUCVFB94
         x3DJDEt8+noMnYXiDBiX7sQyrrYZkIQiTRMBSZm7Lsfhy47AWJBnVkGPUsZWEyILOb73
         gnrls34xQ9zunoUHV8rRfwApALE4iJwa7gD7zEIC6MKaM9L4KOQ/rendmMeDmTkYaXbd
         tE6TycpClPloiIJl8J+thvixNf8TMHcZNkirteuYUMqe+CuqokAE0Dy7QJ9+fwumYhXf
         QpD8GKP+GYgBYdspBmVStgHK1jTn7wj8quuWMkan1UfiTD8GagtagVgsyjnC/e2Qv2WF
         D74w==
X-Gm-Message-State: AOAM530QzcvyciHgDxZOjw7U327f+UuRZDqkRV1jZoZIJHpCMl5KgKkZ
        mBW2jWfRV6jakKOI6vOnntla5JjK8I0clWrdqcM=
X-Google-Smtp-Source: ABdhPJx7jX+qSl6hSkIJjjuVHvApPexAU/jsCaAJ1qdjT3qf5oCZgY38PO9ALloX5AEO8e8WFaJLeRawU/yp8PkK28E=
X-Received: by 2002:aca:b742:: with SMTP id h63mr3423281oif.148.1598441339761;
 Wed, 26 Aug 2020 04:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200713072429.6182-1-geert@linux-m68k.org>
In-Reply-To: <20200713072429.6182-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Aug 2020 13:28:48 +0200
Message-ID: <CAMuHMdXWfLa8dCZPF6jSQYuowGBR4dJnS1hx_rN1kDpPFZnVGg@mail.gmail.com>
Subject: Re: [PATCH] zorro: Fix address space collision message with RAM
 expansion boards
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Stefan Reinauer <stefan.k.reinauer@gmail.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 9:24 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> When booting Linux on an Amiga with BigRAMPlus Zorro expansion board:
>
>     zorro: Address space collision on device Zorro device 12128600 (Individual Computers) [??? 0x50000000-]
>
> This happens because the address space occupied by the BigRAMPlus Zorro
> device is already in use, as it is part of system RAM.  Hence the
> message is harmless.
>
> Zorro memory expansion boards have the ERTF_MEMLIST flag set, which
> tells AmigaOS to link the board's RAM into the free memory list.  While
> we could skip registering the board resource if this flag is set, that
> may cause issues with Zorro II RAM excluded in a memfile.
>
> Hence fix the issue by just ignoring the error if ERTF_MEMLIST is set.
>
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, and queued in the m68k for-v5.10 branch.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
