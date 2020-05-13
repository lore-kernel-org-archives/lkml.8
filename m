Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C941C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85AB32053B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589411660;
	bh=HuA/NIar/TEMztosQ4CNtydvowmBO8rdCOsELQ170As=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2P2h7ryeWn3WOl0QjP5kAGIyVIVS0pkT88Tb9BAxACj/muRHEVX9wEU9XlfTrzFjw
	 gFF2r2n0m3H0lZLj3582Jgyhf4T7DrqOiv4vXyK2u/gP67YTalyMOO81rY8AEsfKsp
	 fX733fFmOLyIuWLXOCnvRMTol3aLLt6hYsq80IPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbgEMXOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732331AbgEMXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:14:13 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6237DC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:14:13 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e25so1442023ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0j3/OIPLsEoSjumgEsA8PXHbekOcSjeJ/f/Whs1clc8=;
        b=aWY/W00Vhs08u53IbUOOBmS6kQV0IdXs0gGbI9xldX6dgisVMq/l6vfmkGNI1z7fWx
         tOJl3WVP9kL5eNCEZgAeoeDhMecMnoXs+tEv8IopMGuY4Z8/YdVmykgjM8brjp9eWPdB
         rs/NoCXW7VxjHDjL5BXCEJsCICzD98wX2vGhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0j3/OIPLsEoSjumgEsA8PXHbekOcSjeJ/f/Whs1clc8=;
        b=nuviA9vZTHawtyOx3QIQ1xCGHcLkJpDNhTiiGui9KdvwOz05qIO8qQqcE2c6wfy3+4
         Tv1u/FtXg6Y3MikWHQFDsbKCDQ5iUopF7k3WWHW52xlBvRUbSn1sg18qwQLs1C+reD+5
         yT3srZO/odR1DQV5+cv2pIpF2eRDlD8CFYpfSTy+u+1WBCxhXlXhi9C5w0S9hA0gRdYB
         iION6DB6g9FNsR5BLHYvfADpfHx9iqAxNg3ZWBi79iR+UwyT/xa7m7LseUR7PpzUB198
         HuuW5NNlyXRG/5lwVE1/9XHwg/528ZJ2u89pqTUe5ONEd44vYyaDlitwKDGMjSTj236B
         x/Xg==
X-Gm-Message-State: AOAM531f8HGrRDFdQYMtavewroyNTFCs8bpfurAu4u3k3jtsnySIrjAD
        sge574Djr7QYOf6W+aFpCott/MBxWMc=
X-Google-Smtp-Source: ABdhPJzwrBEj2PZ0S3tH/2LfrmF/bIjJ80uA1NNEgvNH7bXkVSQwme4LRzWvm72bUukoU18ABAVnpQ==
X-Received: by 2002:a05:651c:50f:: with SMTP id o15mr870326ljp.16.1589411651232;
        Wed, 13 May 2020 16:14:11 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id r7sm558324lfc.79.2020.05.13.16.14.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 16:14:10 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id a4so927878lfh.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:14:09 -0700 (PDT)
X-Received: by 2002:ac2:58c8:: with SMTP id u8mr1201550lfo.142.1589411649429;
 Wed, 13 May 2020 16:14:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-1-arnd@arndb.de> <20200509120707.188595-2-arnd@arndb.de>
 <87v9l24qz6.fsf@kamboji.qca.qualcomm.com> <87r1vq4qev.fsf@kamboji.qca.qualcomm.com>
 <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com> <20200513154847.GA158356@rani.riverdale.lan>
 <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic>
In-Reply-To: <20200513222038.GC6733@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 May 2020 16:13:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
Message-ID: <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Borislav Petkov <bp@suse.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 3:20 PM Borislav Petkov <bp@suse.de> wrote:
>
> Linus, shout if you'd prefer only the last three commits there:
>
> 950a37078aa0 x86/build: Use $(CONFIG_SHELL)
> f670269a42bf x86: Fix early boot crash on gcc-10, next try
> 73da86741e7f x86/build: Check whether the compiler is sane

Do we really need that sanity check?

Are there known compilers that fail that check? Because honestly, that
sounds unlikely to me to begin with, but if it does happen then that
just means that the prevent_tail_call_optimization() thing is broken.

The check itself doesn't seem worth it. If your worry is that an empty
asm() can be optimized away, then don't use an empty asm!

In other words, the only reason for that check seems to be a worry
that simply isn't worth having.

In fact, I think the check is wrong anyway, since the main thing I can
see that would do a tailcall despite the empty asm is link-time
optimizations that that check doesn't even check for!

So everything I see there just screams "the check is bogus" to me. The
check doesn't work, and if it were to work it only means that the
prevent_tail_call_optimization() thing is too fragile.

Just put a full memory barrier in there, with an actual "mfence"
instruction or whatever, so that you know that the check is pointless,
and so that you know that a link-time optimizer can't turn the
call+return into a tailcall.

Don't send me the broken check.

                  Linus
