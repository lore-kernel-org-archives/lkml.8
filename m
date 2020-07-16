Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323E0C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:40:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A85207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="v2ePmRco"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgGPOkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:40:14 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:27233 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgGPOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1594910413; x=1626446413;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   mime-version;
  bh=Md3PPwvrPy33GuyoA1RPm1ZIiZ3YtZxHfXnteTdKvuE=;
  b=v2ePmRcoWHLS7xRb3hVDdb8eVScHY7lzaW7XBnYJR0LwPMETFe5ogh2w
   FBahMJmfbaay8NQYihJrFwlJhzSNH79GykJgbDyoM0xYM98D02ckzzdQM
   9Q98Va8xuvqYfhoAbX6gZA2SMNReGkk36W+GcYbDuWNeUurEvjuqe/xfG
   A=;
IronPort-SDR: m5eMdnNy1//P3W0bkENgE1YpjOWhiR1O5DBzuYR3/6BQfyBxtf20eQ+Sg7BmVJ/TtuDAUul34w
 3kP/Wpo7ZYrw==
X-IronPort-AV: E=Sophos;i="5.75,359,1589241600"; 
   d="scan'208";a="42274627"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 16 Jul 2020 14:40:12 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 5C7322250DE;
        Thu, 16 Jul 2020 14:40:09 +0000 (UTC)
Received: from EX13D31EUA004.ant.amazon.com (10.43.165.161) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 16 Jul 2020 14:40:08 +0000
Received: from u886c93fd17d25d.ant.amazon.com (10.43.162.73) by
 EX13D31EUA004.ant.amazon.com (10.43.165.161) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Thu, 16 Jul 2020 14:40:03 +0000
From:   SeongJae Park <sjpark@amazon.com>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH] mm: drop duplicated words in <linux/pgtable.h>
Date:   Thu, 16 Jul 2020 16:39:43 +0200
Message-ID: <20200716143943.30304-1-sjpark@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2bb6e13e-44df-4920-52d9-4d3539945f73@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.73]
X-ClientProxiedBy: EX13D48UWB003.ant.amazon.com (10.43.163.82) To
 EX13D31EUA004.ant.amazon.com (10.43.165.161)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-15T18:29:51-07:00 Randy Dunlap <rdunlap@infradead.org> wrote:

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled words "used" and "by".
> 
> Drop the repeated acronym "TLB" and make several other fixes around it.
> (capital letters, spellos)
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: SeongJae Park <sjpark@amazon.de>


Thanks,
SeongJae Park

> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> ---
>  include/linux/pgtable.h |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> --- linux-next-20200714.orig/include/linux/pgtable.h
> +++ linux-next-20200714/include/linux/pgtable.h
> @@ -866,7 +866,7 @@ static inline void ptep_modify_prot_comm
>  
>  /*
>   * No-op macros that just return the current protection value. Defined here
> - * because these macros can be used used even if CONFIG_MMU is not defined.
> + * because these macros can be used even if CONFIG_MMU is not defined.
>   */
>  #ifndef pgprot_encrypted
>  #define pgprot_encrypted(prot)	(prot)
> @@ -1259,7 +1259,7 @@ static inline int pmd_trans_unstable(pmd
>   * Technically a PTE can be PROTNONE even when not doing NUMA balancing but
>   * the only case the kernel cares is for NUMA balancing and is only ever set
>   * when the VMA is accessible. For PROT_NONE VMAs, the PTEs are not marked
> - * _PAGE_PROTNONE so by by default, implement the helper as "always no". It
> + * _PAGE_PROTNONE so by default, implement the helper as "always no". It
>   * is the responsibility of the caller to distinguish between PROT_NONE
>   * protections and NUMA hinting fault protections.
>   */
> @@ -1343,10 +1343,10 @@ static inline int pmd_free_pte_page(pmd_
>  /*
>   * ARCHes with special requirements for evicting THP backing TLB entries can
>   * implement this. Otherwise also, it can help optimize normal TLB flush in
> - * THP regime. stock flush_tlb_range() typically has optimization to nuke the
> - * entire TLB TLB if flush span is greater than a threshold, which will
> - * likely be true for a single huge page. Thus a single thp flush will
> - * invalidate the entire TLB which is not desitable.
> + * THP regime. Stock flush_tlb_range() typically has optimization to nuke the
> + * entire TLB if flush span is greater than a threshold, which will
> + * likely be true for a single huge page. Thus a single THP flush will
> + * invalidate the entire TLB which is not desirable.
>   * e.g. see arch/arc: flush_pmd_tlb_range
>   */
>  #define flush_pmd_tlb_range(vma, addr, end)	flush_tlb_range(vma, addr, end)
> 
