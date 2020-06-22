Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1ABC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 204DE206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592797836;
	bh=Il2sZwUvesEn74y95uUgGMq0HmpO8RIeZYx2xfUvUFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eS+URHMqS0dq6JuznIe5kZQaymICiPsYID7yZx8XpbSS7obG2aDiAQriU0WCko5Px
	 pJHy1dY4xP3FhZ1phR3mM+XzKXIKj4hLC+3ZM/Iy7QBXTRHUzz365MHDXXRcGRcBCb
	 xK/9rp2E1Y1DmEpwpmgqeia0R4298LRxzFfyDQuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731063AbgFVDuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbgFVDub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:50:31 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6CFC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 20:50:30 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c11so8735838lfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 20:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1MQBHhyMZkPAJV79BAo7BFoOxokarl3OUQ7F4YaqYDg=;
        b=QU7TYK9myuQFDbo/upObAnH7FMsutR8r2Xn6J87H0jTWTJOSP0dTiNcnkysYLNorke
         HYDJlH49PuQvjArWiUtX6qlEvgwys0IoWd9XA2hhAY/UUMW/lndTKZrOtcsoY6Jwkb6L
         LnwR8MvwtrfvxWGH3T/u7KSBcqVnnCxPXP0NU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1MQBHhyMZkPAJV79BAo7BFoOxokarl3OUQ7F4YaqYDg=;
        b=kzMt7e8qKKF26yIzb0sBKS5qTyTX6y6924BMNr8r1ITDEUjM1pCtnhqNRYtVuSr/fJ
         F6uqtw9DvHBUX/xRz0sc4LdI127hhfQRmYbuDvkZ4Z3YY0whQVmsM79Kq7k36xz6EbVM
         NOButgSLW8IYwur5RATBRmr9uqZkJ/1OBBN5trk9aejIXW8GefQ/TowjoauEcvzIgUyt
         m29sCzXVbtYqshMAUbQbWhK4gwrM7Fwpf8jZ+G4F8KNjI647J4972XfmQ/QNqZIKOlux
         1oBmZndlkHQj0a1h/Td3ll4Vy+xY5VUt21zLOkapGpJNKaG2W8ZahqL0oE8x94scyPF1
         g6IQ==
X-Gm-Message-State: AOAM531DSmf1sVMXBboxlhkp7e9Y+H0e15XR9jT6xemlpI/cUVUSCn3k
        K2FdJf79e3VgU66dri0N+93FgMy7Xs8=
X-Google-Smtp-Source: ABdhPJzE/nQ1VQqdpeaJSQCu1SJUw55YJohYGtUmCkypAXYuoWA1xYZIGEkPQ6HHOPHWrteiPWLpcg==
X-Received: by 2002:a19:4301:: with SMTP id q1mr8568726lfa.96.1592797827265;
        Sun, 21 Jun 2020 20:50:27 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id l22sm2493348ljg.41.2020.06.21.20.50.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 20:50:26 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e4so17602338ljn.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 20:50:25 -0700 (PDT)
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr7407154ljj.371.1592797825626;
 Sun, 21 Jun 2020 20:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200622030222.1370098-1-Jason@zx2c4.com>
In-Reply-To: <20200622030222.1370098-1-Jason@zx2c4.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Jun 2020 20:50:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5TPoHih-8m+s9UNShiKavUFLacmHFmNbDrXQem43kSA@mail.gmail.com>
Message-ID: <CAHk-=wj5TPoHih-8m+s9UNShiKavUFLacmHFmNbDrXQem43kSA@mail.gmail.com>
Subject: Re: [PATCH] Revert "kernel/printk: add kmsg SEEK_CUR handling"
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 8:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> This reverts commit 8ece3b3eb576a78d2e67ad4c3a80a39fa6708809.
>
> This commit broke userspace. Bash uses ESPIPE to determine whether or
> not the file should be read using "unbuffered I/O", which means reading
> 1 byte at a time instead of 128 bytes at a time.

Ack. Somewhat odd behavior, but clearly user space depended on the
legacy "return EINVAL rather than ESPIPE" behavior.

I do think there are other reasons to not return ESPIPE. The fact is,
the printk buffer _is_ seekable, it's just relative seeking that
doesn't work. You can seek to the beginning and the end and a
particular offset, just not relative.

So I kind of see why people wanted to return ESPIPE, but at the same
time it really is very misleading: ESPIPE is for pure streams that
can't lseek at all.

The fact that some silly shell internal then reacts very badly to that
may be extreme, but it may be as well as you can do it you worry about
leaving data for the next user.

I've applied the revert.

             Linus
