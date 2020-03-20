Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A538BC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71ED62072D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgCTXYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:24:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37647 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbgCTXYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:24:05 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFQzX-0005ew-Fg; Sat, 21 Mar 2020 00:23:51 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D71B1FFC77; Sat, 21 Mar 2020 00:23:50 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kyung Min Park <kyung.min.park@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
In-Reply-To: <CALCETrUxOd6P-Yh78qjmOYnh9jY0ggeb4vB=coVjMjthXMTREg@mail.gmail.com>
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com> <1584677604-32707-3-git-send-email-kyung.min.park@intel.com> <CALCETrWJ88CaGmij_NNysRjUQ6LPwwbPnMy1YPdKnM-cFDueSw@mail.gmail.com> <877dzf4a8v.fsf@nanos.tec.linutronix.de> <CALCETrUxOd6P-Yh78qjmOYnh9jY0ggeb4vB=coVjMjthXMTREg@mail.gmail.com>
Date:   Sat, 21 Mar 2020 00:23:50 +0100
Message-ID: <87zhcaobjt.fsf@nanos.tec.linutronix.de>
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

> On Fri, Mar 20, 2020 at 3:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Andy Lutomirski <luto@kernel.org> writes:
>> > On Thu, Mar 19, 2020 at 9:13 PM Kyung Min Park <kyung.min.park@intel.com> wrote:
>> >>  void use_tsc_delay(void)
>> >>  {
>> >> -       if (delay_fn == delay_loop)
>> >> +       if (static_cpu_has(X86_FEATURE_WAITPKG)) {
>> >> +               delay_halt_fn = delay_halt_tpause;
>> >> +               delay_fn = delay_halt;
>> >> +       } else if (delay_fn == delay_loop) {
>> >>                 delay_fn = delay_tsc;
>> >> +       }
>> >>  }
>> >
>> > This is an odd way to dispatch: you're using static_cpu_has(), but
>> > you're using it once to populate a function pointer.  Why not just put
>> > the static_cpu_has() directly into delay_halt() and open-code the
>> > three variants?
>>
>> Two: mwaitx and tpause.
>
> I was imagining there would also be a variant for systems with neither feature.

Oh I see, you want to get rid of both function pointers. That's tricky.

The boot time function is delay_loop() which is using the magic (1 << 12)
boot time value until calibration in one way or the other happens and
something calls use_tsc_delay() or use_mwaitx_delay(). Yes, that's all
horrible but X86_FEATURE_TSC is unusable for this.

Let me think about it.

Thanks,

        tglx








