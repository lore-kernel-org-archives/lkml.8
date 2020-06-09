Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332D7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 099F0207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591706632;
	bh=+gVx3wgcg7Sd3cQ0sMU6w7abwVymSVpRBRCTExi/xGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tq5NeRrrSYujgoLZa7kFdW2UtCB1OUsfDVgc6DSbvP7cYMJfEMEgFWykhi9cKMZhe
	 +7mXFWCK+dwUsY7QCV2d8TV3cQdOTGR3wgbWOXjHgaHA0Ul5rMpUe8bUWABVzpF8RA
	 O+2v7NIFHVvzH5ka/684wreJOosb5JDBIWVuH8Ck=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgFIMnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:43:50 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:35051 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgFIMnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:43:49 -0400
Received: by mail-ej1-f65.google.com with SMTP id y13so22208145eju.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 05:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t3GQNmWtf4ksIggwptv0txsHLVgsuiaz0p09us+yUC0=;
        b=VLKbjyYmXUhnirRmmILwmD/D7qCwWO1kEQC32a5ZixGYqmudDS7cKxQc2gjhXs0wC2
         n1hH7Ijd0vZreNNCRseFQginn4+J7BA/o9Wsg9dPpM5I6lsTyllZSAcqOr1DTrr/GCe3
         y728RjVnRmIyUuGNsHegpNqWEyjKvPsX1N9ROftzIUmRgTlHjWlhCkIjerWykdb6CoSF
         C3m7QGHcRX2vWI1hbluRRSYuZLbMtzHva1PR9He0Jy1nOpAagQD4ujqE8Oqg2vUss2ZK
         IHw9Qy5lFErgyiN+RyChXwrX5BKUpGV4jqN9DGk8JCOaW8GY+cwCuz+uLSSxO8llm2LO
         B3vg==
X-Gm-Message-State: AOAM533whjg0sxtn0Z6vT5k0iTOWbdQ9eM1yXJIfSaGIypysmdSiPY2M
        xIxlVz+0u4eFJWthryu2U28=
X-Google-Smtp-Source: ABdhPJzrhhabnTeUtVY91t7kfFr3pxKvQaWZW7X9nXWAtIKEyVK75iUHEyP3Zo7mM/2HyIVcn8BNOA==
X-Received: by 2002:a17:906:7c5a:: with SMTP id g26mr25499817ejp.200.1591706626955;
        Tue, 09 Jun 2020 05:43:46 -0700 (PDT)
Received: from localhost (ip-37-188-174-195.eurotel.cz. [37.188.174.195])
        by smtp.gmail.com with ESMTPSA id k23sm954411ejk.114.2020.06.09.05.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 05:43:45 -0700 (PDT)
Date:   Tue, 9 Jun 2020 14:43:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 01/12] mm/page_isolation: prefer the node of the
 source page
Message-ID: <20200609124344.GC22623@dhcp22.suse.cz>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590561903-13186-2-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-05-20 15:44:52, Joonsoo Kim wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> For locality, it's better to migrate the page to the same node
> rather than the node of the current caller's cpu.
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_isolation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 2c11a38..7df89bd 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -300,5 +300,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  
>  struct page *alloc_migrate_target(struct page *page, unsigned long private)
>  {
> -	return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
> +	int nid = page_to_nid(page);
> +
> +	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
>  }
> -- 
> 2.7.4

-- 
Michal Hocko
SUSE Labs
