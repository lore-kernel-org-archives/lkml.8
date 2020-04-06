Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7DDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A816206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="r+R7nWJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgDFXkl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:40:41 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:11601 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFXkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:40:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8bbdeb0000>; Mon, 06 Apr 2020 16:40:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 16:40:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 16:40:40 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 23:40:39 +0000
Received: from [10.2.60.145] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 23:40:39 +0000
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
To:     David Rientjes <rientjes@google.com>
CC:     Michal Hocko <mhocko@kernel.org>, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>
References: <20200403083543.11552-1-mhocko@kernel.org>
 <20200403083543.11552-2-mhocko@kernel.org>
 <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com>
 <87blo8xnz2.fsf@notabene.neil.brown.name>
 <20200406070137.GC19426@dhcp22.suse.cz>
 <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
 <alpine.DEB.2.21.2004061626540.45667@chino.kir.corp.google.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <efbdbe8f-f4fe-cfc8-4f15-1e19ee0bf416@nvidia.com>
Date:   Mon, 6 Apr 2020 16:40:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2004061626540.45667@chino.kir.corp.google.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586216427; bh=8aqbNQI9RcmnwWJRUQnWv9wtbfsMthod/bREPW0Ma1E=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=r+R7nWJR9LVbcyF4mliSlFAKiBkSthlsczleItsy2w1i2/cKh3co5vk5BxG5Lo5fm
         N7y2Z8E9+W4up8NYgL4v+bejZtBFZZOqueqmcF1jPGmA1W2VyRl1XeS+kd8LJKvps+
         Re0qZq5B9+vuM5ZBqegl5aLioUjJrCksVYEWCch+vtPmyMwv05ENVUl96Pi52oqLyA
         oXsxFI9f0fyeesTg6DmEeIZ2iVdScEwLBvDCbEaPtpJk15pvdyBDD+4Yc0a71zfKWZ
         isBRfUZE0K4jbx9w62TbE7pJLM8I5IPR7wWkfZW/oKA+gBjdGh8fOVWk+BkMWC3Tdh
         B5zee0XyYDsNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/6/20 4:32 PM, David Rientjes wrote:
> On Mon, 6 Apr 2020, John Hubbard wrote:
> 
>> Hi Michal and all,
>>
>> How about using approximately this wording instead? I found Neil's wording to
>> be
>> especially helpful so I mixed it in. (Also fixed a couple of slight 80-col
>> overruns.)
>>
>> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
>> index be2754841369..c247a911d8c7 100644
>> --- a/include/linux/gfp.h
>> +++ b/include/linux/gfp.h
>> @@ -111,6 +111,15 @@ struct vm_area_struct;
>>    * very shortly e.g. process exiting or swapping. Users either should
>>    * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
>>    *
>> + * To be extra clear: users of __GFP_MEMALLOC must be working to free other
>> + * memory, and that other memory needs to be freed "soon"; specifically,
>> before
>> + * the reserve is exhausted. This generally implies a throttling mechanism
>> that
>> + * balances the amount of __GFP_MEMALLOC memory used against the amount that
>> the
>> + * caller is about to free.
>> + *
>> + * Usage of a pre-allocated pool (e.g. mempool) should be always considered
>> + * before using this flag.
>> + *
>>    * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency
>> reserves.
>>    * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>>    */
> 
> I agree this looks better, but if a developer is reading this and is
> unfamiliar with the implementation of memory reserves or __GFP_MEMALLOC,
> how do they take any action that memory allocated with this bit is freed
> before the reserve is exhausted?
> 

In order to make it even possible to write documentation, I'd like to constrain
what "a developer" means a bit more. Someone who comes decides to use this
flag will at least get a clear indication of what's involved, and I would
expect that if it's still not clear, they would take a slightly deeper look.

So "a developer unfamiliar with the implementation of memory reserves" is
probably going to get into trouble if they remain unfamiliar. This documentation
should inspire them to learn what they need to learn.


> It seems like it's simply saying "don't allocate a lot of this before you
> free it."  That may be very well how it goes, but any discussion of
> depletion of the reserve seems to imply we'd want to quantify it and I
> agree that's not what we want the user to do.
> 
> So maybe simply state that reserves can be extremely limited and thus it's
> best to assume there is very little reserve left?
> 

Well...but now we're sort of back to the original documentation anyway. I
like the idea of putting in a bit about "you're supposed to be doing something
that frees up memory" in the comments, because it is a lot more concrete.

Because it's pretty hard to figure out what "be careful, there's not much
left" really means, in terms of code that one writes. :)

thanks,
-- 
John Hubbard
NVIDIA
