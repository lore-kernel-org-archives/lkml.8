Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28926C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0501C2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 13:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dA7Zr3gi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEGN2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 09:28:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47748 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbgEGN2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 09:28:06 -0400
Received: from zn.tnic (p200300EC2F0B6A0029AA22443DE255A6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:6a00:29aa:2244:3de2:55a6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3A631EC034B;
        Thu,  7 May 2020 15:28:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1588858084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=UKYPzyKu7xdY2cAzbcIlp71pBFCxfzry8/RMNM7yEx4=;
        b=dA7Zr3gitZ2xHpjZQ8NgDTz9Raab/9gcD9fOyD2QFHW5P/lIuReeMFEy06+04zNq0bAF4N
        EbAwITKzgjBhD5gzeC+9iaWKiz3Gj1W2wam8kQzXExRgnvOOS7T3muZEObi466QwDhxCYH
        rhX+kW6TdFK1qXO+AnJk1GiLwZ7SqNQ=
Date:   Thu, 7 May 2020 15:28:00 +0200
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
Subject: Re: [PATCH v3 07/10] x86/fpu/xstate: Update
 copy_kernel_to_xregs_err() for XSAVES supervisor states
Message-ID: <20200507132800.GB23026@zn.tnic>
References: <20200328164307.17497-1-yu-cheng.yu@intel.com>
 <20200328164307.17497-8-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200328164307.17497-8-yu-cheng.yu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:43:04AM -0700, Yu-cheng Yu wrote:
> The function copy_kernel_to_xregs_err() uses XRSTOR, which can work with
> standard or compacted format without supervisor xstates.  However, when
> supervisor xstates are present, XRSTORS must be used.  Fix it by using
> XRSTORS when XSAVES is enabled.
> 
> I also considered if there were additional cases where XRSTOR might be
> mistakenly called instead of XRSTORS.  There are only three XRSTOR sites
> in kernel:
> 
> 1. copy_kernel_to_xregs_booting(), already switches between XRSTOR and
>    XRSTORS based on X86_FEATURE_XSAVES.
> 2. copy_user_to_xregs(), which *needs* XRSTOR because it is copying from
>    userspace and must never copy supervisor state with XRSTORS.
> 3. copy_kernel_to_xregs_err() mistakenly used XRSTOR only.  Fixed in
>    this patch.

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
