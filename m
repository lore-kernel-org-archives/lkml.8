Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6B9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B59208C7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 10:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="IGQBYkGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgIHKIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgIHKIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 06:08:39 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA175C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 03:08:38 -0700 (PDT)
Received: from zn.tnic (p200300ec2f10bf005903392eda591655.dip0.t-ipconnect.de [IPv6:2003:ec:2f10:bf00:5903:392e:da59:1655])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 64D6C1EC0428;
        Tue,  8 Sep 2020 12:08:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599559717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=VOcGA+H2HtnCYJQ+in3FX6Ci+Wut7LjFO5TvqGEf1E8=;
        b=IGQBYkGXWxs4Nohn6b3ekc2sk3kMSkNxdmfLHqeMzYX/4urjbvQpt2K0oSRUWNUXqH92YC
        43atIvkNOja5TwYcZiPZwZgl6iLIxe9CGax2ym+GnJmE1IjPIlZh1MmnYYxyiGieJ5wweK
        /Z55g+HogcnZ7pTvI5IGLQxJ2Qanh9w=
Date:   Tue, 8 Sep 2020 12:08:37 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200908100837.GC25236@zn.tnic>
References: <20200906212130.GA28456@zn.tnic>
 <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908094650.GA25236@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 11:46:50AM +0200, Borislav Petkov wrote:
> So, Andy suggested we do a simple .fixup so that when the RDMSR fails,
> in the fixup we panic directly.

Ok, so I think this is what Andy meant last night and PeterZ just
suggested it too:

We do a:

	 _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_panic)

which panics straight in the #GP handler and avoids the IRET.

I mean, we want to panic there because architectural violation and we
won't have to deal with the IRET...

Hohumm, sounds like the right thing to do in the face of the brokenness
of this magnificent architecture.</maxed out sarcasm>.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
