Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D128EC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A46206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u89NMh1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgC1A0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:26:21 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35617 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgC1A0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:26:21 -0400
Received: by mail-wr1-f67.google.com with SMTP id d5so13953242wrn.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 17:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o34z7NV9hLhlnbHsIbZ5TkmJUG3sU9ivdCVdSN9yfiw=;
        b=u89NMh1ACxIa7THDFh2QEdGWWv/ReIu4L4xooWDijmg+kY6Ufvwqve4POMnMMMhstd
         p8p9N/H0qK+EomSqkcsCrcc5ixTRqVPTMWdZEacxGu7jPQjhXnTd2UhxBI0AutporTHI
         rE3TbZbJ0aCGgcIlnFORqdH3XsZUQpu9VUuSZ5lanCi4Bx8V1zgH1Lf3jjXgltkufJ/J
         py4FBX9u1BDACzJdtLCqac5uZLIISY4NAK/TIKeX0H72CE5Xe60o0a3MBUbLWbQ23NyN
         hpytQzQSMtBAqt2i4j7nMezWvWwABluHCwJ6fPkWMaoejvxPyTn+5fbBe56JT1l91zTG
         bJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=o34z7NV9hLhlnbHsIbZ5TkmJUG3sU9ivdCVdSN9yfiw=;
        b=H2P7KO3hz/ANVhxvbjiEplp0C57GDosuIxLHJ3VgE7ih6a3OyxnzuJMikYpQHh+EmR
         OGkTWooU7/f593tZ+lHW+ZD6rqkE6pv2FTFwBCqXP7JUDFqvB1Vd6tEqk6P6bQsSx5bJ
         3geKKgNWrJkY4ZF+0TzIURzYBdQMWzzA3PfF/38wj0R05Vbt1WJ7HBznflDQLIR1w+Le
         4DKxRP63T+gHy+StGIBM6NUUd4q7fsM2WRT3KwxuApUskM+S3oxKS95cNwmrmheL1QHB
         uw19cdCEDkR76m05izRyIvm5fy5PbhnygtXtrzZ3UB04OJ+kKU36EZC+ZiwQbgFh7ggt
         I1wg==
X-Gm-Message-State: ANhLgQ37DvyUsXPcz6ogLBpehEmHCaoPGizJiY1QQy2owWpM8hI+vUYT
        jsMOLTts1II+aff5Zn3YR28=
X-Google-Smtp-Source: ADFU+vsNAURVsNTvCfnn3ERfF0eMVyH3ZDYFdxGFYHDbiNO4vgn0qMkASHLy6F1zaGRi3RvCXSbghA==
X-Received: by 2002:adf:f892:: with SMTP id u18mr2063766wrp.367.1585355179041;
        Fri, 27 Mar 2020 17:26:19 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u8sm9977687wrn.69.2020.03.27.17.26.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Mar 2020 17:26:18 -0700 (PDT)
Date:   Sat, 28 Mar 2020 00:26:16 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Message-ID: <20200328002616.kjtf7dpkqbugyzi2@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 03:37:57PM -0700, John Hubbard wrote:
>On 3/27/20 3:01 PM, Wei Yang wrote:
>> Since we always clear node_order before getting it, we can leverage
>> compiler to do this instead of at run time.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> ---
>>   mm/page_alloc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index dfcf2682ed40..49dd1f25c000 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
>>   static void build_zonelists(pg_data_t *pgdat)
>>   {
>> -	static int node_order[MAX_NUMNODES];
>> +	static int node_order[MAX_NUMNODES] = {0};
>
>
>Looks wrong: now the single instance of node_order is initialized just once by
>the compiler. And that means that only the first caller of this function
>gets a zeroed node_order array...
>

What a shame on me. You are right, I miss the static word. 

Well, then I am curious about why we want to define it as static. Each time we
call this function, node_order would be set to 0 and find_next_best_node()
would sort a proper value into it. I don't see the reason to reserve it in a
global area and be used next time.

My suggestion is to remove the static and define it {0} instead of memset
every time. Is my understanding correct here?

>
>>   	int node, load, nr_nodes = 0;
>>   	nodemask_t used_mask = NODE_MASK_NONE;
>>   	int local_node, prev_node;
>> @@ -5595,7 +5595,6 @@ static void build_zonelists(pg_data_t *pgdat)
>>   	load = nr_online_nodes;
>>   	prev_node = local_node;
>> -	memset(node_order, 0, sizeof(node_order));
>
>...and all subsequent callers are left with whatever debris is remaining in
>node_order. So this is not good.
>
>The reason that memset() was used here, is that there aren't many other ways
>to get node_order zeroed, given that it is a statically defined variable.
>
>
>>   	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
>>   		/*
>>   		 * We don't want to pressure a particular node.
>> 
>
>
>
>thanks,
>-- 
>John Hubbard
>NVIDIA

-- 
Wei Yang
Help you, Help me
