Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4094C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D940420774
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590861467;
	bh=kxwoWdF8+KIP+11Hoa57/Bfp3/qtSaxfEKPcuNo8oIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=g3t071dfcw94hklsuCotRJrCeJ5r4l17ALa/ceRTPEJFRZAoQHRRFzcnfBYo3J0aS
	 8Ifz1UQCLjxM3Pnp5IHg1aMdy1yWy6F6+T8CzsUsq2GBpgWQG0BSuHrrY9ZLmub08q
	 i8jKlDcHBJX6YxNRtO7CrO+2qwinBZ82bKRB+bIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgE3R5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 13:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgE3R5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 13:57:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C217C08C5C9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 10:57:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so3171783ljo.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oSw9tD6N6PkQVpqgffMdls3duXKGoPYgqTcZw/O/Ajs=;
        b=Lrpv+rXNeI30WFwiZ3vG/HqSBj3X8LK4/226aM9DIBxsp+rGuUknOUrRMAKhbygxl4
         2/b72LXeaiKacrNWcsuKU1yFVjfrDuO9n9ZrCDP6XoASr7ATsfi5/BJRKwLKcRRm019Y
         q0vVl8iWNZpE3VHVrbGLWaJXKDmyB69Ejad/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oSw9tD6N6PkQVpqgffMdls3duXKGoPYgqTcZw/O/Ajs=;
        b=I5te3HhnQnkqLioAvbXEu0YF6kquAlrtvuP74ly6GiFp4gw0Qw8etJ0VBPQ0rLFRj0
         nZjPEAo+Sl5m9xjLG0nb4d+Tq9IdS+Gf+qB6dYt/yrwlspZ6JE1JUtGMrYU2oFD3gnt1
         aZUrDMQvw2i+qOwn752y0JF9XETTDuRpNxdJ5/L3sOEPEB9CfuAT3IoqLHFMsh2IblgW
         jl0QFGcJCg38lqNzxCAK4e73X2Cj5ibQ4BQsAbg4KfNKtwL0r3rrYoa58qgX1cuh3syM
         ykgqbEtsnIVL6OeIvi2QYxH07FPGSgLVycj36+td7mzEOE3OgqgW4eY4Ffgan0NVS3Br
         u98Q==
X-Gm-Message-State: AOAM533qNTNj623US25L+LQ8k/DpVdzBpS0B6sF/XsN2OpWEM2VO86Wz
        SkdqgwDJO/3WMsGBf+noLsFQTw5gZ80=
X-Google-Smtp-Source: ABdhPJzwnGBdUukXlfFjVfaAv4wu6xdL+M8lSL1tUXH0cLtn30cciZsFR475uezRD5h1Kb9ELKBrpQ==
X-Received: by 2002:a05:651c:54e:: with SMTP id q14mr3939895ljp.279.1590861461869;
        Sat, 30 May 2020 10:57:41 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s8sm3151437lfc.83.2020.05.30.10.57.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 10:57:40 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id u10so1914836ljj.9
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 10:57:40 -0700 (PDT)
X-Received: by 2002:a2e:8897:: with SMTP id k23mr2590713lji.285.1590861460328;
 Sat, 30 May 2020 10:57:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232723.44942-1-viro@ZenIV.linux.org.uk>
 <20200529232723.44942-8-viro@ZenIV.linux.org.uk> <CAHk-=wgq2dzOdN4_=eY-XwxmcgyBM_esnPtXCvz1zStZKjiHKA@mail.gmail.com>
 <20200530143147.GN23230@ZenIV.linux.org.uk> <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
In-Reply-To: <81563af6-6ea2-3e21-fe53-9955910e303a@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 30 May 2020 10:57:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
Message-ID: <CAHk-=wiW=cKaMyBKgZMOOJQbpAyeRrz--o2H_7CdDpbn+az9vQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] x86: kvm_hv_set_msr(): use __put_user() instead of
 32bit __clear_user()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 9:20 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Yes, the access_ok is done in __kvm_set_memory_region and gfn_to_hva()
> returns a page-aligned address so it's obviously ok for a u32.

It's not that it's "obviously ok for an u32".

It is _not_ obviously ok for a user address. There's actually no
access_ok() done in the lookup path at all, and what gfn_to_hva()
actually ends up doing in the end is __gfn_to_hva_memslot(), which has
zero overflow protection at all, and just does

        slot->userspace_addr + (gfn - slot->base_gfn) * PAGE_SIZE;

without us having _ever_ checked that 'gfn' parameter.

Yes, at some point in the very very distant past,
__kvm_set_memory_region() has validated
mem->{userspace_addr,memory_size}.  But even that validation is
actually very questionable, since it's not even done for all of the
memory slots, only the "user" ones.

So if at any point we have a non-user slot, of it at any point the gfn
thing was mis-calculated and {over,under}flows, there are no
protections what-so-ever.

In other words, it really looks like kvm is entirely dependent on
magic and luck and a desperate hope that there are no other bugs to
keep the end result as a user address.

Because if _any_ bug or oversight in that kvm_memory_slot handling
ever happens, you end up with random crap.

So no. I disagree. There is absolutely nothing "obviously ok" about
any of that kvm code. Quite the reverse.

I'd argue that it's very much obviously *NOT* ok, even while it might
just happen to work.

That double underscore needs to go away. It's either actively buggy
right now and I see no proof it isn't, or it's a bug just waiting to
happen in the future.

               Linus
