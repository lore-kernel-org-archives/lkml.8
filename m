Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F7FC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB10D2080C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387735AbgDBITs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:19:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36370 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387603AbgDBITs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:19:48 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJv4f-0007Hd-K5; Thu, 02 Apr 2020 10:19:41 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B8300100D52; Thu,  2 Apr 2020 10:19:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
In-Reply-To: <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com> <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com> <87v9mioj5r.fsf@nanos.tec.linutronix.de> <CAHk-=wh3_WTKeR=TTbPpbJYjC8DOPcDPJhhoopTVs3WJimsT=A@mail.gmail.com>
Date:   Thu, 02 Apr 2020 10:19:40 +0200
Message-ID: <87sghmnvtv.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Wed, Apr 1, 2020 at 4:55 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>   - x86 starts the short log after the colon with an uppercase
>>     letter
>
> Ahh. I actually tried to match the previous ones by Al, and they don't
> follow that pattern.

Yeah. As Al's stuff was late already, I just took it as is.

>>   - All commits lack a Link:https//lore.kernel.org/r/$MSG-ID tag. That
>>     might be an oversight or just reflecting the fact that these patches
>>     have never seen a mailing list.
>
> Yeah. They were literally me looking at my patch in my other tree, and
> trying to make incremental progress.
>
> Nobody else has a working compiler to even test that patch, because
> even upstream tip-of-the-day llvm mis-generates code (I have a patch
> that makes it generate ok code, but that one isn't good enough to
> actually go upstream in llvm).

Fair enough.

> I don't think I'll do any more, because the next stage really is to
> actually have some CONFIG_ASM_GOTO_WITH_INPUTS code and then try to
> make something similar to the SET_CC for this.
>
>> From a quick check I can confirm that the resulting text changes are
>> just random noise and I did not notice anything horrible in the
>> generated code either.
>
> Btw, do you guys have some better object code comparison thing than my
> "objdump plus a few sed scripts to hide code movement effects"

Not sure whether s/sed/python/ makes it any better :)

Thanks,

        tglx
