Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC18C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 18:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A17B204EF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 18:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590864786;
	bh=JiiHNY0lrk0+8OxUzyVN36CF9S1LevIe2BahgCsKVUs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vQVerEL5qp+tOG6ggMIJQBpNUQXdAig05AroeC7GLqwzR1hjAYulH8FeQXRAXnjv9
	 DKTVcHfwhkMkqN/ELtxbHxlyCWwIor2BDYcM0NUWLh0/vbo2jSAoFfAQ+iA8b5u3VL
	 PNG/dSqAdyuTvXCjgF0xPaoAjJA84E6jSPShJJOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgE3SxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 14:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbgE3SxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 14:53:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405F8C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 11:53:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q2so3232674ljm.10
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 11:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZHzJltOh4wlFbNpZhBw/XeTB/tCPGs6HUO1he1lSBzM=;
        b=OCKRD3WBSxWqJ660azgGmH4vrTVrjzQGz1F8EUVxr3/PjeBwCXSVOh6EicOBytWsK4
         doerNBJ3zzjyEoQu/BaNQ3fZld1nB7BeR3HkzqFS6p4AfHT8QxaH4DbLqJohCuREeqaw
         yK1NF6J/j1kHP1gm2ttUycjI1buYzyxyyRYTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZHzJltOh4wlFbNpZhBw/XeTB/tCPGs6HUO1he1lSBzM=;
        b=DBQSJP2aKbNQi5LFSmfqv+ARzYtL9kOEZyT+WE7AYttS5V8qazWdaFxYC7e0Ch8+Ff
         Q1j2TnpOPp2TSSduNUJiQ453SFvE7g/6gCPMRk85Jq6l1ouN1Xu8hKs1nWmEcm50Help
         Tt9bYJMtz39NAKEo7drkMyMC3XjirFG+zLGnfGHeWXvUEwd7AUdKKSk9iC1InSMjjkcC
         jeaUPl9j7/KZTKCLldjY5Ru2pT4dJfpBKTD08GoxR+NwmPZmTYEO6v633NXkGRz9zmpw
         GysXGQDPWkIWhUyXOjpNoeGajlwe9+txSp1Zx4CT4LLFh3a/9dyamsGt1X7vw/PmT5Y5
         Yg+w==
X-Gm-Message-State: AOAM532rIQxizsNJqwBlgsYa3tQq5tbhAnID78ArlE90bzlciTEj/UHM
        i1hbSpk89nC+yXvjD6qNn1VNEhYE06k=
X-Google-Smtp-Source: ABdhPJxO6LBi4f6rGg3OZF2fpaQLDQLIM6guOqJe/OP0K0G3AwgXR2sjT6+P+2ZpkAw2V5EmvM6YRA==
X-Received: by 2002:a2e:900a:: with SMTP id h10mr6735315ljg.329.1590864781898;
        Sat, 30 May 2020 11:53:01 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id z1sm1214234lja.108.2020.05.30.11.53.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 11:53:01 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 9so1820519ljc.8
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 11:53:00 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr6718682ljd.102.1590864780355;
 Sat, 30 May 2020 11:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk> <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk> <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
 <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com> <20200530183853.GQ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200530183853.GQ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 May 2020 11:52:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmCBXj0==no0f9Og6NZuAVWPEFXUgRL+fRmJ8PovbdPQ@mail.gmail.com>
Message-ID: <CAHk-=wjmCBXj0==no0f9Og6NZuAVWPEFXUgRL+fRmJ8PovbdPQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 11:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Actually, it's somewhat less brittle than you think (on non-mips, at least)
> and not due to those long-ago access_ok().

It really isn't.

Your very first statement shows how broken it is:

> FWIW, the kvm side of things (vhost is yet another pile of fun) is
>
> [x86] kvm_hv_set_msr_pw():
> arch/x86/kvm/hyperv.c:1027:             if (__copy_to_user((void __user *)addr, instructions, 4))
>         HV_X64_MSR_HYPERCALL
> arch/x86/kvm/hyperv.c:1132:             if (__clear_user((void __user *)addr, sizeof(u32)))
>         HV_X64_MSR_VP_ASSIST_PAGE
> in both cases addr comes from
>                 gfn = data >> HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT;
>                 addr = kvm_vcpu_gfn_to_hva(vcpu, gfn);
>                 if (kvm_is_error_hva(addr))
>                         return 1;

Just look at that. You have _zero_ indication that 'adds" is a user
space address. It could be a kernel address.

That kvm_vcpu_gfn_to_hva() function is a complicated mess that first
looks for the right 'memslot', and basically uses a search with a
default slot to try to figure it out. It doesn't even use locking for
any of it, but assumes the arrays are stable, and that it can use
atomics to reliably read and set the last successfully found slot.

And none of that code verifies that the end result is a user address.

It _literally_ all depends on this optimistically lock-free code being
bug-free, and never using a slot that isn't a user slot. And as
mentioned, there _are_ non-user memslots.

It's fragile as hell.

And it's all completely and utterly pointless. ALL of the above is
incredibly much more expensive than just checking the damn address
range.

So the optimization is completely bogus to begin with, and all it
results in is that any bug in this _incredibly_ subtle code will be a
security proiblem.

And I don't understand why you mention set_fs() vs access_ok(). None
of this code has anything that messes with set_fs(). The access_ok()
is garbage and shouldn't exist, and those user accesses should all use
the checking versions and the double underscores are wrong.

I have no idea why you think the double underscores could _possibly_
be worth defending.

            Linus
