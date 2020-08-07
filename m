Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A09C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 22:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6488A2086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 22:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YAApT+8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgHGWk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 18:40:29 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:8591 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgHGWk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 18:40:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2dd7f50000>; Fri, 07 Aug 2020 15:38:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 07 Aug 2020 15:40:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 07 Aug 2020 15:40:27 -0700
Received: from [10.2.52.206] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 7 Aug
 2020 22:40:22 +0000
Subject: Re: [PATCH v2] mm, dump_page: do not crash with bad
 compound_mapcount()
To:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <cai@lca.pw>, <rppt@linux.ibm.com>, <vbabka@suse.cz>,
        <william.kucharski@oracle.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200804214807.169256-1-jhubbard@nvidia.com>
 <20200807143504.4kudtd4xeoqaroqg@box>
 <20200807151029.GE17456@casper.infradead.org>
 <20200807164805.xm4ingj4crdiemol@box>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <2038d28f-0f65-5629-f033-e92c5c5e9798@nvidia.com>
Date:   Fri, 7 Aug 2020 15:40:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200807164805.xm4ingj4crdiemol@box>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596839925; bh=V8KL8V1OqjlOYNcn5ZdslPutD+BA8Q66zxQ3bPAosTs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YAApT+8MeT8HnTLuUyKnGmD/DTT1gJs7KAgtSTP7hcPox004MhFKDmQzU8dzfLC86
         ixuquydWeMlJ6sjH0XBxljFydG3F2snZ32FrUs7tZBnMwayqhuGAs4Hmq/V7dYxJJ/
         gLfVMC1xdMJ1I1jVBrZWGHmdOdBwj7D4Q/CT9vuniVTWNyv1PJ6fBGoJZrycOWscmn
         JFgjR277qKR1mVaTNRw9dUg9iVCuPqLeCoH65O9fj3F6tLIZZS0tE8ckLczvN+Yu8t
         0h5JPEe7C19I2eMkpSq9+9fsa7m8wJLq5R6Vdq9cSyQpEWc3YdGR3QxrzktyRhG6Tn
         5qWsKNKmeXMzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/20 9:48 AM, Kirill A. Shutemov wrote:
>> [...]
>>>> +static inline int head_mapcount(struct page *head)
>>>> +{
>>>
>>> Do we want VM_BUG_ON_PAGE(!PageHead(head), head) here?
>>
>> Well, no.  That was the point of the bug report -- by the time we called
>> compound_mapcount, the page was no longer a head page.
> 
> Right. VM_BUG_ON_PAGE(PageTail(head), head)?

Sorry for overlooking that feedback point. Looking at it now, I'd much
rather not put any assertions at all here. This supposed to be for
implementing the failure case, and we've moved past assertions at this
point. In other words, dump_page() is part of *implementing* an
assertion, so calling assertions from within it is undesirable.

It's better to put the assertions in code that would call these inner
routines. Then, if we want to use these routines outside of mm/debug.c,
as per the other thread, then we should provide a wrapper that has such
assertions.


thanks,
-- 
John Hubbard
NVIDIA
