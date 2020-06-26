Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A22C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A962081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFZEp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:45:59 -0400
Received: from ozlabs.org ([203.11.71.1]:43233 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgFZEp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:45:56 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49tPTZ5hYkz9sT8; Fri, 26 Jun 2020 14:45:53 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <9f2df6621fcaf9eba15fadc61c169d0c8e2fb849.1592481938.git.christophe.leroy@csgroup.eu>
References: <9f2df6621fcaf9eba15fadc61c169d0c8e2fb849.1592481938.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/8xx: Modify ptep_get()
Message-Id: <159314672826.1150869.11989654987721504305.b4-ty@ellerman.id.au>
Date:   Fri, 26 Jun 2020 14:45:53 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 12:07:46 +0000 (UTC), Christophe Leroy wrote:
> Move ptep_get() close to pte_update(), in an ifdef section already
> dedicated to powerpc 8xx. This section contains explanation about
> the layout of page table entries.
> 
> Also modify it to return 4 times the pte value instead of padding
> with zeroes.

Applied to powerpc/next.

[1/1] powerpc/8xx: Modify ptep_get()
      https://git.kernel.org/powerpc/c/105fb38124a490f38e9c1e23bb4c4a0b6ba12fdb

cheers
