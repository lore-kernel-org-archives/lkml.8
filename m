Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AB9C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D06720787
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="IerDSP3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504703AbgDNT0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:26:44 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10012 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504673AbgDNT0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:26:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9609890000>; Tue, 14 Apr 2020 12:05:45 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Apr 2020 12:05:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Apr 2020 12:05:58 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Apr
 2020 19:05:58 +0000
Received: from [10.2.59.2] (10.124.1.5) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Apr 2020 19:05:57
 +0000
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
To:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
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
 <efbdbe8f-f4fe-cfc8-4f15-1e19ee0bf416@nvidia.com>
 <20200413191532.6b234b50caea9134fb95a151@linux-foundation.org>
 <87h7xmu3di.fsf@notabene.neil.brown.name>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <a7520c0f-4285-4661-1281-ca343361407a@nvidia.com>
Date:   Tue, 14 Apr 2020 12:05:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87h7xmu3di.fsf@notabene.neil.brown.name>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586891145; bh=g4yF/XOBRuoNrZ1hb1bn5M1jI7/I+PjWefBEgTSY1Zo=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=IerDSP3yz3nDr3jFx0NePg9qqclc7xk4zAzjvw4VqWUrv3Rs0e6irKHec+TsoEAYl
         P+JBbgsYVQ8GYKW3lXSqkWje2mjJ9VdQ+iC0RHWGF3W3jpw9Wj55mNdL5mfDUd1O6n
         fW4GxtZFrNtclNxV9UE7RvRy2ijcfEuBWGjZ+b92OD1d11IbnWVCjuC04/QzZjdxWa
         qdix9tNV68rEGUO55O4zNCM+zs+UNf6OzOSwCBjWrtI71Xn2n/W0UT69ml4bTRIqaQ
         5RcaKMqMHHgMuyF1pOc2kGB/HwdxhjO5nvTlLcduXKNdoRXBRERJM21e6ntBYOmZLM
         BC31nWOOy04dQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-13 20:56, NeilBrown wrote:
> On Mon, Apr 13 2020, Andrew Morton wrote:
> 
>> I've rather lost the plot with this little patch.  Is the below
>> suitable, or do we think that changes are needed?
>>

I recall we were trying to talk Neil into adding some of his writings
into Documentation/core-api/memory-allocation.rst, and then refer to
that from here. But that would be a separate patch I think.


thanks,
-- 
John Hubbard
NVIDIA

>>
>> From: Michal Hocko <mhocko@suse.com>
>> Subject: mm: clarify __GFP_MEMALLOC usage
>>
>> It seems that the existing documentation is not explicit about the
>> expected usage and potential risks enough.  While it is calls out that
>> users have to free memory when using this flag it is not really apparent
>> that users have to careful to not deplete memory reserves and that they
>> should implement some sort of throttling wrt.  freeing process.
>>
>> This is partly based on Neil's explanation [1].
>>
>> Let's also call out that a pre allocated pool allocator should be
>> considered.
>>
>> [1] http://lkml.kernel.org/r/877dz0yxoa.fsf@notabene.neil.brown.name
>>
>> [akpm@linux-foundation.org: coding style fixes]
>> Link: http://lkml.kernel.org/r/20200403083543.11552-2-mhocko@kernel.org
>> Signed-off-by: Michal Hocko <mhocko@suse.com>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Joel Fernandes <joel@joelfernandes.org>
>> Cc: Neil Brown <neilb@suse.de>
>> Cc: Paul E. McKenney <paulmck@kernel.org>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> [mhocko@kernel.org: update]
>>    Link: http://lkml.kernel.org/r/20200406070137.GC19426@dhcp22.suse.cz
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
>>   include/linux/gfp.h |    5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> --- a/include/linux/gfp.h~mm-clarify-__gfp_memalloc-usage
>> +++ a/include/linux/gfp.h
>> @@ -110,6 +110,11 @@ struct vm_area_struct;
>>    * the caller guarantees the allocation will allow more memory to be freed
>>    * very shortly e.g. process exiting or swapping. Users either should
>>    * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
>> + * Users of this flag have to be extremely careful to not deplete the reserve
>> + * completely and implement a throttling mechanism which controls the
>> + * consumption of the reserve based on the amount of freed memory.
>> + * Usage of a pre-allocated pool (e.g. mempool) should be always considered
>> + * before using this flag.
> 
> I particularly don't like the connection between the consumption and the
> amount freed.  I don't think that say anything useful and it misses the
> main point which, I think, is having a bound on total usage.
> 
> Nichal's previous proposal is, I think, the best concrete proposal so
> far.
> 
> NeilBrown
> 
>>    *
>>    * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency reserves.
>>    * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>> _


