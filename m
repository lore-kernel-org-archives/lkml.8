Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18290C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2C820FC3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592391435;
	bh=oVYweIR6zLMediXDsU1jDQ9pyvK//XIYoenxlo7SOcE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XKv6WXJT2EkCgVTCaTmCowa5DhYD3+bgA2J0QdnmKWsaqGQ8kFRNn7SZxfv0Ds9MK
	 uK9DN5b3RcrZeRdVaZttIv+a+8K1tbru5ND11i1n9HqjQ/3xiOijoIk424cNAEt/Gn
	 dhYuDoLIG65gMHkkFmB0K0f28gTlC+lBU1F64MMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgFQK5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:57:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgFQK5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:57:14 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AC77208B3;
        Wed, 17 Jun 2020 10:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592391433;
        bh=oVYweIR6zLMediXDsU1jDQ9pyvK//XIYoenxlo7SOcE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HB7HHd1u1+1jDZ68+nOq2V/Yg9kDRfF1mmDDPGQSytreC543TQYscnE8rTyG7ryWc
         EJ497VjPlRBG1okeyG9fRVW0vkxlOE6AxZX+c7XaDhFmhezLeATXXnIZkYJs/f+/+9
         zWW/n+CA4dyENNhzkB6Q499C43G10YVNCGjGKsEM=
Date:   Wed, 17 Jun 2020 11:57:08 +0100
From:   Will Deacon <will@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, arnd@arndb.de
Subject: Re: [PATCH 0/3] Fix build failure with v5.8-rc1
Message-ID: <20200617105708.GA3503@willie-the-truck>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1592225557.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+Arnd in case he's interested in this series]

On Mon, Jun 15, 2020 at 12:57:55PM +0000, Christophe Leroy wrote:
> Commit 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for
> {READ,WRITE}_ONCE() memory accesses") leads to following build
> failure on powerpc 8xx.
> 
> To fix it, this small series introduces a new helper named ptep_get()
> to replace the direct access with READ_ONCE(). This new helper
> can be overriden by architectures.

Thanks for doing this, and sorry for the breakage. For the series:

Acked-by: Will Deacon <will@kernel.org>

Hopefully we can introduce accessors for the other page-table levels too,
but that can obviously happen incrementally.

Will

> Christophe Leroy (3):
>   mm/gup: Use huge_ptep_get() in gup_hugepte()
>   mm: Allow arches to provide ptep_get()
>   powerpc/8xx: Provide ptep_get() with 16k pages
> 
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 10 ++++++++++
>  include/asm-generic/hugetlb.h                |  2 +-
>  include/linux/pgtable.h                      |  7 +++++++
>  mm/gup.c                                     |  4 ++--
>  4 files changed, 20 insertions(+), 3 deletions(-)
> 
> -- 
> 2.25.0
> 
