Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8D1C2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2696206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 13:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM/HnmhQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgC0NWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 09:22:03 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46106 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgC0NWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 09:22:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so11317617wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kK0eYZi8oifTFTpm0EYAk1xaXlFVzS6cFt1buE80FCg=;
        b=NM/HnmhQLTnxK7yMTwQ8cC2o85yHO8jAXVnmgMfPemyTZ3TpaIGDYSMngmoEkROwnj
         UqVU7Zag5b3Re6Fww1ATB4K4zL5VWjQOw3mKdTlY4XEPPJq2pERpHLQsjiHmxB0Hj0J2
         g6KBi0cVTci4hEpKHKCzN3rL+I032/wzF5CZNfmXJ0LEuUwv8UNq8J3bV+44Ck00XL+d
         FtcHJ6b5161XxVMSOQQWSq2B8YNb92Ll04ZsM+b40WGo+z6nH9YRNjFo1JHf8A9ulpjE
         Sk4qTQf9jU5kaUIZdLWTw3i4fsNBH77aeJKzDhvPzxpyFi3o6YP9j0Ebqp8d7te9KznO
         Ns/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kK0eYZi8oifTFTpm0EYAk1xaXlFVzS6cFt1buE80FCg=;
        b=YxaSL4jpIXLe4AOOcDSTItEUunHxLQnhPZip6W88xm+slF++7/gWQGoREqrsaTgFzq
         H4Ediw9cUcYntfHaHUzUhdgxrP15T9RQSkWrt98m28C1aE36x6pkydYowUj4xZzO00v0
         tL6vg2rlBn+DXnEBOYIU1HF7Pu15I8mMDV8/JQn/WmD14vYThqMr2sftxdLSe65KxFB1
         ChewIxUTbaWiOxWbOR/4XeIoAB0c3yxswra5lXzWg7TtNtcvDp8P4pNS1Abpu5lNJ9wu
         1/VVGjnpvdiANyTmI444qHKJ9BDL4FHToEyuuwkG0Uz69dEC/x8bmKpYAh/DZg27KqEs
         rQnA==
X-Gm-Message-State: ANhLgQ2Ty1zlNFFpRceWYwOSZTUbEuxrjYR1hXxShdJCCdlw5qFiMz8N
        tJ9ZzcsU93lBfTVdOENTaVQOg++W
X-Google-Smtp-Source: ADFU+vuh58W8BcRwScxiOOJdzYp95/SVwnseKOCZ693WEF/md1XpUknVUZQH6gJofOfc7WD/JC/HIQ==
X-Received: by 2002:adf:9cca:: with SMTP id h10mr14795983wre.167.1585315320268;
        Fri, 27 Mar 2020 06:22:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s131sm8029830wmf.35.2020.03.27.06.21.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 06:21:59 -0700 (PDT)
Date:   Fri, 27 Mar 2020 13:21:58 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/page_alloc.c: leverage compiler to zero out
 used_mask
Message-ID: <20200327132158.fmnalzjucwt7jk32@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200326222445.18781-1-richard.weiyang@gmail.com>
 <d712ce2d-78a9-afcc-64d4-1102638f2fc0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d712ce2d-78a9-afcc-64d4-1102638f2fc0@redhat.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 10:32:45AM +0100, David Hildenbrand wrote:
>On 26.03.20 23:24, Wei Yang wrote:
>> Since we always clear used_mask before getting node order, we can
>> leverage compiler to do this instead of at run time.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>  mm/page_alloc.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 0e823bca3f2f..2144b6ceb119 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5587,14 +5587,13 @@ static void build_zonelists(pg_data_t *pgdat)
>>  {
>>  	static int node_order[MAX_NUMNODES];
>>  	int node, load, nr_nodes = 0;
>> -	nodemask_t used_mask;
>> +	nodemask_t used_mask = {.bits = {0}};
>>  	int local_node, prev_node;
>>  
>>  	/* NUMA-aware ordering of nodes */
>>  	local_node = pgdat->node_id;
>>  	load = nr_online_nodes;
>>  	prev_node = local_node;
>> -	nodes_clear(used_mask);
>>  
>>  	memset(node_order, 0, sizeof(node_order));
>>  	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
>> 
>
>t480s: ~/git/linux default_online_type $ git grep "nodemask_t " | grep "="
>arch/x86/mm/numa.c:     nodemask_t reserved_nodemask = NODE_MASK_NONE;
>arch/x86/mm/numa_emulation.c:   nodemask_t physnode_mask = numa_nodes_parsed;
>arch/x86/mm/numa_emulation.c:   nodemask_t physnode_mask = numa_nodes_parsed;
>arch/x86/mm/numa_emulation.c:           nodemask_t physnode_mask = numa_nodes_parsed;
>drivers/acpi/numa/srat.c:static nodemask_t nodes_found_map = NODE_MASK_NONE;
>kernel/irq/affinity.c:  nodemask_t nodemsk = NODE_MASK_NONE;
>kernel/sched/fair.c:            nodemask_t max_group = NODE_MASK_NONE;
>mm/memory_hotplug.c:    nodemask_t nmask = node_states[N_MEMORY];
>mm/mempolicy.c:         nodemask_t mems = cpuset_mems_allowed(current);
>mm/mempolicy.c: nodemask_t nodes = NODE_MASK_NONE;
>mm/oom_kill.c:  const nodemask_t *mask = oc->nodemask;
>mm/page_alloc.c:nodemask_t node_states[NR_NODE_STATES] __read_mostly = {
>mm/page_alloc.c:        nodemask_t saved_node_state = node_states[N_MEMORY];
>
>Should this be NODE_MASK_NONE?

Thanks, this is gcc extension. Learn something new.

I would update this in v2.

>
>-- 
>Thanks,
>
>David / dhildenb

-- 
Wei Yang
Help you, Help me
