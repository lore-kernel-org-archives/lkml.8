Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D782C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F5520866
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tTAnB7W0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMQVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:21:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52886 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMQVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:21:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597335696; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=mB7n5Oub8AHP0m+b94Uq/CktE/TX2Om68E8f34e5GJU=; b=tTAnB7W0+LBG27qvPtwHNrx5oWGns7tsbHs+4yUt5/eHZfScH4blzUBAA6at5dDNDVysvHM/
 nVyzZ6sm12PpVGFiu/8JFpPUkWX+jUW93qrqcSK1XSLD1c7SZgqhraFo72DxnjME7v1D7vrK
 /IePzgwbXtI/bFQesycB6NM+CpY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f35688f46ed996674a974ab (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 16:21:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28F02C43391; Thu, 13 Aug 2020 16:21:35 +0000 (UTC)
Received: from [192.168.1.103] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3BE35C433C6;
        Thu, 13 Aug 2020 16:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3BE35C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
 <20200813114105.GI9477@dhcp22.suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <9ca76893-dfe8-9a46-f2ec-6b3c663e848e@codeaurora.org>
Date:   Thu, 13 Aug 2020 21:51:29 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813114105.GI9477@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal for comments.

On 8/13/2020 5:11 PM, Michal Hocko wrote:
> On Tue 11-08-20 18:28:23, Charan Teja Reddy wrote:
> [...]
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e4896e6..839039f 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>  	struct page *page, *tmp;
>>  	LIST_HEAD(head);
>>  
>> +	/*
>> +	 * Ensure proper count is passed which otherwise would stuck in the
>> +	 * below while (list_empty(list)) loop.
>> +	 */
>> +	count = min(pcp->count, count);
>>  	while (count) {
>>  		struct list_head *list;
> 
> 
> How does this prevent the race actually?

This doesn't prevent the race. This only fixes the core hung(as this is
called with spin_lock_irq()) caused by the race condition. This core
hung is because of incorrect count value is passed to the
free_pcppages_bulk() function.

The actual race should be fixed by David's suggestion (isolate, online
and undo isolation).

Something needs to be improved in commit message? May be like below:
s/The following race is observed with the repeated ... / Cpu core hung
is observed as a result of race with the use case of repeated...

 Don't we need something like
> the following instead?
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e028b87ce294..45bcc7ba37c4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1317,9 +1317,16 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  		 * lists
>  		 */
>  		do {
> +			bool looped = false;

IIUC, this looped will always be initialzed to false thus never jumped
to free.
But I think I got your idea that looping of the pcp lists for any pages.
If not found despite MIGRATE_PCPTYPES count lists are traversed, just
break the loop. Does this checking really required? Shouldn't pcp->count
tells the same whether any pages left in the pcp lists?

> +
>  			batch_free++;
> -			if (++migratetype == MIGRATE_PCPTYPES)
> +			if (++migratetype == MIGRATE_PCPTYPES) {
> +				if (looped)
> +					goto free;
> +
>  				migratetype = 0;
> +				looped = true;
> +			}
>  			list = &pcp->lists[migratetype];
>  		} while (list_empty(list));
>  
> @@ -1352,6 +1359,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  		} while (--count && --batch_free && !list_empty(list));
>  	}
>  
> +free:
>  	spin_lock(&zone->lock);
>  	isolated_pageblocks = has_isolate_pageblock(zone);
>  
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
