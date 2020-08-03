Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0559CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D06B7206DA
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:29:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xdhDCEB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgHCN3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:29:08 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:31336 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726398AbgHCN3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:29:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596461347; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=5lz/yjuFSbfi7AP16DemqYxIyN/7sfSVueFdw1yEZKU=; b=xdhDCEB56/5qVQt4nvInLbSFbXofGuzl2oi5fGyrRygDOqHSLFzgvELjCO586xbD6lwHUJNd
 NwEDxVVN5Dk0w6qWJ7h5isRk9BPolWIfivZPcUrJleEM57TMHGov2zZeTJvO8bbjLEfSGCq7
 H9NprDY5bNozGc5DzXvwfLsDtXQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f28110f21feae908b7919f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 Aug 2020 13:28:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5A305C43395; Mon,  3 Aug 2020 13:28:46 +0000 (UTC)
Received: from [192.168.1.103] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E264C433C9;
        Mon,  3 Aug 2020 13:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E264C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
Subject: Re: [PATCH] mm, memory_hotplug: update pcp lists everytime onlining a
 memory block
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
References: <1596372896-15336-1-git-send-email-charante@codeaurora.org>
 <e15bc2ca-6bc5-158c-41df-af13aba75e54@redhat.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <f7913d7d-9fd9-97a5-eae8-3a5bb2683e19@codeaurora.org>
Date:   Mon, 3 Aug 2020 18:58:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e15bc2ca-6bc5-158c-41df-af13aba75e54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks David for the comments.

On 8/3/2020 1:35 PM, David Hildenbrand wrote:
> On 02.08.20 14:54, Charan Teja Reddy wrote:
>> When onlining a first memory block in a zone, pcp lists are not updated
>> thus pcp struct will have the default setting of ->high = 0,->batch = 1.
>> This means till the second memory block in a zone(if it have) is onlined
>> the pcp lists of this zone will not contain any pages because pcp's
>> ->count is always greater than ->high thus free_pcppages_bulk() is
>> called to free batch size(=1) pages every time system wants to add a
>> page to the pcp list through free_unref_page(). To put this in a word,
>> system is not using benefits offered by the pcp lists when there is a
>> single onlineable memory block in a zone. Correct this by always
>> updating the pcp lists when memory block is onlined.
> 
> I guess such setups are rare ... but I can imagine it being the case
> with virtio-mem in the future ... not 100% if this performance
> optimization is really relevant in practice ... how did you identify this?

Even the Snapdragon hardware that I had tested on contain multiple
onlineable memory blocks. But we have the use case in which we online
single memory block and once it is filled then online the next block. In
the step where single block is onlined, we observed the below pageset
params.
  pagesets
    cpu: 0
              count: 0
              high:  0
              batch: 1
Once the second block is onlined then only seeing some sane values as below.
    cpu: 0
              count: 32
              high:  378
              batch: 63

In the above case, till the second block is onlined, no page is held in
the pcp list. So, updating the pcp params every time when onlining the
memory block is required, as an example in the usecase that I had
mentioned.

> 
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>> ---
>>  mm/memory_hotplug.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index dcdf327..7f62d69 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -854,8 +854,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
>>  	node_states_set_node(nid, &arg);
>>  	if (need_zonelists_rebuild)
>>  		build_all_zonelists(NULL);
>> -	else
>> -		zone_pcp_update(zone);
>> +	zone_pcp_update(zone);
>>  
>>  	init_per_zone_wmark_min();
>>  
>>
> 
> Does, in general, look sane to me.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks for the ACK.

> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
