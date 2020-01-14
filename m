Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08366C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D821524673
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="a9LzlIUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgANTHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:07:07 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:9040 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgANTHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:07:05 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1e11440001>; Tue, 14 Jan 2020 11:06:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 11:07:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 14 Jan 2020 11:07:04 -0800
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 19:07:04 +0000
Subject: Re: [PATCH] mm/gup.c: use is_vm_hugetlb_page() to check whether to
 follow huge
To:     Wei Yang <richardw.yang@linux.intel.com>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20200113070322.26627-1-richardw.yang@linux.intel.com>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <3ec77382-900c-56b9-dcad-f8b24117b097@nvidia.com>
Date:   Tue, 14 Jan 2020 11:07:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20200113070322.26627-1-richardw.yang@linux.intel.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579028804; bh=hZsn8tMhhorSOJE+MItZ1I/KLc39J7bADhxnf8j7JvY=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=a9LzlIUh5iwnZCfjQnhED77O0uXMOeGDhdVwJLxb+syAs2kmiR+bxsIX+n35HT1ep
         sVCw0l5cJG0KpfzQrGIewERctGineNDGFXcqnPemWPWx0JlCOvFG9sOowFhnkqTdIu
         +JOt53LsUdbnHADxipNHQvWYstcTmzTPwnddmhecUQQSgbOafQ6QM7re5IRa9tzOBz
         SnQEU0KCYm5/U9znbCOONIg9a2W1uNbopVz10TLtvmhOelaWMoZpZN80dme5bKfOxo
         8ZUZwigZg1gImggYj24/1kOBiTPnaszuD3eCvmkegvzjcx96FXf5q/RVS/PI/2IYO8
         2uRb14sqrxQNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/12/20 11:03 PM, Wei Yang wrote:
> No functional change, just leverage the helper function to improve
> readability as others.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

I had thought about doing this same thing. :-)
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

> ---
>   mm/gup.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 7646bf993b25..7705929cc920 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -323,7 +323,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
>   	pmdval = READ_ONCE(*pmd);
>   	if (pmd_none(pmdval))
>   		return no_page_table(vma, flags);
> -	if (pmd_huge(pmdval) && vma->vm_flags & VM_HUGETLB) {
> +	if (pmd_huge(pmdval) && is_vm_hugetlb_page(vma)) {
>   		page = follow_huge_pmd(mm, address, pmd, flags);
>   		if (page)
>   			return page;
> @@ -433,7 +433,7 @@ static struct page *follow_pud_mask(struct vm_area_struct *vma,
>   	pud = pud_offset(p4dp, address);
>   	if (pud_none(*pud))
>   		return no_page_table(vma, flags);
> -	if (pud_huge(*pud) && vma->vm_flags & VM_HUGETLB) {
> +	if (pud_huge(*pud) && is_vm_hugetlb_page(vma)) {
>   		page = follow_huge_pud(mm, address, pud, flags);
>   		if (page)
>   			return page;
> 
