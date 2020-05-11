Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BC7C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30E65206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589225661;
	bh=XbMYjrbbwHPO3ig7RAxLoahzBKjFR+CIncwBbtQtBsA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tw8bxf6N3rnxgG0s+eztoooMGJwzLUv8OADRWTlRRr2xycczOGRF7ELpBbfpcrYlj
	 Y10QOpYfBNpomiwESyB65StomuYeEuC+OKD0N91VfZN2RGn0OAmOCTzckzjWZp8hdr
	 g9Mw5eAwu/Zx9CKQ3JTqpElZ14IS7LTr4l4NbBic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbgEKTeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729453AbgEKTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:34:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48967C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:34:18 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x73so8543481lfa.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PdupfeR3R25/tcJ9rHIR0mur+MFPzqZKr63niiEJHBQ=;
        b=HYP9BaJozO8xTGyBSvFhj4mC89PmhhTI5wZVLw+Kgc3WQf9Nwye77lYnha2qpi0I2A
         VBcJc9qDjyWIVlWckj0XXhgIAjbs3ZHtkX61q7XTI8o0EQDcaDzqzRFwqWSDYsvwqGrT
         Ov6zjgkib3vCJNCHlIf43Lo2HfEgaZRPOj2s4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PdupfeR3R25/tcJ9rHIR0mur+MFPzqZKr63niiEJHBQ=;
        b=hmBh9cEPoSkSwvVj+Uhb0q5rGLzxb6CFQDzSJtMKELlqpFysNACBChz+CAvuljfDAX
         etzYx3bAbysqBzVWzLyz5z8TuejUCRthSfcQDrs1pPm3hyOH0cDrAlWyMQl2mDD/tOZx
         DCj7kK6y62H/sxCWto9z+ZqjeYTV1goNDJ3wR1ZMyUhgpwjjL9dhjq1YbmOMeNBz8pKi
         M5ILz9SOw/xL/QuZzki1A0/OCPdYYjUjHkCzhLM49ywpEc7QHhmyG7eGUz+cTLcDNUWg
         TOWV6LirmLYrgHwfdDSAYgI+cgb2Jgz0C9mAO/diYPuojfLL8dJirJHExXOCyT1mU914
         hLYw==
X-Gm-Message-State: AOAM530HDtvx0X4DTkWgo5r6tgNzGAOVFo8a5tdunN1oBLVhWEIl34Q9
        6Y1cUz8W3Hf4cRzZW08ZVELoUMlBaO0=
X-Google-Smtp-Source: ABdhPJwB570I7HGPInkou/63URfUmevCNZWV17JqKx+Ob+U/C/E/P8G/PZAIrylBZvtCwuPq1st3kg==
X-Received: by 2002:a05:6512:3ea:: with SMTP id n10mr12163041lfq.127.1589225656331;
        Mon, 11 May 2020 12:34:16 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j21sm10067193lja.2.2020.05.11.12.34.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 12:34:15 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id b26so8540405lfa.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 12:34:15 -0700 (PDT)
X-Received: by 2002:a19:4816:: with SMTP id v22mr1923457lfa.30.1589225654675;
 Mon, 11 May 2020 12:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
 <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com> <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
 <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
In-Reply-To: <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 12:33:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=SbaC20nRx5tmAZ2_tOpVOq7469V+KvZU9=4yvfvmnA@mail.gmail.com>
Message-ID: <CAHk-=wi=SbaC20nRx5tmAZ2_tOpVOq7469V+KvZU9=4yvfvmnA@mail.gmail.com>
Subject: Re: I disabled more compiler warnings..
To:     Paul Smith <psmith@gnu.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 10:59 AM Paul Smith <psmith@gnu.org> wrote:
>
> As with all single-threaded applications, though, the problem is the
> difficulty (in a portable way) of handling both signals and wait*(2)
> reliably...

I do wonder if GNU make isn't making it worse for itself by blocking SIGCHLD.

I wonder if you could just have three different file descriptors:

 - the "current token file descriptor"

 - a /dev/null file descriptor

 - the jobserver pipe file descriptor. This is left blocking.

and then make the rule be that

 - the SIGCHLD handler just does

        dup2(nullfd, jobserverfd);

   This guarantees that any read() that was interrupted by a SIGCHLD
will now reliably return immediately. But it also guarantees that if
we raced, and the SIGCHLD happened just *before* we did the read(),
the read() will also exit immediately.

 - the waiting code does

        check_child_status();
        for (;;) {
            ret = read(jobserverfd, buffer, 1);
            if (ret == 1) {
                .. we got the token successfully, do whatever ..
                return;
            }
            /* The read might fail because of SIGCHLD - either we got
interrupted, or the fd was replaced with /dev/null */
            /* First, re-instate the pipe binding */
            dup2(pipefd, jobserverfd);
            /* Then do the child status stuff again */
            check_child_status();
            /* Ok, we can restart, there's no races with SIGCHLD */
         }

which fundamentally doesn't have any races. Look, ma, no need for
nonblocking reads, or pselect().

I don't know. Maybe I missed something.

               Linus
