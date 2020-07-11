Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAB2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 22:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D4C206A5
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 22:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="Tu+br38l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgGKW2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 18:28:44 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:35771 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbgGKW2o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 18:28:44 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c50e4350
        for <linux-kernel@vger.kernel.org>;
        Sat, 11 Jul 2020 22:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=tHmjuOtOeEXsejtJ+4YLouIDGXo=; b=Tu+br3
        8lYRYCdGLXuMiU7bnfcwpstjH2v/TBBR/aImRkKazp0MZAo4EULtofn9IK8lD8li
        GCso5n28ntNDDRYzyh39cEPeZsgH284ZaKcG2l+EKU4FkFLVaIn757ZJuYzZd0Xo
        QICZ/lkW9kEkoyhnTNxNGy2RPmLDsCxOkFNtEk+EogXsL/Mm0uC7n6GK7fzkkOEe
        Hs6wRCfCoYWP/1TMUrPCV3aD5HLxC2ZV69Jllll7nqLrJrAyoKxtQr+kxD38twjd
        haxHlhfUmzr7K4TF9PgmLl/N/m+lN5gPAbWe8aZuLFvt9xUJsgvKKnoXWzFBPio0
        XevjW0/4f0kQI01w==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c9b6a749 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 11 Jul 2020 22:07:25 +0000 (UTC)
Received: by mail-io1-f52.google.com with SMTP id p205so1175879iod.8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 15:28:41 -0700 (PDT)
X-Gm-Message-State: AOAM5329jqfqvEKi8wjfmHcVMTzjbijXFSQOaFGCSpI5wLwUtEY4uyz9
        wD4tnC9etAHNlbcSACsliMem4bQ6047yhL6B1GA=
X-Google-Smtp-Source: ABdhPJy/LAe4LHsK4Je/M460Rz6W+u43TcvVtnGuQAJ4f1vZHX7k9NwI+f9SQsoj0nCK3/3J7zN6E6gZ74aLr0DQrMI=
X-Received: by 2002:a05:6638:dcf:: with SMTP id m15mr85722623jaj.86.1594506520979;
 Sat, 11 Jul 2020 15:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200622030222.1370098-1-Jason@zx2c4.com>
In-Reply-To: <20200622030222.1370098-1-Jason@zx2c4.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 11 Jul 2020 16:28:29 -0600
X-Gmail-Original-Message-ID: <CAHmME9o84kCsK=J-c59gP9RhhzApkwMeh9Y95UeRG8Cs-2ED=g@mail.gmail.com>
Message-ID: <CAHmME9o84kCsK=J-c59gP9RhhzApkwMeh9Y95UeRG8Cs-2ED=g@mail.gmail.com>
Subject: Re: [PATCH] Revert "kernel/printk: add kmsg SEEK_CUR handling"
To:     Petr Mladek <pmladek@suse.com>, LKML <linux-kernel@vger.kernel.org>
Cc:     Bruno Meneguele <bmeneg@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 21, 2020 at 9:02 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> This commit broke userspace. Bash uses ESPIPE to determine whether or
> not the file should be read using "unbuffered I/O", which means reading
> 1 byte at a time instead of 128 bytes at a time. I used to use bash to
> read through kmsg in a really quite nasty way:
>
>     while read -t 0.1 -r line 2>/dev/null || [[ $? -ne 142 ]]; do
>        echo "SARU $line"
>     done < /dev/kmsg
>
> This will show all lines that can fit into the 128 byte buffer, and skip
> lines that don't. That's pretty awful, but at least it worked.

FYI, bash finally bumped its read buffer up to 4k, which actually
makes reading /dev/kmsg less awful than previously thought:
http://git.savannah.gnu.org/cgit/bash.git/commit/?id=6edcd70089d71ee8c17bf3298527054b3223be9f
This is probably too mundane to warrant an email, but in case somebody
finds this thread in the future, voila.
