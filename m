Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2E8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B28E820678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgFCPpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgFCPpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:45:20 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A00AC08C5C0;
        Wed,  3 Jun 2020 08:45:20 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jgVZp-0003HG-N5; Wed, 03 Jun 2020 17:45:14 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 2151F10108D; Wed,  3 Jun 2020 17:45:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: system time goes weird in kvm guest after host suspend/resume
In-Reply-To: <87sgfcf96k.fsf@nanos.tec.linutronix.de>
References: <CAJfpegstNYeseo_C4KOF9Y74qRxr78x2tK-9rTgmYM4CK30nRQ@mail.gmail.com> <875zcfoko9.fsf@nanos.tec.linutronix.de> <CAJfpegsjd+FJ0ZNHJ_qzJo0Dx22ZaWh-WZ48f94Z3AUXbJfYYQ@mail.gmail.com> <CAJfpegv0fNfHrkovSXCNq5Hk+yHP7usfMgr0qjPfwqiovKygDA@mail.gmail.com> <87r1v3lynm.fsf@nanos.tec.linutronix.de> <CAJfpegt6js2WK6SjSZHsz+fg7ZLU+AL6TzrsDYmRfp7vNrtXyw@mail.gmail.com> <CAJfpegtH7C0cu2iPv8gLq5_+=U3-XWZ3XRsP64h6Gbx-qqyZTQ@mail.gmail.com> <87sgfcf96k.fsf@nanos.tec.linutronix.de>
Date:   Wed, 03 Jun 2020 17:45:13 +0200
Message-ID: <87pnagf912.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Miklos Szeredi <miklos@szeredi.hu> writes:
>> On Fri, May 29, 2020 at 2:31 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>>
>>> > Can you please describe the setup of this test?
>>> >
>>> >  - Host kernel version
>>
>> 5.5.16-100.fc30.x86_64
>>
>>> >  - Guest kernel version
>>
>> 75caf310d16c ("Merge branch 'akpm' (patches from Andrew)")
>>
>>> >  - Is the revert done on the host or guest or both?
>>
>> Guest.
>>
>>> >  - Test flow is:
>>> >
>>> >    Boot host, start guest, suspend host, resume host, guest is screwed
>>> >
>>> >    correct?
>>>
>>> Yep.
>
> Of course this does not reproduce here. What kind of host is this
> running on? Can you provide a full demsg of the host please from boot to
> post resume?

Plus /proc/cpuinfo please (one CPU is sufficient)
