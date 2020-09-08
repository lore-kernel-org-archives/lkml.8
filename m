Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6493DC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323D721D42
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PCchdK+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbgIHJrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbgIHJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:47:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC37CC061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 02:46:59 -0700 (PDT)
Received: from zn.tnic (p200300ec2f10bf005903392eda591655.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:5903:392e:da59:1655])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50D121EC0212;
        Tue,  8 Sep 2020 11:46:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599558416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mJDgbJPaubpykZRvW7SoZ/gkpQYvOgTthhnb2GPXITM=;
        b=PCchdK+v60wILSMt52YJvzwQ91J3tpThGbdZpBfehItb3zAZtj/NHCx8qr6ZTfGJqSPcm2
        5l19n/AjzwCMWkYCF101HTLw/1kQZjQH2po4MbNfFzPzcC539ymRLf2u3xByUKKwPm4pSO
        n1CdV4lKIeaIv9GKvoQndJ3oUzx2+QU=
Date:   Tue, 8 Sep 2020 11:46:50 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200908094650.GA25236@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:06:22PM -0700, Luck, Tony wrote:
> Digging into the history it seems that this rdmsrl_safe() was added for
> a possible bug on a pentiumIII back in 2009 that was eventually closed
> as "unreproducible".

So this is the $ 10^6 question so far: if I can assume that those two
boxes we found in bug reports which triggered this warn because they
failed the MSR read even though those MSRs are MCA architectural, if I
can assume that those are a one-off thing and that we won't support such
and we'd let machines like that crash and burn in testing, hopefully
before they get released to the public, then, we can do the plain MSR
read there.

No, tracing, no exception handling.

HOWEVER!

*If* that non-existent MSR read happens after all, then the machine
would #GP.

Our #GP handler, however, doesn't panic unless panic_on_oops, as Andy
pointed out on IRC yesterday and this makes a nasty situation even
worse.

Now, even if it did panic, reporting this would not be very
user-friendly because people would have to look at the Code: output of
the splat to see which insn rIP pointed to and then figure out what
happened.

Now, we can look at the code bytes around rIP ourselves, in the #GP
handler, and decide to panic if 0F 32, i.e., RDMSR opcode.

But that is ewww ugly to say the least.

So, Andy suggested we do a simple .fixup so that when the RDMSR fails,
in the fixup we panic directly.

The problem there is:

NMI -> #MC -> #GP ... IRET

Another #MC won't happen after we IRET because MSR_IA32_MCG_STATUS is
not cleared yet but the state is mightily confused and you don't want to
run code on that box anymore but panic and not move.

> Do we have three distinct classes of calls to RDMSR now?
> 
> 
> 1) This case. Architecture checks have been made. This call can't
> fail. We are calling from a tricky state (on IST) so no tracing
> allowed.

*If* we can hold hw people to the architectural guarantee, then this
would be the cleanest fix.

> 2) Normal case ... architecture checks have been done so shouldn't
> fail. Safe state for tracing etc. Use rdmsrl().

Yeah, but see above.

> 3) Probe case. Architecture didn't provide definitive enumeration,
> so we might take a #GP. Use the rdmsrl_safe().

... and that is bad because above *and* tracing can't handle atomic
context properly.

> If mce subsystem is the only instance of case "1", then this
> inline is OK.  If there are others then rather than inlining
> the asm here, we should have some new rdmsrl_notrace() inline
> function declared for all to use.

Yeah, Ingo suggested the same thing but let's solve the bigger issue
first.

> Needs a:
> 
> Fixes: 11868a2dc4f5 ("x86: mce: Use safer ways to access MCE registers")
> 
> since this is undoing an earlier change.

Ok.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
