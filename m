Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65C0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5FE022D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596647230;
	bh=qO0+aVexHaRB4Ea6Qm7nyqgNgpjJ70yewcz4HpFpa5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aQiJNEFbj4eemIOkDH6qLvNDQBodPQms7VTaZeUz/1r/0hnknNmCv/uW2tKOUytBQ
	 Sgj4AYKaXHBuVy5edKDAN1lgQd0++zk7TWxEs+ZHLFz12/6BItEGx/GJO2K+JpzHO0
	 dsGN5KRSbWGO91UxB6EdX5PTqf10aa2ZPaOTNAZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgHERG6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:06:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgHERFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:05:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00EEC061756
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:05:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so14055243ljk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eg8kpWg73aerX78Ja1/DHgTDw4natARxbgvZfOQvqcc=;
        b=Oydvx95P+jnjKxo5tlTqRlnkndNruh7hOYn4RcJZBAS+DeaSg91DZo0hUs6xneKkhs
         wm0sA9+ZDx7IsscMUOGxJsg6gkB36gcFH78Hb0rpcblrBXAWvSheRSUvCbrltCWm2XPV
         /4WB2mcY4DUlgZqHIZzLtoudE2kH5powoRjxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eg8kpWg73aerX78Ja1/DHgTDw4natARxbgvZfOQvqcc=;
        b=MVL0MiIU33cP2NBCP/ptEJv4VPBZLmrrz/6KuHf7AgXrd+2lcvjkbY6I1EvOUvL0oU
         nCYGVN1TCGkETU/c0m8DN7eRpfV+NGjZIKWc7fTF3b69kzgedIKwLyMYDsBEl3NSRLox
         fSXTLxWnMprWgZMFbdsCMkbshqwikgxQm0FKEy9U4F1SQWFsCgTDKIUfGhFkhfE33e5Q
         kRdIpmLrp+sxd/B7iQvQ62ERFesj5gTEb2ks8itz9XsHYnmZ87zKj0y9LOo4RU0d8Rl2
         EYZUaPGg/J25jA12eBP2ysNSMLYjcPtenQuhaar7xvNpj77Lp3qg3UzDv8GIV356mTji
         QZoA==
X-Gm-Message-State: AOAM532eyRxEOaYoYV04l2DfQW7lok2CoZJPEA+YmaPLKJoYWJateDzi
        wSgLy1RMZ6A63YyEXNFsJSypj266C0M=
X-Google-Smtp-Source: ABdhPJw38D1LFhcICbIeXUOdDNK9kCMXYb4Gx56D6CdxhyN4+hYExar5P9aW3KSfiYi1Sm7kqI+jDQ==
X-Received: by 2002:a2e:5cc9:: with SMTP id q192mr1934536ljb.452.1596647122681;
        Wed, 05 Aug 2020 10:05:22 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id n3sm1114102ljj.39.2020.08.05.10.05.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 10:05:21 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s16so33301314ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:05:20 -0700 (PDT)
X-Received: by 2002:a2e:9252:: with SMTP id v18mr1776978ljg.70.1596647120510;
 Wed, 05 Aug 2020 10:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200803190354.GA1293087@gmail.com> <20200805110348.GA108872@zx2c4.com>
In-Reply-To: <20200805110348.GA108872@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 10:05:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
Message-ID: <CAHk-=wiq+7sW3Lk5iQ0-zY5XWES4rSxK505vXsgFY=za88+RZw@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm changes for v5.9
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:03 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> The commit 8bb9bf242d1f ("x86/mm/64: Do not sync vmalloc/ioremap
> mappings") causes the OOPS below, in Linus' tree and in linux-next,
> unearthed by my CI on <https://www.wireguard.com/build-status/>.
> Bisecting reveals 8bb9bf242d1f, and reverting this makes the OOPS go
> away.

The oops happens early in the function, and the "Code:" line actually
gets almost the whole function prologue in it (missing first two bytes
are probably "push %rbp"):

   0: 41 56                push   %r14
   2: 41 55                push   %r13
   4: 41 54                push   %r12
   6: 55                    push   %rbp
   7: 48 89 f5              mov    %rsi,%rbp
   a: 53                    push   %rbx
   b: 48 89 fb              mov    %rdi,%rbx
   e: 48 83 ec 08          sub    $0x8,%rsp
  12: 48 8b 06              mov    (%rsi),%rax
  15: 4c 8b 67 40          mov    0x40(%rdi),%r12
  19: 49 89 c6              mov    %rax,%r14
  1c: 45 30 f6              xor    %r14b,%r14b
  1f: a8 04                test   $0x4,%al
  21: b8 00 00 00 00        mov    $0x0,%eax
  26: 4c 0f 44 f0          cmove  %rax,%r14
  2a:* 49 8b 46 08          mov    0x8(%r14),%rax <-- trapping instruction


> BUG: unable to handle page fault for address: ffffe8ffffd00608
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0

Yeah, missing page table because it wasn't copied.

Presumably because that kthread is using the active_mm of some random
user space process that didn't get sync'ed.

And the sync_global_pgds() may have ended up being sufficient
synchronization with whoever allocated thigns, even if it wasn't about
the TLB contents themselves.

So apparently the "the page-table pages are all pre-allocated now" is
simply not true. Joerg?

Unless somebody can figure this out fairly quickly, I think it should
just be reverted.

               Linus
