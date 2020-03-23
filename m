Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2CCC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88606206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584991010;
	bh=EOBJN3BpirFwgagRJHSCiInDvZ9sEMGEDEhL6Cz+c3Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UPw3Q1u63nORKEkYypeXGA6gqdu/o/OhmNFqImNDkWtPxc/RBUm+Qce07xJEO7PzW
	 UbrN72BMvloM/msaVcirhPjYwUzJMVfVoA2huOwbp6zv0apSu7EDnLh04VDdUwJ3Fz
	 HsKGmIjjgl/1acuV+0yvuh+2Z5rqjqTKtmeIE6cg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgCWTQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:16:49 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46253 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCWTQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:16:48 -0400
Received: by mail-lj1-f196.google.com with SMTP id v16so8898292ljk.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A8AaD7PeBM+BqQBSCUne0JC1w+8v/VR4Ruj2mnlVpoo=;
        b=GTL0uX2RUZzoWX3xVkXy4vdTv1KaniqoDTX5wRp9EHqAlZMZLuPQc9ldFdsUGGlb/s
         nwJEyhR9PMSsbtw4ZVEScgYBTreSsns5Pv2thseplI+wcI36tlBLktgQtwBiD2mwd1P2
         fPMXEkKXwhYLppuqhUF0ARhCrSsLxLqNI5cWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A8AaD7PeBM+BqQBSCUne0JC1w+8v/VR4Ruj2mnlVpoo=;
        b=PTjXRkM8jIwvEdpnI5DrdWNFaTbcJugPt5+e1nJcGt00IxTWY0DrkFou8aypYfPCkS
         4u7pjxvO3lEi94pU/+C9SCGP0/1099EHmkIvKHYtTxEF6rLDuK/CgleWzJ7NJLcV1vWq
         vcq0YdsOvLpslZlJ+ZzdKSSQxLNJxizoaVBw6j1fRPyna7fSKjq5cr48Jvu5oSs7kELQ
         uoSoR6MFHa2zz4h1Ehch/ApR/hPXoRjDBBr9O4+Q6BZEsp8DXO3qE+D4UxMOGBevrWvi
         3VHgU3f21mx2es4UG4hxdcE+R/4ngx+GQ75Mh+G4OohOhsuYq0rbMTEdXrlSs4x5YmYs
         hsFA==
X-Gm-Message-State: ANhLgQ0+L9fo47k1EjS2UvD5muW91LshSDQ7a4eoinimZ/RdFwzGRlpI
        /2EcDc2e6LAB3ECTxPnz0fNjhXRC96U=
X-Google-Smtp-Source: ADFU+vt/j0w8elesxQrWqVHkjeZ/Da7/eh09+vhKGSZw1AV9eKlDLCkn2tNbzpeB/5AXUDIKVxVsOQ==
X-Received: by 2002:a2e:85cb:: with SMTP id h11mr8122595ljj.190.1584991006015;
        Mon, 23 Mar 2020 12:16:46 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id u19sm945849lfl.57.2020.03.23.12.16.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 12:16:45 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id g12so15956537ljj.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:16:45 -0700 (PDT)
X-Received: by 2002:a2e:8911:: with SMTP id d17mr3881751lji.16.1584991004925;
 Mon, 23 Mar 2020 12:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
In-Reply-To: <20200323183620.GD23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Mar 2020 12:16:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAaviS3hmELax6dkTqWsHcV6gGhhwOMUVZ1xit4CXLtQ@mail.gmail.com>
Message-ID: <CAHk-=wgAaviS3hmELax6dkTqWsHcV6gGhhwOMUVZ1xit4CXLtQ@mail.gmail.com>
Subject: Re: [RFC][PATCHSET] x86 uaccess cleanups
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 11:36 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Beginning of uaccess series; there's more already linearized, but
> I'll be posting that separately.

Ok, apart from my naming hang-up, I love how this gets rid of some of
my least favorite header file crud.

So big ack.

One thing to look out for: have you done profiling with stack frames
with this? That patch 1/22 looks obviously correct, but all those
magic rules for __copy_from_user_nmi() are the scary ones.

Simple test to run - just do this as root:

   perf record -e cycles:pp -g -a sleep 100

while you're doing a kernel build or similar. That will do the
system-level profile of everything with stack trace code, which tends
to trigger a lot of special stuff.

Doing some basic ftrace tests might be good too.

Because that callchain code is the thing that really needs to work
from odd contexts, and also can't afford to have a stack frame because
you get into nasty recursive issues with tracing etc.

I think your patch is "obviously correct" in that you basically just
expand the crazy complex inline rules anyway, but I just want to make
sure it got some basic testing too..

            Linus
