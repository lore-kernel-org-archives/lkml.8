Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D98C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF9BA207DD
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="pOBB48QN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgFQNEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:04:41 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43991 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgFQNEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:04:41 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49n4zB03pYz9sRf;
        Wed, 17 Jun 2020 23:04:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592399078;
        bh=lMWVaP+IJqwxYXx0XCxsVq12dX+k4WTJuX55RHp3h1g=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pOBB48QNNv+NWyG+uTcUl0oO3zQAIjTArOPfy/VLqEuTmAGX5fFF7C50tT8P+62Er
         rGr/wuxLv+MsvwOdScWGvovUwgSJWKWf0Brmnr82YrLuq1MBQJhWzADu0Id83GqrmO
         eJZCKgX3rCGFuz4Hmlh09Tq6EFKZSpG78NpgrW9Q0kGqFOsHigTTDxSBXAWMpDJHmG
         zgLICJUjpfsu+8NpJ+rAbJWEUTxeDljV+Oti9Ds+DIRIy8f7yrNsQxpjy0khgVcP67
         yT5gCbn6VB2VjjsvwWMCBksgkFJ9ZBVv/ET6ToZ29c6h0cD/nBS36rufuUldzrUrYa
         GfmuXSQvkDwJg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] powerpc/8xx: use pmd_off() to access a PMD entry in pte_update()
In-Reply-To: <20200617041617.GA6571@kernel.org>
References: <20200615092229.23142-1-rppt@kernel.org> <20200616124304.bbe36933fcd48c5f467f4be9@linux-foundation.org> <87o8piegvt.fsf@mpe.ellerman.id.au> <20200617041617.GA6571@kernel.org>
Date:   Wed, 17 Jun 2020 23:05:04 +1000
Message-ID: <875zbpetbz.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Rapoport <rppt@kernel.org> writes:
> On Wed, Jun 17, 2020 at 09:21:42AM +1000, Michael Ellerman wrote:
>> Andrew Morton <akpm@linux-foundation.org> writes:
>> > On Mon, 15 Jun 2020 12:22:29 +0300 Mike Rapoport <rppt@kernel.org> wrote:
>> >
>> >> From: Mike Rapoport <rppt@linux.ibm.com>
>> >> 
>> >> The pte_update() implementation for PPC_8xx unfolds page table from the PGD
>> >> level to access a PMD entry. Since 8xx has only 2-level page table this can
>> >> be simplified with pmd_off() shortcut.
>> >> 
>> >> Replace explicit unfolding with pmd_off() and drop defines of pgd_index()
>> >> and pgd_offset() that are no longer needed.
>> >> 
>> >> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>> >> ---
>> >> 
>> >> I think it's powerpc material, but I won't mind if Andrew picks it up :)
>> >
>> > Via the powerpc tree would be better, please.
>> 
>> I'll take it into next for v5.9, unless there's a reason it needs to go
>> into v5.8.
>
> I consider it a fixup for 5.8 merge window conflicts. Besides, mering it
> now may avoid new conflicts in 5.9 ;-)

OK, I'll pick it up for v5.8.

cheers
