Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E18C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAB720723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="x8T0W9Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389428AbgEYRTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 13:19:18 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5208EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 10:19:18 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so186742pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QNqUDHqeLmQwJcbOV1PJJOsb3TplahEFyxpwRYV5ku0=;
        b=x8T0W9JriEirkY4VgAMUyOjmq42JztHepZI1y/Mv/yDDxQRsClpF2b2sXsYPb8rdNq
         n3MVMFU7/FA2nvIx6B25M7yCjVblIEoQjLKfepmSjf2g9Gb1JHTY0jnIDaAl1Ma52Ih+
         ECNDDdGk7mwl7ADk9uzIYoiAQBg6yFMBiMTgr2Uh9KiOX7+SrxUTHObspGwJaPgB/hy7
         kr0l4+nJQyKZKvXYmJu3aeV1H2IUkFhe+A8TWHXRubnRYVygVM/00vzneb/z4xpo3q5Y
         Jk5n42f0o9+fJ8SKS+dJf6UTXVGNs6XWMvq0RvQ35gBRNjJ2q+pt7f46n7pw68v2r6rt
         lyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QNqUDHqeLmQwJcbOV1PJJOsb3TplahEFyxpwRYV5ku0=;
        b=T+yAtb9gtYz6B18CCFqaPjD3Nn8UxlH3qeTrh8S2zVGhbHsE72IFLU6ty0MKqruqfE
         B9zUFmw7DsfJi7g6o/XSUmhoBGEGj1qMQS4RzaqP44eAHgmc6DB4hD9ASIDgw3VPVLjO
         XVp6hwk224X0op6cqYn1Nfu+1hNgyFj6vAgRgCH4d+rFxxF42+0ttjf3Qd8B//+QdCBx
         4id4J6oqxFf4bjnfw8d93cc8Xg3hkERpGJECZLJ284u+bYuB+pcXJrNTE1PM+TDeyc6Q
         FmYRDvWvOyIlxMAAjKzDX3OQQFj5Wh3uOm8lWnmH9y1ZGLESyoUkPXh/G0qnwi+hUwQg
         DQKQ==
X-Gm-Message-State: AOAM531oTQ2rsdMLGVY2UoYSw7qbXTVCdmnGXJ9YOpOQ3vmOuLIOLTfp
        sXfRvXoyrLdDXj4fIBQqdZ2/HQ/EUCc=
X-Google-Smtp-Source: ABdhPJyTJhXXyL97I7ky/iQgu+EfX98VlCfx+Z6WZS8iqEXT/kEIUL7CmCM3ZqnLYmpdw6ohUFTkYA==
X-Received: by 2002:a17:902:b115:: with SMTP id q21mr6021704plr.182.1590427156995;
        Mon, 25 May 2020 10:19:16 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:80a8:9f3:92bf:a63f? ([2601:646:c200:1ef2:80a8:9f3:92bf:a63f])
        by smtp.gmail.com with ESMTPSA id k13sm14622746pfd.14.2020.05.25.10.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 10:19:16 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Date:   Mon, 25 May 2020 10:19:08 -0700
Message-Id: <2E6DBDE0-FEEA-467F-A380-4ED736B6C912@amacapital.net>
References: <20200525110101.GG325303@hirez.programming.kicks-ass.net>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
In-Reply-To: <20200525110101.GG325303@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 25, 2020, at 4:01 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> =EF=BB=BFOn Mon, May 25, 2020 at 12:40:38PM +0200, Peter Zijlstra wrote:
>>> On Mon, May 25, 2020 at 12:02:48PM +0200, Rasmus Villemoes wrote:
>>>=20
>>> Naive question: did you check disassembly to see whether gcc threw your
>>> native_get_debugreg() away, given that the asm isn't volatile and the
>>> result is not used for anything? Testing here only shows a "mov
>>> %r9,%db7", but the read did seem to get thrown away.
>>=20
>> Argh.. no I did not. Writing it all in asm gets me:
>>=20
>> [    1.627405] XXX: 3900 8304 22632
>>=20
>> which is a lot worse...
>=20
> +    u64 empty =3D 0, read =3D 0, write =3D 0, cpu =3D 0, cpu1 =3D 0;
> +    unsigned long dr7;
> +
> +    for (i=3D0; i<100; i++) {
> +        u64 s;
> +
> +        s =3D rdtsc();
> +        asm volatile ("lfence; lfence;");
> +        empty +=3D rdtsc() - s;
> +
> +        s =3D rdtsc();
> +        asm volatile ("lfence; mov %%db7, %0; lfence;" : "=3Dr" (dr7));
> +        read +=3D rdtsc() - s;
> +
> +        s =3D rdtsc();
> +        asm volatile ("lfence; mov %0, %%db7; lfence;" :: "r" (dr7));
> +        write +=3D rdtsc() - s;
> +
> +        s =3D rdtsc();
> +        asm volatile ("lfence; mov %0, %%db7; lfence;" :: "r" (dr7));
> +        write +=3D rdtsc() - s;
> +
> +        clflush(this_cpu_ptr(&cpu_dr7));
> +
> +        s =3D rdtsc();
> +        asm volatile ("lfence;");
> +        dr7 =3D this_cpu_read(cpu_dr7);
> +        asm volatile ("lfence;");
> +        cpu +=3D rdtsc() - s;
> +
> +        s =3D rdtsc();
> +        asm volatile ("lfence;");
> +        dr7 =3D this_cpu_read(cpu_dr7);
> +        asm volatile ("lfence;");
> +        cpu1 +=3D rdtsc() - s;
> +    }
> +
> +    printk("XXX: %ld %ld %ld %ld %ld\n", empty, read, write, cpu, cpu1);
>=20
> [    1.628252] XXX: 3820 8224 45516 35560 4800
>=20
> Which still seems to suggest using DR7 directly is probably a good
> thing. It's slower than a L1 hit, but massively faster than a full miss.
>=20

How about adding it to cpu_tlbstate?  A lot of NMIs are going to read that a=
nyway to check CR3.

And blaming KVM is a bit misplaced. This isn=E2=80=99t KVM=E2=80=99s fault =E2=
=80=94 it=E2=80=99s Intel=E2=80=99s. VT-x has two modes: DR access exits and=
 DR access doesn=E2=80=99t exit. There=E2=80=99s no shadow mode.
