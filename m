Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7720C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 951F621973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M4sHywYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgIIEBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:01:19 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:13596 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgIIEBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:01:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f58537f0007>; Tue, 08 Sep 2020 21:01:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 21:01:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 08 Sep 2020 21:01:17 -0700
Received: from [10.2.54.52] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Sep
 2020 04:01:07 +0000
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
To:     Roman Gushchin <guro@fb.com>, Zi Yan <ziy@nvidia.com>
CC:     Michal Hocko <mhocko@suse.com>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
 <20200904074207.GC15277@dhcp22.suse.cz>
 <20200904211045.GA567128@carbon.DHCP.thefacebook.com>
 <20200907072014.GD30144@dhcp22.suse.cz>
 <3CDAD67E-23A1-4D84-BF19-FFE1CF956779@nvidia.com>
 <20200908195859.GC567128@carbon.DHCP.thefacebook.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <f4dcc2fc-9435-10eb-27df-e5961bb42a12@nvidia.com>
Date:   Tue, 8 Sep 2020 21:01:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908195859.GC567128@carbon.DHCP.thefacebook.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599624063; bh=dmRq6pPL7lsu+1BBewRPvrdpoyaWLX1m2BQUzqJSQ9I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=M4sHywYiL0FR9Sr3mf87Zm3japsLXA8Ko7pyj0m0x8ykakwPAItGz/GLAtkYfIARt
         M6SjB3hPKv5v09INfUxokMCuV/EtHWjsdBTZZn5hnpHajFzPMxKGOXYChGtLwk8p2f
         WYUsP//nXhZCfVAH+6ndsW80kht5z8teMtH1fjyOsc9RV6SovvrCDNc16Zaz2CbSop
         5mVlWLwJPHhotRiSR6atRsPDjGB6BqY9ER3I6ql3wXy4sg4EZmbEb3IW80wmypHQi+
         FxD9g/PSzznk4GGjHl+uDJN7I/JUsylpdseXn7+9Hgw3Z18KaK8LI7Z99z209Fgp//
         +gKPAH9Xqhk1g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 12:58 PM, Roman Gushchin wrote:
> On Tue, Sep 08, 2020 at 11:09:25AM -0400, Zi Yan wrote:
>> On 7 Sep 2020, at 3:20, Michal Hocko wrote:
>>> On Fri 04-09-20 14:10:45, Roman Gushchin wrote:
>>>> On Fri, Sep 04, 2020 at 09:42:07AM +0200, Michal Hocko wrote:
>>> [...]
>> Something like MADV_HUGEPAGE_SYNC? It would be useful, since users have
>> better and clearer control of getting huge pages from the kernel and
>> know when they will pay the cost of getting the huge pages.
>>
>> I would think the suggestion is more about the huge page control options
>> currently provided by the kernel do not have predictable performance
>> outcome, since MADV_HUGEPAGE is a best-effort option and does not tell
>> users whether the marked virtual address range is backed by huge pages
>> or not when the madvise returns. MADV_HUGEPAGE_SYNC would provide a
>> deterministic result to users on whether the huge page(s) are formed
>> or not.
> 
> Yeah, I agree with Michal here, we need a more straightforward interface.
> 
> The hard question here is how hard the kernel should try to allocate
> a gigantic page and how fast it should give up and return an error?
> I'd say to try really hard if there are some chances to succeed,
> so that if an error is returned, there are no more reasons to retry.
> Any objections/better ideas here?

I agree, especially because this is starting to look a lot more like an
allocation call. And I think it would be appropriate for the kernel to
try approximately as hard to provide these 1GB pages, as it would to
allocate normal memory to a process.

In fact, for a moment I thought, why not go all the way and make this
actually be a true allocation? However, given that we still have
operations that require page splitting, with no good way to call back
user space to notify it that its "allocated" huge pages are being split,
that fails. But it's still pretty close.


> 
> Given that we need to pass a page size, we probably need either to introduce
> a new syscall (madvise2?) with an additional argument, or add a bunch
> of new madvise flags, like MADV_HUGEPAGE_SYNC + encoded 2MB, 1GB etc.
> 
> Idk what is better long-term, but new madvise flags are probably slightly
> easier to deal with in the development process.
> 

Probably either an MADV_* flag or a new syscall would work fine. But
given that this seems like a pretty distinct new capability, one with
options and man page documentation and possibly future flags itself, I'd
lean toward making it its own new syscall, maybe:

     compact_huge_pages(nbytes or npages, flags /* page size, etc */);

...thus leaving madvise() and it's remaining flags still available, to
further refine things.


thanks,
-- 
John Hubbard
NVIDIA
