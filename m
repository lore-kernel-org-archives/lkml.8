Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62F4C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E533214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2xxZ6k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727412AbgCBRo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:44:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:34056 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727101AbgCBRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:44:57 -0500
Received: by mail-io1-f66.google.com with SMTP id z190so351425iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bkqP5rqEcpTe8UkETGyC05Piyo30bTlkBX2zfQhiYak=;
        b=K2xxZ6k/fKXqdRvOCWx+o0bgdJCP+yd8W5j2364rXc8L702Bc1Wmif/AzeGUaoIyvt
         k+m2aJ6AslxkpZ7mQvFRmnQmUhN7o2ZrWI4XqX8MaxkmDTI//BwWcP+tcLjTnbeuZdw3
         AFIkLe2W3PLWkNJWv8VOOwhopZKemlZSEyOlt7ytg9COABmAEhASuOHZXULeApfo2u6w
         SR3ILAve6uo6HzklXFmk6HLFDkJYi2icuDuAlMo0RCTJVmtHsDzjMfFeoGsfzo0Vm0lf
         Hx4wx/5eCmF01cHqrVDwGS39wRsdH2jF4ADU03NfOweDwrEp3RNCeYBELbPVnR8zFjLE
         g0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bkqP5rqEcpTe8UkETGyC05Piyo30bTlkBX2zfQhiYak=;
        b=jEgUD3X7WEGBaAEIIsxfngzGBliQo50+tVjFBel+DKaod8XIrlZcLdS/BZbsVSFOom
         o4iLkiGkwUHHluUnfFJoKKa0WpNKxNLV9F6ctRiKh3H+0m+0gTmPlFF92NwvALlSIRS+
         qXCJaVjtUlxpzjNB4vHzhyYmjLWjJTrJEsU1ubvJTEiCpnSRc7Re9SRGDrcLXk4bqITK
         DNpfUsRj+hpfQnnZxwXqX5feZHgqdCx/q0C8LXEVonwQ9c6KLm0a/1FMtee6o+WozSmR
         Jo7UY6M9EjnMx5OwCDhHWHVunZud+SanTFV9bPvoe5COgzZknWtjxmgX+q3rff2/xQRY
         eJVw==
X-Gm-Message-State: ANhLgQ2DhZ5CKdrpNRx9vOcG8ymTFJvQhlNf9gDt88dy2p/y8Y7OE7kf
        qQyb6uOV72TBLj283PkgGVE5PKN6z6rrNyc7/hXs8w==
X-Google-Smtp-Source: ADFU+vtX00vo2g2GZFlbw53ClqMtaKWhDpEWgjNmTVZc8q6YVuwN/BIthZga8jq4MTg4rwSiAe6hEGv+A/C/nYA77JU=
X-Received: by 2002:a6b:c986:: with SMTP id z128mr563097iof.296.1583171096690;
 Mon, 02 Mar 2020 09:44:56 -0800 (PST)
MIME-Version: 1.0
References: <1582773688-4956-1-git-send-email-linmiaohe@huawei.com>
 <CALMp9eSaZ557-GaQUVXW6-ZrMkz8jxOC1S6QPk-EVNJ-f2pT5w@mail.gmail.com> <a1ff3db1-1f5a-7bab-6c4b-f76e6d76d468@redhat.com>
In-Reply-To: <a1ff3db1-1f5a-7bab-6c4b-f76e6d76d468@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 2 Mar 2020 09:44:45 -0800
Message-ID: <CALMp9eQqFKnCLYGXdab-k=Q=h-H5x8VnV20F3HH9fDZTDuQcEQ@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: X86: deprecate obsolete KVM_GET_CPUID2 ioctl
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linmiaohe <linmiaohe@huawei.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 2, 2020 at 9:09 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 02/03/20 18:01, Jim Mattson wrote:
> >> And in fact, it's not used anywhere. So it should be
> >> deprecated.
> > I don't know how you can make the assertion that this ioctl is not
> > used anywhere. For instance, I see a use of it in Google's code base.
>
> Right, it does not seem to be used anywhere according to e.g. Debian
> code search but of course it can have users.
>
> What are you using it for?  It's true that cpuid->nent is never written
> back to userspace, so the ioctl is basically unusable unless you already
> know how many entries are written.  Or unless you fill the CPUID entries
> with garbage before calling it, I guess; is that what you are doing?

One could use GET_CPUID2 after SET_CPUID2, to see what changes kvm
made to the requested guest CPUID information without telling you.
