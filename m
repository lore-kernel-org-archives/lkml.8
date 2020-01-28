Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6ADC32771
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9D22467C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 00:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgA1Ajb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 19:39:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:7369 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgA1Ajb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 19:39:31 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jan 2020 16:39:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,371,1574150400"; 
   d="scan'208";a="261265782"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2020 16:39:29 -0800
Date:   Tue, 28 Jan 2020 08:39:42 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan.c: only adjust related kswapd cpu affinity
 when online cpu
Message-ID: <20200128003942.GC20624@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20200126132052.11921-1-richardw.yang@linux.intel.com>
 <alpine.DEB.2.21.2001261443020.164983@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2001261443020.164983@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 02:44:31PM -0800, David Rientjes wrote:
>On Sun, 26 Jan 2020, Wei Yang wrote:
>
>> When onlining a cpu, kswapd_cpu_online() is called to adjust kswapd cpu
>> affinity.
>> 
>> Current routine does like this:
>> 
>>   * Iterate all the numa node
>>   * Adjust cpu affinity when node has an online cpu
>> 
>> Actually we could improve this by:
>> 
>>   * Just adjust the numa node to which current online cpu belongs
>> 
>> Because we know which numa node the cpu belongs to and this cpu would
>> not affect other node.
>> 
>
>Is there ever a situation where the cpu to be onlined would have appeared 
>in the cpumask of another node and so a different kswapd's cpumask would 
>now include an off-node cpu?

No, I don't think so.

Per my understanding, kswapd_cpu_online() will be invoked when a cpu is
onlined. And the particular cpu belongs to a particular numa node. So it is
not necessary to iterate on every nodes.

And current code use cpumask_and_any() to do the check. If my understanding is
correct, the check would return true if this node has any online cpu. This is
likely to be true.

This is why I want to make the logic clear.

>
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> ---
>>  mm/vmscan.c | 19 ++++++++++---------
>>  1 file changed, 10 insertions(+), 9 deletions(-)
>> 
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 572fb17c6273..19c92d35045c 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -4049,18 +4049,19 @@ unsigned long shrink_all_memory(unsigned long nr_to_reclaim)
>>     restore their cpu bindings. */
>>  static int kswapd_cpu_online(unsigned int cpu)
>>  {
>> -	int nid;
>> +	int nid = cpu_to_node(cpu);
>> +	pg_data_t *pgdat;
>> +	const struct cpumask *mask;
>>  
>> -	for_each_node_state(nid, N_MEMORY) {
>> -		pg_data_t *pgdat = NODE_DATA(nid);
>> -		const struct cpumask *mask;
>> +	if (!node_state(nid, N_MEMORY))
>> +		return 0;
>>  
>> -		mask = cpumask_of_node(pgdat->node_id);
>> +	pgdat = NODE_DATA(nid);
>> +	mask = cpumask_of_node(nid);
>> +
>> +	/* One of our CPUs online: restore mask */
>> +	set_cpus_allowed_ptr(pgdat->kswapd, mask);
>>  
>> -		if (cpumask_any_and(cpu_online_mask, mask) < nr_cpu_ids)
>> -			/* One of our CPUs online: restore mask */
>> -			set_cpus_allowed_ptr(pgdat->kswapd, mask);
>> -	}
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.17.1
>> 
>> 
>> 

-- 
Wei Yang
Help you, Help me
