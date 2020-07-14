Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92333C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6780322571
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 16:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PJ+wCLEC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgGNQ6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:58:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40118 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgGNQ6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 12:58:05 -0400
Received: from nazgul.tnic (77-85-108-148.ip.btc-net.bg [77.85.108.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DF3D81EC0316;
        Tue, 14 Jul 2020 18:58:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1594745884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=XyYLnc+06Gm9dGG/15z3YOVVpur6VHuhn4YtUH4KUP4=;
        b=PJ+wCLEClDd+fP0J4ENiKVXVITYPzB7XKq8JPpkktzi8OAdAmkkxkQfx9d7LfiaSu22rbj
        oDue+UJO3x9dKHuBYqUiPzvIVC1xz5eQyYI74Vh5LTo0zeCqOkBJWYcPvcPajuVgeZGpQD
        mz0KM3lwKfmbSDbdgxK/FiRsDvMMXH0=
Date:   Tue, 14 Jul 2020 18:58:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        sean.j.christopherson@intel.com, torvalds@linux-foundation.org,
        x86@kernel.org, kernel-team@fb.com,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH -v2.1] x86/msr: Filter MSR writes
Message-ID: <20200714165813.GB3622@nazgul.tnic>
References: <20200615063837.GA14668@zn.tnic>
 <20200714121955.GA2080@chrisdown.name>
 <20200714154728.GA3101@nazgul.tnic>
 <20200714160448.GC2080@chrisdown.name>
 <20200714164612.GA28474@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200714164612.GA28474@agluck-desk2.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:46:12AM -0700, Luck, Tony wrote:
> Maybe we just need smarter filtering of warnings.  It doesn't
> seem at all useful to warn for the same MSR 1000's of times.
> Maybe keep a count of warnings for each MSR and just stop
> all reports when reach a threshold?

No, not stop - just make them more rare.

And this is where the bikeshedding starts about how rare.

/me runs away to the beach and lets the others fight it out.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
