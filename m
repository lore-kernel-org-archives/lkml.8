Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05694C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 01:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D786F207DA
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 01:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="pP05YEqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFABvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 21:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgFABvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 21:51:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA63FC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 18:51:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t8so4228865pju.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 18:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9dXvtk/r9WWB0K0puzQusMZ/JsqoKiWxqlF1sGJrjWc=;
        b=pP05YEqIkQxAyG4vYCDW80FpHLOizHA6onXy4Gwo4itfkUonGPoNe26IGRJawn+vDB
         6xm/XLtQIvd+VQShZDf/Lv3ABN0+/LsR6M7s+H96gvXg+EBop8epLWjtsuYq46KvOk6n
         0QAYtfeNxq8zpoHHI7TeM6HMKXRoigU3xvB/McCFShyraP6f0r1ISOFaKqh0YNZGtdjZ
         wZczeBqxjU0vErzv+Iy4JsQ6XPGHLgIBBCvsRaezOCahPeBHGKTOcN05q8++ARzlZQb0
         TTj9wruO2IrFSTpw5CM/mz1LXI0BqFCN0aI6is75wz/0plhkA6m5LDVZG0hXUAIt518h
         bmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9dXvtk/r9WWB0K0puzQusMZ/JsqoKiWxqlF1sGJrjWc=;
        b=X7aT3y9XU85OKLYbF/Ot/2T1BEn0juLg6fJV/p/K527OuBJDqiKcQM3jyiP0gE068P
         t8jm3qv9iWjgAZ3/DuX8YWxZk+i/i5fJoiVefYOMV9Ivrz2tAnqUA/Vlp9dmoirb1cuz
         +vIX4+v9XprUE45rI7L5Ck2PEnYiad8cG3WO5xFrXTh9vafcQN0kAIPOQcdQDg2RKfaJ
         fj9sA0UphkJhxvI/gD/YsyHfmhHyjCsU1VKBUzH2J1fghyUUQZWDfJG3nls/gEowsETL
         FPstQ+kRErsxTmE+7n+4TszvZ2dxOZ6hGqJNLA68tY+W62CGG9jDzZkMLHef9RKabuEO
         PfEA==
X-Gm-Message-State: AOAM532JTxuCVRkba5Ecig+MkVq4kaUpiV8tRMxoZOwTQ+d8i4nikP/A
        TD83Ilt4cnGWIRdZLt63AMhATQ==
X-Google-Smtp-Source: ABdhPJyKdBvCLHLO/yUYp1MwzbdySIcglCWzDBtFYs8Uw6OMa2V55Q7KwEVOfGOGHmAQaeQTvnAfvg==
X-Received: by 2002:a17:902:e903:: with SMTP id k3mr17628008pld.317.1590976303529;
        Sun, 31 May 2020 18:51:43 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1d33:1e7d:661b:bcd4? ([2601:646:c200:1ef2:1d33:1e7d:661b:bcd4])
        by smtp.gmail.com with ESMTPSA id q28sm12946145pfg.180.2020.05.31.18.51.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 18:51:42 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Date:   Sun, 31 May 2020 18:51:40 -0700
Message-Id: <53C0BD81-A942-4BB3-8538-D5107E84C5CD@amacapital.net>
References: <8DF2868F-E756-4B33-A7AE-C61F4AB9ABB9@codeweavers.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Paul Gofman <gofmanp@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Zebediah Figura <zfigura@codeweavers.com>
In-Reply-To: <8DF2868F-E756-4B33-A7AE-C61F4AB9ABB9@codeweavers.com>
To:     Brendan Shanks <bshanks@codeweavers.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 31, 2020, at 4:50 PM, Brendan Shanks <bshanks@codeweavers.com> wrot=
e:
>=20
> =EF=BB=BF
>> On May 31, 2020, at 11:57 AM, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> Using SECCOMP_RET_USER_NOTIF is likely to be considerably more
>> expensive than my scheme.  On a non-PTI system, my approach will add a
>> few tens of ns to each syscall.  On a PTI system, it will be worse.
>> But using any kind of notifier for all syscalls will cause a context
>> switch to a different user program for each syscall, and that will be
>> much slower.
>=20
> There=E2=80=99s also no way (at least to my understanding) to modify regis=
ter state from SECCOMP_RET_USER_NOTIF, which is how the existing -staging SI=
GSYS handler works:
>=20
> <https://github.com/wine-staging/wine-staging/blob/master/patches/ntdll-Sy=
scall_Emulation/0001-ntdll-Support-x86_64-syscall-emulation.patch#L62>
>=20
>> I think that the implementation may well want to live in seccomp, but
>> doing this as a seccomp filter isn't quite right.  It's not a security
>> thing -- it's an emulation thing.  Seccomp is all about making
>> inescapable sandboxes, but that's not what you're doing at all, and
>> the fact that seccomp filters are preserved across execve() sounds
>> like it'll be annoying for you.
>=20
> Definitely. Regardless of what approach is taken, we don=E2=80=99t want it=
 to persist across execve.
>=20
>> What if there was a special filter type that ran a BPF program on each
>> syscall, and the program was allowed to access user memory to make its
>> decisions, e.g. to look at some list of memory addresses.  But this
>> would explicitly *not* be a security feature -- execve() would remove
>> the filter, and the filter's outcome would be one of redirecting
>> execution or allowing the syscall.  If the "allow" outcome occurs,
>> then regular seccomp filters run.  Obviously the exact semantics here
>> would need some care.
>=20
> Although if that=E2=80=99s running a BPF filter on every syscall, wouldn=E2=
=80=99t it also incur the ~10% overhead that Paul and Gabriel have seen with=
 existing seccomp?
>=20
>=20

Unlikely. Some benchmarking is needed, but the seccomp ptrace overhead is li=
kely *huge* compared to the overhead of just a filter.

As wild guess numbers on made up modern hardware, cache hot:

Empty syscall: 50ns, or 300ns with PTI

Empty syscall accepted by simple seccomp filter: 10ns more than an empty sys=
call without seccomp

Seccomp ptrace round trip: 6 us  Worse with PTI

Seccomp user notif round trip: 4 us

Syscall hypothetically redirected back to same process: about the same as an=
 empty filtered accepted syscall, plus however long it takes to run the hand=
ler. Add 900ns if using SIGSYS instead of plain redirection. Add an extra 50=
0ns on current kernels because signal delivery sucks, but I can fix this.

Take these numbers with a huge grain of salt.  But the point is that the BPF=
 part is the least of your worries.=
