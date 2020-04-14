Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067D7C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C64FE206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=juliacomputing-com.20150623.gappssmtp.com header.i=@juliacomputing-com.20150623.gappssmtp.com header.b="PvNd+JcV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632850AbgDNUPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2632810AbgDNUOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:14:51 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5CC061A41
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:55:44 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id f19so14584215iog.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=juliacomputing-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sjVvZonb0hVGjhdZ35VWK21WqwfB1XaKuSBkV0Zyjh0=;
        b=PvNd+JcVIrErvIye2eIVifVi9exD5Rgm72/G+zjK72njls/t+oLDlFGJsW98dujywT
         4XjOKGsIZADatakxpcHQBqMe7NgqrmCsotFm4GnOGy4vsttMaWLGW8UO0ZQwbvZfyg5N
         VYUfSBF6hI/2JCKAJ+EQ3DiuZvYmSJA3wQIwIw1GvgvF8U0YHtv3cOJKHT/pLmusZ0i5
         wUS4/Q4uYw4iJ2spiaTC+yG7VYNSowyLRNz6d56ajnLlMEeBEPEMk2hCqvkf/xsAWI+6
         nmLEgDu/dHzlHtFPoltUGrYDTCnYjwte9eG+1jrx/QfHaOcvBnursf3Pnjvv5TfwOy0s
         ff2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sjVvZonb0hVGjhdZ35VWK21WqwfB1XaKuSBkV0Zyjh0=;
        b=f8Nuzt13pMvmt6nWFTd8dmKGGHzfvaqFGZIjK6yhiaJ84uua5EO1GkfNRj0fdt+dLf
         hEVkW7Mc/SWp4iI+jGIk4FVoFhuXC52RynMBtq9zeGuyfCW/7v/2GRB+5lV90lpM0cH+
         vc6ooxoYQQM9hD1XySIE8AKS+pt8u8AfUjeqAdEFogMskhd8d7Z4AQ9+daCiun6Tw7Zi
         88+DXuetKh0E21Lzd5fraBjuqtYDAg+BMlnbgkUvaWg3kDoJcOgGndq/DCkxoud9s88G
         HIx8blRutVNVjEnWuSrL99jUoHk4G/Xy1Z7HVclUdVBa0L8dHe2GF18vHO5WgnJn7oiu
         fJIA==
X-Gm-Message-State: AGi0PuarCXBhpvx5g1WP4aRt5jfioMynbKaUaWOA7edghJqwl+Zh3Gu/
        QTdv/DZGWdaqSf8tUqL380YtcTHXC4H4bsNfPS98+w==
X-Google-Smtp-Source: APiQypJuSkKnSFW+a5lugNBcUtA3MoeGUC7wQc61G10VXtYgncmQO6k3h4ozTE1pckGKZdNGz3nVuCqt5qO9VwKvjGc=
X-Received: by 2002:a05:6602:2182:: with SMTP id b2mr22542641iob.19.1586894144019;
 Tue, 14 Apr 2020 12:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200407011259.GA72735@juliacomputing.com> <8f95e8b4-415f-1652-bb02-0a7c631c72ac@intel.com>
 <CABV8kRw1TQsqs+z43bSfZ5isctuFGMB4g_ztDYihiiXHcy4nVA@mail.gmail.com>
 <5208ad1e-cd9b-d57e-15b0-0ca935fccacd@intel.com> <CABV8kRzfR32+MpAvTAPHCN902WtHSxySujcO2yAB3OT0caVDJg@mail.gmail.com>
 <9921cb2e-a7cb-c1d0-b120-c08f06be7c7f@intel.com> <CABV8kRxDkE1dQh0c2FkFpkUruiR0aD-hXbgd5-jcoCDiwYHs1A@mail.gmail.com>
In-Reply-To: <CABV8kRxDkE1dQh0c2FkFpkUruiR0aD-hXbgd5-jcoCDiwYHs1A@mail.gmail.com>
From:   Keno Fischer <keno@juliacomputing.com>
Date:   Tue, 14 Apr 2020 15:55:07 -0400
Message-ID: <CABV8kRy6M8_-An5TEvBATAz+MxdaQqbCLBEZbJsaz=aZiV48wA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I'd like to continue this discussion along two directions:

1) In this patch, what should happen to signal frames?

I continue to think that it would be good for these to observe
the process' XCR0, but I understand the argument that we
should not let the XCR0 setting modify any kernel behavior
whatsoever. Andy, I would in particular appreciate your views
on this since I believe you thought it should do the latter.

2) What would a solution based on the raw KVM API look like?

I'm still afraid that going down the KVM route would just end up
back in the same situation as we're in right now, but I'd like to
explore this further, so here's my current thinking: Particularly for
recording, the process does need to look very much like a regular
linux process, so we can get recording of syscalls and signal state right.
I don't have enough of an intuition for the performance implications
of this. For example, suppose we added a way for the kernel to
directly take syscalls from guest CPL3 - what would the cost
of incurring a vmexit for every syscall be? I suppose another
idea would be to build a minimal linux kernel that sits in guest
CPL0 and emulates at least the process state and other high
frequency syscalls, but forwards the rest to the host kernel.
Seems potentially doable, but a bit brittle - is there prior art
here I should be aware of, e.g. from people looking at securing
containers? As I mentioned, I had looked at Project Dune
before (http://dune.scs.stanford.edu/), which does seem to
do a lot of the things I would need, though it doesn't appear
to currently be handling signals at all, and of course it's also
not really KVM based, but rather
KVM-but-copy-pasted-and-manually-hacked-up-in-a-separate.ko
based.

I may also be missing a completely obvious way to do this -
my apologies if so. I would certainly appreciate any insight on
how to achieve the set of requirements here (multiple tracees
with potentially differing XCR0 values, faithful and performant
provision of syscalls/signals to the tracees) on top of KVM.

If we can figure out a good way forward with KVM, I'd be quite
interested in it, since I think there may be additional performance
games that could be played by having part of rr be in guest CPL0,
I'm just unsure that KVM is really the right abstraction here, so
I'd like to think through it a bit.

Keno
