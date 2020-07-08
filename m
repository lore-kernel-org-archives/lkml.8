Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A709BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B35720708
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/+llDmn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgGHHP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgGHHP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:15:57 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFBEC08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:15:56 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n24so34018573otr.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rUN87HHcT0D+VYtpGAgTAdZG4A7i97yXdShp42YthWM=;
        b=M/+llDmnnVb41HXbwGOiq6jmJPUaW8FTQkCNy2QnRSJcNvFQz7To2Zi1x1XHAnSlcW
         rN5mobyMuuy1YzbBp6BTqhI+EhsEyXpb6bsBmx8xuUAxPfRdmb1/kJsYyQSwF2pR5W7L
         ku19jswToojrU0/+xLzKSohGM0llFTFrYsyezI+Vp3B93TVjmqqvLUSqbUY4T0bfUXMN
         V8uy+jzabbSJzuAiBle2nPlVZyitMpOPiPSmzzJKZnxrCPFcszkCdZtKxd9mdvot52z5
         HaKvIw0BWdmUzd+Cr5U5fPoJRINu0Qj4C+VR0J7bv/yKZrkqf03UcNkhw7GLtzfpib7q
         2d6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rUN87HHcT0D+VYtpGAgTAdZG4A7i97yXdShp42YthWM=;
        b=LXGT0znRp4ajyilZmWKfdrh3VFe/vUF7+nPCyHru/K6hGfACLbIfLVBnCZ3VxXy7xG
         QXvevSmbIKwNkS4cNRdHRWITO0l0KCZM4gLeLmhPBTaV3JRw4XOG3lVlu37unRSvgJHH
         afsocKI8o4xFAWdpmaqzKglgUDMHnbrbzrDSliux4M/JC+CNsFFr8K6UecGXlZmZsOOi
         d/+pGpi82ynw093rzqocyG/iixDIKmIkDZ4gmws0JA92YLiEnx/DLe/eMor8725PLM/+
         c9nQuhKKsrTKqVL1QI3rWmk/qApxnD6qXI8MK9PDspyyGjb7FvQ1EvwkVJqdB4Jzplkz
         LjXg==
X-Gm-Message-State: AOAM5317o9tCN/VPyeHz3/wwjFVbZiXXTJwesKklzJBiS64XqwvI/QYp
        AfsnfT+US0yPMtWRwxNcuga/l9vfARo0UyCSv+9jcQ==
X-Google-Smtp-Source: ABdhPJyMCCNt8i1Et0DyOsaJ8wbMi3m1E8cveJ16TjMymVl4lnUJDpBklfG7oZetuBRbt8rGyAQ/aXNQNKJmxsfRdtU=
X-Received: by 2002:a9d:2788:: with SMTP id c8mr32372097otb.251.1594192556026;
 Wed, 08 Jul 2020 00:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-19-will@kernel.org>
 <20200701170722.4rte5ssnmrn2uqzg@bakewell.cambridge.arm.com>
 <20200702072301.GA15963@willie-the-truck> <20200706160023.GB10992@arm.com>
 <20200706163455.GV9247@paulmck-ThinkPad-P72> <20200706170556.GE10992@arm.com>
 <20200706173628.GZ9247@paulmck-ThinkPad-P72> <20200707102915.GI10992@arm.com>
 <20200707225122.GJ9247@paulmck-ThinkPad-P72> <CAKwvOdkW__H21m8vqqk1-n6-KK67HBk=YbA+MkUS7igxfjV1iw@mail.gmail.com>
In-Reply-To: <CAKwvOdkW__H21m8vqqk1-n6-KK67HBk=YbA+MkUS7igxfjV1iw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Jul 2020 09:15:44 +0200
Message-ID: <CANpmjNP8xwyjiDRgzWO13K3rPbxM0gRwTvMvX3Amm-QOWD0_tQ@mail.gmail.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when CLANG_LTO=y
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Matt Turner <mattst88@gmail.com>,
        kernel-team <kernel-team@android.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Richard Henderson <rth@twiddle.net>,
        LKML <linux-kernel@vger.kernel.org>, linux-alpha@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 01:01, Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> I'm trying to put together a Micro Conference for Linux Plumbers
> conference focused on "make LLVM slightly less shitty."  Do you all
> plan on attending the conference? Would it be worthwhile to hold a
> session focused on discussing this (LTO and memory models) be
> worthwhile?

I would welcome sessions on LLVM, and would try to attend. Apart from
general improvements to the LLVM ecosystem, we should also emphasize
the benefits LLVM provides and how we can enable them (one reason we
want LTO is to get CFI).

Regarding LTO and memory models, I'm not sure. Given the current state
of things, such a discussion needs to be carefully framed to not go in
circles, because we're trying to figure out things at the intersection
of architecture, what the compiler does, the C standard, and the
kernel wants. And because some of these boxes are difficult to change
(standard, arch, compiler) or difficult to precisely define behaviour
(compiler), we might end up going in circles. From what I see there
are efforts to fix the situation at the root (standard), and we might
have means to get the compiler to tell us what it's doing. But these
happen extremely slowly.

So, if we do this, we need to be careful to not end up re-discussing
what we discussed here, but rather try and make it a continuation that
hopefully leads to some constructive output.

Thanks,
-- Marco
