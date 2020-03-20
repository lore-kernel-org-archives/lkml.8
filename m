Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADABCC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D79C2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584748638;
	bh=O8Rg+s96c/nEER146ncnD3qGyWFv1O+qlEviAIesj5A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rdBZIdHX/eWHpgk6jTu3C4MqL3NCBl1k6LfMaCSfM6JrbB23J+HHDV7LpwXq+tpqI
	 MZ+cTWqfNeYXtsXXoH14Z6wzATGKOPlitg25KvIZ/UhBGAgd2U/F5tq/SPulgXZ5+F
	 0x3OE9AGF7wHWU9RPB0Azl7GNhos9kvdD4MlCz+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbgCTX5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTX5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:57:17 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D14D2076E
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 23:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584748636;
        bh=O8Rg+s96c/nEER146ncnD3qGyWFv1O+qlEviAIesj5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ttY+s798i38AHS/hfxFjOVrACLR+gxne7OhaOoYjaOpaobC0EEdiRHq8YYXkXTxQ3
         A5sB17+4c15+L0dneBM/gR9jLUvHXMFOxlFdtckq+11zJC1EsbW5NAIhLlcq2YAsU3
         7qsuBKDapXaH96rqh3YdEEYU2b//TuIbq30DqQ1E=
Received: by mail-wr1-f41.google.com with SMTP id 31so3504286wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:57:15 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3pkUIvzAUAIGVLH8aXJGZ9GwDPO8+MYoGwz3o9H+XdAlM1fXZe
        oxFOyTWPwBJxQY6mCtjRbXqUNe8DhJBsaRlf2FBQsA==
X-Google-Smtp-Source: ADFU+vuPB9t9salOQKO5ZID2LgyhHfito4CfUMkLJm7PoNDnyBs/tXJk0zJQY/gqbFuuXEMIqHmhRxbQYx3JpKMGdEA=
X-Received: by 2002:adf:df8f:: with SMTP id z15mr13827347wrl.184.1584748634372;
 Fri, 20 Mar 2020 16:57:14 -0700 (PDT)
MIME-Version: 1.0
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
 <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
 <CALCETrWJ88CaGmij_NNysRjUQ6LPwwbPnMy1YPdKnM-cFDueSw@mail.gmail.com>
 <877dzf4a8v.fsf@nanos.tec.linutronix.de> <CALCETrUxOd6P-Yh78qjmOYnh9jY0ggeb4vB=coVjMjthXMTREg@mail.gmail.com>
 <87zhcaobjt.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zhcaobjt.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Mar 2020 16:57:03 -0700
X-Gmail-Original-Message-ID: <CALCETrU9ucYrXxfDddgkKaP2-NBfmhqrFG51EiC6LWHOu0JaPQ@mail.gmail.com>
Message-ID: <CALCETrU9ucYrXxfDddgkKaP2-NBfmhqrFG51EiC6LWHOu0JaPQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] x86/delay: Introduce TPAUSE delay
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kyung Min Park <kyung.min.park@intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 4:23 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
>
> > On Fri, Mar 20, 2020 at 3:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> Andy Lutomirski <luto@kernel.org> writes:
> >> > On Thu, Mar 19, 2020 at 9:13 PM Kyung Min Park <kyung.min.park@intel.com> wrote:
> >> >>  void use_tsc_delay(void)
> >> >>  {
> >> >> -       if (delay_fn == delay_loop)
> >> >> +       if (static_cpu_has(X86_FEATURE_WAITPKG)) {
> >> >> +               delay_halt_fn = delay_halt_tpause;
> >> >> +               delay_fn = delay_halt;
> >> >> +       } else if (delay_fn == delay_loop) {
> >> >>                 delay_fn = delay_tsc;
> >> >> +       }
> >> >>  }
> >> >
> >> > This is an odd way to dispatch: you're using static_cpu_has(), but
> >> > you're using it once to populate a function pointer.  Why not just put
> >> > the static_cpu_has() directly into delay_halt() and open-code the
> >> > three variants?
> >>
> >> Two: mwaitx and tpause.
> >
> > I was imagining there would also be a variant for systems with neither feature.
>
> Oh I see, you want to get rid of both function pointers. That's tricky.
>
> The boot time function is delay_loop() which is using the magic (1 << 12)
> boot time value until calibration in one way or the other happens and
> something calls use_tsc_delay() or use_mwaitx_delay(). Yes, that's all
> horrible but X86_FEATURE_TSC is unusable for this.
>
> Let me think about it.

This is definitely not worth overoptimizing.  It's a *delay* function
-- the retpoline isn't going to kill us :)

>
> Thanks,
>
>         tglx
>
>
>
>
>
>
>
>
