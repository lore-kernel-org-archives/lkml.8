Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EF3C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FCCE2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StGX0zg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgBSULB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:11:01 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:40257 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgBSULA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:11:00 -0500
Received: by mail-io1-f66.google.com with SMTP id x1so1998569iop.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+h8OMq5ap5ScfL8XqeP9gKwIkHjfAosh3tAUb+IoSRs=;
        b=StGX0zg+xGzM+nwSZF3wlA5TRpwRQV5LywLkEYDUQA8ItE8WvExKoaWyzqtWaBAZZj
         xXiwktKui2oz2yXjjVoDOY2JhsknoK22qlgduTqvon/np3lpZqf4fYX/HvTFhsZtSCa9
         5tbkbKiAlRgP4XjBMC2zc4OIod3FwGklWggFRHJcAqxAZBEO8GK3k0M/dq7SqdLkaXYw
         uZTmP3nm8OINa8oQ+Qj4jRwa4T7UAkFYMBbk+Dwaf4nOzO5r5uBVk/s4KPG6YZlhBCsC
         Td2PLQT7QU+3ZvSrcw/cSHkinmm58Td71PO/ZldX9vSy22u6oZ/iler8dZzHZZ9holk2
         7VUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+h8OMq5ap5ScfL8XqeP9gKwIkHjfAosh3tAUb+IoSRs=;
        b=FDJdw2erSkdmLtgZ5C/lyLPJr2z2GF7xeAJTcJ6loELodnKiAudzuoI5nwMmusZsTO
         zezToCk2MoG3pRv8LYCE1zEtmjvLWHpmYUkOZfNRDb1HzkJpiXJbwwTCXl4EIHuf5Jrt
         YuAfGoramH5Lo5G1iP/CaT6WcLq656KY81C0//Tr1oFnZdyd8s30+w2ox9Lv9R8Uxxjn
         Oe22oU1KWf5DuvxxcjPvUcWKIWRV0rKTupAxfKocwrul/7oQS9eX+77wLdyVEk8FHq8U
         4SyNIwRdhKScnayLYa2wMjqqe0QNdbG2Xs8chimeVlVqruI1gxgk2kSxVz7Mn7fLYyzf
         hYjw==
X-Gm-Message-State: APjAAAV6xGjgjotQ2KdzNZ1mFKAur72SEnyeQnL3oSdiXS+ZbAiy0/25
        lppQaJp6t29Z/f0z068raGgveVAT87iCoanoIsXD
X-Google-Smtp-Source: APXvYqxspfdZL63YAPwl0zB/0t3IqfpJBoujRekmUD9zTan0lw3FKnPG50r5i9iSwh8I5nZTXhsdp2aSTqI2g8bEk3w=
X-Received: by 2002:a6b:7b41:: with SMTP id m1mr19646049iop.191.1582143060172;
 Wed, 19 Feb 2020 12:11:00 -0800 (PST)
MIME-Version: 1.0
References: <87zhdeq4qu.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zhdeq4qu.fsf@nanos.tec.linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 19 Feb 2020 15:10:49 -0500
Message-ID: <CAMzpN2ie64-TOJ5MJ+MFQ22GxXcjAgthJBV046OOPjvcMAseNw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry/32: Add missing ASM_CLAC in general_protection entry
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 4:58 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> All exception entry points must have ASM_CLAC right at the
> beginning. The general_protection entry is missing one.
>
> Fixes: e59d1b0a2419 ("x86-32, smap: Add STAC/CLAC instructions to 32-bit kernel entry")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> ---
>  arch/x86/entry/entry_32.S |    1 +
>  1 file changed, 1 insertion(+)
>
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1681,6 +1681,7 @@ SYM_CODE_START(int3)
>  SYM_CODE_END(int3)
>
>  SYM_CODE_START(general_protection)
> +       ASM_CLAC
>         pushl   $do_general_protection
>         jmp     common_exception
>  SYM_CODE_END(general_protection)

How about moving ASM_CLAC to common_exception instead?  That would
save a few bytes (kernel text + alternatives), and the AC bit has no
effect on kernel stack pushes.

--
Brian Gerst
