Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95ADFC4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6603520663
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZQzsGh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCMVna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:43:30 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38882 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgCMVna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:43:30 -0400
Received: by mail-pf1-f193.google.com with SMTP id z5so6056677pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SDNw5CeBEFA5vbuaWYRsJmiXk2Vn4f6I+fsRzDcDF5g=;
        b=pZQzsGh/c0WrWAiFM9UAZpHX38gUmWFqs+L7VOKADQYFP48cNV+2N6hSyfbbG/Pu4d
         twp6A7jNVhERqTTJ5pgz2tD8/ylTHXn0BFaHcWdrXF5ujuaE7tPCBLOgalpYgJL+gfvW
         p3BI9lLFF9I+Oy0T0+Tp10+CMuyBhahaFaQf56dY/SR40lJpiEBWd5cY4bFb7vHrn/MD
         Sw4ITSVRVoaM5PjQy6dJFJM7lxGDnV70uR3dqGKxi4v3ymoKHZo+c4PG+KVRruM8knLX
         0Oz11Iq5/r4VcNXn0UFD6Ot+Bc8Jhpgk3FXSPFEEJ6o6Sjz5EHKbByKLqdRQICCh6mxc
         1QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SDNw5CeBEFA5vbuaWYRsJmiXk2Vn4f6I+fsRzDcDF5g=;
        b=owL4vWLEqjARx/4lMFRF0msVrfpBrukxA4KI4DQDhaFsgZb7B6NkNy/k+VPilHk7J0
         yKZfbjUg1MgvI0m0YEwryrb+B4HOdy0quTkwRY7dqrIhAfd0N/2dzrYR1IgJ+93qBkLx
         eDKbmZbmM8+9hTYuMMfW49cDheEncTBhDxapEWDi8wr7VHM6t+5bnLRjg9kqZ2YBOaYI
         acteTSljA9wS/3OulCmXRLlULedRThUQBDwrd33KYW7nGptyob3X/U7FIrcyI9AnncUI
         JYXAthEwaieH03nfziHzUEWZL4gZEuEj70rSMU5P1UbdjA/llh/mwhwJiFtSZdENYUmf
         sIPQ==
X-Gm-Message-State: ANhLgQ1YsGpUWHjGTh87DVPd7IDymV8i1hIBCLgVXaQ11Er34Q5fOFNh
        0VWbXUnzf3LgKc5PM+aRlQneZbP7oM0=
X-Google-Smtp-Source: ADFU+vs5HCuqq1xKRwirD0WhYDOW1scUjscD0l2RCmUOOn5TDpACKWyibD3zz0dfth/WUYXLVX/n7g==
X-Received: by 2002:a62:7c15:: with SMTP id x21mr16494914pfc.132.1584135807311;
        Fri, 13 Mar 2020 14:43:27 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z17sm11256310pff.12.2020.03.13.14.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 14:43:26 -0700 (PDT)
Date:   Fri, 13 Mar 2020 14:43:26 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm: Code cleanup for MADV_FREE
In-Reply-To: <20200313090056.2104105-1-ying.huang@intel.com>
Message-ID: <alpine.DEB.2.21.2003131443030.242651@chino.kir.corp.google.com>
References: <20200313090056.2104105-1-ying.huang@intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020, Huang, Ying wrote:

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

Acked-by: David Rientjes <rientjes@google.com>

Thanks very much for following through with this Ying!
