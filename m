Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0235CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4BE12072E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="nHbvHZHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391503AbgFXUr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:47:27 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1502 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729867AbgFXUr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:47:27 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ef3bbd10000>; Wed, 24 Jun 2020 13:47:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 24 Jun 2020 13:47:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 24 Jun 2020 13:47:26 -0700
Received: from [10.2.59.206] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 24 Jun
 2020 20:47:24 +0000
Subject: Re: [PATCH] mm: Skip opportunistic reclaim for dma pinned pages
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Chris Wilson <chris@chris-wilson.co.uk>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <intel-gfx@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
References: <20200624191417.16735-1-chris@chris-wilson.co.uk>
 <20200624192116.GO6578@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <44708b2e-479f-7d58-fe01-29cfd6c70bdb@nvidia.com>
Date:   Wed, 24 Jun 2020 13:47:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624192116.GO6578@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593031633; bh=2lne34Bgsltqu3lapK9YX7sbymR3G2JcYO7zm77mdNE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=nHbvHZHIjUANZly99KWpI0RSdeNad4AK7nIXU5pCxrbQ5vWImuiYwSjbdJoCOXR08
         IdrDGS/BHFsg0UX2z3Pzd0rnDwisWyZp9RUN6N8lUHHZtMQmzYj8ryw7VGqnos1xWz
         /PJBzVgEP16oGD6Jhptv7NtjKJQoWrqGTz4l68UmxP2JQZhZDH5PF986iJQz0XiSkE
         Ghw1gl1yBLHuE5BDJPtDcNRizNB/blV6dUTzudJqHMJplitxETQg24AjXsYG8fGstc
         22evbs+ZsahLfC8gaXvPNambISBtM6BQLhP5vScPMbb/e7g1fzUr2UtTTUAfRh2HoK
         9fUDzyn6K/GBA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 12:21, Jason Gunthorpe wrote:
> On Wed, Jun 24, 2020 at 08:14:17PM +0100, Chris Wilson wrote:
>> A general rule of thumb is that shrinkers should be fast and effective.
>> They are called from direct reclaim at the most incovenient of times when
>> the caller is waiting for a page. If we attempt to reclaim a page being
>> pinned for active dma [pin_user_pages()], we will incur far greater
>> latency than a normal anonymous page mapped multiple times. Worse the
>> page may be in use indefinitely by the HW and unable to be reclaimed
>> in a timely manner.
> 
> A pinned page can't be migrated, discarded or swapped by definition -
> it would cause data corruption.
> 
> So, how do things even get here and/or work today at all? I think the
> explanation is missing something important.
> 

Well, those activities generally try to unmap the page, and
have to be prepared to deal with failure to unmap. From my reading,
it seemed very clear.

What's less clear is why the comment and the commit description
only talk about reclaim, when there are additional things that call
try_to_unmap(), including:

     migrate_vma_unmap()
     split_huge_page_to_list() --> unmap_page()

I do like this code change, though. And I *think* it's actually safe to
do this, as it stays away from writeback or other filesystem activity.
But let me double check that, in case I'm forgetting something.

thanks,
-- 
John Hubbard
NVIDIA
