Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42CEA20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgCXNbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:31:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44907 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727686AbgCXNbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:31:47 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jGjeT-00059H-NX; Tue, 24 Mar 2020 14:31:29 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 68700100292; Tue, 24 Mar 2020 14:31:28 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xiaoyao Li <xiaoyao.li@intel.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v5 1/9] x86/split_lock: Rework the initialization flow of split lock detection
In-Reply-To: <95093fb0-df88-0543-c7eb-32b94ac4f99e@intel.com>
References: <20200315050517.127446-1-xiaoyao.li@intel.com> <20200315050517.127446-2-xiaoyao.li@intel.com> <87zhc7ovhj.fsf@nanos.tec.linutronix.de> <95093fb0-df88-0543-c7eb-32b94ac4f99e@intel.com>
Date:   Tue, 24 Mar 2020 14:31:28 +0100
Message-ID: <87imitev67.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:
> On 3/24/2020 1:02 AM, Thomas Gleixner wrote:
>> Xiaoyao Li <xiaoyao.li@intel.com> writes:
>> 
>>> Current initialization flow of split lock detection has following issues:
>>> 1. It assumes the initial value of MSR_TEST_CTRL.SPLIT_LOCK_DETECT to be
>>>     zero. However, it's possible that BIOS/firmware has set it.
>> 
>> Ok.
>> 
>>> 2. X86_FEATURE_SPLIT_LOCK_DETECT flag is unconditionally set even if
>>>     there is a virtualization flaw that FMS indicates the existence while
>>>     it's actually not supported.
>>>
>>> 3. Because of #2, KVM cannot rely on X86_FEATURE_SPLIT_LOCK_DETECT flag
>>>     to check verify if feature does exist, so cannot expose it to
>>>     guest.
>> 
>> Sorry this does not make anny sense. KVM is the hypervisor, so it better
>> can rely on the detect flag. Unless you talk about nested virt and a
>> broken L1 hypervisor.
>> 
>
> Yeah. It is for the nested virt on a broken L1 hypervisor.

Then please spell it out in the changelog. Changelogs which need crystalballs
to decode are pretty useless.

Thanks,

        tglx
