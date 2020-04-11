Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53EBC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68072214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 20:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586635826;
	bh=tkZx2eZMiYDdxOplK8fnIi/vRbwYtSUc5CMh5quFCDs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qp4MWpWGcvmwYZdDwoRIs4AaTVqgKfY59p2dRY409hEEwoD9fxfBmefTBfNEFA+4a
	 nnda8AVSbCYMqEk8WT/uuH/ItNk4FSkUEs0OmziFVq+xNE+IaQuj4/F5Rmeub814Rj
	 cP6yhol/CSpSMCmrgt+Kik0IVpJO2KuJXfU9L6II=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgDKUIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 16:08:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43192 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgDKUIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 16:08:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id h25so5099203lja.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ckETjyKs3wJXPyqZgyPwa/yV7VS5IBRDAAJU3FEjkSI=;
        b=EL+bYpcUnaTcXWuvXtH0M/jVlt2lX7v0fF2yiZ5VLTU81EC49R9knRc+9ab/5P+SQ9
         bYI1m/YaM57oGAi1kIj73BgK9hW/nwhCsOn68BOUKcggV+vF04VxsRpVWnlJmyAtZ9EI
         yOSqQP8XwRRu3KF6LTK1e/gBPk63JS4N4Cbbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ckETjyKs3wJXPyqZgyPwa/yV7VS5IBRDAAJU3FEjkSI=;
        b=M23UZ2bnj76T7lQM4zBLAGclmbOB8kMXADSvi2pTq9MNDM2ll9WEwkxoLN6z6vjVaQ
         Id6/lbNY69n901SELXWC6sHUFB5Zy4Tfcu7ribPGhDx/PtlYbxT5P9dQwVpVnWRmC9Cl
         FIP09SWD0xm1YRFArI51X2i7Hh30V4gaJBqTvgZC2N0QZXcGZgAL3CgMBXjT7omGyRxb
         H0Vu/cdRXYdG3TALx+mffl+y2Q0jgHuBk34ZiyOmecLY2jcnqXCKkjywe2Pj/N2iARou
         17yRBr7oPgHg4j6XBKFuAdFGOEiAnXsofksI1VwG72Q8jQeCw+3ppwclhd5gwQFyV4yM
         L7jA==
X-Gm-Message-State: AGi0PuYxIiX43mc17kO0VRQDuMQPQwE8RC65Cr1gmRvAnEXWOyX4M35d
        xqaf4KlR584M1tfs/DlkxrK7CFuXSJc=
X-Google-Smtp-Source: APiQypL9Ak47nyqNi9Gmwblw2m8gvMDsvTuFLIqGLkiphc8UCZQ9tkfS4LGnlULmalH5uFhvUIpN4g==
X-Received: by 2002:a2e:4942:: with SMTP id b2mr6592014ljd.135.1586635687047;
        Sat, 11 Apr 2020 13:08:07 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id b16sm4462453lfj.2.2020.04.11.13.08.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2020 13:08:05 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id l11so3707319lfc.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 13:08:05 -0700 (PDT)
X-Received: by 2002:a19:6144:: with SMTP id m4mr5889906lfk.192.1586635685181;
 Sat, 11 Apr 2020 13:08:05 -0700 (PDT)
MIME-Version: 1.0
References: <AM6PR03MB51708FD4226E07AB7CB0D6A7E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wjaoYM4gXdAyYY=u8PaYj2LXUvcfp=8DKum8f1DM+Ws0A@mail.gmail.com>
 <AM6PR03MB5170F924EA69A81D79BD0929E4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whMKC5F-=QQP=fCNRuTF+ZGiNtLEKvx7KekpK1JtrwDhw@mail.gmail.com>
 <CAHk-=whJ8khGBqfqh6ZmHsKjcyyBLm5xgkgLW_AC_=82iFBWoQ@mail.gmail.com>
 <AM6PR03MB51700B243E34BF4A59FF33CFE4C10@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whJttTNFQn1fMYp91LZ90iHE7B2THZ8NjQ7fBwmWX9k6w@mail.gmail.com>
 <87imi8nzlw.fsf@x220.int.ebiederm.org> <CAHk-=wgh4zts+3hdkGzHLJ6pBGumcJ=23gRbMfubDrLstis2Bg@mail.gmail.com>
 <CAHk-=whKHpERyVv2-C+kxq9KV_mJPW3hkGDpn6f4yOvs+au8SA@mail.gmail.com>
 <20200411182043.GA3136@redhat.com> <CAHk-=wgwXpKepChGi4ZhQVxZxD0ic8s2CDXvUmqBTMaKGz-fjg@mail.gmail.com>
 <AM6PR03MB5170660DA597EAAAC0AC1B5BE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5170660DA597EAAAC0AC1B5BE4DF0@AM6PR03MB5170.eurprd03.prod.outlook.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 11 Apr 2020 13:07:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXxM0VnLN6iwVeORwxED5QgXS_AXUJ4+Af3jUeFY21gw@mail.gmail.com>
Message-ID: <CAHk-=wjXxM0VnLN6iwVeORwxED5QgXS_AXUJ4+Af3jUeFY21gw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull proc and exec work for 5.7-rc1
To:     Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
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

On Sat, Apr 11, 2020 at 12:15 PM Bernd Edlinger
<bernd.edlinger@hotmail.de> wrote:
>
> But won't the dead thread's lifetime overlap the new thread's lifetime
> from the tracer's POV?

What new thread?

execve() doesn't create any new thread.

But yes, an external tracer could see the (old) thread that did
execve() do new system calls before it sees the (other old) thread
that was a zombie.

But that is already somethign that can happen, simply because the
events aren't ordered. The whole issue is that the zombie thread
already died, but the tracer just didn't bother to read that state
change.

So it's not that the dead thread somehow _dies_ after the execve(). It
already died.

It's just that whoever is to reap it (or traces it) just hasn't cared
to read the status of that thing yet.

             Linus
