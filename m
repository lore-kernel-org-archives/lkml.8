Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4983C3B190
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBC92073A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581634090;
	bh=kuhbs/VbpNEZWogAUDjvRYiro5cykILbgDMBojkyEI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WP/zrCN6UWpw8q8EVcAd3cfV5ZRuhFAoS+vhnSQldB6DyGmwbZ8QirDyMXZnx1Jke
	 MMvN7CrprvDMRmfg2Dc7b/k0nUjnEdGXv+lhGI1XOge87bRe7agzUAbicBM4csv9Ux
	 D+H8L1UUVt/FIgK0adGyR/gYT4nAT40EjCmphEuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgBMWsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:48:09 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41575 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbgBMWsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:48:09 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so8514175ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 14:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rVdHJ1r/9FxJmwhDqRkVHSIn1Ry+lO3z+KpnaUuqwYk=;
        b=dRYW8MemR37cE0uru6NTUES5Od7vEqzfZmb/KMY93QEjURoq6DE5QcXLZ6JJL9HB8V
         KfvM/ZKQbYsF7Zy+x1PnUgqdmV3x1lbxpWU+BFmhJglL6UqALgYvF3IltbUH8c3PxzFq
         KRLtkM5e8bHrUc0004IuGa/Hy6940Rjrv4zzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rVdHJ1r/9FxJmwhDqRkVHSIn1Ry+lO3z+KpnaUuqwYk=;
        b=TPsfmJYY3XsBpE2qb0LJZLq/eC+UvaX+mnCB/ijzgZB/fVazZywBjbbF2smo8o9yJl
         Y2ZwBKYiu5yk4nTYbaH9v//unzDRxqDPbYiH7lNsE5nmzZEma1harOipH95Ihu3q8bok
         qBls1BRRvjSBdLbX8Lu+vM0ysGCXh9r0DrP+Zg2mTqqAHTB+S6gV+j0kt1JSjQkMCt9g
         fB3/rYimOnWbyKfzPvax2yFHg/hXP4aIizK7LQHCHPoPgNfJwsrmkDe+plaxL/4cV/05
         cYqlLrN6iCvSVuJGqRY7XX8I0rbscmmSbQ8iiSAf41YMeSfsZzTpJy0q7sTaK9gQGeiT
         5aQw==
X-Gm-Message-State: APjAAAXCMq6vIqt8QjEL+wujGqid6jOCt/HIGQT+UGYv2wZ7KrF5HOWJ
        sh9lQHYS9/BF8h6ERzh+7Krti41aPs4=
X-Google-Smtp-Source: APXvYqx+yrq9z9Zlkc6R1Q4HkZnkBWmZmpjMJWNJhQbyC+PKAg1BnXF9Ujm6YLmQQU5xX5qYv3HvYA==
X-Received: by 2002:a2e:8145:: with SMTP id t5mr58212ljg.144.1581634086996;
        Thu, 13 Feb 2020 14:48:06 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id m83sm2017565lfa.5.2020.02.13.14.48.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2020 14:48:05 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id w1so8527966ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 14:48:05 -0800 (PST)
X-Received: by 2002:a2e:88c5:: with SMTP id a5mr35496ljk.201.1581634084790;
 Thu, 13 Feb 2020 14:48:04 -0800 (PST)
MIME-Version: 1.0
References: <20200212200335.GO23230@ZenIV.linux.org.uk> <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
 <20200212203833.GQ23230@ZenIV.linux.org.uk> <20200212204124.GR23230@ZenIV.linux.org.uk>
 <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
 <87lfp7h422.fsf@x220.int.ebiederm.org> <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
 <87pnejf6fz.fsf@x220.int.ebiederm.org> <20200213055527.GS23230@ZenIV.linux.org.uk>
 <CAHk-=wgQnNHYxV7-SyRP=g9vTHyNAK9g1juLLB=eho4=DHVZEQ@mail.gmail.com> <20200213222350.GU23230@ZenIV.linux.org.uk>
In-Reply-To: <20200213222350.GU23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Feb 2020 14:47:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjePLiQqUfQGCrNb0wp+EtgRddQbcK-pHH=6rxbdYNNOA@mail.gmail.com>
Message-ID: <CAHk-=wjePLiQqUfQGCrNb0wp+EtgRddQbcK-pHH=6rxbdYNNOA@mail.gmail.com>
Subject: Re: [PATCH v8 07/11] proc: flush task dcache entries from all procfs instances
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 2:23 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> I'd been thinking of ->d_fsdata pointing to a structure with list_head
> and a (non-counting) task_struct pointer for those guys.  Allocated
> on lookup, of course (as well as readdir ;-/) and put on the list
> at the same time.

Hmm. That smells like potentially a lot of small allocations, and
making readdir() even nastier.

Do we really want to create the dentries at readdir time? We do now
(with proc_fill_cache()) but do we actually _need_ to?

I guess a lot of readdir users end up doing a stat on it immediately
afterwards. I think right now we do it to get the inode number, and
maybe that is a basic requirement (even if I don't think it's really
stable - an inode could be evicted and then the ino changes, no?)

Ho humm. This all doesn't make me happy. But I guess the proof is in
the pudding - and if you come up with a good patch, I won't complain.

              Linus
