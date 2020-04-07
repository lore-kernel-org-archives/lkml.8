Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151E5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BF82063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:21:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nUq0d8G/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgDGMVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:21:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41722 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgDGMVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pk/wTIvk5X/DA8IhsCZhc7nIIHKp7L4drvl4ax6UlCI=; b=nUq0d8G/UTbLmHOUMtDRZHG7G8
        lmfBuv9l9XDCrfNeMMPzDX5LeWc4XlPOWSw1F8VqaQEA1X0o144IoW7upqJ/eCaqPpbMEDGNii59x
        mFJeYjXuyLzmBhZWTwSMuGThBX3edd89GQ21+Jb7PRs1RrG2CiMidbHYHH+oA9mi/uNegd4hQO4ck
        KU55v8J5n87l5CDbwymwwze/U3jxcOEcyCroM5B7korTt5WbAYaacEOI6+l7slJXtxni7yQCT2dBg
        L689SisLfiL8duhwNUHapm1s2FwQQVU4x68zHLGo/JeCNO3OEaAPUpIBmkXxpigDVhqlLzVizZNwN
        WCbZJkng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLnE2-0003qM-R2; Tue, 07 Apr 2020 12:21:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 56F893010C8;
        Tue,  7 Apr 2020 14:21:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3E48B2B907A89; Tue,  7 Apr 2020 14:21:03 +0200 (CEST)
Date:   Tue, 7 Apr 2020 14:21:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0
 per-thread
Message-ID: <20200407122103.GU20730@hirez.programming.kicks-ass.net>
References: <20200407011259.GA72735@juliacomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011259.GA72735@juliacomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:12:59PM -0400, Keno Fischer wrote:
> This is a follow-up to my from two-years ago [1]. I've been using
> rebased versions of that patch locally for my needs, but I've had
> more people ask me about this patch recently, so I figured, I'd
> have another go at this. Even if this doesn't make it into mainline,
> I figure I can at least improve the quality of the patch for others
> who want to use it. That's said, here's how this version is
> different from v1:

Aside of having an inconsistent comment style and whitespace damage, it
adds exports without a module user.

But my main reason for replying is asking: 'What the heck for?'

You had a fairly long changelog detailing what the patchd does; but I've
failed to find a single word on _WHY_ we want to do any of that.
