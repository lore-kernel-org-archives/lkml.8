Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28DF5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2D0D2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592254577;
	bh=Sagple07xyCIsPdgjQ8Ny7Cwrnw7GIvSTODh1SoJ+9Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=r7gFptoMSt75BF8+KeG+PSZW181DrGGv7hgx23nEhoN1IleFNNLt0ZJmKJTM7Lkpf
	 kpK3deCFMjx8kpjep28tBZknYu4K/wNi6a3iAz9qMVkxomnHoOWGj2B7mKM5dQO5Ll
	 VqfZ7z7ripclwxTCDFxM5U6orNu+/ivcoecFpZiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731497AbgFOU4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgFOU4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:56:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EB2C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:56:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z206so10421883lfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66wParxW9Grg3BmLz9POwK3vmAg5lmpdxczfAkn21rk=;
        b=Y8w2RpI5MgG4oOHdSMJeKvl3r9qwdxDiEWmWPIj5D0+dd6+sh9TXOigVDK/AbVK0rh
         +Y+rX8wNNc43lwaLCNrfMuTBUIk8Mf9+a+ySN104CNOqEmN4r2sqw0/2vz9EV5PvhKzI
         oJoRR1VwFRobbCeiZLtjL7+IohACJ8a8FSoDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66wParxW9Grg3BmLz9POwK3vmAg5lmpdxczfAkn21rk=;
        b=NmzlYZ7et2AalgSnFvYVq6Xp+zigqqCoYCER2rWJ5oPCFTy5GKSZQWKUsm5E94ig1F
         F2am9ss1iiEUmMgwiuy17ue1dC3UV4O5kXZU9zXcRf7J9M88T6GurzOROJ9lOBUg2ZK9
         KROe7rLIXTM/n0JGofqv07mnMU28EzC6Roa1MM23TTuEZONgsxp7ZSUWtLerL+rpbSb8
         1UzAmK2tYHGzmIRzii0McdOdEzs/PQZ/IfgRKb3yEVF4fDOTxcoq2WlwRP+dTSxzRrUJ
         DnJOt5jAzC3LmoGhguSzEQV5pjFJmjTRBfariIGc8F1eQ7geEVJ+T44dCe2SYaSkXMc1
         3v+g==
X-Gm-Message-State: AOAM532+s/hinhzxvVAuvHNl+RasoBeCk9HEVc3KUYt0OLCEMIquG+Ii
        CXplM8/xPxArEOTJBB77NPt3kw6B9nA=
X-Google-Smtp-Source: ABdhPJxtC47H//lCLUf83zg4mKmg6rjpGRHfgDTWJVnw3gifPDEEttEXucYt4yp/FlXxGXZMiQD4jg==
X-Received: by 2002:a05:6512:10c3:: with SMTP id k3mr14744835lfg.33.1592254567977;
        Mon, 15 Jun 2020 13:56:07 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id y22sm4768778lfh.12.2020.06.15.13.56.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 13:56:06 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id c17so20868242lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:56:06 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr13342489ljj.102.1592254566141;
 Mon, 15 Jun 2020 13:56:06 -0700 (PDT)
MIME-Version: 1.0
References: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
 <CAHk-=wjmZzz6b_9iBGp+3Nysb0A6_3VatmUdr_ArgyqHq0KMcA@mail.gmail.com> <f5102546-786d-eb63-10c5-97a92c0be311@linuxfoundation.org>
In-Reply-To: <f5102546-786d-eb63-10c5-97a92c0be311@linuxfoundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 13:55:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
Message-ID: <CAHk-=wgB6xs-gfihkMSngyAcRHaQ0oE3jVawVMzzAh4Xm0VsSQ@mail.gmail.com>
Subject: Re: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>
Cc:     Joerg Roedel <jroedel@suse.de>, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 1:41 PM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> I have CONFIG_DEBUG_INFO enabled. Ran the stack trace through
> scripts/decode_stacktrace.sh

Thanks. It looks like it isn't needed and people already know what the cause is.

Also, sadly the stack trace decoding didn't end up as useful as it
could have been because it looks like it doesn't know how to do the
nice address lookups for modules.

So this:

> [   15.341237] RIP: 0010:__memset (arch/x86/lib/memset_64.S:41)

gets nicely pinpointed to the source, but the most critical part of
the call trace is in modules, and there we end up having just

> [   15.341259] Call Trace:
> [   15.341267] ? snd_pcm_hw_params+0x3ca/0x440 snd_pcm
> [   15.341272] snd_pcm_common_ioctl+0x173/0xf20 snd_pcm
> [   15.341277] ? snd_ctl_ioctl+0x1c5/0x710 snd
> [   15.341282] snd_pcm_ioctl+0x27/0x40 snd_pcm

without then looking at the debug info in the snd_pcm module to figure that out.

Then when the call trace gets back to non-module code, it looks good again:

> [   15.341285] ksys_ioctl (fs/ioctl.c:49 /home/shuah/lkml/linux_5.8/fs/ioctl.c:753)
> [   15.341288] __x64_sys_ioctl (fs/ioctl.c:760)
> [   15.341291] do_syscall_64 (arch/x86/entry/common.c:359)
> [   15.341294] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:124)

with pinpointing to exactly where the calls are.

I note that Konstantin Khlebnikov did add support to do the module
parts too back in 2016, but it requires people to know to give the
module path too.

Adding him and Sasha to the participants in case there are ideas on
how to improve on this (and party just because I want to once again
give scripts/decode_stacktrace.sh soem more mention, because a lot of
people seem to be unaware of how useful it can be to make oopses and
traces more readable..

Maybe even just a warning about lacking a module path when there are
module symbols present?

             Linus
