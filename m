Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B3FC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC66B2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588697547;
	bh=juvGSHZ59LWg55H0/g10X6Ke5hXipdAxrYX3JGvA05Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aFeCTJXSAF3di7RI1eiNvqd652BkJmTLflaD0tlKYRObumFiCfLlU2P/XDW77wrkW
	 OaPhz6cOvp/MBydB+SY/3+48vwOwfBTGlcyRzawof4dLnqnyIykdM9oHtv+QvJQx5h
	 mI0hjduDrTibSqnmDi7MBk98Nje0C2kqwTuwQwbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgEEQw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729747AbgEEQwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:52:25 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C51C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:52:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u15so2374357ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9hFXujfAx2/iHidBrnKhRaNUObDjx6hbclJAooxUbFo=;
        b=eb7GI2X/XrhuAn2Vm+U9831w2ibE6cHnWF7F9S99pPGIKJ581y9sIjG0fOlnKnr8XU
         3l3RpH6pJHtIm3ZTaZWOJ1vg4eqLgQyIQUJKPk6h3hKYNOZAM/NKILDQePeV8IKRtcTz
         txmKNoel5w65lmX1pdFQXgC+9b7bhZqgRSUAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9hFXujfAx2/iHidBrnKhRaNUObDjx6hbclJAooxUbFo=;
        b=OQ28oLqCjl2y6Ar7RLSQOWBjDmltWWVTrrZ7uslDNgLTTcxEb0x+MZWaQyyTJ8Jn7Y
         QRw/v+tDfWcIpDyLHxSMvWZbnVo9Z2sv2zoYnBfV4byHwPcxEj2pBrTc6Pt2oVMzQNbb
         FTMWURaqAlxG4xtw1m68us+ETKDAw5L894PqQnERxrHJ/9M+Eid+Yd5KwAxnChiyscC4
         EFkZ9TEDTuSkI8DPapKUNLkkvmqK4qAF+BZlzOKkSjBLu9FLuDjLjw2Xcx8OXl/LbxDu
         Adbubg9c2TAJz/ph2vQ+eJTYw+dwpxVcle8dsN+v0Cdq8QPA1ge8dQmUvDKqFZjeZvE6
         AeHg==
X-Gm-Message-State: AGi0PuYRkO1ImR2yNrRWRo+QKATel7Sj5gktI0SnJLFDqSsM97c+Cq4h
        4Bx4MSt7psYFjGyqOJGJ9Au8+YtUezA=
X-Google-Smtp-Source: APiQypIedb5mOT0y5ACJZsVZdI+/Hf1/R6WwSNLnLp93Wa1VDRI/rRiwrrNhQUmY5a2rFpL7n5YMqg==
X-Received: by 2002:a2e:88d8:: with SMTP id a24mr2397500ljk.224.1588697543143;
        Tue, 05 May 2020 09:52:23 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id l2sm2134420ljg.89.2020.05.05.09.52.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 09:52:21 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id a21so2346971ljj.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:52:21 -0700 (PDT)
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr2307697ljj.241.1588697540733;
 Tue, 05 May 2020 09:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200505101256.3121270-1-hch@lst.de>
In-Reply-To: <20200505101256.3121270-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 5 May 2020 09:52:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgrHhaM1XCB=E3Zp2Br8E5c_kmVUTd5y06xh5sev5nRMA@mail.gmail.com>
Message-ID: <CAHk-=wgrHhaM1XCB=E3Zp2Br8E5c_kmVUTd5y06xh5sev5nRMA@mail.gmail.com>
Subject: Re: remove set_fs calls from the coredump code v6
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeremy Kerr <jk@ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 3:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> this series gets rid of playing with the address limit in the exec and
> coredump code.  Most of this was fairly trivial, the biggest changes are
> those to the spufs coredump code.

Ack, nice, and looks good.

The only part I dislike is how we have that 'struct compat_siginfo' on
the stack, which is a huge waste (most of it is the nasty padding to
128 bytes).

But that's not new, I only reacted to it because the code moved a bit.
We cleaned up the regular siginfo to not have the padding in the
kernel (and by "we" I mean "Eric Biederman did it after some prodding
as part of his siginfo cleanups" - see commit 4ce5f9c9e754 "signal:
Use a smaller struct siginfo in the kernel"),  and I wonder if we
could do something similar with that compat thing.

128 bytes of wasted kernel stack isn't the end of the world, but it's
sad when the *actual* data is only 32 bytes or so.

                Linus
