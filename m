Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BE7C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA0321D82
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDRJ1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbgDRJ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:27:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C449C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:27:39 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPjkz-0006Ja-5H; Sat, 18 Apr 2020 11:27:25 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 92391101304; Sat, 18 Apr 2020 11:27:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        "Luck\, Tony" <tony.luck@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
In-Reply-To: <651504d9-f458-1d25-870d-b8c55061be45@intel.com>
References: <873691zuqu.fsf@nanos.tec.linutronix.de> <651504d9-f458-1d25-870d-b8c55061be45@intel.com>
Date:   Sat, 18 Apr 2020 11:27:24 +0200
Message-ID: <87wo6dxhxf.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao,

can you please trim your replies?

Xiaoyao Li <xiaoyao.li@intel.com> writes:
> On 4/18/2020 5:07 AM, Thomas Gleixner wrote:
>> + * Bits in the IA32_CORE_CAPABILITIES are not architectural, so they should
>> + * only be trusted if it is confirmed that a CPU model implements a
>> + * specific feature at a particular bit position.
>> + *
>> + * The possible driver data field values:
>> + *
>> + * - 0: CPU models that are known to have the per-core split-lock detection
>> + *	feature even though they do not enumerate IA32_CORE_CAPABILITIES.
>> + *
>> + * - 1: CPU models which may enumerate IA32_CORE_CAPABILITIES and if so use
>> + *      bit 5 to enumerate the per-core split-lock detection feature.
>
> So now, it's tightly associated with CPU model, which makes it harder to 
> expose this feature to guest. For guest, the CPU model can be configured 
> to anything.
>
> As suggested by Sean internally, we'd better use a KVM CPUID to expose 
> it to guest, which makes it independent of CPU model.

Works for me.

Thanks,

        tglx
