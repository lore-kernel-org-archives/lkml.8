Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F8DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37504206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584114078;
	bh=Ph1NaOx4Fqn/IwIUZeEekNk/YXReej4IS77CjGALXW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=psQoc1EC8qaQ++7/FsENOFmCY/50lNfVTPfWZzEiKxw7Lehfolluut4hsM3fN+D6R
	 0Zao/w9dbCa50ee6bUoMrCLwggO1Tw4qqmwHw14VCN/B/vHVSXO9BPIKuSOmsSfJby
	 kB5cHewsq14bCNazQAzP0Qb5IrdPFo/huHxlPEaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCMPlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:41:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51239 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMPlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:41:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so10491692wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 08:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gkOpGqZ4HZ0Gczdmy8fRkS4oC/ZNHjgZPtF1KgbpwK8=;
        b=RlX3asRT/tnr6igLFmVaj3qmvuypOSE2YNCtWMs1+F7DI5I3BaP0aWk3zoR+Wr6lhw
         hzI2k+Yb2x5k4oA7xI4IozLzzeZmBLvET9PJjK+V0R18ebMeDnMv5Yi/i8ZxN69Nwk98
         GwUkGDvDCUlLihIvoptHwuZkGCd0LKFvQnLCT/7yh0PYWIe0VykwUSrXsaeLQWK5NzbK
         hT4VJ/xW3FvNIrVyxYKfqSHjT4wkho4l+L5QPSAr/tO8TtnjF8R1YjhJi4XByhOhYlSx
         ecEoxH6+3mMbUjnCA4yTCY9/otelrl+Xp1gTQ9ZbW7r+bute9xk1ElabtOKmhDlmWyEm
         ilzA==
X-Gm-Message-State: ANhLgQ1RImQBgEHvGbJe1o68un6x99syCY96EsUJ2Qz7sTXkwkZxQdDk
        HiBxvl66JVKGdRuQ82/zTA8=
X-Google-Smtp-Source: ADFU+vubCQz/pw1/gHUN38Gv+kKTeEXfXIKG6z5UA/SluUtT62FiwYYo+OtYH4Tq/5PNvVY33Ih1hg==
X-Received: by 2002:a7b:c456:: with SMTP id l22mr7278014wmi.184.1584114072890;
        Fri, 13 Mar 2020 08:41:12 -0700 (PDT)
Received: from localhost (ip-37-188-247-35.eurotel.cz. [37.188.247.35])
        by smtp.gmail.com with ESMTPSA id f15sm17298220wmj.25.2020.03.13.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 08:41:12 -0700 (PDT)
Date:   Fri, 13 Mar 2020 16:41:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        David Rientjes <rientjes@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm: Code cleanup for MADV_FREE
Message-ID: <20200313154110.GH21007@dhcp22.suse.cz>
References: <20200313090056.2104105-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313090056.2104105-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13-03-20 17:00:56, Huang, Ying wrote:
> From: Huang Ying <ying.huang@intel.com>
> 
> Some comments for MADV_FREE is revised and added to help people understand the
> MADV_FREE code, especially the page flag, PG_swapbacked.  This makes
> page_is_file_cache() isn't consistent with its comments.  So the function is
> renamed to page_is_file_lru() to make them consistent again.  All these are put
> in one patch as one logical change.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Suggested-by: David Rientjes <rientjes@google.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Rik van Riel <riel@surriel.com>

Acked-by: Michal Hocko <mhocko@suse.com>

Although I would rephrased this a bit
> + * PG_swapbacked is cleared if the page is page cache page backed by a regular
> + * file system or anonymous page lazily freed (e.g. via MADV_FREE).  It is set
> + * if the page is normal anonymous page, tmpfs or otherwise RAM or swap backed.
> + *

PG_swapbacked is set when a page uses swap as a backing storage. This
are usually PageAnon or shmem pages but please note that even anonymous
pages might lose their PG_swapbacked flag when they simply can be
dropped (e.g. as a result of MADV_FREE).
-- 
Michal Hocko
SUSE Labs
