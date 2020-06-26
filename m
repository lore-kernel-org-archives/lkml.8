Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C6FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D60820702
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ocallahan-org.20150623.gappssmtp.com header.i=@ocallahan-org.20150623.gappssmtp.com header.b="CfAfFgam"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgFZBEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgFZBEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 21:04:02 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB696C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 18:04:01 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id m26so4223001lfo.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 18:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ocallahan-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=BUreYomgUbX9Tt5pj2+xiYdz91/CVVJ43t+n5EJKCsM=;
        b=CfAfFgam99/Iow2RlQsd1BJLYuErz2ltAuBZCpzF8RDA+NcWxNjo6qUtLMl+dgbgtc
         w3xwP/BkCd9uknj1M4S30mVcnko+CPY/MNr26b3MFueqoPnd8e9+ly209HXj1VpGr1+d
         +KyPnCdp/L5ezR4tSLpgvXsPPGCIiginPqEquCUiakR0KOfnWcKa5F08P55RK24re8Ah
         ScB88LWlvvEVNCG8ZEdeae4/kI1VQM0clBzCZu8NHuJbA0HrqnVtDLmfGGsDSJUIVkEm
         08Zvp0VbNnAEvpnOhEhbTWSnhojvGeZMK2EdwTrKLKeiyg+rkF0TEYnDOYXwaDuSGTDN
         9EEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=BUreYomgUbX9Tt5pj2+xiYdz91/CVVJ43t+n5EJKCsM=;
        b=byifkSmdO2ENjQS4y7oN4UnaIktxH65G0vTe+uzQVeHEj6Mu14wVpQR07oIm/osJAC
         CR0F9QqoGc3M6F5FpQaNvhz/FD2BgezVBb5l6Gs1Mlxj8FYhPpZ6caqcy/6EmbX9PB10
         gicxMqySMWx+8cJ/Fg9ZhgTQDjPJyca6ERUGOK/2+I/JJ2O3faIWSbKWIUkHaR6ZMvmP
         akk/Z7L03clbR9QLhRYKXG7Oyq+H9JT07J0qVqNZxMv5FGzE2DK5oTYuxiU62nXu3Zia
         a4VwsuAdSF160FOZ4iMC8bqOJUvfq5tAOKKlmv0pbIc7J0KZPefIMKDmgqbyUrwB7/It
         o4/Q==
X-Gm-Message-State: AOAM533QNqsRndp7cTGOa3BjdeX0rGgcEwCaInAUEeaOIM51cRsr9WO/
        gg/lsDXSceLelEMOPX3G7rtrhvZLof8k7eE6jrE=
X-Google-Smtp-Source: ABdhPJzFA9NylCGxqWkjjzIRnvOWcTLbn5FmMP3h4ZKQYIOTkbDxLPTSPuIFfBrsMcmJ04yj7THUz2ViDS9O4aliaGI=
X-Received: by 2002:a19:c8a:: with SMTP id 132mr387175lfm.23.1593133440043;
 Thu, 25 Jun 2020 18:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200530055953.817666-1-krisman@collabora.com>
 <AF65147C-15DB-4BA4-A08B-55676B489BA5@amacapital.net> <85367hkl06.fsf@collabora.com>
 <CAOp6jLazKdQ4U8Zyuqf3Zj8DgBnq0QGCbpk3f46dnyLDr69upg@mail.gmail.com> <877dvuemfp.fsf@collabora.com>
In-Reply-To: <877dvuemfp.fsf@collabora.com>
Reply-To: robert@ocallahan.org
From:   "Robert O'Callahan" <robert@ocallahan.org>
Date:   Fri, 26 Jun 2020 13:03:47 +1200
Message-ID: <CAOp6jLZrzmKh34L5f=RFOW7kNKraqer7M0cuQPv-aeUNc+AcpA@mail.gmail.com>
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Gofman <gofmanp@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 11:49 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
> We couldn't patch Windows code because of the aforementioned DRM and
> anti-cheat mechanisms, but I suppose this limitation doesn't apply to
> Wine/native code, and if this assumption is correct, this approach could
> work.
>
> One complexity might be the consistent model for the syscall live
> patching.  I don't know how much of the problem is diminished from the
> original userspace live-patching problem, but I believe at least part of
> it applies.  And fencing every thread to patch would kill performance.
> Also, we cannot just patch everything at the beginning.  How does rr
> handle that?

That's a good point. rr only allows one tracee thread to run at a time
for other reasons, so when we consider patching a syscall instruction,
we inspect all thread states to see if the patch would interfere with
any other thread, and skip patching it in that unlikely case. (We'll
try to patch it again next time that instruction is executed.) Wine
would need some other solution, but indeed that could be a
showstopper.

> Another problem is that we will want to support i386 and other
> architectures.  For int 0x80, it is trickier to encode a branch to
> another region, given the limited instruction space, and the patching
> might not be possible in hot paths.

This is no worse than for x86-64 `syscall`, which is also two bytes.
We have pretty much always been able to patch the frequently executed
syscalls by replacing both the syscall instruction and an instruction
before or after the syscall with a five-byte jump, and folding the
extra instruction into the stub.

>I did port libsyscall-intercept to
> x86-32 once and I could correctly patch glibc, but it's not guaranteed
> that an updated libc or something else won't break it.

We haven't found this to be much of a problem in rr. From time to time
we have to add new patch patterns. The good news is that if things
change so a syscall can't be patched, the result is degraded
performance, not functional breakage.

> I'm not sure the benefit of not needing enhanced kernel support
> justifies the complexity and performance cost required to make this work
> reliably, in particular since the semantics for a kernel implementation
> that we are discussing doesn't seem overly intrusive and might have
> other applications like in the generic filter Andy mentioned.

That's fair --- our solution is complex. (But worth it --- for us,
it's valuable that rr works on quite old Linux kernels.)

As for performance, it performs well for us. I think we'd prefer our
current approach to Andy's hypothetical PR_SET_SYSCALL_THUNK because
the latter would have higher overhead (two trips into the kernel per
syscall). We definitely don't want to require CAP_SYS_ADMIN so that
rules out any eBPF-based alternative too. I would love to see a
low-overhead unprivileged syscall interception mechanism that would
obsolete our patching approach --- preferably one that's also
stackable so rr can record and replay processes that use the new
mechanism --- but I don't think any of the proposals here are that,
yet, unfortunately.

Rob
-- 
Su ot deraeppa sah dna Rehtaf eht htiw saw hcihw, efil lanrete eht uoy
ot mialcorp ew dna, ti ot yfitset dna ti nees evah ew; deraeppa efil
eht. Efil fo Drow eht gninrecnoc mialcorp ew siht - dehcuot evah sdnah
ruo dna ta dekool evah ew hcihw, seye ruo htiw nees evah ew hcihw,
draeh evah ew hcihw, gninnigeb eht morf saw hcihw taht.
