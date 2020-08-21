Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B149BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8057E20732
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="owR7eiVg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgHUHYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727873AbgHUHYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:24:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57060C061385;
        Fri, 21 Aug 2020 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zz8fZZdhH+JJC5yy6EdzQ8wTU5OLIvBo+26qAJBzST8=; b=owR7eiVgwxP6repaAN6OZzTsKU
        ALgQR0Z0DDdZr34Clu2uH0hSy8Doug989grf/jXukUqXF4BpdX5TWGhDflwZzJdfqdD2zBTGk2t1T
        wwyYfMQOsKkLYmhRPrhoJBZhNwP4zUIfEaXbKDFgzp+xeKdsxf+vi8y8YNJNid+1fWkyyotxjg1DH
        fQ7fRgHy261s466smafmg63VozhZUGLIhj3XdSjRBZjS3uuYTTehwFlHOtW0mNaM6iY3eeGmbAKS/
        VVzAXuYIBFkpr8mcdS8DuwcmzRz7C016IlIgCXBBRndxV+LTMuzwgMaUAfHUzFZe0vKv6PKIGr+Kl
        TN5b3bEQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k91PO-0004lQ-2r; Fri, 21 Aug 2020 07:24:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59090303271;
        Fri, 21 Aug 2020 09:24:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3EC922B410945; Fri, 21 Aug 2020 09:24:14 +0200 (CEST)
Date:   Fri, 21 Aug 2020 09:24:14 +0200
From:   peterz@infradead.org
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] x86/entry/64: Disallow RDPID in paranoid entry if KVM is
 enabled
Message-ID: <20200821072414.GH1362448@hirez.programming.kicks-ass.net>
References: <20200821025050.32573-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821025050.32573-1-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 07:50:50PM -0700, Sean Christopherson wrote:
> diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> index 70dea93378162..fd915c46297c5 100644
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -842,8 +842,13 @@ SYM_CODE_START_LOCAL(paranoid_entry)
>  	 *
>  	 * The MSR write ensures that no subsequent load is based on a
>  	 * mispredicted GSBASE. No extra FENCE required.
> +	 *
> +	 * Disallow RDPID if KVM is enabled as it may consume a guest's TSC_AUX
> +	 * if an NMI arrives in KVM's run loop.  KVM loads guest's TSC_AUX on
> +	 * VM-Enter and may not restore the host's value until the CPU returns
> +	 * to userspace, i.e. KVM depends on the kernel not using TSC_AUX.
>  	 */
> -	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx
> +	SAVE_AND_SET_GSBASE scratch_reg=%rax save_reg=%rbx no_rdpid=IS_ENABLED(CONFIG_KVM)
>  	ret

With distro configs that's going to be a guaranteed no_rdpid. Also with
a grand total of 0 performance numbers that RDPID is even worth it, I'd
suggest to just unconditionally remove that thing. Simpler code
all-around.
