Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9CC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BE8E208C3
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584741084;
	bh=tnlLUvNFcgfDBUYCx5ccdiQoD4rY41g0BG8LE1O08T0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kgg1+5SHo7eeGY4C1S2ok2Cx8S989nO08hTdpo1dU2p0p5Cq3HNO2u86zryuj2R+K
	 Zc9FhES9Qu8n6dSIgCyUr6pg0NMyxl/foK/digy76Z8KgK4YRFOeZIBYIw20B3pkun
	 abJ7pM33fXPZVKjxyd95IWlwPQNSxFCnCOkRs+tw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCTVvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTVvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:51:23 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12975216FD
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 21:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584741082;
        bh=tnlLUvNFcgfDBUYCx5ccdiQoD4rY41g0BG8LE1O08T0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rtV2LjfqEcp4GQZKXpK8xBMgkmN8RJCAKP7sdu26KDf6+KnrnPcMlJcGj9W+EcoMh
         5oGm45rao+5CS9GZ3VV69Xut2+aR1XUaEKxQ3QRQjncWAK7+3nNfJxQ1ZzbPUDdRen
         T8rFvqq3T8s+NuLqNmz3770mcsZemLRRYVQ4DrHc=
Received: by mail-wr1-f44.google.com with SMTP id w10so9297031wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 14:51:21 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1f3P3OYZVArC6njY1AUrXiHuPw80KzbJXHlcIYouGOg+V441f8
        /We27bUTbk1uWZOxBanfZmXprJEZXi8c3rIeuInLnA==
X-Google-Smtp-Source: ADFU+vtIy5v5w0nCe+j+Gl9O3RfRQCjnL/4GVlbEZNlcgynrDziiDhg0tdjiQ/8XJhVwqfs9UVTcmz5aIH+zweLwPzI=
X-Received: by 2002:adf:df8f:: with SMTP id z15mr13377202wrl.184.1584741080378;
 Fri, 20 Mar 2020 14:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <1584677604-32707-1-git-send-email-kyung.min.park@intel.com>
 <1584677604-32707-3-git-send-email-kyung.min.park@intel.com>
 <CALCETrWJ88CaGmij_NNysRjUQ6LPwwbPnMy1YPdKnM-cFDueSw@mail.gmail.com> <877dzf4a8v.fsf@nanos.tec.linutronix.de>
In-Reply-To: <877dzf4a8v.fsf@nanos.tec.linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 20 Mar 2020 14:51:08 -0700
X-Gmail-Original-Message-ID: <CALCETrUxOd6P-Yh78qjmOYnh9jY0ggeb4vB=coVjMjthXMTREg@mail.gmail.com>
Message-ID: <CALCETrUxOd6P-Yh78qjmOYnh9jY0ggeb4vB=coVjMjthXMTREg@mail.gmail.com>
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

On Fri, Mar 20, 2020 at 3:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Andy Lutomirski <luto@kernel.org> writes:
> > On Thu, Mar 19, 2020 at 9:13 PM Kyung Min Park <kyung.min.park@intel.com> wrote:
> >>  void use_tsc_delay(void)
> >>  {
> >> -       if (delay_fn == delay_loop)
> >> +       if (static_cpu_has(X86_FEATURE_WAITPKG)) {
> >> +               delay_halt_fn = delay_halt_tpause;
> >> +               delay_fn = delay_halt;
> >> +       } else if (delay_fn == delay_loop) {
> >>                 delay_fn = delay_tsc;
> >> +       }
> >>  }
> >
> > This is an odd way to dispatch: you're using static_cpu_has(), but
> > you're using it once to populate a function pointer.  Why not just put
> > the static_cpu_has() directly into delay_halt() and open-code the
> > three variants?
>
> Two: mwaitx and tpause.

I was imagining there would also be a variant for systems with neither feature.
