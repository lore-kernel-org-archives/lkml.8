Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC739C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:22:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8620724699
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="l6JoLnB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgB1RWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:22:09 -0500
Received: from mail.skyhub.de ([5.9.137.197]:43110 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgB1RWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:22:08 -0500
Received: from zn.tnic (p200300EC2F084600F4D7BC1685508240.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:4600:f4d7:bc16:8550:8240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7D0721EC072D;
        Fri, 28 Feb 2020 18:22:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1582910526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=JO5IZ/WUY3Rkly+M1+A+be28WJqvRxpTmqHwXLrnu/k=;
        b=l6JoLnB6p/KHZ2xOu+VeCJNe5ott5tHHykAJwFLYJ1qWmn9Itsw16rTFcDtjmCRturKhH8
        8kUYi3WwB0+kQQjn67fY1j2XOlttssy8FNuM052a9ZA+RabyAaXgJVSkqGMCWBmyXdGJra
        +d2XXVyIYarLOam5UHR55boUTyVaB90=
Date:   Fri, 28 Feb 2020 18:22:02 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 8/8] x86/fpu/xstate: Restore supervisor xstates for
 __fpu__restore_sig()
Message-ID: <20200228172202.GD25261@zn.tnic>
References: <20200121201843.12047-1-yu-cheng.yu@intel.com>
 <20200121201843.12047-9-yu-cheng.yu@intel.com>
 <20200221175859.GL25747@zn.tnic>
 <77f3841a92df5d0c819699ee3612118d566b7445.camel@intel.com>
 <20200228121724.GA25261@zn.tnic>
 <89bcab262d6dad4c08c4a21e522796fea2320db3.camel@intel.com>
 <20200228162359.GC25261@zn.tnic>
 <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 08:20:27AM -0800, Yu-cheng Yu wrote:
> When XSAVES writes to an xsave buffer, xsave->header.xcomp_bv is set to
> include only saved components, effectively changing the buffer's format.

So you want to *save* the supervisor states and xcomp_bv will be set to
supervisor states only and since we don't care about the user states
there - they will be loaded later - we're good.

Or do you have to set xcomp_bv later in order to save the user
components too and also rearrange the buffer to undo the format change
above?

We have using_compacted_format() and we do conversion from compacted to
standard buffers - I'm looking at copy_xstate_to_kernel() et al - so it
shouldn't be impossible. So to repeat Sebastian's question which you
ignored:

"How large is this supervisor state at most? I guess saving the AVX512
state just to get the 2 bytes of the supervisor state at the right spot
is not really optimal."

In any case, this performance penalty better be paid only by those
who are actually using some supervisor states. I haven't looked at
the CET patchset but I'm assuming you're setting the CET bit in
xfeatures_mask_all only when the feature is being actually used?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
