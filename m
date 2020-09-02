Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F6AC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0EF820767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:55:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="nk1iqBJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgIBQzG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgIBQzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:55:05 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6A1C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 09:55:04 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d7a00acdede37bac547d6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7a00:acde:de37:bac5:47d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 923721EC0493;
        Wed,  2 Sep 2020 18:54:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599065699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PVvZberZXPtknBWe89EYmhC7Z/aQIBONE/vTyia2nyg=;
        b=nk1iqBJ/q9QQ51noWdo/XTN/vMlH1uAzMFA+037bfhPmpqOrgKlm8N93AE0SXxao5Eq+K0
        8muK8rVr+FdHAOKGSk+YzsrYnO66B1HB9dzX3zjad67Pc1gEmKpqFgRj90kFX6rwrKY5hU
        3gV8M42oy+RnLLVB1kA8bvrvFps7Ov4=
Date:   Wed, 2 Sep 2020 18:55:01 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     peterz@infradead.org
Cc:     Feng Tang <feng.tang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tools/x86: add kcpuid tool to show raw CPU features
Message-ID: <20200902165501.GC21537@zn.tnic>
References: <1598514543-90152-1-git-send-email-feng.tang@intel.com>
 <20200902164538.GN1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902164538.GN1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:45:38PM +0200, peterz@infradead.org wrote:
> We really should clear the CPUID bits when the kernel explicitly
> disables things.

Actually, you want to *disable* the functionality behind it by clearing
a bit in CR4 - and yes, not all features have CR4 bits - so that
luserspace doesn't "probe" the existence of certain instructions.

Example: you can still try to run RDRAND and succeed even if the
corresponding CPUID bit is clear.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
