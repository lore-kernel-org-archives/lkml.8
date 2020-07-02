Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78818C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB7A20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 19:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593719569;
	bh=9UIrJixA42MadyBQS14mZtQ87J3ZYZ3jSIfcIDIbHmg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TpNp3TfZgdl95HYXQrDw7GEBHTFGIv7DjDN29dPDk8E8b6Vd/WM8bu4jxL03bIcg+
	 8Xx6/XShHS3n+yIgffTWUgTmJJrix9h43WWarnHFoz/NgzlXdePM9JqENYapMlchzw
	 37O9R/FkWLKyBrpjpUXSSbXY7yFYxomE8uQSES+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgGBTwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 15:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGBTwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 15:52:47 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF297C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 12:52:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so33748741ljv.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mdHCKcpOC6Y1fWfOcAYKBwR587EeQvxDuT43W9WnVVQ=;
        b=AQIB7HT1eB2dbRaCbxE4inMMtsVBPcGzd40Icubwlse37QUYe42pikzknMaB01q0ZP
         f4ZuLZeXppyBpTIs6RDpv9iP944jGstnjUa93RdynfaZ9fK+cWLJe08oO0OWvcSAa0wX
         5PJjin+0jq0gCUgrp8e5r7ZoW2TN0kyuFzPv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mdHCKcpOC6Y1fWfOcAYKBwR587EeQvxDuT43W9WnVVQ=;
        b=LrV5DUtg0XbSFHRr7aXfIJu8RK+2eLVzmSK4RSAFGTwpaXqhmRzV1qouPkMBRAOQn3
         R3rapdv2P4jnA3BpcNlc4zPbEBdt9wtQJuVjZ5gHPtOCeEaayW8mZ07/toFAl+IwgKtE
         Uuhm11x4lpP9ZFgP9aeskZCx7AkDTmjq8Uwf7zVaVCkr4ItgI2cBCJtgvVV6af3RZV1V
         Of1qugrPx9BF+G1RmfUk7jt9eJBfHbg5Li3JGRdBMAVt/95EUJ+UpqFY3Oo6fmJxK4r8
         AbD7dQICGaCbTFgJPtwhLPzp4QqS7XuBLqTLpI257be54cKVSI13h9cR5BpYHhCuziTM
         ZCkQ==
X-Gm-Message-State: AOAM533dVtBDgw6wfmFPnSsQHvszORYckxfnnTjD8mhR/g3yEqaFEY5E
        GLk8hcMNJysHGGmi6Xe5tNEBEs+I9qk=
X-Google-Smtp-Source: ABdhPJyOS6EQ8jLpUVVjhC8bHz8ECHBykF0GZ2xN6fGiBTqHRmhz7P0XRRo33aR9mZOfLJlxVriYsQ==
X-Received: by 2002:a2e:8699:: with SMTP id l25mr8672567lji.81.1593719564700;
        Thu, 02 Jul 2020 12:52:44 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id 24sm3719916lfy.59.2020.07.02.12.52.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 12:52:43 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id h22so26614069lji.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 12:52:43 -0700 (PDT)
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr14533604ljn.421.1593719563219;
 Thu, 02 Jul 2020 12:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
In-Reply-To: <87lfk26nx4.fsf@mpe.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 12:52:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
Message-ID: <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 6:32 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Probably the simplest option for us is to just handle it in our
> unsafe_op_wrap(). I'll try and come up with something tomorrow.

IMy suggestion was to basically just always handle it in all exception cases.

And note that IU don't mean the fault handler: obviously page faults
(or unaligned faults or whatever) can happen while in a user access
region.

But I mean any time fixup_exception() triggers.

For x86, this is in fact particularly natural: it involves just always
clearing the AC bit in the "struct pt_regs" that fixup_exception()
gets anyway. We can do it without even bothering with checking for
CLAC/STAC support, since without it, AC is meaningless in kernel mode
anyway, but also because doing "user_access_end()" in the exception
would be pointless: AC is restored by the exception routine, so on x86
you *have* to do it by just modifying the return state.

             Linus
