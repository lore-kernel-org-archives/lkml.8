Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD08C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6160D2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgCSCGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 22:06:38 -0400
Received: from smtprelay0209.hostedemail.com ([216.40.44.209]:34626 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726596AbgCSCGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:06:38 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D02E2182CED28;
        Thu, 19 Mar 2020 02:06:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: month39_56a2ada6b4e5c
X-Filterd-Recvd-Size: 2114
Received: from XPS-9350 (unknown [172.58.27.183])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Mar 2020 02:06:35 +0000 (UTC)
Message-ID: <f4f8090c1be1a5a5ca663345751fb39893c89814.camel@perches.com>
Subject: Re: [PATCH -next] mm/hugetlb.c: fix printk format warning for
 32-bit phys_addr_t
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 18 Mar 2020 19:04:43 -0700
In-Reply-To: <b74dcb60-ef35-f06e-de2d-b165ed38036a@infradead.org>
References: <b74dcb60-ef35-f06e-de2d-b165ed38036a@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-18 at 14:33 -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix printk format warnings when phys_addr_t is 32 bits, i.e.,
> CONFIG_PHYS_ADDR_T_64BIT is not set/enabled.
[]
> ../mm/hugetlb.c:5472:73: note: format string is defined here
>     pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
>                                                                       ~~~^
[]
> --- linux-next-20200318.orig/mm/hugetlb.c
> +++ linux-next-20200318/mm/hugetlb.c
> @@ -5469,8 +5469,10 @@ void __init hugetlb_cma_reserve(int orde
>  					     0, false,
>  					     "hugetlb", &hugetlb_cma[nid]);
>  		if (res) {
> -			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
> -				res, nid, PFN_PHYS(min_pfn), PFN_PHYS(max_pfn));
> +			phys_addr_t begpa = PFN_PHYS(min_pfn);
> +			phys_addr_t endpa = PFN_PHYS(max_pfn);
> +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%pap, %pap)",
> +				res, nid, &begpa, &endpa);

You might correct the odd use of an open bracket
then close parenthesis and add a new line too

Perhaps:
			pr_warn("%s: reservation failed: err %d, node %d, [%pap, %pap]\n",
				__func__, res, nid, &begpa, &endpa);


