Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E97C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10B52087E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588162196;
	bh=0tg0jeJk3OJvBfPB90oChQqprhwQvLMyVybYsSJoKIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l2QArZqylCzNJ14tyKjLzdwi4WhnbPZADaV4Y4t1eNwifVlwd7UyYGMt6FEoHPOQl
	 voQNAYkZjLrTm9K1BrETRPWO0I4CIRxCDI98ocjX83b5iLhviAaDDHTV/4Xka2FPm3
	 WPqzwJyFbdYBllG04962jGca6HFUhh4XS51M0PCY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgD2MJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:09:56 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56082 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbgD2MJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:09:55 -0400
Received: by mail-wm1-f67.google.com with SMTP id e26so1744629wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0KFJsuweAsy2po8J04xM3JEaLOIdNb8hu1GHvhSVb/U=;
        b=az7eWWmfWb2qqJdEIlfnNGIc9I09x00rYN90fY4twD1NObfJTZDyCl2JEceqfzEhet
         wCQBHXxiX5D0mVqFz5TrGTH/Vfq/umFlJ22Y63k5PpHE92nw9qEoak5C1upyFMvllhvi
         XJNzVn6AV3z3n2LSt+0bUuLHlQkNbkK2nq8Fs2bdXeEcTzdb+/JBbkTgN0c0NRUGmCL/
         QOF7hRrjS3UGZIVRo0hoi0RAxV+R7KmEk4sU2Fsa8yEWfRO1ww+vJEYV74S/yzyptVbh
         cu1p5xyx8JUMxb0pDcA6jA5LL0O2/5XtRAVrivfdPW5KHW2UVGN6H6EwW3+WceHRBSSm
         32rA==
X-Gm-Message-State: AGi0Puay/1sveXlBo143hucGH7kgJLLF8gboK0B+4TOhDdYyb6TfFDvH
        ZehcR1hZ1vlhz7IzEiY4U4s=
X-Google-Smtp-Source: APiQypKmAnDJcnzt1C2af24ekvd9u/E7junmh2qliw3xx+9V/UpmGC9xbL7/FuC1yhAiswiD7ohNQQ==
X-Received: by 2002:a7b:c4d1:: with SMTP id g17mr2920096wmk.158.1588162193667;
        Wed, 29 Apr 2020 05:09:53 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id h6sm7373995wmf.31.2020.04.29.05.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 05:09:52 -0700 (PDT)
Date:   Wed, 29 Apr 2020 14:09:51 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Maninder Singh <maninder1.s@samsung.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, a.sahrawat@samsung.com,
        v.narang@samsung.com
Subject: Re: [PATCH 1/1] mm/vmscan.c: change prototype for shrink_page_list
Message-ID: <20200429120951.GC28637@dhcp22.suse.cz>
References: <CGME20200429055946epcas5p2d5faf2b320913d59a4a8380cb017053c@epcas5p2.samsung.com>
 <1588139967-19012-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588139967-19012-1-git-send-email-maninder1.s@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 29-04-20 11:29:27, Maninder Singh wrote:
> 'commit 3c710c1ad11b ("mm, vmscan:
> extract shrink_page_list reclaim counters into a struct")'
> 
> changed data type for the function,
> so changing return type for funciton and its caller.
> 
> Signed-off-by: Vaneet Narang <v.narang@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Is there any reason to move declarations here?

> -unsigned long reclaim_clean_pages_from_list(struct zone *zone,
> +unsigned int reclaim_clean_pages_from_list(struct zone *zone,
>  					    struct list_head *page_list)
>  {
> +	unsigned int ret;
>  	struct scan_control sc = {
>  		.gfp_mask = GFP_KERNEL,
>  		.priority = DEF_PRIORITY,
>  		.may_unmap = 1,
>  	};
>  	struct reclaim_stat dummy_stat;
> -	unsigned long ret;
>  	struct page *page, *next;
>  	LIST_HEAD(clean_pages);
>  
> @@ -1900,13 +1900,13 @@ static int current_may_throttle(void)
>  {
>  	LIST_HEAD(page_list);
>  	unsigned long nr_scanned;
> -	unsigned long nr_reclaimed = 0;
>  	unsigned long nr_taken;
>  	struct reclaim_stat stat;
>  	int file = is_file_lru(lru);
>  	enum vm_event_item item;
>  	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>  	struct zone_reclaim_stat *reclaim_stat = &lruvec->reclaim_stat;
> +	unsigned int nr_reclaimed = 0;
>  	bool stalled = false;
>  
>  	while (unlikely(too_many_isolated(pgdat, file, sc))) {
> @@ -2096,7 +2096,7 @@ static void shrink_active_list(unsigned long nr_to_scan,
>  unsigned long reclaim_pages(struct list_head *page_list)
>  {
>  	int nid = NUMA_NO_NODE;
> -	unsigned long nr_reclaimed = 0;
> +	unsigned int nr_reclaimed = 0;
>  	LIST_HEAD(node_page_list);
>  	struct reclaim_stat dummy_stat;
>  	struct page *page;
> -- 
> 1.9.1

-- 
Michal Hocko
SUSE Labs
