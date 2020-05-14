Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749CCC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8F5206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wgk2rSnu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgENDuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 23:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgENDuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 23:50:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274CDC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:50:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i15so1978362wrx.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XMTc98UIvyXvpMeARxQhAw8UFvYP9zjRrMHTZktrDvE=;
        b=wgk2rSnuCu0b50yyTPjkGCFFlEiDvjPrYOiDulK1EirNq9VluSpFZUDuQeDaldkJJk
         HSUQagu4QMLAURFsWgchUoFXBpIuwem+UgnroBxJHloT4izDBfjUE4gf/gP2GdsPbxbY
         +pxAl1i2QF5M8EtwjBt59q0Fik7kx1jxkt/8sRTelmVY6CmtLpT5jfySJ9iJwyeB0iHh
         lqT1versBBzbyiGx0jRalDYFGHV419ly9WOSW/fEhEH+cLGdsQPrnk9gc/9jqb+DiI2u
         u3kr5+6JFji8rZPfnTnkQsPpVz+ueum+D5aIjP6/4YctO3iBn+DIeoY38AsrYo/AEG1+
         lEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XMTc98UIvyXvpMeARxQhAw8UFvYP9zjRrMHTZktrDvE=;
        b=iynldUA+fGODnyf+XPyV+aeePuIUiN1UJZ1KhVrAls7rNhLWjaW/KenBLbn0YCSmaQ
         k8mJf7gO1EQwXfq2leMItKuLzxRF3eZKoGjl3RLoiYLtrDpYQchB2MpVTCwjqJ2qMraK
         jt994qdG0Ifso1+3zHl4PM9rosxn5zLbncvwOtFKf1gM3oZ3yTGMQspSy8NPob88W74p
         2Bp221Ws7tUqpa6Qle0S/5/ZJYjvvFXc+eYz2OKM4K6VLtWFOUoNv3t3Xwij72sYOWpV
         EWWsLszEtfBwMLHlo3Bn7vK6EAGCZdaaMzaRH8UWQ3FdeOFLKjQ1liugnfCyLlAVHSJT
         yUog==
X-Gm-Message-State: AOAM532iR+4eWcGru4z3KHxsUHccdP/9rRtGy/tTj435jHf3vNIA1lY+
        fW8J2wxGt6rwcJDUqk0u7HJgBYu4kDYmtXKEz4J0vg==
X-Google-Smtp-Source: ABdhPJxGuvDaiuvG6Ya4B15DrM/wXwUhKcfyYOzGzij3FdeitgnfmiRUayKqkaOmX8vReE8neotGEf7u+un7HzcBoCM=
X-Received: by 2002:adf:a389:: with SMTP id l9mr2958751wrb.18.1589428214741;
 Wed, 13 May 2020 20:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200509120707.188595-2-arnd@arndb.de> <87v9l24qz6.fsf@kamboji.qca.qualcomm.com>
 <87r1vq4qev.fsf@kamboji.qca.qualcomm.com> <87d078tjl0.fsf_-_@kamboji.qca.qualcomm.com>
 <20200513154847.GA158356@rani.riverdale.lan> <CAK8P3a3KpM91+jv6+7KSKFRpwLqf38Lz1wbGhkFFyfDb9oahgA@mail.gmail.com>
 <20200513214128.GB6733@zn.tnic> <CAK8P3a3XPCyNM7s3vbn8JYK6swA3ZpPtTWB+uhmAE3YEX-nmig@mail.gmail.com>
 <20200513222038.GC6733@zn.tnic> <CAHk-=wgybuOF+Jp2XYWqM7Xn1CW6szWQw_FgVoFh5jx_4YoCVw@mail.gmail.com>
 <20200513233616.GD6733@zn.tnic> <CAHk-=wjZXFe08MiNRevJFGDvX0O6kcQTiK8GFBS7hwUAzB+LQw@mail.gmail.com>
 <CAKwvOd=o_wuiVpw5KVzLEt25W-A9Ah9fzftPZLG+yutqJmWbOg@mail.gmail.com> <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
In-Reply-To: <CAHk-=wg6G+p1RRjR6UZBEuSCDs9=iWBsxrDPTEwqh+y5RayqKA@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 13 May 2020 20:50:03 -0700
Message-ID: <CALCETrUYA60fWu+=MviKx0NmW+_ppsOcv-ShUXdbyM4EjyfzHQ@mail.gmail.com>
Subject: Re: gcc-10: kernel stack is corrupted and fails to boot
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On May 13, 2020, at 7:20 PM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>
> =EF=BB=BFOn Wed, May 13, 2020 at 5:51 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> Are you sure LTO treats empty asm statements differently than full
>> memory barriers in regards to preventing tail calls?
>
> It had better.
>
> At link-time, there is nothing left of an empty asm statement. So by
> the time the linker runs, it only sees
>
>    call xyz
>    ret
>
> in the object code. At that point, it's somewhat reasonable for any
> link-time optimizer (or an optimizing assembler, for that matter) to
> say "I'll just turn that sequence into a simple 'jmp xyz' instead".
>

What, what?

LTO isn=E2=80=99t a linker taking regular .o files full of regular machine
code and optimizing it. That=E2=80=99s nuts.  LTO takes an intermediate
representation and optimizes *that*. This will contain actual
indications that something is inline asm.  If LTO starts rewriting
inline asm, then I bet all kinds of things will go wrong and this is
the least of our worries.  Also, trying to do the kinds of stuff LTO
does by looking at just machine code isn't going to work.

So the difference between:

asm volatile ("nop");

and

asm volatile ("");

will be, literally, the absence of the nop.  (And alignment changes, etc.)
