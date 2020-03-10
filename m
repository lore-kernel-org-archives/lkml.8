Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2BCC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB53E21D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583862144;
	bh=bvoBIugNpuDJBZzzjGNYuLl0Hz/BR+jEH71T4YVoZwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VYnNACPWcJQC4KlIssOV2HXyLQkWZKO/0gjfBgu6JbShOjofjSKUmqMti2wQz5bCJ
	 fhbkTl4JEJErkkkjH92U9MzKAM4Wp3kUZdXmL2DUKpIb4DAvOVzr5j9WYvLg7G6CcE
	 1G3jaNJiGsavheFb106g0Q610z0hYF7g31o5TXak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgCJRmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:42:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51792 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJRmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:42:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id a132so2387165wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k2TPWmwJ3LuGZV9degtM5H3I2TZ2CPy5p7AlAPeRGQE=;
        b=W93Bg46Fb9qIpdOV+LxzBmqm/qyGH2vDt8DwdjKis/6NfnL7sl+cG4W2Yx++/YeqyI
         QLf2FG4pmtv0IDKiaxfKYhXgewVLMuyUJ+6BCczxNGd54RIjPPD5Qz/XkW/w4Rv0CzoR
         CZOFI0zd6Oqx8qMVgUin3ZN+UoVDfk4vr2YB9N1nSxdH5pxCBJg8aPDj8LOtzdEoraQB
         tXfJN/hGxvPE3nCaGiwn0Y2SKJZOV/TmogVZcwwtesO7Lf5CLA3FEwKPxo7p5m8Dq2SN
         fsb+PAB2JkM2LcUjd5ixUsKJBibRh6TM2Tplw7M93Ds+wJP9P0lghvj8DDL+5srUw0Ig
         zEQA==
X-Gm-Message-State: ANhLgQ3ikvlFB88PQzvUY7MqrOvJZph2NqC0QSaj3OHrYivvEUv1Gell
        waq9k6Y1BwUibXSzbFwGOuU=
X-Google-Smtp-Source: ADFU+vuvv2lxXdtAYfZdMNvZ2GO3kBSkzQ+7+qf18vTcO8YHUI6ebiZmsHgrY2OR2MqwT2yVJIKF5w==
X-Received: by 2002:a1c:b657:: with SMTP id g84mr3165060wmf.107.1583862141358;
        Tue, 10 Mar 2020 10:42:21 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id c2sm5068246wma.39.2020.03.10.10.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 10:42:20 -0700 (PDT)
Date:   Tue, 10 Mar 2020 18:42:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310174219.GY8447@dhcp22.suse.cz>
References: <20200310002524.2291595-1-guro@fb.com>
 <20200310084544.GY8447@dhcp22.suse.cz>
 <ce96c9e9-1082-df68-010e-b759d2ede69a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce96c9e9-1082-df68-010e-b759d2ede69a@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 10:38:24, Mike Kravetz wrote:
> On 3/10/20 1:45 AM, Michal Hocko wrote:
> > On Mon 09-03-20 17:25:24, Roman Gushchin wrote:
> <snip>
> >> +early_param("hugetlb_cma", cmdline_parse_hugetlb_cma);
> >> +
> >> +void __init hugetlb_cma_reserve(void)
> >> +{
> >> +	unsigned long totalpages = 0;
> >> +	unsigned long start_pfn, end_pfn;
> >> +	phys_addr_t size;
> >> +	int nid, i, res;
> >> +
> >> +	if (!hugetlb_cma_size && !hugetlb_cma_percent)
> >> +		return;
> >> +
> >> +	if (hugetlb_cma_percent) {
> >> +		for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn,
> >> +				       NULL)
> >> +			totalpages += end_pfn - start_pfn;
> >> +
> >> +		size = PAGE_SIZE * (hugetlb_cma_percent * 100 * totalpages) /
> >> +			10000UL;
> >> +	} else {
> >> +		size = hugetlb_cma_size;
> >> +	}
> >> +
> >> +	pr_info("hugetlb_cma: reserve %llu, %llu per node\n", size,
> >> +		size / nr_online_nodes);
> >> +
> >> +	size /= nr_online_nodes;
> >> +
> >> +	for_each_node_state(nid, N_ONLINE) {
> >> +		unsigned long min_pfn = 0, max_pfn = 0;
> >> +
> >> +		for_each_mem_pfn_range(i, nid, &start_pfn, &end_pfn, NULL) {
> >> +			if (!min_pfn)
> >> +				min_pfn = start_pfn;
> >> +			max_pfn = end_pfn;
> >> +		}
> > 
> > Do you want to compare the range to the size? But besides that, I
> > believe this really needs to be much more careful. I believe you do not
> > want to eat a considerable part of the kernel memory because the
> > resulting configuration will really struggle (yeah all the low mem/high
> > mem problems all over again).
> 
> Will it struggle any worse than if the we allocated the same amount of memory
> for gigantic pages as is done today?  Of course, sys admins may think reserving
> memory for CMA is better than pre-allocating and end up reserving a greater
> amount.

Yes the later is my main concern. It requires to have a deep MM
understanding to realize what the lowmem problem is. Even though who
might be familiar consider it 32b relict of the past. I have seen that
several times wrt. unproportional ZONE_MOVABLE sizing already.

-- 
Michal Hocko
SUSE Labs
