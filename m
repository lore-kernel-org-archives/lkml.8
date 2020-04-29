Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13094C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08E420787
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 00:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vuI12hdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgD3AAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 20:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD3AAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 20:00:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFA2C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:00:18 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d25so3200065lfi.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 17:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBb6YUzJ0ih00bACFlDgj6pLxzVV7c+ybx+1P5/b1gA=;
        b=vuI12hdgPQQ+hpHUcCjrJQtfA0k+PEgPRHdnovYXVvPCR9p1zBWBWMpLdVw6AQDvpK
         iSi1wOvQhrm4/B+XgXoDvQpnwCByRuEkSSToUnrHM4PznjWcwaMASYK0zJkGv5/eNj8u
         3VJRNbGOnvfwMcGuAAl4cZ8UAzwg0z6TOuaKgg8yNuE4zB1Mc14MIsPJHBofFzFa5VLO
         54A24oLNGsTKANQuyAUIITPGN1i9vQbad4PRe/w58yuwH3gYqlHyuRnGpYw7Ygr+vjXF
         j8VPd9Ek1MSG/puz1EaZy5J0axewfUTdd3fPRiwrrx9NI4Mi1Q3p8RObzGAj4EIyeVIE
         436w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBb6YUzJ0ih00bACFlDgj6pLxzVV7c+ybx+1P5/b1gA=;
        b=gzlhLhai8ByKQb50Oj4qbAbA2/Csfo1eJN5cW81TCiwK69o+YLi6fnZcMgRf7aLETX
         FHl7hgRaOataWeTcy0RjlpSVJDPlaRzDXHEOkOYosuH2Nmpm+y16hrXYv9IgbhDdFotE
         ky7RTWGXmiMUS9hQ0l1Pzr3l+EkZ4fVSU9jzjgbjwPV/fxYlimX/TSM1e+Du8EiP7pLo
         YI6qamAnScAzDnKAJQlR+5TPIcfknYWNRfVW+fQByfPPNmYgOlek1ra9qiyurUr8MFV2
         Gxu+rhE6MvjsZ04ZW69Rhhwh5+uTSutT36ocYvgT/Nt5z9xbsXEnwxfJ2Q1hBvUXSDzK
         Xdeg==
X-Gm-Message-State: AGi0PuZQCMoejaxHXQDbeWHV0zHQ4gqlJ463cSc4/+TJQ6lThGHKVrxh
        spBDRZUo338J2HUPQW860b3ypGWHYfVRpz7E663Tig==
X-Google-Smtp-Source: APiQypJlxaoKVY8jfNWGdnaYnv7jxr0k2Zi+XkkroPrW2JKbq7LQxRyxO2wGothdUTjvATx1ZQK4thllCE3H2YE05Y8=
X-Received: by 2002:a05:6512:104a:: with SMTP id c10mr227612lfb.184.1588204816199;
 Wed, 29 Apr 2020 17:00:16 -0700 (PDT)
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
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com> <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
In-Reply-To: <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Apr 2020 01:59:49 +0200
Message-ID: <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Thu, Apr 30, 2020 at 1:22 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 29, 2020 at 3:38 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > If you do it properly, with a helper function instead of repeating
> > that fragile nasty thing, maybe it will look better to me.
>
> Side note: if it has a special helper function for the "get lock,
> repeat if it was invalid", you can do a better job than return
> -EAGAIN.
>
> In particular, you can do this
>
>         set_thread_flag(TIF_SIGPENDING);
>         return -RESTARTNOINTR;
>
> which will actually restart the system call. So a ptrace() user (or
> somebody doing a "write()" to /proc/<pid>/attr/xyz, wouldn't even see
> the impossible EAGAIN error.

Wouldn't you end up livelocked in the scenario that currently deadlocks? Like:

 - tracer attaches to thread A
 - thread B goes into execve, blocks on waiting for A's death
 - tracer tries to attach to B and hits the -EAGAIN

If we make the PTRACE_ATTACH call restart, the tracer will just end up
looping without ever resolving the deadlock. If we want to get through
this cleanly with this approach, userspace needs to either
deprioritize the "I want to attach to pid X" and go back into its
eventloop, or to just treat -EAGAIN as a fatal error and give up
trying to attach to that task.
