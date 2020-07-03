Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1CCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3D9D20B1F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593747163;
	bh=cY3ZXCphbp6Bd6g8eTIXgPjm8svRdi8PK6+pdgEY2Eg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Yusbwz0JakPBmOHrmduzae704C+gSoR5U1WSdkX0oOQzVGa2Zjd8VI3jDlmjg32V4
	 4lBrmECZyS1k6qiH5Ly6McRk0jzt06F/kmPlA1tnq8A0r1J4uNNVsAb2BVEBGWgAtf
	 xcFG7KGGcqL6FL0JezxXArsipvF1ShCoDkUn2Voc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgGCDcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgGCDcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:32:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A2DC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 20:32:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g139so17566924lfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 20:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKrI4dJKbvS2Zs02hCoAOreYiDF6WXutUVQY7w6Sug8=;
        b=W1m9caZiHMlzdfuC0OJSkqCvPiBMLKBTPkMBKUZdOkTSwUAMzcgNEZKgW1Rn9mNH4h
         +uo7lgPQDHrpxBNqC5wnv/A92dCP8bOq4BX8BB/ULboTx4ORD/cGKx4RVt2g91wWMcCL
         ePEdPU1E3hINe6ohxBNFhIuv7OvpYEIxwVtZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKrI4dJKbvS2Zs02hCoAOreYiDF6WXutUVQY7w6Sug8=;
        b=QiIDc55TsppIcvbAk3V+bFiiT05C3TtrypoAY3VjATfzSDRHPExfGy/coTNF7rZ7rw
         gftu2fg2mfEZkYba8EbUU+YMmmm8qZgXq8h/yOaWphdqIe697PwC8aPiINPYML3VteCi
         0MXgc+4nlnCSkBWKpKgQZy1Jw8d4QDPllu7FyE0g0tVyfvy3aeYkA8bXBpJha/Z86bYT
         6C+LR2DztalvYcbVgUstF8HkKIjxzcO2PT6yRq2pLFNQX48eXUeoBNSUDmZZrP7CCdCJ
         O8FF4uB/JOgLovgJiSmh9LP83aId2AX3R7n1ic7zq+kNKy6C6dJ8zvb0tDgg2etWUlph
         /p5g==
X-Gm-Message-State: AOAM533pnixCJ5DQQYoQsQW9wcaaYdn/z4K0LmON6K/JKs9LnXsvF0VS
        h7DDprskXM+ShKZe457eJ4EOpcNTbLA=
X-Google-Smtp-Source: ABdhPJwjwltvG3iwqjkPxnUAr/HgLPtjL08ZbvBbBBQBqm5bEucQE5m3xZaJOjRDq5wCVNWpS48D+g==
X-Received: by 2002:ac2:5226:: with SMTP id i6mr20615126lfl.55.1593747159496;
        Thu, 02 Jul 2020 20:32:39 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id k6sm4135349lfm.89.2020.07.02.20.32.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2020 20:32:38 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f5so19207008ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 20:32:37 -0700 (PDT)
X-Received: by 2002:a2e:86c4:: with SMTP id n4mr3550221ljj.312.1593747157671;
 Thu, 02 Jul 2020 20:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au> <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk> <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk> <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200703013328.GQ2786714@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Jul 2020 20:32:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-qbjVo5-cQCAjEbQ0ykN+x6CXpNqYHqaj8kikhnWHpA@mail.gmail.com>
Message-ID: <CAHk-=wh-qbjVo5-cQCAjEbQ0ykN+x6CXpNqYHqaj8kikhnWHpA@mail.gmail.com>
Subject: Re: objtool clac/stac handling change..
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 6:33 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> What about load_unaligned_zeropad()?

What about it? It doesn't care. It's for kernel addresses, clearing AC
on exception does nothing.

There's no user_access_begin/end anywhere around that thing that I can see.

             Linus
