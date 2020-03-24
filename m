Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F12AC2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 483CB2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EYSg5odJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgCXQSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:18:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36114 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbgCXQSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:18:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id g12so19238987ljj.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nA1TQQTlmTJlvkZppojVGxQeMFpIHI93BXspwS4KxHo=;
        b=EYSg5odJbVSzbDUDXGOVu9Lz/BPnBm7kqKrMW3dZyRwINYfATbGgY0WqehyjC4PGlc
         Umw5Z8lsjzJZMuco7hGDH2XihLo4pDyqQDI17Sj8EHtCQiSaWP6VMCJi1+wQ5OaK4THE
         nkuznzrK8ocUbDyHOxkAUhgQUUcBSbgF4Y4YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nA1TQQTlmTJlvkZppojVGxQeMFpIHI93BXspwS4KxHo=;
        b=r7nszhetcOip0MvpRi2PBG+FxuXGC2tHtMSOCTsReIWfosRD4jO9wRh3rc0ZajvFPV
         iG37+16LOg2BedB2O2Qjm328os1ubBxijJL0kYNIlmYbEmh+67rNp7W4Q/zvb1gYsjJz
         r2gxMx3H3Y1tlbmlSs+aFpElaTyt/L1c5wn94ulSXEvhVMttJPWR6wtYTwzCfKinyxBJ
         CNCMmZR1Y57tvCeqv0FoPSAbUMsAfkCweeUQ3lpbxCVxWdaRCBlr5HWiVJwtDJNKjZob
         OA/BrNFBa3l2Ayirmg7RnOgJlgzT5wILNNtLobhjWaN/JbcEmEqO4qK5XRX0PvR+S4wL
         0oVw==
X-Gm-Message-State: ANhLgQ22mxJrvI/iqx4TBg6NSaBttfCZlbls1PS7gJ73Pygc58DnhFqH
        VTYJkaoUi1Q/lLE9YATu0lBwJtVjpCE=
X-Google-Smtp-Source: ADFU+vv3lzUx2g3aghe9YDctLxzMr+MKzvVquCnbuyTXaIuApT2+XNxKTjwSxtArXn0cG+lnQapCGw==
X-Received: by 2002:a2e:b446:: with SMTP id o6mr5499961ljm.80.1585066680295;
        Tue, 24 Mar 2020 09:18:00 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id d26sm12215451lfm.0.2020.03.24.09.17.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 09:17:59 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id v4so10043080lfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 09:17:59 -0700 (PDT)
X-Received: by 2002:a19:48c9:: with SMTP id v192mr12030417lfa.130.1585066678787;
 Tue, 24 Mar 2020 09:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <806c51fa-992b-33ac-61a9-00a606f82edb@linux.intel.com>
 <87d0974akk.fsf@nanos.tec.linutronix.de> <b9fbd55a-7f97-088d-2cc2-4e4ea86d9440@linux.intel.com>
 <87r1xjp3gn.fsf@nanos.tec.linutronix.de> <f8057cbc-4814-5083-cddd-d4eb1459529f@linux.intel.com>
 <878sjqfvmi.fsf@nanos.tec.linutronix.de>
In-Reply-To: <878sjqfvmi.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 24 Mar 2020 09:17:21 -0700
X-Gmail-Original-Message-ID: <CAE=gft6Fbibu17H+OfHZjmvHxboioFj09hAmozebc1TE_EqH5g@mail.gmail.com>
Message-ID: <CAE=gft6Fbibu17H+OfHZjmvHxboioFj09hAmozebc1TE_EqH5g@mail.gmail.com>
Subject: Re: MSI interrupt for xhci still lost on 5.6-rc6 after cpu hotplug
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>, x86@kernel.org,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Ghorai, Sukumar" <sukumar.ghorai@intel.com>,
        "Amara, Madhusudanarao" <madhusudanarao.amara@intel.com>,
        "Nandamuri, Srikanth" <srikanth.nandamuri@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 5:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Mathias Nyman <mathias.nyman@linux.intel.com> writes:
> > On 23.3.2020 16.10, Thomas Gleixner wrote:
> >>
> >> thanks for providing the data. I think I decoded the issue. Can you
> >> please test the patch below?
> >
> > Unfortunately it didn't help.
>
> I did not expect that to help, simply because the same issue is caught
> by the loop in fixup_irqs(). What I wanted to make sure is that there is
> not something in between which causes the latter to fail.
>
> So I stared at the trace data earlier today and looked at the xhci irq
> events. They are following a more or less periodic schedule and the
> forced migration on CPU hotplug hits definitely in the time frame where
> the next interrupt should be raised by the device.
>
> 1) First off all I do not have to understand why new systems released
>    in 2020 still use non-maskable MSI which is the root cause of all of
>    this trouble especially in Intel systems which are known to have
>    this disastrouos interrupt migration troubles.
>
>    Please tell your hardware people to stop this.
>
> 2) I have no idea why the two step mechanism fails exactly on this
>    system. I tried the same test case on a skylake client and I can
>    clearly see from the traces that the interrupt raised in the device
>    falls exactly into the two step update and causes the IRR to be set
>    which resolves the situation by IPI'ing the new target CPU.
>
>    I have not found a single instance of IPI recovery in your
>    traces. Instead of that your system stops working in exactly this
>    situation.
>
>    The two step mechanism tries to work around the fact that PCI does
>    not support a 64bit atomic config space update. So we carefully avoid
>    changing more than one 32bit value at a time, i.e. we change first
>    the vector and then the destination ID (part of address_lo).  This
>    ensures that the message is consistent all the time.
>
>    But obviously on your system this does not work as expected. Why? I
>    really can't tell.
>
>    Please talk to your hardware folks.
>
> And of course all of this is so well documented that all of us can
> clearly figure out what's going on...

I won't pretend to know what's going on, so I'll preface this by
labeling it all as "flailing", but:

I wonder if there's some way the interrupt can get delayed between
XHCI snapping the torn value and it finding its way into the IRR. For
instance, if xhci read this value at the start of their interrupt
moderation timer period, that would be awful (I hope they don't do
this). One test patch would be to carve out 8 vectors reserved for
xhci on all cpus. Whenever you change the affinity, the assigned
vector is always reserved_base + cpu_number. That lets you exercise
the affinity switching code, but in a controlled manner where torn
interrupts could be easily seen (ie hey I got an interrupt on cpu 4's
vector but I'm cpu 2). I might struggle to write such a change, but in
theory it's doable.

Actually the slightly easier experiment might be to reserve a single
vector for xhci on all cores. We'd strongly expect the problem to go
away, since now there's no more torn writes since the vector is always
the same. If it somehow didn't go away, you'd know there's more to the
story.

I was alternately trying to build a theory in my head about the write
somehow being posted and getting out of order, but I don't think that
can happen.

Another experiment would be to try my old patch in [1]. I'm not
advocating for this patch as a solution, Thomas and Bjorn have
convinced me that it will break the rest of the world. But your PCI
device 0xa3af seems to be Comet Lake. I was also on Comet Lake. So I'd
expect to at least see it mask your problem. Again, if it didn't, that
might be an interesting datapoint.

[1] https://lore.kernel.org/lkml/20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid/

-Evan
