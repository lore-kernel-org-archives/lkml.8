Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46639C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D897206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 18:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dw2ML1fF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgHVSRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 14:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgHVSRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 14:17:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A321C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 11:17:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w14so5303443ljj.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YChPTRKYweJBRwXhiNVWgynaCPUMI1IPuQnqYEi2Wg8=;
        b=dw2ML1fF7uUxx5dE3FtnoIC3IlzZ4yvUnt7ERurdXFGa8xvZOjMuqt4bV4FZF+S34y
         diFBoi9qJB2SV4CGMHVmvCj/9AbxfXoiV8AbcX5gQp12dbtSqTdJpzNgdgh0wm0JwWZU
         fPBoIvDpgKqFmICWN0JqXZKRlriGP0/3N6/vTF2tSOz6Jzxv7h9zBgvLJqD14L5JpjIJ
         iXlvhX31/z59sLPN9w1753eO10V5uvSVigO1HcpuQNya2rQKgZtij06t+aR63TvyAnFk
         FZwC7gIvDBFkPe15qaxOiNNpCDVyx+RTJDMbe5eOw4iUcMxVfvv7y9npUprd8ecclLk2
         ioyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YChPTRKYweJBRwXhiNVWgynaCPUMI1IPuQnqYEi2Wg8=;
        b=kKnNCZXYTLeD2uGONVbPwRUmlCeK5a2UQRGy931LZBO93GM1IuPYG58ASmk/yZK4Jh
         ovcfaBApaaQN/CTUi14KZzyy8A2iB/hyBR0Bpez+SlOYZQzBzAzZMY+3VJZc+8UAkPOZ
         LvSfcc8zt/6MjZHjx08tt6MSGZTUyx/3ZAch1cT5EFXLdAuVs1jLc1Z5HbALqwJ1kzRg
         jjvlyH4MX2BEmDl27KXflPg5JLdon2X4HWtJ52iDZ1v9leixUVkbPjG7VcIC22N+PEpI
         orSsAOT6DKJZ+dr9omjYbVgajbZfbcWDARZoBcrXHKvtK7YURkNUPtQ4h/ljYOFVR9yR
         triQ==
X-Gm-Message-State: AOAM531/I3bSpnn5kEanrYVeE++dtCKNYPFOHi53gVS1UneLyrCCxrcV
        SA+G8KpzDOXakhoFPsCy61sjoko0AxzIEvVkSAo=
X-Google-Smtp-Source: ABdhPJyW3/ywjLfNkLgZFgGY/QCzXsNe1mtqqdjbbtXxMehshBtljXf9+wiK+SBMXDTq6coCJsTvcN7HZjCPHB6iDos=
X-Received: by 2002:a2e:920c:: with SMTP id k12mr4301931ljg.29.1598120263649;
 Sat, 22 Aug 2020 11:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <87h7t6tpye.fsf@nanos.tec.linutronix.de> <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan> <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan> <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan> <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de> <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org> <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
In-Reply-To: <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Aug 2020 20:17:32 +0200
Message-ID: <CANiq72=3iOh5Z_rboZf-_GUpBE2LUUv3yPKOVNN_XmaNswdNSw@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 11:52 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> I am asking myself who is using such ancient compilers?

There are many users/companies using older versions of compilers,
kernels and everything. GCC <= 4.9 will still be used/supported (by
third parties) for a handful of years at least.

However, the important question is whether those users/companies care
about running the latest kernels. Many of those definitely do not want
to touch their kernel either. For those that do, there are several
longterms to pick from that still support 4.9, as well as other
workarounds.

Thus I am usually in favor of raising the minimum whenever new hacks
are required to be added. On the other hand, we already raised the
version twice this year and it is not clear to me what is the minimum
version we would need to go for to ensure this does not bite us.

> If this is a real problem with GCC version <= 5, so can this be moved
> to a GCC specific include header-file?
> Thinking of include/linux/compiler-gcc.h or
> include/linux/compiler_types.h with a GCC-VERSION check?

That would be better if it can be done, yes.

Cheers,
Miguel
