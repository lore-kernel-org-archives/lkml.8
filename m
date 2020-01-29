Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4F8C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EE8207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgA2FRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:17:30 -0500
Received: from ozlabs.org ([203.11.71.1]:33401 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbgA2FR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:17:28 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 486sDj4pFyz9sRs; Wed, 29 Jan 2020 16:17:25 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 39413ae009674c6ba745850515b551bbb9d6374b
In-Reply-To: <05105deeaf63bc02151aea2cdeaf525534e0e9d4.1574790198.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ravi.bangoria@linux.ibm.com
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] powerpc/hw_breakpoints: Rewrite 8xx breakpoints to allow any address range size.
Message-Id: <486sDj4pFyz9sRs@ozlabs.org>
Date:   Wed, 29 Jan 2020 16:17:25 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-11-26 at 17:43:29 UTC, Christophe Leroy wrote:
> Unlike standard powerpc, Powerpc 8xx doesn't have SPRN_DABR, but
> it has a breakpoint support based on a set of comparators which
> allow more flexibility.
> 
> Commit 4ad8622dc548 ("powerpc/8xx: Implement hw_breakpoint")
> implemented breakpoints by emulating the DABR behaviour. It did
> this by setting one comparator the match 4 bytes at breakpoint address
> and the other comparator to match 4 bytes at breakpoint address + 4.
> 
> Rewrite 8xx hw_breakpoint to make breakpoints match all addresses
> defined by the breakpoint address and length by making full use of
> comparators.
> 
> Now, comparator E is set to match any address greater than breakpoint
> address minus one. Comparator F is set to match any address lower than
> breakpoint address plus breakpoint length. Addresses are aligned
> to 32 bits.
> 
> When the breakpoint range starts at address 0, the breakpoint is set
> to match comparator F only. When the breakpoint range end at address
> 0xffffffff, the breakpoint is set to match comparator E only.
> Otherwise the breakpoint is set to match comparator E and F.
> 
> At the same time, use registers bit names instead of hardcoded values.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/39413ae009674c6ba745850515b551bbb9d6374b

cheers
