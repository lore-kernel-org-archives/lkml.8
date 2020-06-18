Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC83C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401A921924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 00:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NHTZlTX/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFRA55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 20:57:57 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:45981 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726879AbgFRA55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 20:57:57 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49nNpC6gn1z9sSc;
        Thu, 18 Jun 2020 10:57:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592441876;
        bh=6zbfkIJEcTCwhluvkJvBqEMwTUGHoNtvQJF2+Rj1LaM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NHTZlTX/5g6rn40qsPCUdD6fSYs3H/O96lPB5Od0iDL+byhDWHWQIQLE27MzX0zhE
         9gsbQEXMgI1UPVY4mdvDy4wx0BLwEFro2ntSpgtfXzlbJHxHhgyLf98H4FhbaT8dY5
         T91UAEm4lqMTVsgNKXUL0DxccrN73ibptXw5UT1d41o6J5a9E8Z3t7whaBu9ZvCQ4s
         5Fc//tbxV8gTmwVK6YMSylhlNXJT4WpKvPERA/V1PRuNcd3MzmBiYkdJdjpJ0qgybm
         I3vWexaORUZkpPuXQ/95I8XjjaSBfuKhGXTJ2Ixrv/l/P0xbKvBR/VShg2ea7diDVv
         Li/WBRKe9KZ6Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] powerpc/8xx: Provide ptep_get() with 16k pages
In-Reply-To: <20200617143826.GJ2531@hirez.programming.kicks-ass.net>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu> <341688399c1b102756046d19ea6ce39db1ae4742.1592225558.git.christophe.leroy@csgroup.eu> <20200615132244.GR2531@hirez.programming.kicks-ass.net> <87wo45db8d.fsf@mpe.ellerman.id.au> <20200617143826.GJ2531@hirez.programming.kicks-ass.net>
Date:   Thu, 18 Jun 2020 10:58:26 +1000
Message-ID: <87pn9xchql.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Thu, Jun 18, 2020 at 12:21:22AM +1000, Michael Ellerman wrote:
>> Peter Zijlstra <peterz@infradead.org> writes:
>> > On Mon, Jun 15, 2020 at 12:57:59PM +0000, Christophe Leroy wrote:
>
>> >> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
>> >> +#define __HAVE_ARCH_PTEP_GET
>> >> +static inline pte_t ptep_get(pte_t *ptep)
>> >> +{
>> >> +	pte_t pte = {READ_ONCE(ptep->pte), 0, 0, 0};
>> >> +
>> >> +	return pte;
>> >> +}
>> >> +#endif
>> >
>> > Would it make sense to have a comment with this magic? The casual reader
>> > might wonder WTH just happened when he stumbles on this :-)
>> 
>> I tried writing a helpful comment but it's too late for my brain to form
>> sensible sentences.
>> 
>> Christophe can you send a follow-up with a comment explaining it? In
>> particular the zero entries stand out, it's kind of subtle that those
>> entries are only populated with the right value when we write to the
>> page table.
>
> static inline pte_t ptep_get(pte_t *ptep)
> {
> 	unsigned long val = READ_ONCE(ptep->pte);
> 	/* 16K pages have 4 identical value 4K entries */
> 	pte_t pte = {val, val, val, val);
> 	return pte;
> }
>
> Maybe something like that?

I think val wants to be pte_basic_t, but otherwise yeah I like that much
better.

cheers
