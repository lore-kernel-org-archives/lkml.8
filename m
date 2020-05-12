Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBC5C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9680220575
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 09:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729167AbgELJNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 05:13:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:53538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgELJNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 05:13:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CFD8EAC6C;
        Tue, 12 May 2020 09:13:31 +0000 (UTC)
Subject: Re: [PATCH 1/2] xen/xenbus: avoid large structs and arrays on the
 stack
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200511073151.19043-1-jgross@suse.com>
 <20200511073151.19043-2-jgross@suse.com>
 <965e1d65-3a0c-3a71-ca58-2b5c04f98bce@oracle.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <aa93722b-100a-c750-cf51-bcaf9defbd03@suse.com>
Date:   Tue, 12 May 2020 11:13:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <965e1d65-3a0c-3a71-ca58-2b5c04f98bce@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.05.20 20:01, Boris Ostrovsky wrote:
> On 5/11/20 3:31 AM, Juergen Gross wrote:
>>   
>>   static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
> 
> 
> I wonder whether we can drop valloc/vfree from xenbus_ring_ops' names.

I can do that.

> 
> 
>> +				      struct map_ring_valloc *info,
>>   				      grant_ref_t *gnt_ref,
>>   				      unsigned int nr_grefs,
>>   				      void **vaddr)
>>   {
>> -	struct xenbus_map_node *node;
>> +	struct xenbus_map_node *node = info->node;
>>   	int err;
>>   	void *addr;
>>   	bool leaked = false;
>> -	struct map_ring_valloc_hvm info = {
>> -		.idx = 0,
>> -	};
>>   	unsigned int nr_pages = XENBUS_PAGES(nr_grefs);
>>   
>> -	if (nr_grefs > XENBUS_MAX_RING_GRANTS)
>> -		return -EINVAL;
>> -
>> -	*vaddr = NULL;
>> -
>> -	node = kzalloc(sizeof(*node), GFP_KERNEL);
>> -	if (!node)
>> -		return -ENOMEM;
>> -
>>   	err = alloc_xenballooned_pages(nr_pages, node->hvm.pages);
>>   	if (err)
>>   		goto out_err;
>>   
>>   	gnttab_foreach_grant(node->hvm.pages, nr_grefs,
>>   			     xenbus_map_ring_setup_grant_hvm,
>> -			     &info);
>> +			     info);
>>   
>>   	err = __xenbus_map_ring(dev, gnt_ref, nr_grefs, node->handles,
>> -				info.phys_addrs, GNTMAP_host_map, &leaked);
>> +				info, GNTMAP_host_map, &leaked);
>>   	node->nr_handles = nr_grefs;
>>   
>>   	if (err)
>> @@ -641,11 +654,13 @@ static int xenbus_map_ring_valloc_hvm(struct xenbus_device *dev,
>>   	spin_unlock(&xenbus_valloc_lock);
>>   
>>   	*vaddr = addr;
>> +	info->node = NULL;
> 
> 
> Is this so that xenbus_map_ring_valloc() doesn't free it accidentally?

Yes.


Juergen

