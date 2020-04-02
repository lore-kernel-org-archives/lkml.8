Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3916C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4D412077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SZ/onoFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733285AbgDBAOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:14:47 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42637 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgDBAOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:14:47 -0400
Received: by mail-oi1-f196.google.com with SMTP id e4so1244373oig.9;
        Wed, 01 Apr 2020 17:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=klVPjyyJRn9Ce0U12Zt30pNh36uPBeOjBoM8Z9HJi78=;
        b=SZ/onoFgFTgDMxXXOATDMWC5BsRg2I/S0kVdr0CKA0EKjlkrexnFLj4njG0QBw8qj1
         sOdSwop/KvZ1hPcKDvrTppUF0AmRZzdEDPXsc8RkLpytRb7NYTaHuvu2UeHdE4iXCbfX
         qzwpdA7L8KAAI3tWtQzuUzdOk0tDCePEtUwC1aLMed4X4zRnI5G0f3QU7z0O9WGOySPi
         JHsqrE1bAh2x1rHC9ZuTGEufWwYK1yI1DyZeQnLEXDBVN+2/zeOJwq/KXuAkW39M3iAE
         S7jVKXLdS7DaKjfmNhNfejQGLnUz/rmefa94Vf9H7pq9VHEdk2MJnEW8h0npqs9g/UQh
         dXBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=klVPjyyJRn9Ce0U12Zt30pNh36uPBeOjBoM8Z9HJi78=;
        b=RSTpP3U/93ALPoX0jfIxPCu3YRX0YZDxe2ztMCT1q9Ediwp9HXUmCxEBp2CRkGEmJO
         HDa4oWJVPg+m0mnifX/Wq2NZMZBzjXHoBEeFZdk8tl8cztJqMvNbOVvz6vxkPP1uReEQ
         u8hWOZ64gBBsiUmhxnQmvDdDzOKahSqttEAcW1JVhOx+rWGFfRjNnt2p60H0Qgwf9QeA
         Q/CEu0lL+yttUPMXYN3/m1gbbs9TKQJxNfw1XFi3cFMlf/l6wQ5gNaX4nCiVlSlKbbNv
         eySh0Rlhttbjl/VBzPIhuAdOwL42apwvFktss1udexSkIkGwFOdD9Hvd0dcwWatwSbvj
         0CCQ==
X-Gm-Message-State: AGi0PubjA+UaKjWvdjorzhn1LH2+dqBs8gfGAxmSfYLJBF3wiWe7kfrg
        3TVgC2MHLSZzJXOMn6pcU4471olHxHaQRIGcv04=
X-Google-Smtp-Source: APiQypL5QD6tgop+X7paSmL/U7vNB5syj3q1dP23DoAJBr/8ol3cKXoaywSJ9/R8VJJE4Zi5sLvZcqZ8sDnAEVHfK2E=
X-Received: by 2002:a54:4094:: with SMTP id i20mr391678oii.141.1585786486773;
 Wed, 01 Apr 2020 17:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <1585700362-11892-1-git-send-email-wanpengli@tencent.com>
 <1585700362-11892-2-git-send-email-wanpengli@tencent.com> <6de1a454-60fc-2bda-841d-f9ceb606d4c6@redhat.com>
 <CANRm+CzB3dWatF7qOO_WajXM_ZBn1U6Z8+uq4NxCuLG3TgwY1Q@mail.gmail.com>
 <CE34AD16-64A7-4AA0-9928-507C6F3FF6CD@vmware.com> <20200401230100.GE9603@linux.intel.com>
In-Reply-To: <20200401230100.GE9603@linux.intel.com>
From:   Wanpeng Li <kernellwp@gmail.com>
Date:   Thu, 2 Apr 2020 08:14:34 +0800
Message-ID: <CANRm+CzX4UcYLKC16=kONa5HGQeWejCvwbW_hFL_9o=p0-ktsA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] KVM: LAPIC: Don't need to clear IPI delivery
 status in x2apic mode
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Nadav Amit <namit@vmware.com>, Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 at 07:01, Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Wed, Apr 01, 2020 at 05:40:03PM +0000, Nadav Amit wrote:
> > > On Mar 31, 2020, at 11:46 PM, Wanpeng Li <kernellwp@gmail.com> wrote:
> > >
> > > Cc more people,
> > > On Wed, 1 Apr 2020 at 08:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >> On 01/04/20 02:19, Wanpeng Li wrote:
> > >>> -             /* No delay here, so we always clear the pending bit */
> > >>> -             val &= ~(1 << 12);
> > >>> +             /* Immediately clear Delivery Status in xAPIC mode */
> > >>> +             if (!apic_x2apic_mode(apic))
> > >>> +                     val &= ~(1 << 12);
> > >>
> > >> This adds a conditional, and the old behavior was valid according to the
> > >> SDM: "software should not assume the value returned by reading the ICR
> > >> is the last written value".
> > >
> > > Nadav, Sean, what do you think?
> >
> > I do not know. But if you write a KVM unit-test, I can run it on bare-metal
> > and give you feedback about how it behaves.
>
> I agree with Paolo, clearing the bit doesn't violate the SDM.  The
> conditional is just as costly as the AND, if not more so, even for x2APIC.
>
> I would play it safe and clear the bit even in the x2APIC only path to
> avoid tripping up guest kernels that loop on the delivery status even when
> using x2APIC.

Fair enough.

    Wanpeng
