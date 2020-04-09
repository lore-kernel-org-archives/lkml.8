Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE39C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2E820753
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586467083;
	bh=iFJ2uXSUtewQGy/XQWzDbwdljeWyAp5lFEbtIqeww1M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=e7gDIQktE7fVBVgiBtWPEr5aTz+7sSJP8x7jTh8FROBi/EcDQeTvxHHEntV8orTyd
	 uSfEKY8vOga7P5RkSPzayIXjuGnczK8Xh/h2HFrR9oKnwNH1uCP/x/sJ2nV4Badhzp
	 sopt/u6i3KvZT31rWZx0yebEo9N6M8I2gPxvd9P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbgDIVSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:18:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34783 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgDIVSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:18:01 -0400
Received: by mail-lf1-f65.google.com with SMTP id x23so782137lfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3ANlkc73xfE7W9i+/i/PzZhTTMot1WbopUumX0rZso=;
        b=TxHSnl5hL9hBLbhzpFFxIIOfEr8Xnaemb9ujkuS20q7mBQjEQ06csx2hlFV+zrgpup
         6dO7d2KwP2bItlzFl438olGyiqFuJzQzU5T7C+QmihScFUaRPswsPZ54xGuUwj654Q74
         W0Ot8qmNDtMNw7H16o5lyW+WTWJ6YCHGAvMqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3ANlkc73xfE7W9i+/i/PzZhTTMot1WbopUumX0rZso=;
        b=jalHcjSK3avGFcds5HbbX9rL8eIQnEpFv28LSkKBqxcMDGvEpp0UzEPY1GT8doEPBY
         v/KKGdQ0vQruHfeGmDEJWNnZVpt7609XPepfu5FP8Y9dQWYzCyN/KyQrAwwo2emkJIT+
         pxEUgRf5C0IB0zHqN+1Rsy/oJ9qomr1byyg0HXOpNRpsh0mDRmI8/jAhUPacCYwfDgtw
         U3IMKbszmMosJYlDcZ/Cxv+RF40xy+KFF5GWfcKt7QT/e6fVA9vMuuUaTT5lznE9OUgv
         YD3ztBKWqrMo7cJHOC9XU/hVVmHuFPnce8m6hBmSrn2HqjNs2RUgN+tONPuXoNQlYMgK
         UJPQ==
X-Gm-Message-State: AGi0Puac6Z60FlvR/6TcTlb+XaODb+/2w7pO2TrF9Zn+u10tH3PKcEPt
        eOOGLt+qdiGzwMNSJmq//3ldmShcnw4=
X-Google-Smtp-Source: APiQypKxDJMFR7PjDUPYyEodmyzYF91/4JicIAbIzgWah1jse6jfu12DJ2le7+cFqnEKFh69a9qM+Q==
X-Received: by 2002:a19:e00e:: with SMTP id x14mr714332lfg.111.1586467076718;
        Thu, 09 Apr 2020 14:17:56 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id y29sm16102785ljd.26.2020.04.09.14.17.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:17:55 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 131so740769lfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:17:55 -0700 (PDT)
X-Received: by 2002:ac2:4466:: with SMTP id y6mr699561lfl.125.1586467075152;
 Thu, 09 Apr 2020 14:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <87blobnq02.fsf@x220.int.ebiederm.org> <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjxyGCj9675mf31uhoJCyHn74ON_+O6SjSqBSSvqWxC1Q@mail.gmail.com>
 <87blo45keg.fsf@x220.int.ebiederm.org> <CAHk-=whES-KCO6Bs93-QBK1tS5CfiWSi+v5D1a7Sc1TD5RFoaA@mail.gmail.com>
 <87v9maxb5q.fsf@x220.int.ebiederm.org> <CAHk-=wih4BqW7GTLaYxewynuT-iFHrXroip0wNo0CyPtmYGUow@mail.gmail.com>
 <87y2r4so3i.fsf@x220.int.ebiederm.org> <CAHk-=wjhAvv6s_7OVeZJiHaY7bBrHyiPTkSpq-TLr6qxYqxUUw@mail.gmail.com>
 <CAHk-=wi0jrKv9x6vJ9FDgTrSUbdbZYDX-79T-E87C48MGSn5=g@mail.gmail.com>
 <87wo6or3pg.fsf@x220.int.ebiederm.org> <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com> <87imi8nzlw.fsf@x220.int.ebiederm.org>
In-Reply-To: <87imi8nzlw.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Apr 2020 14:17:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
Message-ID: <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 2:03 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> But no.  While you are goind a good job at spotting odd corner
> cases that need to be fixed.  This also is not the cause of the
> deadlock.  It is nothing that subtle.

So Eric, I'm now going to stop wasting my time on arguing with you.

Since both you and Bernd claimed to be too busy to even bother testing
that thing, I just built it and booted it.

And guess what? That thing makes your non-deadlock thing go away.

So it's _literally_ that simple.

Now, does it make the tests "pass"? No.

Because the "vmaccess" test fails because the open() now fails -
because we simply don't wait for that dead thread any more, so the
/proc/<pid>/mem thing doesn't exist.

And for the same reason that "attach" test now no longer returns
EAGAIN, it just attaches to the remaining execlp thing instead.

So I'm not just good at "spotting odd corner cases". I told you why
that bogus deadlock of yours failed - the execve was pointlessly
waiting for a dead thread that had marked itself ptraced, and nobody
was reaping it.

And it appears you were too lazy to even try it out.

Yes, that whole "notify_dead" count vs "tsk->exit_state" test is
fundamentally racy. But that race happens to be irrelevant for the
test case in question.

So until you can actually add something to the discussion, I'm done
with this thread.

           Linus
