Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E29DC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30FD6205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gqiMtuKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgD0Tbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD0Tbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:31:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED48C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cIORT2yBgyBsQ3dEPjRf1YjJ/rF80mCkwsPVKdb2lT8=; b=gqiMtuKReqPFCwozLi5DpXNYAz
        0ETVlbomZR7iL/8Fuv2KzMm6I3YAdF9ZImSUNhQYuvOMoxNN8hlP0BIGytlYjCxkMhsYOhAwamSWL
        RpvHdSK7+CxyopvHHu1Ie5mK9vdI9zl9MDamfYYToOOAVsvn+SoqFLHtq05p1Uy2z1CVVa5ngjZHB
        8eVe2HCKw+xHvHTqaPdc0iR5GLU0dn9AwJqtjiL5d8QcAfsMK5CLCUP+loz6EXDShrUdzApMRkG8A
        0mb2VJMjDYRE4cKpH72ySjckSGMxSN9jahrAanDu9IwOQS0ZiteKf+4tP/B+3bwr+x1Z5F9BbFPil
        vfEWwGBg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jT9Ti-0002n0-I9; Mon, 27 Apr 2020 19:31:42 +0000
Subject: Re: [PATCH] mm/gup.c: Updating the documentation
To:     Andrew Morton <akpm@linux-foundation.org>,
        Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1588013630-4497-1-git-send-email-jrdr.linux@gmail.com>
 <20200427122606.dc29c381f6da47831a40d365@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <152176e4-9200-d173-d427-e732241a6355@infradead.org>
Date:   Mon, 27 Apr 2020 12:31:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427122606.dc29c381f6da47831a40d365@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 12:26 PM, Andrew Morton wrote:
> On Tue, 28 Apr 2020 00:23:50 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:
> 
>> This patch is an attempt to update the documentation.
>>
>> * Adding / removing extra * based on type of function
>> static / global.
> 
> I don't think so, unless this is a new kerneldoc convention?

It's not new, but we generally try harder to document exported or
non-private interfaces and not so hard on private interfaces.

>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -722,7 +722,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
>>  	return follow_pud_mask(vma, address, p4d, flags, ctx);
>>  }
>>  
>> -/**
>> +/*
>>   * follow_page_mask - look up a page descriptor from a user-virtual address
>>   * @vma: vm_area_struct mapping @address
>>   * @address: virtual address to look up
> 
> /** indicates that the comment is in kerneldoc form, not that it has
> static scope?

Right.

-- 
~Randy

