Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE9B5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EA1021927
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EBLe+NbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgDRB6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 21:58:49 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46034 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgDRB6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 21:58:49 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03I1vrri007345;
        Sat, 18 Apr 2020 01:58:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=qqN27y5qrDOT+b4UYd2GMrSkWmfCsj5tFTcQmSPIJds=;
 b=EBLe+NbXXv637IyFUUvJ5PchK2O15bgdcT+PiuiTw/IbyJNOZfqPKQfHo4dIheRi8NJP
 8YyUtoc9coO9xzlPkqjQIjbQMGvR0kxjzJ5oTKKwDByafRp4167KegYR7QgckCtX9VOm
 shn/On+o+fs3oRRvCYcn6w7Fu4emKDp/FcQtkKEgUH1rljkJxcrqhX5SUa17Ql3XeIJ5
 H2xaoeAdkgIKjAaq4UKszFxYalJcMtueyMwRzxcK48sY/r63Y2K7CQWmH6+twBZip3gp
 k07UBbIqKqpR2PRthCjPq6Gclz4KOJUad9mkIuPViTTv9JdXzNZXPrNdVr1lDVysJbKX aA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30e0aafe7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 01:58:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03I1qEpA022883;
        Sat, 18 Apr 2020 01:58:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30dn9mr6hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Apr 2020 01:58:37 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03I1wZaa006623;
        Sat, 18 Apr 2020 01:58:36 GMT
Received: from [10.0.0.251] (/24.5.189.83)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 17 Apr 2020 18:58:35 -0700
Subject: Re: [PATCH 1/1] mm: slub: fix corrupted freechain in
 deactivate_slab()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        linux-kernel@vger.kernel.org, joe.jin@oracle.com
References: <20200331031450.12182-1-dongli.zhang@oracle.com>
 <20200417181219.bef9b2f9ade92bf3798e3622@linux-foundation.org>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <d9ebb540-b3ec-a29a-1d7a-2f5762010b53@oracle.com>
Date:   Fri, 17 Apr 2020 18:56:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417181219.bef9b2f9ade92bf3798e3622@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004180010
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9594 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004180010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/17/20 6:12 PM, Andrew Morton wrote:
> On Mon, 30 Mar 2020 20:14:50 -0700 Dongli Zhang <dongli.zhang@oracle.com> wrote:
> 
>> The slub_debug is able to fix the corrupted slab freelist/page. However,
>> alloc_debug_processing() only checks the validity of current and next
>> freepointer during allocation path. As a result, once some objects have
>> their freepointers corrupted, deactivate_slab() may lead to page fault.
>>
>> Below is from a test kernel module when
>> 'slub_debug=PUF,kmalloc-128 slub_nomerge'. The test kernel corrupts the
>> freepointer of one free object on purpose. Unfortunately, deactivate_slab()
>> does not detect it when iterating the freechain.
>>
>> ...
>>
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -2082,6 +2082,20 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>>  		void *prior;
>>  		unsigned long counters;
>>  
>> +		if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
>> +		    !check_valid_pointer(s, page, nextfree)) {
>> +			/*
>> +			 * If 'nextfree' is invalid, it is possible that
>> +			 * the object at 'freelist' is already corrupted.
>> +			 * Therefore, all objects starting at 'freelist'
>> +			 * are isolated.
>> +			 */
>> +			object_err(s, page, freelist, "Freechain corrupt");
>> +			freelist = NULL;
>> +			slab_fix(s, "Isolate corrupted freechain");
>> +			break;
>> +		}
>> +
>>  		do {
>>  			prior = page->freelist;
>>  			counters = page->counters;
> 
> We could do it this way:
> 
> --- a/mm/slub.c~mm-slub-fix-corrupted-freechain-in-deactivate_slab-fix
> +++ a/mm/slub.c
> @@ -2083,6 +2083,7 @@ static void deactivate_slab(struct kmem_
>  		void *prior;
>  		unsigned long counters;
>  
> +#ifdef CONFIG_SLAB_DEBUG
>  		if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
>  		    !check_valid_pointer(s, page, nextfree)) {
>  			/*
> @@ -2096,6 +2097,7 @@ static void deactivate_slab(struct kmem_
>  			slab_fix(s, "Isolate corrupted freechain");
>  			break;
>  		}
> +#endif
>  
>  		do {
>  			prior = page->freelist;
> 
> But it's a bit ugly.  How about this?

Sorry that I did not realize check_valid_pointer() requires CONFIG_SLAB_DEBUG.

Yes, it is much better to encapsulate it into freelist_corrupted() and just
return false when CONFIG_SLAB_DEBUG is not involved. The check_object() has
similar implementation.

Should I resend with your "Signed-off-by" or you would just fix it when applying?

It is the first time I submit a patch to mm so that I am not familiar with the
mm policy/process.

Thank you very much for the feedback!

Dongli Zhang

> 
> --- a/mm/slub.c~mm-slub-fix-corrupted-freechain-in-deactivate_slab-fix
> +++ a/mm/slub.c
> @@ -650,6 +650,20 @@ static void slab_bug(struct kmem_cache *
>  	va_end(args);
>  }
>  
> +static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
> +			       void *freelist, void *nextfree)
> +{
> +	if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
> +	    !check_valid_pointer(s, page, nextfree)) {
> +		object_err(s, page, freelist, "Freechain corrupt");
> +		freelist = NULL;
> +		slab_fix(s, "Isolate corrupted freechain");
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static void slab_fix(struct kmem_cache *s, char *fmt, ...)
>  {
>  	struct va_format vaf;
> @@ -1400,6 +1414,11 @@ static inline void inc_slabs_node(struct
>  static inline void dec_slabs_node(struct kmem_cache *s, int node,
>  							int objects) {}
>  
> +static bool freelist_corrupted(struct kmem_cache *s, struct page *page,
> +			       void *freelist, void *nextfree)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  /*
> @@ -2083,19 +2102,13 @@ static void deactivate_slab(struct kmem_
>  		void *prior;
>  		unsigned long counters;
>  
> -		if ((s->flags & SLAB_CONSISTENCY_CHECKS) &&
> -		    !check_valid_pointer(s, page, nextfree)) {
> -			/*
> -			 * If 'nextfree' is invalid, it is possible that
> -			 * the object at 'freelist' is already corrupted.
> -			 * Therefore, all objects starting at 'freelist'
> -			 * are isolated.
> -			 */
> -			object_err(s, page, freelist, "Freechain corrupt");
> -			freelist = NULL;
> -			slab_fix(s, "Isolate corrupted freechain");
> +		/*
> +		 * If 'nextfree' is invalid, it is possible that the object at
> +		 * 'freelist' is already corrupted.  So isolate all objects
> +		 * starting at 'freelist'.
> +		 */
> +		if (freelist_corrupted(s, page, freelist, nextfree))
>  			break;
> -		}
>  
>  		do {
>  			prior = page->freelist;
> _
> 
