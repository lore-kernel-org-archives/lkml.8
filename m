Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473B2C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAD12073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588218637;
	bh=wfIdrIEXr1or4hfuICK8UJBf3WKPHigLEldc4x4mu4E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ylmGidDw4rjwbvmoDtQkJdwv8ttjOfe40A4gToxCQ7XL6lCwEFvJJvVUx7j2KRahg
	 O8gx4IqTbUnl7MTfU7yqeGq9MBK+M7A/3gjsu4nmAkBEwg1BnW7K3k63K71wijQw55
	 wENGgBRvTRFZr74hehkXHGLuUflmrjvxHD17paK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgD3Dug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3Duf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:50:35 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B06BC035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:50:35 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id g4so4953912ljl.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CW8PCDHX5ISW2m5CWeKILZiugDKRQ2m6b+cmxgYThRo=;
        b=EQ6Y8f6aQgHJ88x1ieqtoWLU7/jMzgTNfBam7Ryk3WqBeXaTQQnn7xG/d1iVGkWW6A
         QjcgmqeJQt2VR0u30g0+la4Py8bom784g9pKxA/iWUHJ/LxCuucyYOBWuiVQrswtOeha
         /rN2oG6KngkxYb87Yjs0LTAFKM6E2LTBqBg2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CW8PCDHX5ISW2m5CWeKILZiugDKRQ2m6b+cmxgYThRo=;
        b=fY1ejUWN6CCcfzW0JHJ2XTPpaLXxnTODa98Z6RAX0KncdqGufZJLIUSTRUSXqW+SxU
         4yG8DpcZISsyi+bvrTxFSZv772oUZ0RhPLClvD3EpkLhHkrZKoxWWryhK1dzU2IYXLMA
         X1bsUyufiuWfkWPzi5f4VhysouofW8S9h11drpU53KjkVaTNXvT6K6A8jhOejotindpp
         dFT6CCAC0tgZbBN6MImAme2AVLEo3Rjx06nEUpIEAkdoC75c/TyQxtnOpO/2tuUuSr3l
         DNZNgZ+hfdt7VBbmJhUl2Uepw26UVAA306FwKzmm2g0Ge8t9NeKQpmw01UtxkYJVDUXV
         Lmaw==
X-Gm-Message-State: AGi0PubFvw8FdGKsFEBE58Adxn5xmq4dTp66QtWSYahyZHc1dzNg58n/
        rO5w9RUkr0ysfMg+y8REPgIUThCHnTM=
X-Google-Smtp-Source: APiQypJZwqTtzjMz2Jb0REx/vweFy5aW2tV5czo5aXNodN14ZS85UEm3pgCwMI2xy+FrCny2d//xrQ==
X-Received: by 2002:a2e:8719:: with SMTP id m25mr861780lji.268.1588218633074;
        Wed, 29 Apr 2020 20:50:33 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id e25sm3929058lfb.89.2020.04.29.20.50.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 20:50:32 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id f8so3510604lfe.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:50:31 -0700 (PDT)
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr677432lfk.192.1588218631345;
 Wed, 29 Apr 2020 20:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <AM6PR03MB5170C5D02C6FCB6D69DFE3ADE4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg6oKSLkVhY5oqOFyzCCSr9eYPGK2SHJfgCXF_QOmPKog@mail.gmail.com>
 <CAG48ez25=6qrCU51dEAV_ciyU2jvPuRFWfFOAAT22kmeAZccuQ@mail.gmail.com>
 <CAHk-=wjE_YJ4SFJUasF=tW0jMr6zg+rkRNuNt2hdODPu_LLTVw@mail.gmail.com> <CAG48ez0yLF4KAK5uMi1_b9woC7NYy0NamYD1jP7BOPJkpKR7Mw@mail.gmail.com>
In-Reply-To: <CAG48ez0yLF4KAK5uMi1_b9woC7NYy0NamYD1jP7BOPJkpKR7Mw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 20:50:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-sm0WHmfyz21w_BzFrDPqfXiaWZzE_8hqhxax-G2f8g@mail.gmail.com>
Message-ID: <CAHk-=wh-sm0WHmfyz21w_BzFrDPqfXiaWZzE_8hqhxax-G2f8g@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 8:41 PM Jann Horn <jannh@google.com> wrote:
>
> | So a ptrace() user (or [...] wouldn't even see the impossible EAGAIN error.
>
> So I assumed you explicitly wanted ptrace() to restart, too. I was
> just pointing out that that didn't make sense to me.

I'm actually ok with the restart option, simply because I continue to
maintain that the program is buggy. "Anything goes".

To not be buggy, the program needs to install a SIGCHLD handler so
that it can reap its (pseudo-)children.

At which point it doesn't actually make any difference whether we fix
the kernel or not, because then the non-buggy program will just work -
even with a non-modified kernel.

Honestly, the main argument for the kernel doing anything different at
all is that from a user-mode perspective, silently hanging in the
kernel waiting for something to happen is likely the least easy to
debug.

But if you do a return to user space - even if it's to just rinse and
repeat - it's at least not "silent" any more, even if the main noise
it makes is just to waste 100% CPU time. At least that's a big hint to
somebody to take a look.

But yes, we can make ptrace() - and _only_ ptrace() - then not repeat,
and return a new error code that it has never returned before. Like
EAGAIN. Mainly because in that case we're only breaking semantics of
something that was already broken - unlike "write()", which has
perfectly well-defined semantics and wasn't broken.

                 Linus
