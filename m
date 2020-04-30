Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD3EAC83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AABD2083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQqZHjXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgD3DAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3DAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:00:32 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A740C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:00:32 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so4875389ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LI1gGiD+U8SlesBE4BliBLDJc/+jluNrXUyQUPdrNJc=;
        b=dQqZHjXB2qAzxB7U2AEFSY8jqzhQa6ziKCE2j5WLRLJMSQcxXapG/+gepOLQ8l49yC
         1m8W8Chvbzs5g7bO3RtkLUC6KKBCSkLAn3g5PFEVVF4mNNJXOM1dzpPF0SdSPBEpZ1sc
         84r4nFuHhCEEdsKvf8MqtVQZdlHNUp3yuWa0dHlCi6MiDi+bgzpeKdQ0drEEejegjgfB
         3yyfkLRVTEyMJGM3eO1AMl9rjg4FYxBlsOpQeJOwgGZqkhB3ar22ADYvymq+S0CLwGod
         mlj3QK8Trik5DxvAdqeRVKcZsnwxRfp8+6A5rOwRBR3H8p6bIH+RENbM9UR+bU/LU+Pa
         +Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LI1gGiD+U8SlesBE4BliBLDJc/+jluNrXUyQUPdrNJc=;
        b=oK/HVLUuByUxmF/DBiQsS1PGR0BUYx9gHFqvQgOkL98QK4xFVMZQHvK9AemVyCv4Br
         GhdL9Efd/XncDN1qe6SlPIu4ExoYmUEQu2omXJ2xY6ZVba/ZW7DJA70LN3fXIe5HrFN7
         P9XEUeo2VetAejAwEKJch/ZzYsTBEeL0+AV0zUi2TAqrXH6veyfH9K+o+KsSf/Td6SBV
         g9NRcJBMfogUzvSFLhFtkXSy/25ghCJqjHy16fqOjAk/N++WV02eqPowvzI68soHQIbR
         Kkn4O0ZPh7jQpujL4ZoGQt2IjSWs3DYvxxKn2fLRRNjjkNuvCNAZg/3Lfj70RUD8+54A
         qCrw==
X-Gm-Message-State: AGi0PuaWe0/S9RSkAeotDsoP6Jt/0TFu8X52dnhCjZluBU4dL97EoAic
        LxQxS8V1PSOhiEAbHJp92TeaM/EJxE8S+snbiWbLmw==
X-Google-Smtp-Source: APiQypK4nfDTS24pWald3rMbn8NAq8hbBXn7T4Hnxzm19fS3+AH/v9SUxej6h18Ck9+QrJHx2EhAfzemZf8iaCtwlV0=
X-Received: by 2002:a2e:b0c5:: with SMTP id g5mr726649ljl.203.1588215630047;
 Wed, 29 Apr 2020 20:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
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
 <CAHk-=wjUZLybZBJgOtD2gng=FS7USrbQQ1-tn5M+UP5DbCWdzw@mail.gmail.com>
 <CAG48ez0FL3i4eGFYryOwG2nnS+JigfKYAVSV9ogVHjmjOWzsrA@mail.gmail.com>
 <AM6PR03MB5170C5D02C6FCB6D69DFE3ADE4AA0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg6oKSLkVhY5oqOFyzCCSr9eYPGK2SHJfgCXF_QOmPKog@mail.gmail.com>
In-Reply-To: <CAHk-=wg6oKSLkVhY5oqOFyzCCSr9eYPGK2SHJfgCXF_QOmPKog@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 30 Apr 2020 05:00:03 +0200
Message-ID: <CAG48ez25=6qrCU51dEAV_ciyU2jvPuRFWfFOAAT22kmeAZccuQ@mail.gmail.com>
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

On Thu, Apr 30, 2020 at 4:20 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 29, 2020 at 6:08 PM Bernd Edlinger
> <bernd.edlinger@hotmail.de> wrote:
> >
> > I added the BIG FAT WARNNIG comments as a mitigation for that.
> > Did you like those comments?
>
> No.
>
> What's the point olf saying "THIS CODE IS GARBAGE" and then expecting
> that to make it ok?
>
> No,m that doesn't make it ok. It just means that it should have been
> done differently.
>
> > Yes, exactly, the point is the caller is expected to call wait in that
> > scenario, otherwise the -EAGAIN just repeats forever, that is an API
> > change, yes, but something unavoidable, and the patch tries hard to
> > limit it to cases where the live-lock or pseudo-dead-lock is unavoidable
> > anyway.
>
> I'm getting really fed up with your insistence on that KNOWN BROKEN
> garbage test-case.
>
> It's shit. The test-case is wrong. I've told you before.
>
> Your patch as-is breaks other cases that are *not* wrong in the kernel
> currently, and that don't have test-cases because they JustWork(tm).
>
> The livelock isn't interesting. The test-case that shows it is pure
> garbage, and is written wrong.
>
> IF that test-case hadn't been buggy in the first place, it would have
> had ignored its child (or had a handler for SIGCHLD), and not
> livelocked.

But if we go with Bernd's approach together with your restart
suggestion, then simply doing PTRACE_ATTACH on two threads A and B
would be enough to livelock, right?

tracer: PTRACE_ATTACHes to A
B: enters de_thread()
tracer: attempts to PTRACE_ATTACH to B

Now the tracer will loop on PTRACE_ATTACH, right?
