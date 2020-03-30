Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7550DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C3A020658
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 09:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgC3JF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 05:05:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43818 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgC3JF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 05:05:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id a6so17202561otb.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 02:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=7jTEzJzOvQs2PCWu4X88jyDwbyYj7GS2gp6XlaD8iHU=;
        b=sx+jnW7OEOYoeYTxFafukCqoewNkOaKvnUTydHtanc41dW3IsZ22VeKPwvP9UYRVe0
         kwLaW6CJwrPgnzsQxd0B331JwbFmZiT8VuU17olMHXGPFl1+a6lcIZPz0J+DV0ZIUGQD
         3V7qnAQiS7oD9DUFaL5MRwIoH6mNmuAIO9YykpqWBDa1SFv5PLMcVjmQUwnYM+mMhaLU
         1/vK+jYfg+8Ycumj7Wl3moXzAyCEAGarckw4ltaBqwUqa83MS40kekGWDt1LXG+pkgvV
         fgduytBzVm/febgLkkeHkzYtBZxKc7Q1iNvWAnKR7xoFP6sd9O4WUgPNiEL4L0pLgYEl
         sEiA==
X-Gm-Message-State: ANhLgQ1Tu+zvzSyDEcxjgQGlqR/vyzhhECH+VHxEuTXDMJ0/6werMn6P
        B76r0KB++WqzRDjLfdrQvGYQECSAdLKEwxgxzCrgzdJP
X-Google-Smtp-Source: ADFU+vvfQ0DvfXVzEhK2OZ05NqGmoFxGAsqcQXNzz9y3pr0qi4KVnsmMTzvT12P23eOE4aOgQX8FfIRjQ+kzUMEUI8o=
X-Received: by 2002:a9d:7590:: with SMTP id s16mr8364554otk.250.1585559127588;
 Mon, 30 Mar 2020 02:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200330085854.19774-1-geert@linux-m68k.org>
In-Reply-To: <20200330085854.19774-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Mar 2020 11:05:16 +0200
Message-ID: <CAMuHMdUXS4T_L+d9XkyrhMTkGE2iJVHCKtUoZPdxxg0+9AckpQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 11:00 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.6[1] to v5.6-rc7[3], the summaries are:
>   - build errors: +0/-0
>   - build warnings: +1/-0

FTR, this is the silly

In function 'memcpy_and_pad.constprop',
    inlined from 'nvmet_execute_identify_ctrl' at
/kisskb/src/drivers/nvme/target/admin-cmd.c:346:2,
    inlined from 'nvmet_execute_identify' at
/kisskb/src/drivers/nvme/target/admin-cmd.c:617:10:
/kisskb/src/arch/m68k/include/asm/string.h:72:25: warning:
'__builtin_memcpy' forming offset 8 is out of the bounds [0, 7]
[-Warray-bounds]

which happens every point release, when strlen(UTS_RELEASE) is
smaller than 8.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
