Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC86CC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B308320734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591047802;
	bh=FtoxoLVF9fsxY1leWCL6v9DoTLgnD2MAsiB9mWirY9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IyCKUMGUOcIVf2NSfrTr6G5J+8ZFfOHJqZ0FsT3xDFKv2t9I1iISqYWV+1zxIMU6p
	 Z9XnBNGUL83diROslCOP5Szhzfx8PP7xnVOgGIDyqckr+jH9gJHznFx36xG4Urmzi/
	 PUhjC6rbaTIaMjkATYhp7reoJrL5hnIn1a9aV6jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbgFAVnW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728360AbgFAVnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:43:21 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4EFC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 14:43:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id c17so4306993lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0E8dX6z5svaGKiQ4AWeQa42pJuIWCtwm9+P3KiJSxhU=;
        b=hWVFzywMhMvmiNOyDM1CxkS5a54IlqLtLluSwao6THnPiBIP5d3Fdj4PUdUeY+R1kt
         F9X5M0VxlW8BhlAM6mkFHlg2mixVbfFe6jv0yfMyTguEaM+7N3A/72Jq7WaXmAc59hBX
         turVdOh+NWFtRBemH/W4UGQRptwOLUNT5yvYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0E8dX6z5svaGKiQ4AWeQa42pJuIWCtwm9+P3KiJSxhU=;
        b=ENe9+8ABA3ObzL6JXlvuDzpZsPlhwMwPxZmehz3eYMEt5GGzrBvTA3A8WrNo7o1VHY
         6JIgabrDLsZn/RN3pBp2Nyvf1irWshLEgAoGpudi+XN+SIcH/YBcxfcnBoqy3FstiLA7
         j3JqiOHXZG4N3Ri/dt04mhKR/BzN3xMOv5s4Kpq2iSAOXS2DHkfosgFxFLjOp+n7amNh
         bCrECN/g+dPKFHs34yNKyNjdf6d+vnnLZa0m8p8RKq+EVLUYsVwXhU7ku+MyTEL+aPNI
         HpVnv9xoe+j7+b+49/MAx+P5s2n19KZXzOiqmJNA2nUli6rRp85GgeEpniDIRD6uwKKI
         amsw==
X-Gm-Message-State: AOAM5305nDbGKSxGRIHbPvjMysNRBOUDDhBI0i8iCHYDk8mCcRNJ7fSD
        62fbLg8m07KqXzOrHxWKf1ATntaofBY=
X-Google-Smtp-Source: ABdhPJymxTkeUAPtDBvB5wiij3z/j7wLHSbioFjQMeo+qKlbOsfzJOCSyvmbyb9DRYevL4Ma0gYNoQ==
X-Received: by 2002:a05:651c:1207:: with SMTP id i7mr11338343lja.86.1591047796950;
        Mon, 01 Jun 2020 14:43:16 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id u15sm183397lfg.92.2020.06.01.14.43.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 14:43:16 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id e125so4861532lfd.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 14:43:15 -0700 (PDT)
X-Received: by 2002:ac2:5a0a:: with SMTP id q10mr12359143lfn.142.1591047795340;
 Mon, 01 Jun 2020 14:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200601170102.GA1346815@gmail.com>
In-Reply-To: <20200601170102.GA1346815@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 14:42:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
Message-ID: <CAHk-=wgXf_wQ9zrJKv2Hy4EpEbLuqty-Cjbs2u00gm7XcYHBfw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.8
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 10:01 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>  - Provide an opt-in (prctl driven) mechanism to flush the L1D cache on context switch.
>    The goal is to allow tasks that are paranoid due to the recent snoop assisted data
>    sampling vulnerabilites, to flush their L1D on being switched out.

Am I mis-reading this?

Because it looks to me like this basically exports cache flushing
instructions to user space, and gives processes a way to just say
"slow down anybody else I schedule with too".

I don't see a way for a system admin to say "this is stupid, don't do it".

In other words, from what I can tell, this takes the crazy "Intel
ships buggy CPU's and it causes problems for virtualization" code
(which I didn't much care about), and turns it into "anybody can opt
in to this disease, and now it affects even people and CPU's that
don't need it and configurations where it's completely pointless".

To make matters worse, it has that SW flushing fallback that isn't
even architectural from what I remember of the last time it was
discussed, but most certainly will waste a lot of time going through
the motions that may or may not flush the L1D after all.

I don't want some application to go "Oh, I'm _soo_ special and pretty
and such a delicate flower, that I want to flush the L1D on every task
switch, regardless of what CPU I am on, and regardless of whether
there are errata or not".

Because that app isn't just slowing down itself, it's slowing down others too.

I have a hard time following whether this might all end up being
predicated on the STIBP static branch conditionals and might thus at
least be limited only to CPU's that have the problem in the first
place.

But I ended up unpulling it because I can't figure that out, and the
explanations in the commits don't clarify (and do imply that it's
regardless of any other errata, since it's for "undiscovered future
errata").

Because I don't want a random "I can make the kernel do stupid things"
flag for people to opt into. I think it needs a double opt-in.

At a _minimum_, SMT being enabled should disable this kind of crazy
pseudo-security entirely, since it is completely pointless in that
situation. Scheduling simply isn't a synchronization point with SMT
on, so saying "sure, I'll flush the L1 at context switch" is beyond
stupid.

I do not want the kernel to do things that seem to be "beyond stupid".

Because I really think this is just PR and pseudo-security, and I
think there's a real cost in making people think "oh, I'm so special
that I should enable this".

I'm more than happy to be educated on why I'm wrong, but for now I'm
unpulling it for lack of data.

Maybe it never happens on SMT because of all those subtle static
branch rules, but I'd really like to that to be explained.

                    Linus
