Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99922C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D426206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592250541;
	bh=t1xX5Axd5jpq6f7yR7Yl6YFOeuNV48KrN/EQHocVNp8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=N/6VayzMLqfAUvQ5XaktiDX7RWhp0DiCTJJXEmg2od7C8ETOwiYWThchipbsk2Wkh
	 dMwnrqfEuQE//CG4gqL5AXg8vdwTH5eyKE9rjYVOBfpGmtX/NLZavfb2uji78DWhCQ
	 pWRtMv360ulPujcU6pJqk51AynbjnomnMOBIUN1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730119AbgFOTs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOTs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:48:59 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59C7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:48:58 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so10308140lfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nMQDwHREIgI2Q4d1JP7S3QvPXAMCKxWBeAQfVzDTIO8=;
        b=EzH0DkAhC0DuxLBnloyscPL9dYyHQfMXECSN7zVPLlxkItz+Sms+vPmlJh8yMtrN6j
         r1Ilk9CzMhW6Exdhn7m8a6DKdd190exXIHGjlst6leIq7NECu9PafZeoE8dPyetFkffZ
         I/w+icohaFwgWtR0ZhYXnY1VqGBJ3st1Hepvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nMQDwHREIgI2Q4d1JP7S3QvPXAMCKxWBeAQfVzDTIO8=;
        b=bx2LZF6AazoRmMsuNmj6mNsR3fkE+Ubw3pCAjzIuBR6jWveqQn8Pwunxl2vI90gGRw
         t5gBvAivztKV7v2qyHRysnqlBd0jHn9r1bQaaQQseQXMvyXGZ+FnsGxqU+85MMSohgaD
         l1tGNLqfkPZaX19wbKKWuzW0ebOxTkUCjAgdL3i2JBoYtYtJH5StsDTuerz1E1cMHHXJ
         6YrDnYLclAOF7zyoVlSbAEXLK/GxaGrPY2IGReK5ckPLD3yuTSN/PyIGbz+tdcLBzh22
         rS857sgDVnZjccRe9P7qUUY85iQRZBk9FfOU6NotPKSUY+w9X9N9UQOIQLT6nWDKH/hk
         wCKg==
X-Gm-Message-State: AOAM533Ir+WfKMLquKfC0SizfyWsEGmJaLImblOlXui7/7g8gaZpkiQZ
        1T2YNKDZOiEn9Ogeyhk2j1TiyPSVPj4=
X-Google-Smtp-Source: ABdhPJw0KNyYHfykWmy/Z3uZBjjfRp8OOoAhAr0fG6MXh/jaRst9jbYeET/KeFG/vzFd0emkdjspLw==
X-Received: by 2002:a05:6512:3049:: with SMTP id b9mr14212811lfb.44.1592250536526;
        Mon, 15 Jun 2020 12:48:56 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id v28sm4744935lfd.35.2020.06.15.12.48.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 12:48:55 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a9so20699271ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:48:55 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr12783607ljn.70.1592250535103;
 Mon, 15 Jun 2020 12:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
In-Reply-To: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 12:48:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmZzz6b_9iBGp+3Nysb0A6_3VatmUdr_ArgyqHq0KMcA@mail.gmail.com>
Message-ID: <CAHk-=wjmZzz6b_9iBGp+3Nysb0A6_3VatmUdr_ArgyqHq0KMcA@mail.gmail.com>
Subject: Re: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 11:48 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> I am seeing the following problem on my system. I haven't started debug
> yet. Is this a known issue?
>
> [    9.791309] BUG: unable to handle page fault for address:
> ffffb1e78165d000
> [    9.791328] #PF: supervisor write access in kernel mode
> [    9.791330] #PF: error_code(0x000b) - reserved bit violation

Hmm. "reserved bit violation" sounds like the page tables themselves
are corrupt.

> [    9.791332] PGD 23dd5c067 P4D 23dd5c067 PUD 23dd5d067 PMD 22ba8e067
> PTE 80001a3681509163

PTE low 12 bits 163 is "global", "dirty+accessed" + "kernel
read-write", so that part looks fine. The top bit is NX. I'm not
seeing any reserved bits set.

The page directory bits look sane too (067 is just the normal state
for page tables).

The PTE does have bit 44 set. I think that's what triggers the
problem. This is presumably on a machine with 44 physical address
bits?

The faulting code is all in memset, and it's just doing "rep stosq" to
fill memory with zeroes, and we have

    RAX: 0000000000000000 (the zero pattern)
    RCX: 00000000000008a0 (repeat count)
    RDI: ffffb1e78165d000 (the target address)

and that target address looks odd. If I read it right, it's at the
41TB mark in the direct-mapped area.

But I am probably mis-reading this.

Better bring in a few more x86 people. We did have some page table
work this time around, with both the entry code changes but also the
vmalloc faulting removal.

It doesn't _look_ like it's in the vmalloc range, though. But with
that RCX value, it's certainly doing more than a single page.

> [    9.791367] Call Trace:
> [    9.791377]  ? snd_pcm_hw_params+0x3ca/0x440 [snd_pcm]
> [    9.791383]  snd_pcm_common_ioctl+0x173/0xf20 [snd_pcm]
> [    9.791389]  ? snd_ctl_ioctl+0x1c5/0x710 [snd]
> [    9.791394]  snd_pcm_ioctl+0x27/0x40 [snd_pcm]
> [    9.791398]  ksys_ioctl+0x9d/0xd0
> [    9.791400]  __x64_sys_ioctl+0x1a/0x20
> [    9.791404]  do_syscall_64+0x49/0xc0
> [    9.791406]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

Can you re-create it with CONFIG_DEBUG_INFO enabled, and run it
through scripts/decode_stacktrace.sh to give more details on where it
happens.

              Linus
