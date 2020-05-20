Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC46EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB2492072C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018390;
	bh=UKbQAHmEfC9mkte28yLtBrav7B0MDclF17mYfAh92ec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AiqKF6+i80o1sjkOvtkuWYV4z3P4Uf2Gxp243LFTdIdhnQJSE9Lsuq+U/p6zLqLjH
	 iuamVENSjYxV6jTBfpiJ2LwDHE7DuV8ydwcjYu8/yINO5tzR63cpZzNXcZnmqAdmEh
	 wHDyPbyRkLXoTFWTq9QmoBNA4a0+mtUfabms0MkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgETXqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:46:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETXq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:46:29 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 356812072C;
        Wed, 20 May 2020 23:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018389;
        bh=UKbQAHmEfC9mkte28yLtBrav7B0MDclF17mYfAh92ec=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cmyy1rpZhufq5eY5YrwCpjq6gzFp6UGrPGPrlx1tSvtfwHUN4i/XsAAtZKU7eWIfc
         zAsXUxt0WVxxY3rXs+JFFBrzQfbJUxgMmmTKVzPZK5LghjaAICKol+ZpwOrO2pFDCI
         ZGpP1EzFaBvvbsiynQyceo3y1OQSYLde4APj5MzM=
Date:   Wed, 20 May 2020 16:46:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: arch/sparc/mm/srmmu.c:300:9: error: variable 'pud' set but not
 used
Message-Id: <20200520164628.fda1af0c681bbae498dd7ba7@linux-foundation.org>
In-Reply-To: <20200520132005.GM1059226@linux.ibm.com>
References: <20200520005733.GB3101@intel.com>
        <20200520132005.GM1059226@linux.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 16:20:05 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:

> The kbuild test robot reported the following warning:
> 
> arch/sparc/mm/srmmu.c: In function 'srmmu_nocache_init':
> >> arch/sparc/mm/srmmu.c:300:9: error: variable 'pud' set but not used
> >> [-Werror=unused-but-set-variable]
> 300 |  pud_t *pud;
> 
> This warning is caused by misprint in the page table traversal in
> srmmu_nocache_init() function which accessed a PMD entry using PGD rather
> than PUD.
> Since sparc32 has only 3 page table levels, the PGD and PUD are essentially
> the same and usage of __nocache_fix() removed the type checking.
> 
> Use PUD for the consistency and to silence the compiler warning.
> 
> ...
>
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -304,7 +304,7 @@ static void __init srmmu_nocache_init(void)
>  		pgd = pgd_offset_k(vaddr);
>  		p4d = p4d_offset(__nocache_fix(pgd), vaddr);
>  		pud = pud_offset(__nocache_fix(p4d), vaddr);
> -		pmd = pmd_offset(__nocache_fix(pgd), vaddr);
> +		pmd = pmd_offset(__nocache_fix(pud), vaddr);
>  		pte = pte_offset_kernel(__nocache_fix(pmd), vaddr);
>  
>  		pteval = ((paddr >> 4) | SRMMU_ET_PTE | SRMMU_PRIV);

I added

Fixes: 7235db268a2777bc38 ("sparc32: use pgtable-nopud instead of 4level-fixup")

and, after a bit of thought,

Cc: <stable@vger.kernel.org>

Because that's a fairly scary-looking warning.
