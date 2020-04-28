Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1879C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB14C20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgD1VlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:41:11 -0400
Received: from mga04.intel.com ([192.55.52.120]:55498 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726774AbgD1VlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:41:10 -0400
IronPort-SDR: J1ZCH6W2Tf+7k2B3KPvKi5aNK8QMIbJ6F9/Slm7ZMUHx3YbS8KidhE/k9jSjQK3jkqnd6vB+A6
 CQ3tyd5PcPIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 14:41:09 -0700
IronPort-SDR: BmShGtgPqO6g9l9TLnBaVqT0N7A8E9oYbKUmaq7A4M6HrJ//OEDzv4VauweuunA2PtV+nzwqSv
 a6P896ZIrZdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,328,1583222400"; 
   d="scan'208";a="247825303"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by fmsmga007.fm.intel.com with ESMTP; 28 Apr 2020 14:41:09 -0700
Date:   Tue, 28 Apr 2020 14:41:09 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH 1/7] mm: Document x86 uses a linked list of pgds
Message-ID: <20200428214109.GB406458@iweiny-DESK2.sc.intel.com>
References: <20200428194449.22615-1-willy@infradead.org>
 <20200428194449.22615-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428194449.22615-2-willy@infradead.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 12:44:43PM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> x86 uses page->lru of the pages used for pgds, but that's not immediately
> obvious to anyone looking to make changes.  Add a struct list_head to
> the union so it's clearly in use for pgds.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/mm_types.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4aba6c0c2ba8..9bb34e2cd5a5 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -142,8 +142,13 @@ struct page {
>  			struct list_head deferred_list;
>  		};
>  		struct {	/* Page table pages */
> -			unsigned long _pt_pad_1;	/* compound_head */
> -			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> +			union {
> +				struct list_head pgd_list;	/* x86 */

Shouldn't pgd_list_{add,del}() use this list head variable instead of lru to
complete the documentation?

Probably the list iteration loops arch/x86/* as well?

Ira

> +				struct {
> +					unsigned long _pt_pad_1;
> +					pgtable_t pmd_huge_pte;
> +				};
> +			};
>  			unsigned long _pt_pad_2;	/* mapping */
>  			union {
>  				struct mm_struct *pt_mm; /* x86 pgds only */
> -- 
> 2.26.2
> 
> 
