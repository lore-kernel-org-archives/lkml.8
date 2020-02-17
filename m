Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B52C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 135C7206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgBQPyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:54:08 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60092 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgBQPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:54:07 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j3iig-0000cX-MB; Mon, 17 Feb 2020 16:54:02 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 48519103A00; Mon, 17 Feb 2020 16:54:02 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Pedro Alves <palves@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [PATCH v2 0/4] x86: fix get_nr_restart_syscall()
In-Reply-To: <CALCETrWJ8PLbxvX6yuP7Q3kz_=dZinacUd-3-OqUkZNSMCE34g@mail.gmail.com>
References: <20191126110659.GA14042@redhat.com> <20191203141239.GA30688@redhat.com> <20191218151904.GA3127@redhat.com> <CAHk-=whNhwFigBDSnyrfJYxr-uAe6PHiWTcHcZzPW+vZ3eWAXw@mail.gmail.com> <CALCETrWJ8PLbxvX6yuP7Q3kz_=dZinacUd-3-OqUkZNSMCE34g@mail.gmail.com>
Date:   Mon, 17 Feb 2020 16:54:02 +0100
Message-ID: <87v9o5nrad.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@kernel.org> writes:

> On Wed, Dec 18, 2019 at 12:02 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> On Wed, Dec 18, 2019 at 7:19 AM Oleg Nesterov <oleg@redhat.com> wrote:
>> >
>> > Andy, Linus, do you have any objections?
>>
>> It's ok by me, no objections. I still don't love your "hide the bit in
>> thread flags over return to user space", and would still prefer it in
>> the restart block, but I don't care _that_ deeply.
>>
>
> I'd rather stick it in restart_block.  I'd also like to see the kernel
> *verify* that the variant of restart_syscall() that's invoked is the
> same as the variant that should be invoked.  In my mind, very few
> syscalls say "I can't believe there are no major bugs in here" like
> restart_syscall(), and being conservative is nice.

Just mopping up my backlog. What happened to this?
