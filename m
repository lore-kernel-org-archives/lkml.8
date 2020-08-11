Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46ACBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1627B2076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:01:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="MYBrA2do"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgHKNBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:01:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46387 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728506AbgHKNB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:01:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597150889; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=HNVJh0REjWkPwPjY9yj6feAv3ggEjHvlkWIzWMdpnXo=; b=MYBrA2doxcP9lACb3FZ6pcn9bjEqYuY9je3cRbgkf87HHNKNfoIU3k40qOwCZxRoEOs2J6NO
 /hsujmS4PXXrK8cS4YJdgRvu9Z3UvPJWk321AafLOWLumJTiLtCLyDvINsepW+o4O+ttwKLz
 oCAXETxnlZWg/m9JplsG5kcxmNg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f329697440a07969ae21ee9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 13:01:11
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1CACDC433CA; Tue, 11 Aug 2020 13:01:11 +0000 (UTC)
Received: from [192.168.1.103] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D5E5BC433C6;
        Tue, 11 Aug 2020 13:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D5E5BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     David Rientjes <rientjes@google.com>
Cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
References: <1597075833-16736-1-git-send-email-charante@codeaurora.org>
 <alpine.DEB.2.23.453.2008101234030.2938695@chino.kir.corp.google.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <aa382119-0679-0adc-d9ea-833fa7ed7525@codeaurora.org>
Date:   Tue, 11 Aug 2020 18:31:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.23.453.2008101234030.2938695@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David.

On 8/11/2020 1:06 AM, David Rientjes wrote:
> On Mon, 10 Aug 2020, Charan Teja Reddy wrote:
> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index e4896e6..25e7e12 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -3106,6 +3106,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>>  	struct zone *zone = page_zone(page);
>>  	struct per_cpu_pages *pcp;
>>  	int migratetype;
>> +	int high;
>>  
>>  	migratetype = get_pcppage_migratetype(page);
>>  	__count_vm_event(PGFREE);
>> @@ -3128,8 +3129,19 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>>  	pcp = &this_cpu_ptr(zone->pageset)->pcp;
>>  	list_add(&page->lru, &pcp->lists[migratetype]);
>>  	pcp->count++;
>> -	if (pcp->count >= pcp->high) {
>> -		unsigned long batch = READ_ONCE(pcp->batch);
>> +	high = READ_ONCE(pcp->high);
>> +	if (pcp->count >= high) {
>> +		int batch;
>> +
>> +		batch = READ_ONCE(pcp->batch);
>> +		/*
>> +		 * For non-default pcp struct values, high is always
>> +		 * greater than the batch. If high < batch then pass
>> +		 * proper count to free the pcp's list pages.
>> +		 */
>> +		if (unlikely(high < batch))
>> +			batch = min(pcp->count, batch);
>> +
>>  		free_pcppages_bulk(zone, batch, pcp);
>>  	}
>>  }
> 
> I'm wondering if a fix to free_pcppages_bulk() is more appropriate here 
> because the count passed into it seems otherwise fragile if this results 
> in a hung core?
> 

Agree that the free_pcppages_bulk() is appropriate place to fix and it
actually much cleaner. Raised V2:
https://patchwork.kernel.org/patch/11709225/

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
