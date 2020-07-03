Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC14FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 935DC20781
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593738366;
	bh=5gW68oWWeR/I+QEodHrrm8fmKQEGk9tk443l2sVF2Bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hvM8LTr6HvC4kufD39bFaKEGfFtKQE3f3a4sSzB7WwtebCexoFzZ3Zjo2mftoUpCR
	 61paCN87HVtyLjR7/HW8p8sSAbaxgNo9BGObCTHqfYlPRXcTgXRWBD917PdD4zV7Np
	 pxKAF2pK096KxMKRD5VfI5RJNw4ZG6NZddDhFwRw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgGCBGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgGCBGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:06:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3B6C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 18:06:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so19943183ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 18:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xhJ/3m0KcF51XQMCDykPvx6FH+Zxv6t6Wm2boNZX4GA=;
        b=HRnc8Z/UWD1VH3SDqiH4lfspf3ok3r+xS7c66s+ynb3ZzlBkN2PSz5kYMKHrzl7TQ4
         fZ8+IFqVBJWm7YWqXIR8IP8nkdyQC3joTYpIj49kaBTa633kHTrhJhFkqzD8TramRmM1
         Yo4ZUFvd4iiBdz/qOIz2C16Di7gBSp0vYJurQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xhJ/3m0KcF51XQMCDykPvx6FH+Zxv6t6Wm2boNZX4GA=;
        b=HAlj8pvaiCkkftpSoV36G0AA+ubuIMvJRYj1GwGb3Ud95ULzC31TWUnuYWSyIrL0jM
         nPutkE7hcGlAOLTBm5VJnJpN4nKzHpxvbZ4Qipfo+nuPHOAZc1n5OeecNvqIDzCPu2Nt
         7gOYVFurLy1v746b/CUqhyBp7bj/XrAbMPRCe6YQwKEL7zuGpe7i8f0ahKvgjRa7bHVo
         MWf47rolY2trVpMsSGuudbXGT18HMadeTAXOrNq6jAdzIVTej6vBNlmzdDRDpWPi4+wW
         M33KwwF2h8NgWs7ls3Np7yrYsyKJaZQtlAKLz4IMFr118Fk4P00VsndAQb/twQiw65Ql
         l8rA==
X-Gm-Message-State: AOAM530T5YwaUVbsT45sxmX0zFliH4ynbBEpb2idZKy89PJ+65GVPDL/
        0OcviURnzpEEJ+Bye6TfrErm4GIaZX8=
X-Google-Smtp-Source: ABdhPJw1PDtkkVCtMxJ1LyS1ghtgis8TvSRRf9y+M7bbCy2LupG28dmqjqZIydby/hqF4e3nLEUQ8g==
X-Received: by 2002:a2e:b4ce:: with SMTP id r14mr9004514ljm.88.1593738361260;
        Thu, 02 Jul 2020 18:06:01 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id v24sm3997209lfo.4.2020.07.02.18.06.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 18:06:01 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id d17so19943124ljl.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 18:06:00 -0700 (PDT)
X-Received: by 2002:a2e:9c92:: with SMTP id x18mr12604594lji.70.1593738033657;
 Thu, 02 Jul 2020 18:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200702232638.2946421-1-keescook@chromium.org> <20200702232638.2946421-5-keescook@chromium.org>
In-Reply-To: <20200702232638.2946421-5-keescook@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 18:00:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZi-v8Xgu_B3wV0B4RQYngKyPeONdiXNgrHJFU5jbe1w@mail.gmail.com>
Message-ID: <CAHk-=wiZi-v8Xgu_B3wV0B4RQYngKyPeONdiXNgrHJFU5jbe1w@mail.gmail.com>
Subject: Re: [PATCH 4/5] kprobes: Do not expose probe addresses to non-CAP_SYSLOG
To:     Kees Cook <keescook@chromium.org>
Cc:     Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        stable <stable@vger.kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Will Deacon <will@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matteo Croce <mcroce@redhat.com>,
        Edward Cree <ecree@solarflare.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Alexander Lobakin <alobakin@dlink.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 4:26 PM Kees Cook <keescook@chromium.org> wrote:
>
> The kprobe show() functions were using "current"'s creds instead
> of the file opener's creds for kallsyms visibility. Fix to use
> seq_file->file->f_cred.

Side note: I have a distinct - but despite that possibly quite
incorrect - memory that I've discussed with somebody several years ago
about making "current_cred()" simply warn in any IO context.

IOW, we could have read and write just increment/decrement a
per-thread counter, and have current_cred() do a WARN_ON_ONCE() if
it's called with that counter incremented.

The issue of ioctl's is a bit less obvious - there are reasons to
argue those should also use open-time credentials, but on the other
hand I think it's reasonable to pass a file descriptor to a suid app
in order for that app to do things that the normal user cannot.

But read/write are dangerous because of the "it's so easy to fool suid
apps to read/write stdin/stdout".

So pread/pwrite/ioctl/splice etc are things that suid applications
very much do on purpose to affect a file descriptor. But plain
read/write are things that might be accidental and used by attack
vectors.

If somebody is interested in looking into things like that, it might
be a good idea to have kernel threads with that counter incremented by
default.

Just throwing this idea out in case somebody wants to try it. It's not
just "current_cred", of course. It's all the current_cred_xxx() users
too. But it may be that there are a ton of false positives because
maybe some code on purpose ends up doing things like just *comparing*
current_cred with file->f_cred and then that would warn too.

              Linus
