Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E96C4BA24
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0B220656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgBZTPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:15:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59306 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgBZTPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:15:55 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j729m-00059d-M2; Wed, 26 Feb 2020 20:15:42 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 64577104099; Wed, 26 Feb 2020 20:15:36 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 08/10] x86/entry/32: Remove the 0/-1 distinction from exception entries
In-Reply-To: <CALCETrXbNQJyvDEkfi0f0P3r+zrz8h7cPMaWB0PM_eTkFEAF0w@mail.gmail.com>
References: <20200225213636.689276920@linutronix.de> <20200225220216.933457250@linutronix.de> <6dd020cd-e20a-be12-aba7-bfa9e1a94795@kernel.org> <87blpli40i.fsf@nanos.tec.linutronix.de> <CALCETrXbNQJyvDEkfi0f0P3r+zrz8h7cPMaWB0PM_eTkFEAF0w@mail.gmail.com>
Date:   Wed, 26 Feb 2020 20:15:36 +0100
Message-ID: <87y2spb1nr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Wed, Feb 26, 2020 at 10:42 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>> The pushed value is used as the error_code argument for the exception
>> handler and I really can't find a single one which cares (anymore).
>>
>> But darn and I overlooked that, it's propagated to do_trap() and
>> friends, but even if this causes a user visible change, I doubt that
>> anything cares about it today simply because for giggles a 64bit kernel
>> unconditionally pushes 0 for all exceptions which do not have a hardware
>> error code on stack. So any 32bit application which excpects a
>> particular error code (0/-1) in the signal would have been broken on the
>> first day it ran on a x64 bit kernel.
>>
>> If someone yells regression, then that's really trivial to fix in
>> C-code.
>
> I *think* this is plumbed much more directly to userspace:
>
> $ cat /proc/$$/syscall
> 61 0xffffffff 0x7ffccf734ed0 0xa 0x0 0x1 0x0 0x7ffccf734eb8 0x7f0667465eda

The task is in syscall 61. And the 0xffffffff is syscall args[0]. So I'm
not sure what you try to demonstrate.

> That entire feature is highly dubious and I suppose we could just
> delete it.  But right now, we at least pretend that we can tell,
> totally asynchronously, whether another task is in a syscall.  Unless
> we do *something*, though, I think you shouldn't make this change.

So if a task actually hits a breakpoint that syscall proc thing reads:

-1 0xffffd0e0 0x565561a6

So even if the entry stub pushs 0, the fixup turns it into -1.

Thanks,

        tglx
