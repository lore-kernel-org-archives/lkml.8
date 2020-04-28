Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B83C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D792072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeE9YjIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD1VGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD1VGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:06:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1978C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:06:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so236574ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OAyhRvn9T9rGX86VAJNageFChs7xaifFIhpVtWdiaas=;
        b=CeE9YjIwTMW8CWILtr2vamZ+47wZ4HXevcxF4gCYriFVCGSjjaDnluRa8MpqlIjBZw
         tNSZQbX3Xviu+b3vd42pX30tnY8CrzLSFXzA/26L93XvY1aXw6W2qyBNOr78YItOFamR
         PXtqdgGm5LljX34XEGYvFWHWe3BMu6PNUlyLZFIkdscveZNoWanc9teg+D3H/p+pPpyQ
         uXLqD1zZdlsMNVo0v0WZWv2YJN6xqEXXFyW0UtQTzGsV3eydm4dAUpAl+2yeDCbmJHwE
         zxzqwLUgfzCqGNwswdJgth1HG2sD9CA6vHNOKWe4tIu0vzebaU1c23XMspSS3LQeLQTp
         pRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OAyhRvn9T9rGX86VAJNageFChs7xaifFIhpVtWdiaas=;
        b=YYmOo7IYjimoItLa8izwA+j5M6ZkSKNJ3ydB0/Id854L+K3A+4+wrcCujH3I9MoiXW
         KsBjQbQ6mgecFze9LS3AtbWk3OwvMDlMt14vPy0vHQ9YRlkGY6QiY6lWH//ku8M2khsm
         UqFx+NjwPQIlgpVdwAJu2woK024zDQZBxRGMIBv/IxPjYn9sqdML184s+FoEb5ZFiLOH
         IXPli0lxwH4aetuN4nxef2NL1UGF3/XSd20fWUbqdgo4v1w+lfbcm87cdLjhX1Bn0/vW
         fwaJI/f/osi/fp6vgnYeFuHfGeiGHwA2E+SeLhg67G92o52He8aRf0J0PMWPIbx78z5h
         lH2A==
X-Gm-Message-State: AGi0Pub0T8GzA+wflyNkggrtMZna/VwAFDTLIL/e/uihIyXMOe9JiR0U
        ZqVAMS0qt6rRiK8Ez3kInS8l8oGVd7Dk7p0o0wUKCg==
X-Google-Smtp-Source: APiQypLrMukjQ8WwkSFBPseMFD3bKPDw2bRXaJ2pwFisVkWdhuqDeANHVhLRnYKw+y+YEYbumIVNpX0LLpF24K2NW7c=
X-Received: by 2002:a2e:87d3:: with SMTP id v19mr17725331ljj.176.1588107987932;
 Tue, 28 Apr 2020 14:06:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <20200412195049.GA23824@redhat.com> <CAHk-=wiDwR+6ugYaKEGHfYteLF+NH5xu=T7uuUTkK9y-hr6zow@mail.gmail.com>
 <AM6PR03MB51708CF53D8A02086427DAC2E4AC0@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wi_zr9dwX3UBYvgkmm6eVQfRP50orryJ6ZVAxuFqdSG5A@mail.gmail.com>
 <20200428190836.GC29960@redhat.com> <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
In-Reply-To: <CAHk-=wi03QRcUR1DfbEr+Pw-DAMENzY-FuRcGawtj9p597=p2w@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 28 Apr 2020 23:06:01 +0200
Message-ID: <CAG48ez03ABTa-KbCtFHqB1hOT7dgAM96c3kiw-e80B+utSEwYw@mail.gmail.com>
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

On Tue, Apr 28, 2020 at 10:36 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 28, 2020 at 12:08 PM Oleg Nesterov <oleg@redhat.com> wrote:
> >
> > Oops. I can update that old patch but somehow I thought there is a better
> > plan which I don't yet understand...
>
> I don't think any plan survived reality.
>
> Unless we want to do something *really* hacky.. The attached patch is
> not meant to be serious.
>
> > And, IIRC, Jan had some ideas how to rework the new creds calculation in
> > execve paths to avoid the cred_guard_mutex deadlock?
>
> I'm not sure how you'd do that.
>
> Execve() fundamentally needs to serialize with PTRACE_ATTACH somehow,
> since the whole point is that "tsk->ptrace" changes how the
> credentials are interpreted.
>
> So PTRACE_ATTACH doesn't really _change_ the credentials, but it very
> much changes what execve() will do with them.
>
> But I guess we could do a "if somebody attached to us while we did the
> execve(), just repeat the whole thing"
>
> Jann, what was your clever idea? Maybe it got lost in the long thread..

My clever/horrible/overly-complex idea was basically:

In execve:

 - After the point of no return, but before we start waiting for the
   other threads to go away, finish calculating our post-execve creds
   and stash them somewhere in the task_struct or so.
 - Drop the cred_guard_mutex.
 - Wait for the other threads to die.
 - Take the cred_guard_mutex again.
 - Clear out the pointer in the task_struct.
 - Finish execve and install the new creds.
 - Drop the cred_guard_mutex again.

Then in ptrace_may_access, after taking the cred_guard_mutex, we'd
know that the target task is either outside execve or in the middle of
execve, with old and new credentials known; and then we could say "you
only get to access that task if you're capable relative to *both* its
old and new credentials, since the task currently has both state from
the old executable and from the new one". (Other users that expect to
use cred_guard_mutex to synchronize with execve would also have to be
changed appropriately; e.g. seccomp tsync would have to bail out if
the task turns out to be in execve after the mutex has been acquired.)

So I think we can conceptually fix the deadlock, but it requires a bit
of refactoring. (I have an old branch somewhere in which I tried to
implement this, and where I did a bunch of refactoring around
ptrace_may_access() so that e.g. the LSM hooks for ptrace can be
invoked twice when the target task is in execve, and so that they take
the target's cred* as an argument.)
