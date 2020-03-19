Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F4FC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD0820754
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 02:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cF3lAWhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgCSCLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 22:11:10 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:38968 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSCLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 22:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Bx+nWphk0Tx3WSlxwQ4mWK6qyApS6Kk6UiaD7YfEwcY=; b=cF3lAWhRGUmF0h6gYJAtrg8uRJ
        7/sVOSJRSd/WTA4DcA/g4Otv7tZ7tQDwJg9NINJFIVqo7psvXjZvt1atVl7x15xOYq2MdI9EI3WOr
        0ueb2s7h+zsJCi5itYwZcy2IimIZYS3vp4wnMFG13ojIDGx7dyTZ1nB6tpGJzmEDgXREw3LxBCF5T
        EslFcghYWereAbjkREKBREt8aPkqTfk1QTLhRjsPlz8oAxdr+j0ZhPmQBgPiqrPhqiXimro+4dQjt
        D6+1BjKxYx4s2QOjgFoJGg2dSZ5TWfsaF2TNlD5ntVsukv0QlgoDp557eFEZllbfgILwTHpjYPwlq
        L3VDGozw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEkeL-0007tW-H1; Thu, 19 Mar 2020 02:11:09 +0000
Subject: Re: [PATCH -next] mm/hugetlb.c: fix printk format warning for 32-bit
 phys_addr_t
To:     Joe Perches <joe@perches.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <b74dcb60-ef35-f06e-de2d-b165ed38036a@infradead.org>
 <f4f8090c1be1a5a5ca663345751fb39893c89814.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ff8cc527-e02e-4f4b-56cd-a94ac5e527a3@infradead.org>
Date:   Wed, 18 Mar 2020 19:11:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f4f8090c1be1a5a5ca663345751fb39893c89814.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 7:04 PM, Joe Perches wrote:
> On Wed, 2020-03-18 at 14:33 -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix printk format warnings when phys_addr_t is 32 bits, i.e.,
>> CONFIG_PHYS_ADDR_T_64BIT is not set/enabled.
> []
>> ../mm/hugetlb.c:5472:73: note: format string is defined here
>>     pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
>>                                                                       ~~~^
> []
>> --- linux-next-20200318.orig/mm/hugetlb.c
>> +++ linux-next-20200318/mm/hugetlb.c
>> @@ -5469,8 +5469,10 @@ void __init hugetlb_cma_reserve(int orde
>>  					     0, false,
>>  					     "hugetlb", &hugetlb_cma[nid]);
>>  		if (res) {
>> -			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
>> -				res, nid, PFN_PHYS(min_pfn), PFN_PHYS(max_pfn));
>> +			phys_addr_t begpa = PFN_PHYS(min_pfn);
>> +			phys_addr_t endpa = PFN_PHYS(max_pfn);
>> +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%pap, %pap)",
>> +				res, nid, &begpa, &endpa);
> 
> You might correct the odd use of an open bracket
> then close parenthesis and add a new line too

Definitely needs a newline char.

I'm fairly sure that the [begin, end) notation is done on purpose, meaning
<begin> is included in the range and <end> is not included in the range.

> 
> Perhaps:
> 			pr_warn("%s: reservation failed: err %d, node %d, [%pap, %pap]\n",
> 				__func__, res, nid, &begpa, &endpa);
> 
> 

thanks.
-- 
~Randy

