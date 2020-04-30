Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CFAC83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 02:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7A5720787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 02:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588212987;
	bh=gkBk/YMPSLRoi+Q1WAqyNhar++zkWGcgbT16f3cvt2I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O8rDeWYz8rcNjuSXkio6XCgM9+pWvWnRwmGaEsrZFu0EnnVhbf9sRnmfbzMzJ8Ja4
	 E0kNOHBiSqa88i7n3pGGg09DfDdzbAFL7CBuub9QMLSy9bb/AYXMEdOrYCR6PKkzsz
	 RCDIRemHlD9GQsHzNLqoq1mkCT9105XQRjb4iUe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgD3CQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 22:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726286AbgD3CQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 22:16:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF822C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:16:24 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so4762962ljb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wpg9VE9K+jtzYNIox6WSxB8PBx0KsFgkBN0bedM2MhE=;
        b=bnIAbolVgYnIc1mXMvPCQT7QUlVDaRrcEeba+hNvMkY+vbZEm1P9/h50OiQ0QMuo1T
         p2CSd/nm8DipGONcPImrQqXTjzU2byyTG4AuW6G1PsHOP5n3MuozXYinDUOf5fZ1vzT4
         HL998XSc/5jlZtCSLbSx0DgUWNnwKQQQMJMRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wpg9VE9K+jtzYNIox6WSxB8PBx0KsFgkBN0bedM2MhE=;
        b=R3g1JQifMOS2Fo2LtmBH9dAB/yFbfZF6/cJ4sIWVKwY26g0SP7FkPKwqBHYHqPPLml
         3ArXVmzuL8vEWZ6meIGlq8glQ30OaQ3U3G1/vOSWrpoDV5SQtVpYdsqr9P4SL41/i+y9
         UrdFETSdXWLjr8esiN7zJbr2HmMHYj/WbYg+k+Val4HJqI5olQVfebv/+xpMMixSjyKo
         EquvKhReVrwWVV9xISvTt9F/fxS5bb+AJABkLH2zr5jNW6/1afWQoKqOH30QCgDi2YcH
         /oV+V1JBQL3FWfWlPmb2dguwpQ2jU3rBUUJ0wAGO01llcNILbzVQ9IzTDp2s0pAtMa9u
         t4DQ==
X-Gm-Message-State: AGi0PuYqrI+Ol+Fzk+b54nNnbkWmxahztbNrv/lfjVE7WixFRAjB1Mrx
        SAC6szxIpPRVs3JlJY8fA7jWhvG1+kM=
X-Google-Smtp-Source: APiQypJ0keEWDC3s9tjIvJ6/EnTOJvfOgeMXuVc3DGCGurAblAjREzQ+FNPZC/TDa8uYMbeKgsjtEw==
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr683214ljo.76.1588212982949;
        Wed, 29 Apr 2020 19:16:22 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id b9sm4101670lfp.27.2020.04.29.19.16.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 19:16:22 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id f11so4818800ljp.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 19:16:21 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr685996ljj.265.1588212981665;
 Wed, 29 Apr 2020 19:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com> <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
In-Reply-To: <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Apr 2020 19:16:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgcvn1_1kCkyourNCKeH+KrzSMRvc-ai_NLU4RGZT_XBg@mail.gmail.com>
Message-ID: <CAHk-=wgcvn1_1kCkyourNCKeH+KrzSMRvc-ai_NLU4RGZT_XBg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Jann Horn <jannh@google.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 5:00 PM Jann Horn <jannh@google.com> wrote:
>
> Wouldn't you end up livelocked in the scenario that currently deadlocks?

The test case that we already know is broken, and any fix will have to
change anyway?

Let's just say that I don't care in the least.

But Bernd's patch as-is breaks a test-case that currently *works*,
namely something as simple as

  echo xyz > /proc/<pid>/attr/something

and honestly, breaking something that _works_ and may be used in
reality, in orderf to make a known buggy user testcase work?

Because no, "write()" returning -EAGAIN isn't ok.

            Linus
