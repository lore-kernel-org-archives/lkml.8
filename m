Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08C9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 20:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A51A324677
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 20:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f7UIGnMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgB1UG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 15:06:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34068 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1UG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 15:06:26 -0500
Received: by mail-io1-f68.google.com with SMTP id z190so4842494iof.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 12:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FcW1voX9EhPE46eVtQa2VVMkG6mrKANb8mimT+XRFA=;
        b=f7UIGnMnit6jiZvWsov3w1KlTgsnfz63NDgQI+fBGQRQ5fuwghmhkTmDEmIQdvLUXG
         e8ygGcmMkmb2Bfrk59utmqNvEdnZelvqhsihhDyzuvltcE7LftelH7b5lDdlwQRkPMXj
         +m3qaegMoJdsKjQb6qFEkUPGpjKDyqG+w2eTcurgzcCWzQZ88nMMatJZwS7jfDd4sGJ8
         82tn2AETDo3hXf+xmBQMFFfkKxisxsvaOSPrXJngHyMceO6oRJbROCcQAGW8X0s9a1t+
         LfEdMEElGow6knzeGS3Vss0BlA6tsy8IjBurKbL7D0z2qJxu8TXX8JGb9Nz7E9sJ/7yO
         dOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FcW1voX9EhPE46eVtQa2VVMkG6mrKANb8mimT+XRFA=;
        b=G46BQsSazEudvBLp6Ny15TsRCwc8ndz+SVya/4bZ/+dmIFTbz6otqmcDedOdyfHyI8
         DYIQGFnLLlaeX2W8H4dn4fiX58S7zACac0U9O+R2Hu/XHGfdNb7F8t5/gfpFyDhmOCad
         yCyBS7kam1VQDy0vI45r8IxvskR/QXwhGpBAzeXnsv0aO+p1ANkijf2xLQfwAfMTAuOy
         6RwNga8UtPSqTZUILrAHrsw//+wmCNQA8g7J9KYmhrxFd9PGRi8QjRb+UuDNs5kxoATN
         dXOGH3MuJ1Xnh51TZQtP9I+LQDmh5+R/Takexz+EQyr+OIOJdM4+g8YWidW9I5qX4b1U
         hy2g==
X-Gm-Message-State: APjAAAVtc/22x00Bif3sSu1Vk//UMs2FYzH37OuC65Myd/+YflsxHx+Y
        42b5eRNvSrzv4Q4macqeMq2FHA7QPJBG78rEu1cg
X-Google-Smtp-Source: APXvYqwPZa0d71u30Kf1SA/yD/STyc7D3zImEq2Tyj/aO0q4r6nhjFwiLmSEAOiKRPDWHvm2WqUr2GOtIhj8JETimNo=
X-Received: by 2002:a02:7fd0:: with SMTP id r199mr4842341jac.126.1582920385484;
 Fri, 28 Feb 2020 12:06:25 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-7-brgerst@gmail.com>
 <CALCETrW=R-tanwBwX9vCsnUiRdHooPq59uDVRBfwiOpC0MzRYQ@mail.gmail.com>
In-Reply-To: <CALCETrW=R-tanwBwX9vCsnUiRdHooPq59uDVRBfwiOpC0MzRYQ@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 28 Feb 2020 15:06:14 -0500
Message-ID: <CAMzpN2j7hO6vpopjc8po+v-9u3mmQ5Z_ZefVai3pJeV823_7Uw@mail.gmail.com>
Subject: Re: [PATCH v3 6/8] x86-32: Enable syscall wrappers
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 2:01 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > Enable pt_regs based syscalls for 32-bit.  This makes the 32-bit native
> > kernel consistent with the 64-bit kernel, and improves the syscall
> > interface by not needing to push all 6 potential arguments onto the stack.
>
> Was the change to the table mechanically generated or mechanically
> verified?  If so, how?

It was done by hand, but I can look into writing a script to verify it.

> After this goes in, I should dust off my code to get rid of all the
> __abi crud in the tables.  I never quite got it working well enough,
> but your series should help.

That would be nice.  After my patches, everything has the ABI prefix
to the functions.

--
Brian Gerst
