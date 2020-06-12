Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BCB9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2854E207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="H7rqzMzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgFLQqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:46:09 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLQqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:46:08 -0400
Received: from zn.tnic (p200300ec2f0af400350ce5827141df5b.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:f400:350c:e582:7141:df5b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AAD621EC02F2;
        Fri, 12 Jun 2020 18:46:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1591980367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Q/esjC/DbCItduaN4TSGRGy7mlUQVmXoTWQVdQd1+6g=;
        b=H7rqzMzUvt21FsTQTvbU+SVTTi/pEbfIRCZLTjY6vAa6KD0xSYReMeniY0gonjqb52uWwo
        k/Q9SPeUFfAiBXlkvjmNwCW1zNkl5FiC1fi0+sdxtTW7uIqCc0Jfo72Zz37W0FGUUnNEJy
        0hcYTnvF7kPChESXgmmmG49626AUu3g=
Date:   Fri, 12 Jun 2020 18:46:02 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     x86-ml <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/msr: Filter MSR writes
Message-ID: <20200612164602.GC22660@zn.tnic>
References: <20200612105026.GA22660@zn.tnic>
 <20200612163406.GA1026@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612163406.GA1026@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:34:06AM -0700, Sean Christopherson wrote:
> The kernel should be tainted if the WRMSR is attempted, regardless of
> whether it succeeds, and it should happen before the WRMSR.  E.g. pointing
> MSR_IA32_DS_AREA at a bad address will likely cause an OOPS on the #PF

If the MSR write fails, MSR_IA32_DS_AREA won't have the bad address. If
the writes fail, nothing has been changed.

> This can be 0600, or maybe 0644, i.e. allow the user to enable/disable
> writes after the module has been loaded.

What for?

crw------- 1 root root 202, 0 Jun 10 19:54 /dev/cpu/0/msr

You need root to write to the chrdev.

Also, the intent is *not* to open it more but to close it so that the
incentive to design proper interfaces is there.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
