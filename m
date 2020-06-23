Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349A1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1FE20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="aU0FiByp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388453AbgFWVcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387937AbgFWVck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:32:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEEBC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:32:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d4700b1ffa781b59a9277.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4700:b1ff:a781:b59a:9277])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A9BE51EC03D2;
        Tue, 23 Jun 2020 23:32:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592947958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=//ND16OFzwTBiuWssLvSmqe373yB5auCq2YNaZGV8qg=;
        b=aU0FiBypVYBxEKswwZ9r+EqE3zuMAVmYJud5MWTd4NyApocxpFWAbv2w3kPw8qlLuO2nP0
        WkL6FiS4D0gy9PPe/abK5zshZEz79E2Sz600N5nVDYKiYDU7CyMdyeOZaArwA8NQFz1m7l
        zCds/ygCwVlXaTTTQG98OOE6rEFJ3ek=
Date:   Tue, 23 Jun 2020 23:32:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        jpa@kernelbug.mail.kapsi.fi, Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests/fpu: Add an FPU selftest
Message-ID: <20200623213230.GL32590@zn.tnic>
References: <20200622190149.GL32200@zn.tnic>
 <B4D00859-000A-4F8C-8CFB-45B9BBCCA16D@amacapital.net>
 <20200623102831.GB32590@zn.tnic>
 <CALCETrXfaEr9OGc5EDpxnhRZxFk5YZBBNVH-N32Eg8V8diwqXg@mail.gmail.com>
 <20200623184726.GI32590@zn.tnic>
 <CAKwvOdnt+8RR=1JPjDNaVY8T1K7wmqFjSGM7XNUUGRb=t1hiWQ@mail.gmail.com>
 <20200623191336.GK32590@zn.tnic>
 <CAKwvOdkTYqpphqr2cvL2pDuK33aYzxXsLDQ6+_PSUk6qxUuQ7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdkTYqpphqr2cvL2pDuK33aYzxXsLDQ6+_PSUk6qxUuQ7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:58:15PM -0700, Nick Desaulniers wrote:
> My point was more so about avoiding needless cc-option checks when
> they're tautological.

No, you're right. The oldest gcc we support is 4.8 and that eats -msse2
just fine.

> When Andy says "consider dropping the problematic GCC version" I
> wonder if it was meant *just for this selftest* as I suggested, or
> outright (which is untenable IMO, as it's a large jump to GCC 7.1+).

Yeah, he's been schooled now :)

> I'm not sure I agree, but I'll take feature detection any day over
> version detection.

Yeah, we had another issue recently with a funky compiler on some funky
distro:

https://lkml.kernel.org/r/CAEJqkgi3w%2BzvMkRBP4VtAewX1UJxrVNRQ03MtRN_yH-PwOOScQ@mail.gmail.com

and I have to say, I'm not at all happy about such subtle issues
stemming from how a distro builds its compiler and that having an impact
on the kernel build. But I guess this is the new reality now since we're
getting more and more married to the compiler.

> Guilty, your honor. :P
> 
> Maybe the feature test should be copy+pasta'd to those other places in
> the kernel, rather than the version check?

"pasta'd"- mmhmhm, tasty noodles. Good idea for lunch tomorrow, thanks!
:-)

But sure, if you feel bored. Let it soak a while first, though, until
all the builders and bots have seen it and haven't triggered moar funky
build errors.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
