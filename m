Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26017C3565B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2EE208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 19:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="CJkwaRDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgBUTWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 14:22:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41823 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgBUTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 14:22:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so1736439pfa.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=babJojdCDy0YFs2iVGK6X7zs9deO0pqtiXujS29YD44=;
        b=CJkwaRDwnuJBn0C4v1Ltjfn9GF0b2pewUCw30smmKBLfZs4zRmMmDsgFkUdIYKzsyy
         hB5perK5p3i1wSNVsj8Vo7g4ohOgdtvtAKo8M+3xZSRkPS9QNX/a6yvJMdGXgHKSz8Wo
         snspxoVchaHx5HaO2sPszMzJITp1bYuLtHVRzOgyNDYni5/DAO0W7Cj9TdsnJgmt1ei2
         pjwkM8rj9YK8ndNQCSAbD0MoFfEMU7lqxVe7LPGWb1lnOCHobBcCTvwbvbKhntI7HtXt
         GzlGeK8AtrVMnKkPL9wFUuPKXMAQeJywGOVgfzfjrzvaLVsvwUs/11Y9cE4SPsmQiAR2
         hgSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=babJojdCDy0YFs2iVGK6X7zs9deO0pqtiXujS29YD44=;
        b=LRd3eYKcvrQpDCWkETq5TeS08C01AXKAj9eLeIXxsahaW2kefD36J6hZLjcz9RTNUP
         H5DLegqL9XYmcB7JmsaSfvrGZZnIh9DOAieOOeHzmAipG2oS3XOa5al6JMgcqC3OPcAv
         zi9WzRpazBqnrdrNsMn63d8CD1mBoKVs0YBCs62FntfnlRJLK+sVHjyoqY8ZI/jx8m+3
         E08nCFJutEFaGjhyuufWfSlt4O6Hk0SUO8YXostY+iPT1J1pJ4lFrIZVvsRv/XyEiiHt
         a9mOvz2sdLPIokzMzY4Wh2ZvtaLMI5ch3GnKIeV0RHspuIx+b7hTcXJITALb49tUI0Zf
         i1uw==
X-Gm-Message-State: APjAAAVX/mC6SYfF2wtrL58MREj4kb6rz56S8aGqH0ZrNsUTzqbnE6xz
        jDOPVFYSR3C2eyjXZdooh4pTdg==
X-Google-Smtp-Source: APXvYqy4kqrPrg8fqCqvVjEj6p+1x50JOT4UfcxeTKHgFx2Fy6nZcE6AJ79oq/DAaShFXQ7/BvCe1w==
X-Received: by 2002:a63:7558:: with SMTP id f24mr39204054pgn.259.1582312941795;
        Fri, 21 Feb 2020 11:22:21 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:4c99:8e8b:baf2:422? ([2601:646:c200:1ef2:4c99:8e8b:baf2:422])
        by smtp.gmail.com with ESMTPSA id g16sm3364584pgb.54.2020.02.21.11.22.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2020 11:22:21 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/tlb: Fix use_mm() vs TLB invalidate
Date:   Fri, 21 Feb 2020 11:22:16 -0800
Message-Id: <6A09F721-0AD9-4B86-AB3E-563A1CF5ABDE@amacapital.net>
References: <CAHk-=wi4uO+Djqr4Jc1TnCofwxUTuXHtgkgwnVX86q06UGV6DA@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>
In-Reply-To: <CAHk-=wi4uO+Djqr4Jc1TnCofwxUTuXHtgkgwnVX86q06UGV6DA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Feb 21, 2020, at 11:19 AM, Linus Torvalds <torvalds@linux-foundation.or=
g> wrote:
>=20
> =EF=BB=BFOn Fri, Feb 21, 2020 at 3:11 AM Peter Zijlstra <peterz@infradead.=
org> wrote:
>>=20
>> +       BUG_ON(!(tsk->flags & PF_KTHREAD));
>> +       BUG_ON(tsk->mm !=3D NULL);
>=20
> Stop this craziness.
>=20
> There is absolutely ZERO excuse for this kind of garbage.
>=20
> Making this a BUG_ON() will just cause all the possible debugging info
> to be thrown away and lost, and you often have a dead machine.
>=20
> For absolutely no good reason.
>=20
> Make it a WARN_ON_ONCE(). If it triggers, everything works the way it
> always did, but we get notified.
>=20
> Stop with the stupid crazy BUG_ON() crap already. It is actively _bad_
> for debugging.
>=20
> =20

In this particular case, if we actually flub this, we are very likely to cau=
se data corruption =E2=80=94 we=E2=80=99re about to do user access with the w=
rong mm.

So I suppose we could switch to init_mm and carry on. *Something* will crash=
, but it probably won=E2=80=99t corrupt data or take down the machine.=
