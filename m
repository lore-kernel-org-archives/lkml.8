Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D451EC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56A8206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgC3OOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:14:36 -0400
Received: from foss.arm.com ([217.140.110.172]:54722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727874AbgC3OOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:14:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964661042;
        Mon, 30 Mar 2020 07:14:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B10F33F71E;
        Mon, 30 Mar 2020 07:14:32 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:14:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] random: Drop ARCH limitations for CONFIG_RANDOM_TRUST_CPU
Message-ID: <20200330141430.GC20969@lakrids.cambridge.arm.com>
References: <20200329082909.193910-1-alexander.sverdlin@gmail.com>
 <20200329165624.GO53396@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329165624.GO53396@mit.edu>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 12:56:24PM -0400, Theodore Y. Ts'o wrote:
> On Sun, Mar 29, 2020 at 10:29:09AM +0200, Alexander Sverdlin wrote:
> > The option itself looks attractive for the embedded devices which often
> > have HWRNG but less entropy from user-input. And these devices are often
> > ARM/ARM64 or MIPS. The reason to limit it to X86/S390/PPC is not obvious.
> > 
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> 
> This feature is *only* applicable if the CPU supports a
> arch_get_random_seed_long() or arch_get_random_long().  I believe
> there are some server-class ARM64 CPU's that support such an
> instruction, but I don't believe any of the embedded arm64 --- and
> certainly non of the embedded arm --- SOC's support
> arch_get_random_long().
> 
> The reason why we limited it to X86/S390/PPC is because those were the
> platforms which supported an RDRAND-like instruction at the time.
> Richard Henderson added support for ARM64 in commit 1a50ec0b3b2e
> ("arm64: Implement archrandom.h for ARMv8.5-RNG") in late January 2020.
> 
> So we should either add ARM64 to the dependency list, or we could, as
> you suggest, simply remove the dependency altogether.  The tradeoff is
> that it will cause an extra CONFIG prompt on a number of platforms
> (mips, arm, sparc, etc.) where it will be utterly pointless since
> those architectures have no chance of support a RDRAND-like
> instruction.

Just for anyone watching, the dependency rework is already handled in
linux-next by commit:

  23ae0c17b89cfeb5 ("random: Make RANDOM_TRUST_CPU depend on ARCH_RANDOM")
  
... where x86, s390, ppc, and arm64 all select ARCH_RANDOM.

Mark.
