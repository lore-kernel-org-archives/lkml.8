Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C3CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28270206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587452534;
	bh=Z+fmf3MZTanUK1eDlZtoFdJGrDCVH0CGd4BwENIe5E0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OXJbeLxrV8/6a/un5NMfSKM3q7aDaAOc2phVKHHLzM8C4jHcu0hZaCjpowOmHloH9
	 khNos3AkFNJ8Fpw0/9vrQ7vYareidsk+sV5fQ5+Is0a03cuq8jBSFepXZNnVbdku23
	 T5qfmTuJUYi4j0CS6CcgD0r+gbLKzIeZTkFIILFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgDUHCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:02:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:58052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgDUHCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:02:13 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2DC8206A5;
        Tue, 21 Apr 2020 07:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587452532;
        bh=Z+fmf3MZTanUK1eDlZtoFdJGrDCVH0CGd4BwENIe5E0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GBUY2Mu1pH5QqANYe1GJjosD6c/oF6gvLuIOBkUU4xMMIBCPQc8eHirwbD/lIN+fo
         pUy9A2APpR3RQVTYdoe85rp+Z4PEu0b/7iqs2G14lfRh1kJ+t8bXU8/q58TDECxLfu
         Zii20HSrpehI+Mop+ZzV1HtSTFSAZqshN53NFF/4=
Date:   Tue, 21 Apr 2020 08:02:06 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] arm64: entry: Enable random_kstack_offset support
Message-ID: <20200421070206.GB14448@willie-the-truck>
References: <20200324203231.64324-1-keescook@chromium.org>
 <20200324203231.64324-6-keescook@chromium.org>
 <20200420205458.GC29998@willie-the-truck>
 <202004201529.BB787BB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004201529.BB787BB@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 03:34:57PM -0700, Kees Cook wrote:
> On Mon, Apr 20, 2020 at 09:54:58PM +0100, Will Deacon wrote:
> > On Tue, Mar 24, 2020 at 01:32:31PM -0700, Kees Cook wrote:
> > > +	/*
> > > +	 * Since the compiler chooses a 4 bit alignment for the stack,
> > > +	 * let's save one additional bit (9 total), which gets us up
> > > +	 * near 5 bits of entropy.
> > > +	 */
> > > +	choose_random_kstack_offset(get_random_int() & 0x1FF);
> > 
> > Hmm, this comment doesn't make any sense to me. I mean, I get that 0x1ff
> > is 9 bits, and that is 4+5 but so what?
> 
> Er, well, yes. I guess I was just trying to explain why there were 9
> bits saved here and to document what I was seeing the compiler actually
> doing with the values. (And it serves as a comparison to the x86 comment
> which is explaining similar calculations in the face of x86_64 vs ia32.)
> 
> Would something like this be better?
> 
> /*
>  * Since the compiler uses 4 bit alignment for the stack (1 more than
>  * x86_64), let's try to match the 5ish-bit entropy seen in x86_64,
>  * instead of having needlessly lower entropy. As a result, keep the
>  * low 9 bits.
>  */

Yes, thank you! I was missing the comparison to x86_64 and so the one
"additional" bit didn't make sense to me.

With the new comment:

Acked-by: Will Deacon <will@kernel.org>

I'm assuming you're merging this via some other tree, but let me know
if you need anything else from me.

Cheers,

Will
