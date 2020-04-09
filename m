Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8FACC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBE620678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgDIHrW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:47:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51377 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgDIHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:47:22 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jMRuA-00028z-83; Thu, 09 Apr 2020 09:47:18 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A742D101150; Thu,  9 Apr 2020 09:47:17 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Thorsten Glaser <t.glaser@tarent.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>, 954294@bugs.debian.org
Subject: Re: __X32_SYSCALL_BIT being defined as UL constant breaks userspace
In-Reply-To: <CALCETrUkC0mfbo44+Jb7p6f19S+nH5VAEZAwTaYApbNqy9Fj-w@mail.gmail.com>
References: <alpine.DEB.2.22.394.2004081607050.27197@tglase.lan.tarent.de> <CALCETrUkC0mfbo44+Jb7p6f19S+nH5VAEZAwTaYApbNqy9Fj-w@mail.gmail.com>
Date:   Thu, 09 Apr 2020 09:47:17 +0200
Message-ID: <87wo6pp0ca.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:
> On Wed, Apr 8, 2020 at 7:34 AM Thorsten Glaser <t.glaser@tarent.de> wrote:
>> asm/unistd_x32.h:#define __NR_mmap (__X32_SYSCALL_BIT + 9)
>>
>> This construct is, thankfully, still usable in something like
>>         #if (__NR_mmap > __NR_somethingelse)
>> but as __X32_SYSCALL_BIT is no longer int its type also isn’t.
>>
>> Therefore I ask you to revert this change, bringing x32 closer
>> to all other architectures.
>>
>
> One might reasonably ask whether it makes sense for syscall nrs to be
> signed at all.
>
> But regardless, this breaks userspace and we should fix it.  I can
> whip up a patch to split it into X32_SYSCALL_BIT (unsigned long) and
> __X32_SYSCALL_BIT (uapi, int).  Thomas, etc, does this seem
> reasonable?  (For those not following all the machinations, this
> change caused some userspace build failures in libseccomp and/or
> systemd for reasons that are vaguely silly.)

Yes.
