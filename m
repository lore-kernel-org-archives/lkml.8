Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B045C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2FD20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730332AbgGALds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:33:48 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:40583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730196AbgGALdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:33:47 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Macf4-1jFtb91Xnm-00c6Rl; Wed, 01 Jul 2020 13:33:45 +0200
Received: by mail-qk1-f178.google.com with SMTP id j80so21792235qke.0;
        Wed, 01 Jul 2020 04:33:45 -0700 (PDT)
X-Gm-Message-State: AOAM533T6ALZjEidRqExrH5mKItpO4/RnI33awMDPqAfmY9TgSooEYhV
        x/SFu5CYjGQ9T0cFADODlTWPn53JzTz8PDed9CU=
X-Google-Smtp-Source: ABdhPJzUyheLKExWmWPJJq8cfmtDNQPYUV5VmAxlZw/B9iC/fX9pH44hi8zZXNkJzktUY7GsGZCLQHu7TodbT+JJTF8=
X-Received: by 2002:a37:9dd6:: with SMTP id g205mr25563365qke.352.1593603224183;
 Wed, 01 Jul 2020 04:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200630173734.14057-1-will@kernel.org> <20200630173734.14057-3-will@kernel.org>
 <CAK8P3a136e2k-iGoJ4X51mnj0f0KSLJKOw6b=s4F2QHHeyAMEQ@mail.gmail.com> <20200701101603.GB14959@willie-the-truck>
In-Reply-To: <20200701101603.GB14959@willie-the-truck>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 1 Jul 2020 13:33:28 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0cfjU-EOVJoMrUcjVDXLOk1Trv4DWcz_bME5Aj3=JPvQ@mail.gmail.com>
Message-ID: <CAK8P3a0cfjU-EOVJoMrUcjVDXLOk1Trv4DWcz_bME5Aj3=JPvQ@mail.gmail.com>
Subject: Re: [PATCH 02/18] compiler.h: Split {READ,WRITE}_ONCE definitions out
 into rwonce.h
To:     Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:/RjR3cx/IosXmLHSIAw3K2DqSQYhrhXWA71/rRKV/wIh3QCve5q
 gHLw8HS5iSdMhiBqrGklBQMexmENgsjC4XY3iUWttf+hhm5BmUWNDrq7JkrPkuEoBALjdhk
 raeyrDJuwB4zboNjFNxyEmQZtcyRtSEL2IrtiZL0NG0ksR8S/sAH31lB6rD/U23yzLls2/7
 +eDDFhwm4BJ5vwtrEkhfw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:umKuxKgCI1I=:/r8f8diZkq+0S5w0FdPi4N
 eWZO6vSDlA6Zp+V1hvLgtcU7LKYJJxMf+eEkUvS/E5v06klFMH91fDuGWtwPGu0ROZUsBw2X1
 LqAhs/Jq/iW+9dJ/SRfWgRIQHciZIf97liLiAclok9p6adg4aVUE30qgg7YkJOwlf3v6FO67U
 1vG6L3EDxClpI6oUyaavz1w1jvK5nM5ZAMBSaEudxDmyybYVUeZVGmGDh6DjuEZoDUUSlvvt8
 nUducq41B+zL9NBiRX/5UsSQNXXiAxBVl1Mz39Dj+qRrfyCGtCBpDYBIz00hdlNP5yPzqsaMO
 wAomUWS60A6zqCvHHrYgYxRCsAqoiYeoiq9Vprm98My2NRtxIyNEV/0iiCLbDoXPv1wkhGmxd
 esUq2Q3gYFig/Q8bep5Q0axtp9pmNP15VVYlrkHeHp3CzjKH0zzEk7A7Cmzcsv9uzF1RYhtPC
 IMttQiM8U/5kalUCZRWVG6auHlBJWclsfH0trOl3dR3FLg9iv7qiw9PKagzs+RA9NeOgsXpzN
 7ukk9nHNCZSM1Nj9PEyCmTObPfldglxPA6xoMvMLeEmUANe+NqKJQYsVtRzsQGACi0Kyb+lYI
 Q51/4YXL+RptvMLqkol+XLc9BZ1VtD7fX6GBOc+PPeKjSx5wV1xR+jvnSsCCjpUGbHsAXU1WW
 d9bpZ/jxupuo5a4/yDD08rAv7TVNrKk2rs/DLffKGRdGbJkQz80DBp0h5437lbWUb98OMHbwr
 +ul3fSvH7Y3a1QD2oF/mA9vLiXrR3bOCKf+LAlIRq0Oz8R8r66DYQZ3xAc3HCAMB8WxQvheiY
 h8rnkXx3DEBg8BGq82zjLmhUAIrejbvsETKZXFsqpj6Q3AE2oo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 12:16 PM Will Deacon <will@kernel.org> wrote:
> On Tue, Jun 30, 2020 at 09:11:32PM +0200, Arnd Bergmann wrote:
> > On Tue, Jun 30, 2020 at 7:37 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > In preparation for allowing architectures to define their own
> > > implementation of the READ_ONCE() macro, move the generic
> > > {READ,WRITE}_ONCE() definitions out of the unwieldy 'linux/compiler.h'
> > > file and into a new 'rwonce.h' header under 'asm-generic'.
> > >
> > > Acked-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  include/asm-generic/Kbuild   |  1 +
> > >  include/asm-generic/rwonce.h | 91 ++++++++++++++++++++++++++++++++++++
> > >  include/linux/compiler.h     | 83 +-------------------------------
> >
> > Very nice, this has the added benefit of allowing us to stop including
> > asm/barrier.h once linux/compiler.h gets changed to not include
> > asm/rwonce.h.
>
> Yeah, with this series linux/compiler.h _does_ include asm/rwonce.h because
> otherwise there are many callers to fix up, but that could be addressed
> subsequently, I suppose.

Right, I didn't mean you should change that right away. I actually
have a work-in-progress patch series that removes a ton of
indirect header inclusions to improve build speed, and a script to
add the explicit includes into .c files where needed.

> > The asm/barrier.h header has a circular dependency, pulling in
> > linux/compiler.h itself.
>
> Hmm. Once smp_read_barrier_depends() disappears, I could actually remove
> the include of <asm/barrier.h> from asm-generic/rwonce.h. It would have to
> remain for arch/alpha/, however, since we need the barrier definitions to
> implement READ_ONCE(). I can probably also replace the include of
> <linux/compiler.h> in asm-generic/barrier.h with <asm/rwonce.h> too (so it's
> still circular, but at least a lot simpler).
>
> I'll have a play...

I think this would require the same kind of fixup for anything that depends on
asm/barrier.h being included implicitly at the moment.

      Arnd
