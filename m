Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DC7C433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48A8E2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594420653;
	bh=xGFoaM78nf0Be5CpFDuuARIxXOUAIZit3M8mlKiu6lg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HZIjAYhsBy2CpQfZ9Rs2uxNge/ElXDA7/DRAGzAvv3tKWaq2ELuzFr3LAiFel9URh
	 dOg1qkQ9EvUfg7xH05W6LKo9vaIY/RBDqMzPlvENMvUrShHsw6WIXTUK2mc9dke7ra
	 DQ5P/rY+xuFjMFfCV8Z494AU+jaKzk7e0cuJuVpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGJWhc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgGJWhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:37:31 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43962C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:37:31 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id e8so8175674ljb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOOtoPj/TYBlLc+eU82ZHIb+aymt/x6TobGnTd4fwRE=;
        b=dIx+a/OwAnrG8R/KYnef3nenl3etd7RuZhDAvmAKf7ajW9FgZYiY8mwJH2kbJjCGgL
         3Eqx+OUt+DfTqjhEIgVjZIcJuRAUMoSbLLJVDrixXdLI6pQjJzHO23RA08UVqdtmORyA
         GTqR0ieEhppw219L++AfD2SD316wsFRClTDOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOOtoPj/TYBlLc+eU82ZHIb+aymt/x6TobGnTd4fwRE=;
        b=J6v50puw/INOL68oY0EMBQH/AEp/8noCSaDJXgeCfg/FoHf9obAHkiE4gUdvSXdZlo
         QjZOvrFdPqD8PMVvwtOAKxtg6Y9/YRgVZdupHexp1oK3GT6OqnVDsVBEQl70y+kKU1S2
         f6woaSlo1IXEA3nYqjvAws8U+h4VBQe5bsQu1C8PKGakEM31bRbO8j/ijn+lkIEZzEg7
         6SmQH6MaKKejY64Bo9NVkdw5ounhaQpBGU0clQGafP4vj2IGAuFKZBeOmaPWOkNjV5VS
         DG5sdpxMFlZewX3n4kAGrOVtcENTUC9XPQtQ2Sj4aDY1gBdrqJgn7y26ArtIRwFk8hi3
         QeMg==
X-Gm-Message-State: AOAM532i8MGPFDTZcY5rMR+AX5Exw3WtNFPuVGUbzt9UNwF20VClaTtd
        TtJFwdMlI3+siq+FMgMVpfGPh7dUGcE=
X-Google-Smtp-Source: ABdhPJxUktYoE/MdJuNNoAW+J/fCn6fpIxbet6yjzSuEeL6MEbheGnF/mnIvM+U8wUqsgeXrgngV1Q==
X-Received: by 2002:a05:651c:1b5:: with SMTP id c21mr16337147ljn.82.1594420649264;
        Fri, 10 Jul 2020 15:37:29 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 203sm2349338ljf.14.2020.07.10.15.37.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 15:37:27 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id h22so8115563lji.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 15:37:26 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr40467600ljj.102.1594420646447;
 Fri, 10 Jul 2020 15:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au> <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk> <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk> <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk> <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <20200704004959.GY2786714@ZenIV.linux.org.uk> <20200704021157.GZ2786714@ZenIV.linux.org.uk>
 <b95ffa72db83431b95597a35f63d8e33@AcuMS.aculab.com>
In-Reply-To: <b95ffa72db83431b95597a35f63d8e33@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jul 2020 15:37:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQJjZX3cgX6vLp6ntTiBG+a6md64J+e74SDntoTi+q4A@mail.gmail.com>
Message-ID: <CAHk-=wjQJjZX3cgX6vLp6ntTiBG+a6md64J+e74SDntoTi+q4A@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     David Laight <David.Laight@aculab.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
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

On Tue, Jul 7, 2020 at 5:35 AM David Laight <David.Laight@aculab.com> wrote:
>
>
> So separate copy and checksum passes should easily exceed 4 bytes/clock,
> but I suspect that doing them together never does.
> (Unless the buffer is too big for the L1 cache.)

Its' the "touch the caches twice" that is the problem".

And it's not the "buffer is too big for L1", it's "the source, the
destination and any incidentals are too big for L1" with the
additional noise from replacement policies etc.

That said, I agree it's likely less of an issue these days when L1
sizes are bigger, and thankfully direct-mapped caches are no more. It
_used_ to be that touching the location twice was very very noticeable
in some situations, it may not be so much any more.

             Linus
