Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3F4C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACCB218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 22:06:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbgDPWGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 18:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728086AbgDPWGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 18:06:52 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A6C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 15:06:52 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPCem-0007H6-AM; Fri, 17 Apr 2020 00:06:48 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id A8EF6100BB6; Fri, 17 Apr 2020 00:06:47 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
In-Reply-To: <20200416205754.21177-3-tony.luck@intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com> <20200416205754.21177-3-tony.luck@intel.com>
Date:   Fri, 17 Apr 2020 00:06:47 +0200
Message-ID: <87eesnm6fc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Luck <tony.luck@intel.com> writes:
> The Intel Software Developers' Manual erroneously listed bit 5 of the
> IA32_CORE_CAPABILITIES register as an architectural feature. It is
> not.

TBH. I'm really pissed off by that. We ask Intel for the past 20 years
that this non-enumerability and model checking has to stop.

Especially for the split lock festure we got assured that the Icelakes
are the only models which need the cpu match because it was too late to
add the capability bit.

> Features enumerated by IA32_CORE_CAPABILITIES are model specific and
> implementation details may vary in different cpu models. Thus it is only
> safe to trust features after checking the CPU model.

What's the point of the IA32_CORE_CAPABILITIES check if we need a model
match to figure out whether IA32_CORE_CAPABILITIES bit 5 is valid to
enumerate split lock detection?

IOW, are we going to see CPUs which end up in the match list and have
bit 5 cleared in IA32_CORE_CAPABILITIES?

Thanks,

        tglx
