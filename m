Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC64C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE5720709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EffDvnTd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFUut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:50:49 -0500
Received: from mail.skyhub.de ([5.9.137.197]:58410 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFUut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:50:49 -0500
Received: from cz.tnic (rrcs-67-78-116-194.sw.biz.rr.com [67.78.116.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8A1081EC0D1F;
        Fri,  6 Mar 2020 21:50:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583527847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Mx/rOs4s2Tl9HGkIb+M43qPY+zJcL/Go4Agl3zS+VgE=;
        b=EffDvnTdXQ1NOA/yjhlV+TAfCX70s0vCg2cHSIlxmCXsm60gyo/zCkXT4lwpP2Mou0GX2t
        od32MV0i5grv2h98lQGur3fcoPl/NqNBS96w8B9XzNgmDzyYJ23Ong3xh2a2qOTPcXpYXj
        ATRw8af+1HtIqsV2uWOgn5fYbMyd5ak=
Date:   Fri, 6 Mar 2020 21:50:39 +0100
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
Message-ID: <20200306205039.GA5337@cz.tnic>
References: <6f91699c91f9ea0f527e80ed3ea2999444a8d2d1.camel@intel.com>
 <20200228172202.GD25261@zn.tnic>
 <9a283ad42da140d73de680b1975da142e62e016e.camel@intel.com>
 <20200228183131.GE25261@zn.tnic>
 <7c6560b067436e2ec52121bba6bff64833e28d8d.camel@intel.com>
 <20200228214742.GF25261@zn.tnic>
 <c8da950a64db495088f0abe3932a489a84e4da97.camel@intel.com>
 <20200229143644.GA1129@zn.tnic>
 <6778d141a3cdbbe51cdeb3a8efb9c34e0951f6c6.camel@intel.com>
 <53e795ffbc029de316985476fd61845b7a9e824f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53e795ffbc029de316985476fd61845b7a9e824f.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 10:18:46AM -0800, Yu-cheng Yu wrote:
> There is another way to keep this patch...
> 
> if (xfeatures_mask_supervisor()) {
> 	fpu->state.xsave.xfeatures &= xfeatures_mask_supervisor();

Is the subsequent XSAVE in copy_user_to_fpregs_zeroing() going to
restore the user bits in XSTATE_BV you just cleared?

Sorry, it looks like it would but the SDM text is abysmal.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
