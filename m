Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3469FC47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14891207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 21:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgD3VO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 17:14:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:64013 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbgD3VO7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:14:59 -0400
IronPort-SDR: qXZaDFHARwr/CkDkWKKKCqQpo8baavmIP3ocnAjQ8Sm/jacWtHJd9q99qtLrr/oMtrfJtPyyWB
 1xa0+HwAmqNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2020 14:14:57 -0700
IronPort-SDR: 3oTPvy83hK+d3EIzFJWpbVd7IpQMrpf+3BjhaiYzaymcNq1dbM5WEC+pwgVk+1mYfOP3j1SbNo
 OM0pcrzGtx5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,337,1583222400"; 
   d="scan'208";a="433110170"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.147])
  by orsmga005.jf.intel.com with ESMTP; 30 Apr 2020 14:14:57 -0700
Date:   Thu, 30 Apr 2020 14:14:57 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] mm/gup.c: Corrected document reference path
Message-ID: <20200430211456.GA582335@iweiny-DESK2.sc.intel.com>
References: <1588273314-3790-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588273314-3790-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 12:31:54AM +0530, Souptick Joarder wrote:
> Document path Documentation/vm/pin_user_pages.rst is not a correct
> reference and it should be Documentation/core-api/pin_user_pages.rst.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  mm/gup.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 7ce796c..4952f12 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2864,10 +2864,10 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>   * the arguments here are identical.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for further details.
> + * see Documentation/core-api/pin_user_pages.rst for further details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
> + * It is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  int pin_user_pages_fast(unsigned long start, int nr_pages,
>  			unsigned int gup_flags, struct page **pages)
> @@ -2904,10 +2904,10 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
>   * the arguments here are identical.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
> + * It is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>  			   unsigned long start, unsigned long nr_pages,
> @@ -2940,10 +2940,10 @@ long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>   * FOLL_PIN is set.
>   *
>   * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>   *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 (DIO) in Documentation/core-api/pin_user_pages.rst.
> + * It is NOT intended for Case 2 (RDMA: long-term pins).
>   */
>  long pin_user_pages(unsigned long start, unsigned long nr_pages,
>  		    unsigned int gup_flags, struct page **pages,
> -- 
> 1.9.1
> 
> 
