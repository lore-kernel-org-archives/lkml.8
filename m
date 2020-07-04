Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B54C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 01:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A55F20747
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 01:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593827678;
	bh=aJ8QmNjsCSZEeqT/srKGa47WC/9ZKDKCh98VAnlZDDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SJYVOrcx4vEkVAgaEoaS5/Yn3bLkKeMSW1a3M2XCt6ztIHQjgsqS2H53m28SMFeeV
	 ESKW9TGhNWmD0MaAqF+gP+bDC5GaM2ZLIzgDNkcrIbEu5CsN9oFt7HLClXR/cDwLOE
	 Mtu19hj/u4lnGD8I26F9lBmHBFmZxC+v4z/EJh8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGDByg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 21:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgGDByg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 21:54:36 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB678C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 18:54:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so31809583lji.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 18:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mpcWk+5OkZGUFQEfldhdVGvgXSOVGFFQsLdygOxAwrY=;
        b=gn1Dn9MwuijYg9hGiJ1noFDalMK96iWLsnzgYP1Znj7R+uTEHyOqguwcsKuLPNZJTf
         30mV18sitzdW1usE7U3wlKEVDlXFVpqgVlR2l1MQKpeVUttajlwQ9F5febky4j3rqUwA
         PiQkHRBzrRp3QUke+f6samrVTfE7DsdHNiU/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mpcWk+5OkZGUFQEfldhdVGvgXSOVGFFQsLdygOxAwrY=;
        b=IxYWVaXLyLmacmVwVC854csCB/Nh/c5qArWHAs00NEVhDQ6X1oApdsk6D5eHQnoVC4
         97JfF6nE30XIab/OWxYAkoIDgs9RCndm3ybADdv9NFRDs5MYcCtvYr9HAWGiNDXnXra7
         2TDY1QEZEI3X+a1Zjol2w+1AOlQDZE2I8LkXTt2qkS9jRFIlF3AOFiwT/VBxJsnSdWeK
         o7Xi8AkM6wV3vakIvFgRb7SoidWGUlGrUjQf6Q5T6rjMSv2njytYCVwonazcR1AYx5xA
         nNUgiQwBSgna19OhWdJBc3XW3ZU+M2lK+PsgA1m91JtkHTnMVcnLoAAz0pa6sxUSbcnC
         qA/g==
X-Gm-Message-State: AOAM530fDn1ZmtPgXeFoXrT8so5BtnqkFt+oU0I9bfzPX1FPcAx92oWy
        oGx02JC77YzMTHzumD2/oOQyWqYNL2c=
X-Google-Smtp-Source: ABdhPJwoIvyTWqD5a6DyvhT3WCilFYrlbxxUpRniLq4T+BVh2Q0bBrlN4Rht+Rk1x4A70LLBxzvLDg==
X-Received: by 2002:a2e:6f14:: with SMTP id k20mr21793233ljc.224.1593827673752;
        Fri, 03 Jul 2020 18:54:33 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id m10sm1646497lji.72.2020.07.03.18.54.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 18:54:32 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e4so39001630ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 18:54:32 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr6758558ljc.285.1593827671608;
 Fri, 03 Jul 2020 18:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au> <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk> <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk> <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk> <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <20200704004959.GY2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200704004959.GY2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Jul 2020 18:54:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxLURD=qsF3ijmQYxGRPSyjS8_zoxZz-AsD-7tmRBM0w@mail.gmail.com>
Message-ID: <CAHk-=whxLURD=qsF3ijmQYxGRPSyjS8_zoxZz-AsD-7tmRBM0w@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 5:50 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>     How could prefetcht0 possibly
> raise an exception?  Intel manual says that the only exception is #UD if
> LOCK PREFETCHT0 is encountered; not here, obviously.  AMD manual simply
> says "no exceptions".  Confused...

Several CPU bugs in this area. I think they may all have been AMD.

But we've definitely had "prefetch causes page faults" errata.

Google for it. One pdf (AMD errata) I found had this:

 "Software Prefetches May Report A Page Fault

  Description Software prefetch instructions are defined to ignore
page faults. Under highly specific and detailed internal
circumstances, a prefetch instruction may report a page fault if both
of the following conditions are true:

   =E2=80=A2 The target address of the prefetch would cause a page fault if
the address was accessed by an actual memory load or store instruction
under the current privilege mode;

   =E2=80=A2 The prefetch instruction is followed in execution-order by an
actual or speculative byte-sized memory access of the same
modify-intent to the same address. PREFETCH and PREFETCHNTA/0/1/2 have
the same modify-intent as a memory load access.

  PREFETCHW has the same modify-intent as a memory store access. The
page fault exception error code bits for the faulting prefetch will be
identical to that for a bytesized memory access of the same-modify
intent to the same address. Note that some misaligned accesses can be
broken up by the processor into multiple accesses where at least one
of the accesses is a byte-sized access. If the target address of the
subsequent memory access of the same modify-intent is aligned and not
byte-sized, this errata does not occur and no workaround is needed.

  Potential Effect on System An unexpected page fault may occur
infrequently on a prefetch instruction."

So sadly the architecture manuals do not reflect reality.

That said, software prefetch instructions very seldom actually work.
They are only useful if you have one _very_ specific load and run one
one _very_ specific micrcoarchiecture.

Ir's almost always a mistake to have them in the first place.

            Linus
