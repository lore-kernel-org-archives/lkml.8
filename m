Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52745C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFDC20777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCTSSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:18:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36798 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726956AbgCTSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:18:51 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFMEF-0001ar-Fw; Fri, 20 Mar 2020 19:18:43 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 68807100375; Fri, 20 Mar 2020 19:18:42 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     syzbot+00be5da1d75f1cc95f6b@syzkaller.appspotmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH] KVM: x86: remove bogus user-triggerable WARN_ON
In-Reply-To: <ef15a35b-3e69-7922-ceda-4a4867054a44@redhat.com>
References: <20200319174318.20752-1-pbonzini@redhat.com> <87o8sr59v9.fsf@nanos.tec.linutronix.de> <87lfnv59u8.fsf@nanos.tec.linutronix.de> <ef15a35b-3e69-7922-ceda-4a4867054a44@redhat.com>
Date:   Fri, 20 Mar 2020 19:18:42 +0100
Message-ID: <87tv2i7uv1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:
> On 20/03/20 16:23, Thomas Gleixner wrote:
>> Thomas Gleixner <tglx@linutronix.de> writes:
>> 
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>> The WARN_ON is essentially comparing a user-provided value with 0.  It is
>>>> trivial to trigger it just by passing garbage to KVM_SET_CLOCK.  Guests
>>>> can break if you do so, but if it hurts when you do like this just do not
>>>> do it.
>>>
>>> Yes, it's a user provided value and it's completely unchecked. If that
>>> value is bogus then the guest will go sideways because timekeeping is
>>> completely busted. At least you should explain WHY you don't care.
>> 
>> Or why it does not matter....
>
> I can change the commit message to "Guests can break if you do so, but
> the same applies to every KVM_SET_* ioctl".  It's impossible to be sure
> that userspace doesn't ever send a bogus KVM_SET_CLOCK and later
> rectifies it with the right value.

Yes please.
