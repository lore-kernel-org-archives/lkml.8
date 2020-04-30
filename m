Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11E2C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE4520873
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588264866;
	bh=Px3Dalfj6msjAALUcdQs0d/nxTVXez80v7FmEDwIVdA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q09oeYuUptJEaLdV9fLHJ/B2Rx9Ul52iGmlg6Wa6zmeHEphA+3hUIC0y7XNakQyzK
	 j9kDF2iKWOKh8HyXGO77e8Eg+TlOaoYRqU5dcWHJfyBD0hbAB1XrutE3VJP4iv6f9N
	 pxiOEA3XU4pG8sjJ/CzuKfYlrTdtjIGcTKiwd9Wc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgD3QlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726130AbgD3QlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:41:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DF5C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:41:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j3so13630ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnljVOaHYUquEixFmEii2Y5v/oewWMeOHc8temc1Ulk=;
        b=UuW8h6k5QG+STHncG4KPXUW+GCZ++u/mvP89xOPdTvhV2ev5G/ottNTcq1gJGPZZrm
         dZ0tWyBWwzm1CllG3jRSytf59dGIY1pHXI35E2Wm08EYYqw0giIVdPPtRyP7pZaHTFy8
         FBzoxdFEIm1NIrwWYwzd/qyWAbgfhpEil4RxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnljVOaHYUquEixFmEii2Y5v/oewWMeOHc8temc1Ulk=;
        b=B5wu5TiAsNzB/nQqHRgXsE5AbcwJdiiZxIssnkvePRwTxHjLULaGwkgbOLAfzwGAaW
         0YI8RwAQiR1YUNbGs+2HoJBWU8xJ3iyzW2X7d4P6W84D6KbipV8XAt0gl7u2hStSjJGT
         Qeh+qByz/jfYdRsabda5m0BeSgw5z7mfni13T6+QeeWrMzBzF6Urd8aNmePJG6hcIJvH
         KNMk1Xp7rpMVTbUcSIWUXZRaWAa90Rgz4ApM3FcKPW1c1UB4T2snCtpWdmONysX0nEJl
         u2tu1LW9Yx5pYBvhFQ+v0lKCKGCzxUxAt5MLdKYdS3GNFjE9P18oMDSr3kC0QA2Q9WwA
         Fl5A==
X-Gm-Message-State: AGi0PuaQvKHRRhM+1gLesEQ1yYgK9SVc1xOZ0yVHpugISwEqVuNMnEry
        oeo2sgIhkqBggSKYmiRP00TNXbbpURM=
X-Google-Smtp-Source: APiQypLTRGi5riKNLmRre0WMmsdVD3xvMQdOZ+lnbMLi2IlM2YsThpryXZoTPVd30uHbGU432nDDkg==
X-Received: by 2002:a2e:87d0:: with SMTP id v16mr87024ljj.137.1588264862590;
        Thu, 30 Apr 2020 09:41:02 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a26sm210181ljm.45.2020.04.30.09.41.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 09:41:01 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id b20so1505419lff.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:41:01 -0700 (PDT)
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr2734479lfe.152.1588264860980;
 Thu, 30 Apr 2020 09:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
 <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
 <CAHk-=whTgFbjGTP=CqMWs_LOkY7bWvLQGYKwKx86amdbMovAkw@mail.gmail.com>
 <CAG48ez2-Nu2ALN6VEUZL-prtR_Kk8QYBHcnvuh0aU2e4zf37RA@mail.gmail.com>
 <CAHk-=wh=G47oD2F1CgOrvGFbEPh2ddMKLV4_wV_bs6S=98aZ5A@mail.gmail.com>
 <AM6PR03MB5170A6AA240D2E8F5E88B911E4AD0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wguiKq8yf11WJjgSL4ADKZ5sLe_Qbd7vHEqAkTvZJ+d+Q@mail.gmail.com>
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <CAHk-=wgcvn1_1kCkyourNCKeH+KrzSMRvc-ai_NLU4RGZT_XBg@mail.gmail.com>
 <AM6PR03MB5170CCB8D9D41904066DAFD5E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wiOdXfMa35bwCNfCNSsAndO-hFmsSNRWEEDziA1iDYGjg@mail.gmail.com> <AM6PR03MB5170BC4A276D72EA54398C58E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170BC4A276D72EA54398C58E4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Apr 2020 09:40:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhZ4uS6XKxJdV0MZO1AN-vhvVmeSeGFSntk1GjpyPwjg@mail.gmail.com>
Message-ID: <CAHk-=wjhZ4uS6XKxJdV0MZO1AN-vhvVmeSeGFSntk1GjpyPwjg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
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

On Thu, Apr 30, 2020 at 7:29 AM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> Ah, now I see, that was of course not the intended effect,
> but that is not where the pseudo-deadlock happens at all,
> would returning -RESTARTNOINTR in this function make this
> patch acceptable, it will not have an effect on the test case?

So that was why I suggested doing it all with a helper function, and
also doing that

        set_thread_flag(TIF_SIGPENDING);

because without going through the "check-for-signals" code at return
to user space, -ERESTARTNOINTR doesn't actually _do_ any restart.

However, the more I looked at it, the less I actually liked that hack.

Part of it is simply because it can cause the exact same problem that
ptrace() does (at least in theory). And even if you don't get the
livelock thing, you can get the "use 100% CPU time" thing, because if
that case ever triggers, and we re-try, it will generally just _keep_
on triggering (think "execve is waiting for a zombie, nobody is
reaping it").

IOW, restarting doesn't really fix the problem, or guarantee any
forward progress.

So I'd have been ok with your "unsafe_exec_flag" if

 (a) it had been done in one place with a helper function.

 (b) it would _only_ trigger for ptrace (and perhaps seccomp).

but I don't think it works for that write() case.

That said, I'm not 100% convinced that that write() case really even
needs that cred_guard_mutex (renamed or not).

Maybe we can introduce a new mutex just against concurrent ptrace
(which is what at least the _comment_ says_ that
security_setprocattr() wants - I didn't check the actual low-level
security code).

So maybe that proc_pid_attr_write() case could be done some other way entirely.

Th emore we go through all this, the more I really think that Oleg's
patch to just delay the waiting for things until after dropping the
mutex in execve() is the way to go.

Is it a "simple" and small patch? No. But it really addresses the core
issue, without introducing new odd rules or special cases, or making a
lock that doesn't reliably work as a lock.

                      Linus
