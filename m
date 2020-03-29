Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49943C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 06:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D59C2073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 06:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0R79Ks/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgC2GJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 02:09:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34133 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgC2GJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 02:09:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so13309566wmk.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 23:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sSBFqFqeLi5UrtTZms8DyoR4KUJQlM9WmD2LlDYyybg=;
        b=X0R79Ks//Mf9JdUYGG/kK+i7IUBwqVVl0s/KJD69upi5amQxDdqpATosNhfaPA7CAH
         vHiZGDQw0hK00+oJUVDWWcOPnb3zNp8QW+lipA1q2F33cRQCnvdShc/0275jreNFlz74
         4vmpmk9W9fHvImaYag5mcsVpcdhcNEOxW2r9jLGYLKnm5DRyu9evkjyrPqyImhr/zjIs
         glLEsa0wbklp4eiDM6U3hPyaOeGNqzIyNEiG6fLzakhOYh7OsN+b+8U/cwxmJzzhDBt6
         i2/5Y5uCQE8eYSTRzfUuVOrFrIV0MhmSX1a0Sbx4rpRFb9DLFN5MslBd8Fh90zXElgZ4
         EfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sSBFqFqeLi5UrtTZms8DyoR4KUJQlM9WmD2LlDYyybg=;
        b=nGMmpLr+0JKewRml6al6Ap7zTLetk3QYL4fqUeexQxp0v7pDZ2VIQHwCGH1PwWl6sw
         3V6fny9VSE139KOjZxZeWeAwQrUEeiJjivQTxsOvVdEsYYJgk8j25Fs5FJPBXlZ9juBK
         IiEEiRg5oZuz/+E56EGElxPM0BQ1GxrceIXzX99TM+5fO9dbv5jOizTIh/EFmrHDHMQO
         MxTQEbePYN+a7uwMJxbwFLGWB+93ppMuacfFvi+rJHcHVSYwnnOjlNRSAmeqMJXAGuNc
         KF2qIG2faVLUPUPDoYld4QwDuJDdaFdyvsr6hISMJWi2Prqpf8CVgZeS9sOMjTXEpyVd
         1Dog==
X-Gm-Message-State: ANhLgQ2RBTETgil2XPN0UMi9sJMXzzZn54YdFbJ/onxBhC1rXiX2dX56
        yah7Ed8/fx6WYylRU6ogiDk=
X-Google-Smtp-Source: ADFU+vuanW/KtzDitf1G5wfZcPMN4YmyjO3oRkzczD1sBe3hSNZrDy2JGWqyxCLNrsAXrvLMITInBQ==
X-Received: by 2002:a1c:7216:: with SMTP id n22mr6851879wmc.41.1585462146935;
        Sat, 28 Mar 2020 23:09:06 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id l64sm15482724wmf.30.2020.03.28.23.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Mar 2020 23:09:06 -0700 (PDT)
Date:   Sun, 29 Mar 2020 06:09:05 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com, bhe@redhat.com
Subject: Re: [Patch v3] mm/page_alloc.c: use NODE_MASK_NONE define used_mask
Message-ID: <20200329060905.ha3la3jjy3woizds@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200329024217.5199-1-richard.weiyang@gmail.com>
 <8d6a1cd3-75cf-78c3-b83b-c5208a209f65@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6a1cd3-75cf-78c3-b83b-c5208a209f65@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 09:00:26PM -0700, John Hubbard wrote:
>On 3/28/20 7:42 PM, Wei Yang wrote:
>> For all 0 nodemask_t, we have already define macro NODE_MASK_NONE.
>> Leverage this to define an all clear nodemask.
>
>It would be a little clearer if you used wording more like this:
>
>Subject: [Patch v3] mm/page_alloc.c: use NODE_MASK_NONE in build_zonelists()
>
>Slightly simplify the code by initializing user_mask with
>NODE_MASK_NONE, instead of later calling nodes_clear(). This saves
>a line of code.
>

Thanks, the wording is better.

>
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>> 
>> ---
>> v3: adjust the commit log a little
>> v2: use NODE_MASK_NONE as suggested by David Hildenbrand
>> ---
>>   mm/page_alloc.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index ef790dfad6aa..dfcf2682ed40 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -5587,14 +5587,13 @@ static void build_zonelists(pg_data_t *pgdat)
>>   {
>>   	static int node_order[MAX_NUMNODES];
>>   	int node, load, nr_nodes = 0;
>> -	nodemask_t used_mask;
>> +	nodemask_t used_mask = NODE_MASK_NONE;
>>   	int local_node, prev_node;
>>   	/* NUMA-aware ordering of nodes */
>>   	local_node = pgdat->node_id;
>>   	load = nr_online_nodes;
>>   	prev_node = local_node;
>> -	nodes_clear(used_mask);
>>   	memset(node_order, 0, sizeof(node_order));
>>   	while ((node = find_next_best_node(local_node, &used_mask)) >= 0) {
>> 
>
>Honestly, I don't think it's really worth doing a patch for this, but
>there's nothing wrong with the diff, so:
>
>Reviewed-by: John Hubbard <jhubbard@nvidia.com>
>

Thanks.

>
>thanks,
>-- 
>John Hubbard
>NVIDIA

-- 
Wei Yang
Help you, Help me
