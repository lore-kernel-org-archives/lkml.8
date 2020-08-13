Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE7BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4906720774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ui9khg8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHMR1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:27:52 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:17047 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726522AbgHMR1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:27:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597339670; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=/+3WtLDRfWjwNOXtJnp0hfGVNxfJvGelGD1RlImJwUc=; b=Ui9khg8MAVSMwJkv+GYoUVQ5RnjW6DLFx7g0X11CDaRdeFQJGEWuyD9vrib/4i8ZqGcj9auT
 gEV/epCm0LV6/RYjttgyC+G0D8pheAJ9sCIAAlBv5x/yRAUJd27lv6J9EqxZU4LVgU09XHZS
 0T7NDH4ZkCe9uWO2oGd2TSKu9Vw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f35780a2889723bf8f3a0eb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 17:27:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC9AEC433CA; Thu, 13 Aug 2020 17:27:37 +0000 (UTC)
Received: from [192.168.1.103] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67A5DC433C6;
        Thu, 13 Aug 2020 17:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 67A5DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
 <20200813114105.GI9477@dhcp22.suse.cz>
 <9ca76893-dfe8-9a46-f2ec-6b3c663e848e@codeaurora.org>
 <20200813163054.GR9477@dhcp22.suse.cz>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <099b1a12-7fcd-f665-3f9d-e20d4e1396d3@codeaurora.org>
Date:   Thu, 13 Aug 2020 22:57:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813163054.GR9477@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal.

On 8/13/2020 10:00 PM, Michal Hocko wrote:
> On Thu 13-08-20 21:51:29, Charan Teja Kalla wrote:
>> Thanks Michal for comments.
>>
>> On 8/13/2020 5:11 PM, Michal Hocko wrote:
>>> On Tue 11-08-20 18:28:23, Charan Teja Reddy wrote:
>>> [...]
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index e4896e6..839039f 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>>>>  	struct page *page, *tmp;
>>>>  	LIST_HEAD(head);
>>>>  
>>>> +	/*
>>>> +	 * Ensure proper count is passed which otherwise would stuck in the
>>>> +	 * below while (list_empty(list)) loop.
>>>> +	 */
>>>> +	count = min(pcp->count, count);
>>>>  	while (count) {
>>>>  		struct list_head *list;
>>>
>>>
>>> How does this prevent the race actually?
>>
>> This doesn't prevent the race. This only fixes the core hung(as this is
>> called with spin_lock_irq()) caused by the race condition. This core
>> hung is because of incorrect count value is passed to the
>> free_pcppages_bulk() function.
> 
> Let me ask differently. What does enforce that the count and lists do
> not get out of sync in the loop. 

count value is updated whenever an order-0 page is being added to the
pcp lists through free_unref_page_commit(), which is being called with
both interrupts, premption disabled.
static void free_unref_page_commit(struct page *page, {
	....
	list_add(&page->lru, &pcp->lists[migratetype]);
	pcp->count++
}

As these are pcp lists, they only gets touched by another process when
this process is context switched, which happens only after enabling
premption or interrupts. So, as long as process is operating on these
pcp lists in free_unref_page_commit function, the count and lists are
always synced.

However, the problem here is not that the count and lists are being out
of sync. They do always in sync, as explained above. It is with the
asking free_pcppages_bulk() to free the pages more than what is present
in the pcp lists which is ending up in while(list_empty()).

> Your changelog says that the fix is to
> use the proper value without any specifics.
> 
Will change this to: Ensure the count value passed is not greater than
the pcp lists count. Any better you suggest?

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
