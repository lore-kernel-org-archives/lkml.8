Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B62C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DF720752
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 01:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kLlN+Nnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCTBDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 21:03:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCTBDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 21:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=Ys84MSFThr+iceWVOVJ1ydyxTrqVWchEPrhB/TlXSx4=; b=kLlN+Nnmx9HvogqnfJbpvfqQI8
        +MkKfXUUVy3e9kgGREXRcrq0vebzEsqrATfd/gUCaIn5TL4QIvw+g5oDaG3faiFTZwjmwW0lntlDY
        yJe18b9P/M7QPu7WPTull9l52/9WPB4Fq8pD3VXQzrBwTvwdS56asp6YVQRo+TzRYlDqsMjQiKacn
        ISf+sYy/t02OJjuS+Of2UZWkKujLE14J9guIWcgdpuqZu5khzDAcJfhDW5zfQh1VJl3Y7Wrql4Uv8
        cqYW+KvV9y+dEH0qEy5OhjjmgKkjqpsYb8UDF/uTiOJyUdSqn/YXDxD9phBCoYC3xKKi3YDu3GPNQ
        9ZKo9I4g==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jF64X-0003Lf-B9; Fri, 20 Mar 2020 01:03:37 +0000
Subject: Re: [PATCH -next] mm/hugetlb.c: fix printk format warning for 32-bit
 phys_addr_t
To:     Joe Perches <joe@perches.com>, Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <b74dcb60-ef35-f06e-de2d-b165ed38036a@infradead.org>
 <f4f8090c1be1a5a5ca663345751fb39893c89814.camel@perches.com>
 <ff8cc527-e02e-4f4b-56cd-a94ac5e527a3@infradead.org>
 <be55765b11f925f15f338152399923e169a20f53.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <58454a65-5022-7517-df65-7bf504cd1432@infradead.org>
Date:   Thu, 19 Mar 2020 18:03:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <be55765b11f925f15f338152399923e169a20f53.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/20 7:37 PM, Joe Perches wrote:
> On Wed, 2020-03-18 at 19:11 -0700, Randy Dunlap wrote:
>> On 3/18/20 7:04 PM, Joe Perches wrote:
>>> On Wed, 2020-03-18 at 14:33 -0700, Randy Dunlap wrote:
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> Fix printk format warnings when phys_addr_t is 32 bits, i.e.,
>>>> CONFIG_PHYS_ADDR_T_64BIT is not set/enabled.
>>> []
>>>> ../mm/hugetlb.c:5472:73: note: format string is defined here
>>>>     pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
>>>>                                                                       ~~~^
>>> []
>>>> --- linux-next-20200318.orig/mm/hugetlb.c
>>>> +++ linux-next-20200318/mm/hugetlb.c
>>>> @@ -5469,8 +5469,10 @@ void __init hugetlb_cma_reserve(int orde
>>>>  					     0, false,
>>>>  					     "hugetlb", &hugetlb_cma[nid]);
>>>>  		if (res) {
>>>> -			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
>>>> -				res, nid, PFN_PHYS(min_pfn), PFN_PHYS(max_pfn));
>>>> +			phys_addr_t begpa = PFN_PHYS(min_pfn);
>>>> +			phys_addr_t endpa = PFN_PHYS(max_pfn);
>>>> +			pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%pap, %pap)",
>>>> +				res, nid, &begpa, &endpa);
>>>
>>> You might correct the odd use of an open bracket
>>> then close parenthesis and add a new line too
>>
>> Definitely needs a newline char.
>>
>> I'm fairly sure that the [begin, end) notation is done on purpose, meaning
>> <begin> is included in the range and <end> is not included in the range.
> 
> OK, that seems a pretty obscure and not obvious use of
> interval notation, at least to me. (18 uses treewide ?)
> 
> Maybe it could be documented somewhere?

I thought about where to put that and came up empty.

> It's an odd pattern to grep.  Maybe I missed some.

It's probably not used much more than this.

> $ git grep -P '".*[\[\{]\s*%\d*[ldux]+\s*[/:,\.\-]?\s*%\d*[ldux]+\).*"'
> arch/x86/kernel/alternative.c:  DUMP_BYTES(instr, a->instrlen, "%px: [%d:%d) optimized NOPs: ",
> drivers/clk/qcom/clk-alpha-pll.c:               pr_err("%s: Rounded rate %lu not within range [%lu, %lu)\n",
> fs/ext4/extents_status.c:               printk(KERN_DEBUG " [%u/%u) %llu %x",
> fs/ext4/extents_status.c:                       es_debug("%u cached by [%u/%u) %llu %x\n",
> fs/ext4/extents_status.c:       es_debug("add [%u/%u) %llu %x to extent status tree of inode %lu\n",
> fs/ext4/extents_status.c:                       es_debug("%u cached by [%u/%u)\n",
> fs/ext4/extents_status.c:       es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
> fs/nilfs2/cpfile.c:                       "cannot delete checkpoints: invalid range [%llu, %llu)",
> fs/nilfs2/dat.c:                          "%s: invalid vblocknr = %llu, [%llu, %llu)",
> include/trace/events/ext4.h:    TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s",
> include/trace/events/ext4.h:    TP_printk("dev %d,%d ino %lu es [%lld/%lld)",
> include/trace/events/ext4.h:    TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s",
> include/trace/events/ext4.h:    TP_printk("dev %d,%d ino %lu found %d [%u/%u) %llu %s",
> include/trace/events/ext4.h:    TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s "
> mm/hugetlb.c:                   pr_warn("hugetlb_cma: reservation failed: err %d, node %d, [%llu, %llu)",
> mm/kasan/report.c:              pr_err(" [%lu, %lu) '%s'", offset, offset + size, token);
> mm/page_alloc.c:                pr_info_ratelimited("%s: [%lx, %lx) PFNs busy\n",
> tools/testing/selftests/kvm/demand_paging_test.c:               PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
> 
> 

thanks.

-- 
~Randy

