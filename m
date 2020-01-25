Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA8EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 20:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736E20708
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 20:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="LsrEU64/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgAYUdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 15:33:14 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39542 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbgAYUdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 15:33:14 -0500
Received: from zn.tnic (p200300EC2F1CE900698071F6EB5AEF0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:e900:6980:71f6:eb5a:ef0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F5D01EC0AA0;
        Sat, 25 Jan 2020 21:33:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579984393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CYD2f+eEpL2esn9rgONgq0XtK58EL9ezOQSBHN4zjTA=;
        b=LsrEU64/1ONmcoSrmO0SRDu6VAqOWQdN/OPHpi3egZY0Nr95L5F/5HJKlrFrDCv0jSTTgz
        E77NAyfrC98Van/4Sl5/5I6JjJfBf5AKU4YoGcijZ7Sycrw478ZB9CMmu5D1XFJFSp35WV
        0QWZtTFRSfpndrdHnUip3nFER4uNRBk=
Date:   Sat, 25 Jan 2020 21:33:12 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
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
Message-ID: <20200125203312.GE4369@zn.tnic>
References: <3908561D78D1C84285E8C5FCA982C28F7F54887A@ORSMSX114.amr.corp.intel.com>
 <20200123004507.GA2403906@rani.riverdale.lan>
 <20200123035359.GA23659@agluck-desk2.amr.corp.intel.com>
 <20200123044514.GA2453000@rani.riverdale.lan>
 <20200123231652.GA4457@agluck-desk2.amr.corp.intel.com>
 <87h80kmta4.fsf@nanos.tec.linutronix.de>
 <20200125024727.GA32483@agluck-desk2.amr.corp.intel.com>
 <20200125104419.GA16136@zn.tnic>
 <20200125195513.GA15834@agluck-desk2.amr.corp.intel.com>
 <20200125201221.GZ11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125201221.GZ11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 25, 2020 at 09:12:21PM +0100, Peter Zijlstra wrote:
> > Blame PeterZ for that. For now I'd like to add the duplicate inline function
> > and then clean up by putting it into some header file (and maybe hunting down
> > other places where it could be used).

Sounds like a good plan.

> Yeah, I copy/paste cobbled that together. I figured it was easier to
> 'borrow' something that worked and adapt it than try and write
> something new in a hurry.

Yeah.

> > Also some PeterZ code. As the comment implies we really shouldn't be able
> > to get here. This whole function should only be called on CPU models that
> > support the MSR ... but PeterZ is defending against the situation that sometimes
> > there are special SKUs with the same model number (since we may be here because
> > of an x86_match_cpu() hit, rather than the architectural enumeration check).
> 
> My thinking was Virt, virt likes to mess up all msr expectations.

My only worry is to have it written down why we're doing this so that it
can be changed/removed later, when we've forgotten all about split lock.
Because pretty often we look at a comment-less chunk of code and wonder,
"why the hell did we add this in the first place."

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
