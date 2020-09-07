Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A40C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D0E207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599473411;
	bh=DdyKvDduyIm5+OD9DDXx1sFF7tQydimT+2MR9Bk8azY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oZPmXDCG7c9sqkoROnO0nXsnjOLHI9ZnWVn1bnDZhz3G25ITX+vvtG0uJ18Y71TVM
	 I9eo/O/tv59z/46kjjFacN0+sBp24bpSCoKkGJxP5u/4c0kX0uKLCS7tCApIBq6rAc
	 /wLr2BzUH/R11BREnr3pqODCV0Tnau/sSm6T1wMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgIGKKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:10:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgIGKKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:10:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7856207C3;
        Mon,  7 Sep 2020 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599473408;
        bh=DdyKvDduyIm5+OD9DDXx1sFF7tQydimT+2MR9Bk8azY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTjARGHH8jiZcyHd46LUsbd3HkMbc5+QZspww7sL89c1XY8KxDrHWUE5ViYX7oj2E
         OBv5Mub8sM2uw46ba0922NnR6v8cSmKALYTVlgj8OeYRYVEA5XEt3IvsjQWWctgs+O
         WnsE2DOQr+M+9a6IY2uBULDHSPtTT7hXIP7bNPv0=
Date:   Mon, 7 Sep 2020 11:10:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Oli Swede <oli.swede@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] arm64: Optimise and update memcpy, user copy
 and string routines
Message-ID: <20200907101003.GA11970@willie-the-truck>
References: <20200630194822.1082-1-oli.swede@arm.com>
 <f52401d9-787c-667b-c1ec-8b91106d6d14@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f52401d9-787c-667b-c1ec-8b91106d6d14@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oli,

Thanks for this. Just a few high-level comments below.

On Wed, Jul 01, 2020 at 09:12:49AM +0100, Oli Swede wrote:
> > Version 3 addressed this but I later found some issues with the fixup
> > correctness after further testing, and have partially re-written them
> > here, and addressed some other behaviours of the copy algorithm.

[...]

> I am waiting on access to the relevant machine before posting the benchmark
> results for this optimized memcpy, but Sam reported the following with the
> similar (but now slightly older) cortex-strings version:
>   * copy_from_user: 13.17%
>   * copy_to_user: 4.8%
>   * memcpy: 27.88%
>   * copy_in_user: Didn't appear in the test results.
> This machine will also be used to check the fixups are accurate on a system
> with UAO - they appear to be exact on a non-UAO system with PAN that I've
> been working on locally.

I'm inclined to say that cortex-strings is probably not a good basis for
our uaccess routines. The code needs to be adapted in a non-straightforward
way so that we lose pretty much all of the benefits we'd usually get from
adopted an existing implementation; we can't pull in fixes or improvements
without a lot of manual effort, we can't reuse existing testing infrastructure
(see below) and we end up being a "second-class" user of the routines
because of the discrepancies in implementation.

So why don't we use cortex-strings as a basis for the in-kernel routines
only, preferably in a form where the code can be used directly and updated
with a script (e.g. similar to how we pull in arch/arm64/crypto routines
from OpenSSL). We can then roll our own uaccess routines, using a slightly
more straight-forward implementation which is more amenable to handling
user faults and doesn't do things like over copying.

> I should also mention that the correctness of these routines were tested
> using a selftest test module akin to lib/test_user_copy.c (whose usercopy
> functionality checks these patches do pass) but which is more specific to
> the fixup accuracy, in that it compares the return value with the true
> number of bytes remaining in the destination buffer at the point of a fault.

Can we put this test module into the kernel source tree, please, maybe as
part of lkdtm? Given the control flow of these optimised functions, I think
we absolutely need targetted testing to make sure we're getting complete
coverage.

Will
