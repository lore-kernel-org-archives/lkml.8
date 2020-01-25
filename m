Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3845EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00F772071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 22:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="OqKwc7Ew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727601AbgAYWRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 17:17:45 -0500
Received: from mail.skyhub.de ([5.9.137.197]:54102 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgAYWRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 17:17:45 -0500
Received: from zn.tnic (p200300EC2F1CE90080C3FC32A2902303.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:e900:80c3:fc32:a290:2303])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F14781EC0B89;
        Sat, 25 Jan 2020 23:17:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579990664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=y/Tx8wNgFYD/6RrPclu+e+WPAGBO2EeSNHlU2NNlnnE=;
        b=OqKwc7Ewi1aHnWDRvPHo+9yMF6dVgdSijmqWX5Iq7wTeZcwnuhwWqDuAdHLJIt4s31ZZD4
        03tKtbGJ6C7Am5CWvRcbraC871RZhvkSuk6IlLKAGlmsG3tAfHtLoZ4/2QoM5JCziXZAIB
        I8RvJLUkxLNoCs6IP0Umhu7aQfed1y8=
Date:   Sat, 25 Jan 2020 23:17:38 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v15] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200125221738.GF4369@zn.tnic>
References: <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125104419.GA16136@zn.tnic>
 <20200125195513.GA15834@agluck-desk2.amr.corp.intel.com>
 <20200125201221.GZ11457@worktop.programming.kicks-ass.net>
 <20200125203312.GE4369@zn.tnic>
 <20200125214232.GA17914@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125214232.GA17914@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 01:42:32PM -0800, Luck, Tony wrote:
> On Sat, Jan 25, 2020 at 09:33:12PM +0100, Borislav Petkov wrote:
> > On Sat, Jan 25, 2020 at 09:12:21PM +0100, Peter Zijlstra wrote:
> > > My thinking was Virt, virt likes to mess up all msr expectations.
> > 
> > My only worry is to have it written down why we're doing this so that it
> > can be changed/removed later, when we've forgotten all about split lock.
> > Because pretty often we look at a comment-less chunk of code and wonder,
> > "why the hell did we add this in the first place."
> 
> Ok. I added a comment:
> 
>  * Use the "safe" versions of rdmsr/wrmsr here because although code
>  * checks CPUID and MSR bits to make sure the TEST_CTRL MSR should
>  * exist, there may be glitches in virtualization that leave a guest
>  * with an incorrect view of real h/w capabilities.

Yap, nice.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
