Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BEA22076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZtjyYI1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgFONW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730065AbgFONW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:22:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53257C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 06:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v1JuBkjgVZu6X7IHxoR7umQyE9OF6DuLKgiaH5Hdipo=; b=ZtjyYI1PdGCLGqQJMjknk88JGR
        DPJo+q7dRMl6FQf1kQ+G9qipHOGhNzgMsWxR6R7yPRVKFhAffl7efh8hLqcXncydwOLJLQBa1ygqZ
        yBbeegWmPfz5A/nnnuAfMFX1YCHy3fSdiOcfryly1pKErYTXfpt3bF6mNOXb4r+fAOtVmIu8cex6R
        meDI2kVU5cRGqrQvFjfJI1PYLyfrR3gF/RPlMO3LgzJZj/ouo2HFD3NURcKaw/WlWE1yGr0eJSr3y
        LhT/61NbJ5pm1cRmAI1jyU7bNUJDBec63wahNEtmR/Pl+r0jS24HybzVHNRurvsk1CHnJKB4xguqc
        9/vUqJlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkp4Z-0007C9-4L; Mon, 15 Jun 2020 13:22:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B653D306102;
        Mon, 15 Jun 2020 15:22:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A0C2C2392E70D; Mon, 15 Jun 2020 15:22:44 +0200 (CEST)
Date:   Mon, 15 Jun 2020 15:22:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 3/3] powerpc/8xx: Provide ptep_get() with 16k pages
Message-ID: <20200615132244.GR2531@hirez.programming.kicks-ass.net>
References: <cover.1592225557.git.christophe.leroy@csgroup.eu>
 <341688399c1b102756046d19ea6ce39db1ae4742.1592225558.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <341688399c1b102756046d19ea6ce39db1ae4742.1592225558.git.christophe.leroy@csgroup.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:57:59PM +0000, Christophe Leroy wrote:
> READ_ONCE() now enforces atomic read, which leads to:


> Fixes: 2ab3a0a02905 ("READ_ONCE: Enforce atomicity for {READ,WRITE}_ONCE() memory accesses")
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/include/asm/nohash/32/pgtable.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
> index b56f14160ae5..77addb599ce7 100644
> --- a/arch/powerpc/include/asm/nohash/32/pgtable.h
> +++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
> @@ -286,6 +286,16 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
>  	return __pte(pte_update(mm, addr, ptep, ~0, 0, 0));
>  }
>  
> +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PPC_16K_PAGES)
> +#define __HAVE_ARCH_PTEP_GET
> +static inline pte_t ptep_get(pte_t *ptep)
> +{
> +	pte_t pte = {READ_ONCE(ptep->pte), 0, 0, 0};
> +
> +	return pte;
> +}
> +#endif

Would it make sense to have a comment with this magic? The casual reader
might wonder WTH just happened when he stumbles on this :-)

Other than that, the series looks good to me, Thanks!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
