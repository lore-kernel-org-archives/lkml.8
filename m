Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C024C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEBB620776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b1Kd3yy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729978AbgEZITQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:19:16 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7535 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgEZITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:19:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eccd0f70000>; Tue, 26 May 2020 01:19:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 May 2020 01:19:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 May 2020 01:19:15 -0700
Received: from [10.2.58.199] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 26 May
 2020 08:19:15 +0000
Subject: Re: [PATCH] mm/gup: correct pin_user_pages.rst location
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Souptick Joarder <jrdr.linux@gmail.com>
References: <20200526081338.179532-1-vkuznets@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <16496017-14a9-146a-c257-35f9d3c2d3cb@nvidia.com>
Date:   Tue, 26 May 2020 01:19:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200526081338.179532-1-vkuznets@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590481143; bh=3sW4iiM0PCSt6YtpVfVEsIZMROlKg64amfSxZGfb1nc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=b1Kd3yy/vj+SjyNr/0DSJfxC4gckhSQ34lOoQ6Jhk0Kqx2T+w0xWk+EI5w91r2N0+
         HQbzookzuMoLt8x+qdrZCPMIsQllOPfCpXrAU+RZmrxI2EJmKgytnh/egZF6zyoLNo
         vF2bPMNkbUcKa6yjF/NyjTjJf7W/Ucx/GD05R0YSh8qkyNX/vRhe9jnf2VjkWQokoC
         0kIdHJKnsdpGhp9/3SIhH3/Ezv6yb4WONFedE2wmVXUarwQP1dbw39VpnMGkI3OBiF
         Zl6QkMnTskc6iUcrIiG6hhy1nJR56tkON1BG+LOh7eWr8CHTGop+g0UxEhdZDDgUwm
         RD99ZnCqQOypA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-26 01:13, Vitaly Kuznetsov wrote:
> pin_user_pages.rst lives in Documentation/core-api/, not Documentation/vm/,
> adjust all links accordingly.
> 
> Fixes: 3faa52c03f44 ("mm/gup: track FOLL_PIN pages")
> Fixes: eddb1c228f79 ("mm/gup: introduce pin_user_pages*() and FOLL_PIN")
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>   include/linux/mm.h |  4 ++--
>   mm/gup.c           | 18 +++++++++---------
>   2 files changed, 11 insertions(+), 11 deletions(-)

Hi Vitaly,

Thanks for the fix,

     Reviewed-by: John Hubbard <jhubbard@nvidia.com>

(+CC Souptick, who fixed a similar set of links, maybe in a different
file, as I recall.)

thanks,
-- 
John Hubbard
NVIDIA

> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5a323422d783..1f2850465f59 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1219,7 +1219,7 @@ void unpin_user_pages(struct page **pages, unsigned long npages);
>    * used to track the pincount (instead using of the GUP_PIN_COUNTING_BIAS
>    * scheme).
>    *
> - * For more information, please see Documentation/vm/pin_user_pages.rst.
> + * For more information, please see Documentation/core-api/pin_user_pages.rst.
>    *
>    * @page:	pointer to page to be queried.
>    * @Return:	True, if it is likely that the page has been "dma-pinned".
> @@ -2834,7 +2834,7 @@ struct page *follow_page(struct vm_area_struct *vma, unsigned long address,
>    * releasing pages: get_user_pages*() pages must be released via put_page(),
>    * while pin_user_pages*() pages must be released via unpin_user_page().
>    *
> - * Please see Documentation/vm/pin_user_pages.rst for more information.
> + * Please see Documentation/core-api/pin_user_pages.rst for more information.
>    */
>   
>   static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
> diff --git a/mm/gup.c b/mm/gup.c
> index 87a6a59fe667..87a3a4b400f9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2845,10 +2845,10 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
>    * the arguments here are identical.
>    *
>    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for further details.
> + * see Documentation/core-api/pin_user_pages.rst for further details.
>    *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
>    */
>   int pin_user_pages_fast(unsigned long start, int nr_pages,
>   			unsigned int gup_flags, struct page **pages)
> @@ -2885,10 +2885,10 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast);
>    * the arguments here are identical.
>    *
>    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>    *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
>    */
>   long pin_user_pages_remote(struct task_struct *tsk, struct mm_struct *mm,
>   			   unsigned long start, unsigned long nr_pages,
> @@ -2921,10 +2921,10 @@ EXPORT_SYMBOL(pin_user_pages_remote);
>    * FOLL_PIN is set.
>    *
>    * FOLL_PIN means that the pages must be released via unpin_user_page(). Please
> - * see Documentation/vm/pin_user_pages.rst for details.
> + * see Documentation/core-api/pin_user_pages.rst for details.
>    *
> - * This is intended for Case 1 (DIO) in Documentation/vm/pin_user_pages.rst. It
> - * is NOT intended for Case 2 (RDMA: long-term pins).
> + * This is intended for Case 1 in Documentation/core-api/pin_user_pages.rst
> + * (DIO). It is NOT intended for Case 2 (RDMA: long-term pins).
>    */
>   long pin_user_pages(unsigned long start, unsigned long nr_pages,
>   		    unsigned int gup_flags, struct page **pages,
> 

