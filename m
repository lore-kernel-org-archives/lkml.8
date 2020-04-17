Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100E5C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9F23207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:48:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDQJsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgDQJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:48:19 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973B5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 02:48:19 -0700 (PDT)
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jPNbX-0005Xp-KG; Fri, 17 Apr 2020 11:48:11 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 28371104096; Fri, 17 Apr 2020 11:48:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck\, Tony" <tony.luck@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Fenghua Yu <fenghua.yu@intel.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/split_lock: Bits in IA32_CORE_CAPABILITIES are not architectural
In-Reply-To: <20200416223335.GA23759@agluck-desk2.amr.corp.intel.com>
References: <20200416205754.21177-1-tony.luck@intel.com> <20200416205754.21177-3-tony.luck@intel.com> <87eesnm6fc.fsf@nanos.tec.linutronix.de> <20200416223335.GA23759@agluck-desk2.amr.corp.intel.com>
Date:   Fri, 17 Apr 2020 11:48:11 +0200
Message-ID: <87blnqmois.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tony,

"Luck, Tony" <tony.luck@intel.com> writes:
> On Fri, Apr 17, 2020 at 12:06:47AM +0200, Thomas Gleixner wrote:
>> Tony Luck <tony.luck@intel.com> writes:
>> > Features enumerated by IA32_CORE_CAPABILITIES are model specific and
>> > implementation details may vary in different cpu models. Thus it is only
>> > safe to trust features after checking the CPU model.
>> 
>> What's the point of the IA32_CORE_CAPABILITIES check if we need a model
>> match to figure out whether IA32_CORE_CAPABILITIES bit 5 is valid to
>> enumerate split lock detection?
>> 
>> IOW, are we going to see CPUs which end up in the match list and have
>> bit 5 cleared in IA32_CORE_CAPABILITIES?
>
> There may be low-end SKUs of a model that don't have all the features of
> the high-end SKUs. So yes, you may find that a specific SKU of a model
> on the list for a feature doesn't have the feature.
>
> A model specific feature may also have implementation differences
> on different models.  E.g. if Intel were to produce a model that
> did split lock "right" (with thread-scoped control). That would
> still use the same bit in IA32_CORE_CAPABILITIES, but the OS would
> need model specific knowledge to know that this split lock detect
> worked differently from another model that has split lock detect.

IA32_CORE_CAPABILITIES makes a lot of sense to enumerate per thread
functionality because common sense and consistency are overrated.

Can Intel's HW folks please stop their approach of 'let software
deal with the mess we create' once and forever?

Thanks,

        tglx
