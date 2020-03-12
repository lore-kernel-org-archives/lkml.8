Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1722CC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E03FB2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 19:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gv9TICZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgCLTXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 15:23:19 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33819 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgCLTXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 15:23:19 -0400
Received: by mail-qv1-f66.google.com with SMTP id o18so3251072qvf.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3/8Ru3hZdAQekG+olG74Zgi2RNI64dD7vAaQTY0BEw=;
        b=Gv9TICZrSjwUOGilZDUvOgADeCujv/uOSfTiozXIbJ/Kk/Whu8ZQxEa0IchCQE+ej9
         oyM76va69ygiG+VRqZkflhU3HdaXYGMoHDigQSfBEkoN0trGYuMz9UKdyAMilwn8ww2V
         kiwLbn9IUgeXkp1hZXUdBOiYBUfAsokU4bR/6eAnOuSfZlEKfCbMKvJSj7a0xEREZQZz
         fBegszz4vVDw294hrX0IxdVxs7hRn3PvuS3B+ArtIbJqP4NhiOh8hpe1LF+dpDMDwRun
         7oDTUMU9nOdC17+8UOCHrDAsaTp/JSHxzmN25ErTYnZ/DPq0TIGWuTJTuLiF48pFQTSQ
         kDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3/8Ru3hZdAQekG+olG74Zgi2RNI64dD7vAaQTY0BEw=;
        b=pOJZ1Y987ot5/kiVGIdEZ+2/ihRZcqwlPUcMXXmvcIKj0AYp8dYd5WI7Xooz8NhRQ0
         pfhz3MSuLyVs+is5Rek4Zxb6cydHdjCCeGnl8UgZXq0zrhWo47iK4RaL/luvI3zIDk0Z
         XwvU56E5LGnLWv2xLCaCXVOD42oUuxQliVVmGjZlwtVOK9DTxtJ6durgvbdj3wMQ27Kt
         DNauZyNxKIUXwPeKMCy5yhKlMV5ZEaHlMk+tA4yYz/OjhJpCOuS9KfqxjH+2D+5lJNgh
         NNrkrOesacRbgTdV5eyupJoLALKHWY7iH4AFgdoJIlJs1eYM6SlX25fGXXxbhfxFTRIv
         qdmw==
X-Gm-Message-State: ANhLgQ27lQO/7GkBBcmNFUUUzgufFL8GRy1cS0KrMEqXKRjlWw8kGVzB
        SzY783uG4O9IQ0NcWYXYV1+kc/6+YY49jOoif2x5Ng==
X-Google-Smtp-Source: ADFU+vsEpj82qr2NLHcKYAE0JNEDCDRHFtrmXtAfYaENmGzg9TU7mWj6+RB8YZTwXJNmSFikMlia50cj/gwZo95n3I0=
X-Received: by 2002:ad4:4bc6:: with SMTP id l6mr8913610qvw.34.1584040998116;
 Thu, 12 Mar 2020 12:23:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200307135822.3894-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <6f2e27de-c820-7de3-447d-cd9f7c650add@suse.com> <20200308065258.GE3983392@kroah.com>
 <3e9f47f7-a6c1-7cec-a84f-e621ae5426be@suse.com> <CACT4Y+a6KExbggs4mg8pvoD554PcDqQNW4sM15X-tc=YONCzYw@mail.gmail.com>
 <20200311101115.53139149@gandalf.local.home>
In-Reply-To: <20200311101115.53139149@gandalf.local.home>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 12 Mar 2020 20:23:06 +0100
Message-ID: <CACT4Y+Z5co4HyQBj6-uUdqT2Vk=6jgT-aQXuPtjx3qV4C_pZ7g@mail.gmail.com>
Subject: Re: [PATCH v2] Add kernel config option for fuzz testing.
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 3:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 10 Mar 2020 07:30:01 +0100
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
> > Steve, I am not sure if by lockdown you mean the existing lockdown
> > mechanism, or just something similar in nature. As Tetsuo pointed, the
> > possibility of using the existing lockdown mechanism for this was
> > discussed here (and rejected):
> > https://lore.kernel.org/lkml/CACdnJutc7OQeoor6WLTh8as10da_CN=crs79v3Fp0mJTaO=+yw@mail.gmail.com/
>
> From Matthew's message a couple of emails earlier:
>
> > Simplicity. Based on discussion, we didn't want the lockdown LSM to
> > enable arbitrary combinations of lockdown primitives, both because
> > that would make it extremely difficult for userland developers and
> > because it would make it extremely easy for local admins to
> > accidentally configure policies that didn't achieve the desired
> > outcome. There's no inherent problem in adding new options, but really
> > right now they should fall into cases where they're protecting either
> > the integrity of the kernel or preventing leakage of confidential
> > information from the kernel.
>
> Now, if you are worried that fuzzing will cause harm, or crash the kernel,
> it sounds to me, whatever fuzzing did would satisfy Matthew's "integrity of
> the kernel" portion.
>
> In other words, I believe fuzzing folks should be working with the lockdown
> folks and letting the lockdown folks how root can crash the system. I would
> think from a security point of view, that if there's a known method to take
> down the kernel, and I don't want root to be able to do so, we should
> either fix the kernel to not be able to do so, or if that interface is "you
> should know what you are doing" then it should be something an admin could
> lock down to keep other admins who don't know what they are doing from
> crashing the system.

The line crashing the system (for some definition) and
working-as-intended is somewhat fuzzy (no pun intended). E.g. FIFREEZE
is it crashing the system if used uncarefully? Or connecting a USB
keyboard programmatically (which can inject CTRL+ALT+DEL)? Or turning
off console output?


> Or teach the fuzz tool not to do specific bad things.

We do some of this.
But generally it's impossible for anything that involves memory
indirections, or depends on the exact type of fd (e.g. all ioctl's),
etc. Boils down to halting problem and ability to predict exact
behavior of arbitrary programs.


> Honestly, if you just go with a single config to prevent interfaces from
> crashing the system while running a fuzz test, then you just lowered the
> usefulness of the fuzz test, as it will never find legitimate cases where
> that interface crashed the kernel when it should not have.

I believe "coarse-grained" above refers to something different. We
don't disable whole subsystems (there are usually configs for that
already), but rather we have a single config that does small tweaks to
multiple subsystems (e.g. that single ioctl is disabled, etc). This
allows to still test majority of the subsystem, but just not that
single bit that is harmful.


> We are currently trying to clean up the tracing / probing code to not be
> able to crash the kernel with any interface. It's hard, but it is a goal.
>
> -- Steve
