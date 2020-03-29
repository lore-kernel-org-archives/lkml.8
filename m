Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95022C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 647CB2073B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 16:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgC2Q4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 12:56:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38630 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728310AbgC2Q4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 12:56:38 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02TGuOFX011538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Mar 2020 12:56:25 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9A2A7420EBA; Sun, 29 Mar 2020 12:56:24 -0400 (EDT)
Date:   Sun, 29 Mar 2020 12:56:24 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] random: Drop ARCH limitations for CONFIG_RANDOM_TRUST_CPU
Message-ID: <20200329165624.GO53396@mit.edu>
References: <20200329082909.193910-1-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329082909.193910-1-alexander.sverdlin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 10:29:09AM +0200, Alexander Sverdlin wrote:
> The option itself looks attractive for the embedded devices which often
> have HWRNG but less entropy from user-input. And these devices are often
> ARM/ARM64 or MIPS. The reason to limit it to X86/S390/PPC is not obvious.
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

This feature is *only* applicable if the CPU supports a
arch_get_random_seed_long() or arch_get_random_long().  I believe
there are some server-class ARM64 CPU's that support such an
instruction, but I don't believe any of the embedded arm64 --- and
certainly non of the embedded arm --- SOC's support
arch_get_random_long().

The reason why we limited it to X86/S390/PPC is because those were the
platforms which supported an RDRAND-like instruction at the time.
Richard Henderson added support for ARM64 in commit 1a50ec0b3b2e
("arm64: Implement archrandom.h for ARMv8.5-RNG") in late January 2020.

So we should either add ARM64 to the dependency list, or we could, as
you suggest, simply remove the dependency altogether.  The tradeoff is
that it will cause an extra CONFIG prompt on a number of platforms
(mips, arm, sparc, etc.) where it will be utterly pointless since
those architectures have no chance of support a RDRAND-like
instruction.

Cheers,

						- Ted
