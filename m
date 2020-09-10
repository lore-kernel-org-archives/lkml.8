Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05346C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5AF4214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VIm0wJkP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgIJTA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727818AbgIJSzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:55:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FEAC061798
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:54:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f133200806c26bf29ee8a02.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:3200:806c:26bf:29ee:8a02])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66B231EC04D3;
        Thu, 10 Sep 2020 20:54:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599764079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jgIo+1ZX5oETyBGMNmTlD3Rk5Arh/xfyb2XUxn3u6Vk=;
        b=VIm0wJkPzSbaywPZIufjctNgw/dNpyB0+zf6DPaXZ3UpAwdRf7UYvvK/DSAC0jIAkGzLbX
        7MEm1OPqeEPLOnJdEhqMwbbYED/ZO8ayllwpd+8LF+RvCKAhuRu9VKYr1C72+h88DeEJKi
        k7PMrd0qAmY/F67jA1ypqij5alQda+w=
Date:   Thu, 10 Sep 2020 20:54:34 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] x86/mce: Make mce_rdmsrl() do a plain RDMSR only
Message-ID: <20200910185434.GM8357@zn.tnic>
References: <20200907200622.GA28517@agluck-desk2.amr.corp.intel.com>
 <20200908094650.GA25236@zn.tnic>
 <20200908100837.GC25236@zn.tnic>
 <c845adaad2414e5ba0bc74a51a1d0134@intel.com>
 <20200908152539.GE25236@zn.tnic>
 <20200909113022.GA12237@zn.tnic>
 <20200909182051.GA31883@agluck-desk2.amr.corp.intel.com>
 <20200909200321.GG12237@zn.tnic>
 <20200910182901.GK8357@zn.tnic>
 <20200910184206.GA17305@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910184206.GA17305@agluck-desk2.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 11:42:06AM -0700, Luck, Tony wrote:
> With only one call site the rIP isn't super helpful at the moment. But
> once you start selling those "MSR or die" T-shirts everyone will want
> to use this :-)

:-)))

> Do we need the stack trace twice? Once from your fixup
> function, second from panic()?

The second panic comes from:

        if (lmce) {
                if (no_way_out)
                        mce_panic("Fatal local machine check", &m, msg);


in do_machine_check() and we panic earlier in mce_no_way_out() where I
stuck

	mce_rdmsrl(0x1234);

because that one does reads MCi_STATUS. mce_gather_info() could cause it
too because it gathers all the other MSRs.

Now, if we want to avoid the second panic(), we'd have to tell that site
above that we have panicked already but that would require some flag
variable or even more uglification.

Considering how this situation is supposed to almost never happen and
how we're actually interested in the first line of the whole splat I
pasted, how much output comes after it, doesn't really matter. All it
matters is that the machine stops any further progress (as much as we
can do that with a panic, ofc).

Or do you see a more important issue with a second panic to warrant such
not-really-needed change?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
