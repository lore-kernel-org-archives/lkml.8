Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BBCC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A3B20721
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 23:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733261AbgDAXzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 19:55:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35943 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732682AbgDAXzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 19:55:52 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJnCz-0002IU-30; Thu, 02 Apr 2020 01:55:45 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 734D5100D52; Thu,  2 Apr 2020 01:55:44 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] x86 cleanups for v5.7
In-Reply-To: <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
References: <20200331080111.GA20569@gmail.com> <CAHk-=wjpBohNkBSxyPfC7w8165usbU5TuLohdbPs+D0bUYqJhQ@mail.gmail.com> <CAHk-=wijWvUfEkqUZRpvo9FCaJNsioS_qZT+iNWUdqQ6eO8Ozw@mail.gmail.com>
Date:   Thu, 02 Apr 2020 01:55:44 +0200
Message-ID: <87v9mioj5r.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Tue, Mar 31, 2020 at 11:09 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Lovely. This now makes my local boot-test tree be much closer to my
>> upstream tree, since I've had my clang asm-goto stuff in my boot tree
>> (and it had that series from Al).
>
> Side note: I've extended on the x86 uaccess cleanups a bit with a
> couple of commits:
>
>   x86: start using named parameters for low-level uaccess asms
>   x86: get rid of 'rtype' argument to __get_user_asm() macro
>   x86: get rid of 'rtype' argument to __put_user_goto() macro
>   x86: get rid of 'errret' argument to __get_user_xyz() macross
>   x86: remove __put_user_asm() infrastructure

A few comments:

  - x86 starts the short log after the colon with an uppercase
    letter

  - 'macross' is really gross :)

  - All commits lack a Link:https//lore.kernel.org/r/$MSG-ID tag. That
    might be an oversight or just reflecting the fact that these patches
    have never seen a mailing list.

    If my brain hasn't gone into complete wishful thinking mode there is
    general consenus that we want to have visability and traceability of
    changes including those which come from maintainers for various good
    reasons (The obvious 'fix a typo breaking the build' exempted).

    Of course that's at your discretion.

> which I _tried_ to make complete no-ops (comparing code generation
> before and after). Sadly, one of them (the "get rid of 'rtype'
> argument to __get_user_asm" one) causes gcc to pick different
> registers for me because now the temporary variables have different
> sizes.
>
> (The others cause line number data changes, of course, but I didn't
> see any _code_ changes).
>
> So that one commit results in a lot of small noise changes to the
> generated code for me, but the few I looked at closer all looked the
> same (mostly just different register, sometimes odd improvements where
> it avoided doing a stupid "andq $0xffffffff", and in one or two cases
> it seemed to randomly just change the stack frame size, sometimes to
> the better, sometimes to worse).

From a quick check I can confirm that the resulting text changes are
just random noise and I did not notice anything horrible in the
generated code either.

> The others should be purely semantically identical.
>
> It was all just small prep to make the patch I have for "asm goto with
> outputs" have a smaller footprint - particularly when I try to then
> make it work with compilers that don't have the capability, and I need
> to have different output registers for that case.
>
> I'm not planning on actually doing that patch this merge window, it's
> just not ready enough. But just in case somebody (Al?) is still
> working on the uaccess.h file, letting you know about my preparatory
> cleanups.

See above.

Thanks,

        tglx
