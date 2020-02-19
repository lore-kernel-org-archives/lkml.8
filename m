Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3554AC7619D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0946620656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 22:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SI2uasgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBSWnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 17:43:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40777 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727232AbgBSWnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 17:43:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id b185so822464pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 14:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DarAl82PcxJAMUan8osRqiWJP5zrzBNFn2my/A9LRV0=;
        b=SI2uasgQc9FMfi5L8cj/jMw5i/igTpq5jC76d8Ym788Dg4qfgnAUOue0gF1t/Q//25
         CuR3r/WGfAOahQVIpbSGoeK53gfYTf6gBU6A+NGdEbBkR6qgO3pEjsY/wulM9RBIXpkb
         lfZ3o+uAQLoYpJKeEHu+KySxpiicUAPB7ek0vQX+MF2S2SqgG03zrU6fc7s6lWDC6Vjc
         F7tdFfJ5Rq1FOUk2FKQqFq+okBgPsCEEB9chHVPLm9iDwZ1hz+VnIxib6yUAW6BtmKwR
         u6vFhBzCyzsLm5snKXcTsbkh/i9rk8FFZVVUAbtsHXJf85L5lkyWQSY3nSTuF7zXr8R8
         sU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DarAl82PcxJAMUan8osRqiWJP5zrzBNFn2my/A9LRV0=;
        b=HoVPkf9MCLNTwc0vcIKzJhO6hE141AB2oJpr9HtwkeVYQXHpRz1a79XCqZOs8HswA6
         Sk7V9AL86Sr/yS99i00PG7sLK9qQGRU36B9XEkGtupU57KRJ9Hn7pm3f3YJNO6sMRo8o
         64yCcB5EPId2sSvqdIWiNXmefaJvme+7daM/zXus391Z5/Y8ijKFK8qIg4B5tlafNtIF
         WFFSW61tkGOck+x9qZtpMSsJvJqpQWsNiZGpj9msDfclOvallc7DM5N2/Hjz1ZHhk2ck
         aBIR5EI9zziW/8f4FsZU0PUNdmGWqQw00iiccAJtNr0mOXaNGm+K/EC5SPE7y/qGuYzR
         /U7Q==
X-Gm-Message-State: APjAAAVPiTfMD83WlxJnZpA2LqyIUS4Hor6krtqJTvOb+oy4u/yvsVtA
        4KCMI9CLMPslRUabZ41lFgd9u2YUEjbj4dSaIRQlLQ==
X-Google-Smtp-Source: APXvYqxEZxyzj2o3h2/4b2lxiDR3ZyXP5vS3IdPCQrTBEhnxDQlQi2PAtKFWTpf2l/rL2e36VXoG7CgtC1N0WJrPr48=
X-Received: by 2002:a63:f24b:: with SMTP id d11mr29148152pgk.381.1582152230079;
 Wed, 19 Feb 2020 14:43:50 -0800 (PST)
MIME-Version: 1.0
References: <f18c3743de0fef673d49dd35760f26bdef7f6fc3.1581359535.git.jpoimboe@redhat.com>
 <158142525822.411.5401976987070210798.tip-bot2@tip-bot2> <20200213221100.odwg5gan3dwcpk6g@treble>
 <87sgjeghal.fsf@nanos.tec.linutronix.de> <20200214175758.s34rdwmwgiq6qwq7@treble>
In-Reply-To: <20200214175758.s34rdwmwgiq6qwq7@treble>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Feb 2020 14:43:39 -0800
Message-ID: <CAKwvOdmJvWpmbP3GyzaZxyiuwooFXA8D7ui05QE7+f8Oaz+rXg@mail.gmail.com>
Subject: Re: [tip: core/objtool] objtool: Fail the kernel build on fatal errors
To:     Chen Rong <rong.a.chen@intel.com>, Philip Li <philip.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        tip-bot2 for Josh Poimboeuf <tip-bot2@linutronix.de>,
        linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 9:58 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Fri, Feb 14, 2020 at 01:10:26AM +0100, Thomas Gleixner wrote:
> > Josh Poimboeuf <jpoimboe@redhat.com> writes:
> > > On Tue, Feb 11, 2020 at 12:47:38PM -0000, tip-bot2 for Josh Poimboeuf wrote:
> > >> The following commit has been merged into the core/objtool branch of tip:
> > >>
> > >> Commit-ID:     644592d328370af4b3e027b7b1ae9f81613782d8
> > >> Gitweb:        https://git.kernel.org/tip/644592d328370af4b3e027b7b1ae9f81613782d8
> > >> Author:        Josh Poimboeuf <jpoimboe@redhat.com>
> > >> AuthorDate:    Mon, 10 Feb 2020 12:32:38 -06:00
> > >> Committer:     Borislav Petkov <bp@suse.de>
> > >> CommitterDate: Tue, 11 Feb 2020 13:27:03 +01:00
> > >>
> > >> objtool: Fail the kernel build on fatal errors
> > >>
> > >> When objtool encounters a fatal error, it usually means the binary is
> > >> corrupt or otherwise broken in some way.  Up until now, such errors were
> > >> just treated as warnings which didn't fail the kernel build.
> > >>
> > >> However, objtool is now stable enough that if a fatal error is
> > >> discovered, it most likely means something is seriously wrong and it
> > >> should fail the kernel build.
> > >>
> > >> Note that this doesn't apply to "normal" objtool warnings; only fatal
> > >> ones.
> > >
> > > Clang still has some toolchain issues which need to be sorted out, so
> > > upgrading the fatal errors is causing their CI to fail.
> >
> > Good. Last time we made it fail they just fixed their stuff.
> >
> > > So I think we need to drop this one for now.
> >
> > Why? It's our decision to define which level of toolchain brokeness is
> > tolerable.
> >
> > > Boris, are you able to just drop it or should I send a revert?
> >
> > I really want to see a revert which has a proper justification why the
> > issues of clang are tolerable along with a clear statement when this
> > fatal error will come back. And 'when' means a date, not 'when clang is
> > fixed'.
>
> Fair enough.  The root cause was actually a bug in binutils which gets
> triggered by a new clang feature.  So instead of reverting the above
> patch, I think I've figured out a way to work around the binutils bug,
> while also improving objtool at the same time (win-win).
>
> The binutils bug will be fixed in binutils 2.35.
>
> BTW, to be fair, this was less "Clang has issues" and more "Josh is
> lazy".  I didn't test the patch with Clang -- I tend to rely on 0-day
> bot reports because I don't have the bandwidth to test the
> kernel/config/toolchain combinations.  Nick tells me Clang will soon be
> integrated with the 0-day bot, which should help prevent this type of
> thing in the future.

Hi Rong, Philip,
Do you have any status updates on turning on the 0day bot emails to
the patch authors in production?  It's been quite handy in helping us
find issues, for the private mails we've been triaging daily.
-- 
Thanks,
~Nick Desaulniers
