Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7B92073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5C3M3Bs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbgFVU4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbgFVU4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:56:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5418AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:56:36 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id p82so6167249oif.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=asdOK2gESNr1qZfP5MeEvOEgqM/mfT3t6hygXJxiRd4=;
        b=h5C3M3Bs03OcWQUVTbeK2VdjGU6tL3xvQsKhXZcMREkwWw4FLlHe94Ca3OEpEh1fHu
         p4yteh7l/XjXKwpae5Ueu/frnb4dK5s9+iGWK06JpqwTkrmK1XjEiHw8qRsdxDSaxfBT
         ZnK7dukBV88rnfpDyE4/AxMCq3fHdRE42BcIZZYxzzxqgkA37ddKs05bmqSlLJeDUWn9
         7m3kOQOhgSdx0OmUuUUOSbhcj+cFu63laiu+YH2DS1GlN8kfVmmumzNwdd4Cgru+1tt5
         HzENQHcyNFu6IiQLlaogh+Ojw3PG+YRYMX1GZdndmtFrtoVjvWOj0iFUF5exZ17kXFX9
         1KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=asdOK2gESNr1qZfP5MeEvOEgqM/mfT3t6hygXJxiRd4=;
        b=L6ql1w3QmasINAzvnb8GubmOiVL0U4r43oHGsXUG3IJur03tyW4/yrpsL54/W0rEHe
         2j8PwWeTXctwszPij2af5ho5pUCjzR5ynIPqBmi2qqf6z8rP/QZ/jdcnPWf/bbejLbGX
         ydP1otlymRPG4PVflWeNXZSexY+UtWeCp7nlK/nVlf3uSljs87OISM44KOl3n3eNpE+R
         +hAImHUHZXsVoELxJ+ynmjikr03ffl0/C/uYw2WAJ2coq4yE7+4FS1wgKwspRoIosNyj
         ft0XQL7pSgrvHMEBa8K5pq2YoyRcvZpmtAM9jiFGfGqSjIFVuXRWSchmHtMz9jaYCek7
         6Yyw==
X-Gm-Message-State: AOAM532bpVi768Y+USXvBqDytTGd/NNj/Eivmo038Mrs47qVlEFe0+/Y
        qjViQZfLUKdMDhnvVHVKLtxXFAbm8e4uMxSyomk=
X-Google-Smtp-Source: ABdhPJy/ZEHqg5gFqADe7xER7K2662Zj5JuX/8k4X84jiHQk3BkslDvQonEaZuG9z3SK0xary+XixJL+GaynTVRL1i8=
X-Received: by 2002:aca:75c1:: with SMTP id q184mr13943323oic.49.1592859395718;
 Mon, 22 Jun 2020 13:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200619143056.24538-1-trini@konsulko.com> <CAP6exYJ64Hy9y3Dzh9Asrq8Y0oDWYk+tf4UAcasEc-ZxTY8DAw@mail.gmail.com>
 <20200622204034.GL27801@bill-the-cat>
In-Reply-To: <20200622204034.GL27801@bill-the-cat>
From:   ron minnich <rminnich@gmail.com>
Date:   Mon, 22 Jun 2020 13:56:24 -0700
Message-ID: <CAP6exYLd0uFbVSbn28iS1OV=jULtg2f+7t1DAn-fvGoRSd5dng@mail.gmail.com>
Subject: Re: [PATCH] initrd: Remove erroneous comment
To:     Tom Rini <trini@konsulko.com>
Cc:     lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "H . Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So, let me first add,  the comment can be removed as needed. Comments
offered only for clarification.

On Mon, Jun 22, 2020 at 1:40 PM Tom Rini <trini@konsulko.com> wrote:

> But what do you mean UEFI "consumes" initrd= ?

What I mean is, there are bootloaders that will, if they see initrd=
in the command line, remove it: the kernel will never see it.

>  I guess looking at
> Documentation/x86/boot.rst is where treating initrd= as a file that
> should be handled and ramdisk_image / ramdisk_size set came from.  I do
> wonder what happens in the case of ARM/ARM64 + UEFI without device tree.

it is possible that the initrd= argument will not be seen by the
kernel. That's my understanding. Will this be a problem if so? It
would be for me :-)

>  And it doesn't provide any sort of link / context to the
> boot loader specification project or similar that explains the cases
> when a non-filename "initrd=" would reasonably (or unreasonably but
> happens in reality) be removed.

But it unreasonably happens as I learned the hard way :-)

Anyway, thanks Tom, I have no objections to whatever you all feel is
best to do with that comment. It was a failed attempt on my part to
explain the state of things :-)

ron
