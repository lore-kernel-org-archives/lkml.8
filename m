Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464D7C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 234422064C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="meYDDc/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgD1Vxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725934AbgD1Vxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:53:37 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB734C03C1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:53:36 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 198so18118434lfo.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EebmjuehlITayp5XUzqWL+oJJRo+KSj0cYhRYx1gdlA=;
        b=meYDDc/NArsPldNgBgNJvrPvMIFHwYS0eD8aPeUWYtpdZTlFyEn5GX2LksPqglJHgk
         EVKmWqoVAaKuViS0X3GMxJ9j0QsRi1r5ZKpNap+JbNg/5cX+nBJxgWnQhnkvD2Z/sVVX
         s2B8DMwznPP6crTK8gUVsUUkGnYEKkHNtBtdcOzPkOmvNQUDNhVU0QRbAAalgjJZWIxV
         winagD3FWbOyBtQIEzXVoPMBuIu7pPRBIThcQ8C6bjb58g9R+VrgHTziKQ/43+2qZeu/
         palfN8xIHpmdSHyeWb0FLV51Hiqb/9NFSSiq07YOp6F//OanEJIE8W7br+Rn/PCPIyZW
         2Oww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EebmjuehlITayp5XUzqWL+oJJRo+KSj0cYhRYx1gdlA=;
        b=Hii5Q8O6eTowGTewhS4Np4KVIJEITWxPA2/nFnVbpu6O0EVfZQs6DtRKIN3Y74oHlG
         nlEwXBh2Vmp4wpEcZPceEpeQizeHDcfFeG7sKOIizUzfvU9SFRQbzlvhSRoDwIdTwsfQ
         xYDtN84Cul8xL0cuoIuXFiOuy/BejbubpMZf0dLsK5HcP/Zmv5C+iRKQjWsGI5S2i+dc
         krZ9mP5aOoSLlW8tB0pv948FrXWqwOhqeJ+8vKqzKZLtnbNV4KPhWcWNN5c3X2gAavfs
         kR3ESP4LlTfNl+oivLn7nyOKWg3h5/xLXqFvvI7CULVCR+K6vUJf7V16/wsg+FGtySxb
         zFLA==
X-Gm-Message-State: AGi0PuaVtC7lO7Loo9BxVdsYM0ZstqZJrAnS6P+7bWrbikq5ZFnDGu3S
        6LABcEjLZmL+fKpF93dPSK0mLmHnmuM3KYMqQuvuQw==
X-Google-Smtp-Source: APiQypJuhLaNNHXGi961rAv3/PkE4xDpF8B341WyZL4HyhwZWoY06bgKp3ljqCOSSkgZEFkd7QpCeUqGrWARsTp/EHo=
X-Received: by 2002:ac2:4257:: with SMTP id m23mr20189275lfl.141.1588110814972;
 Tue, 28 Apr 2020 14:53:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
 <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com> <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjTLnMuZmBO2foeHhsLAoUTpUi7oBVJ67F4XKB+tdEDbQ@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Apr 2020 23:53:08 +0200
Message-ID: <CAG48ez3EQOvdbzu9aO-cEAJwF_=fJzn1Cg0LMs3ruc=5r1ie5w@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
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

On Tue, Apr 28, 2020 at 11:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 28, 2020 at 2:06 PM Jann Horn <jannh@google.com> wrote:
> > In execve:
> >
> >  - After the point of no return, but before we start waiting for the
> >    other threads to go away, finish calculating our post-execve creds
> >    and stash them somewhere in the task_struct or so.
> >  - Drop the cred_guard_mutex.
> >  - Wait for the other threads to die.
> >  - Take the cred_guard_mutex again.
> >  - Clear out the pointer in the task_struct.
> >  - Finish execve and install the new creds.
> >  - Drop the cred_guard_mutex again.
> >
> > Then in ptrace_may_access, after taking the cred_guard_mutex, we'd
> > know that the target task is either outside execve or in the middle of
> > execve, with old and new credentials known; and then we could say "you
> > only get to access that task if you're capable relative to *both* its
> > old and new credentials, since the task currently has both state from
> > the old executable and from the new one".
>
> That doesn't solve the problem with "check_unsafe_exec()" - you might
> miss setting LSM_UNSAFE_PTRACE.

You don't need LSM_UNSAFE_PTRACE if the tracer has already passed a
ptrace_may_access() check against the post-execve creds of the target
- that's no different from having done PTRACE_ATTACH after execve is
over.
