Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A144C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C5820679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ynm27Tfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgCPQRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:17:17 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:36301 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731993AbgCPQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:17:16 -0400
Received: by mail-qt1-f176.google.com with SMTP id m33so14680089qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0n3SIaDpi5LQqX+o3orVS785fReSy2zpbwRqWh4oqjg=;
        b=ynm27TfrRyKHAdDFIldkhG7zJ/MQQzoo7CW9RUu1IRwZZKTY1YJLX/RF5sj0k8BO4c
         rxPZWouCgToBlOFDFH4B3uK//Gwb0sXote7N713pA1rQzs44kdkNM2oalwGihI8WTN9y
         GHJw++6mIfIwrkX5gmwAe6KsnpqHQOBCQeClbzUUm08mJM9YGGMNmdNbL8y+thQolOS3
         yZJ41oZGobwR9U86gk2hdjfYlv4770HZRYJTv38pVhbMojBmeO3AeexZpgTw5b3sgXwb
         Mu48kDivG9+LnvAqK7LDJKcEdj/nOOwXijYzvPAzNIbKNa5+zDJt275V1LtwHNg0AwUj
         v/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0n3SIaDpi5LQqX+o3orVS785fReSy2zpbwRqWh4oqjg=;
        b=I7dz7Slqkcgm7Bs/Zw8tdU2pqDNYtdUl9A2MVKOVm3hMKNJHa0kz+SATH/CAsw21sv
         PSiFNmVl1CSIO5foD41tf2PTopuGzlT+nXbNpLU0XjsMUvT1dtViVevXlyTmQnTuN6oV
         7L3fPlGdrdT/HO+REZUtdMTh93ZiMPo0Qi4TskPajwOGqbqefyxJmjLvj9Y96ksb5J6z
         Zk6DrOnl2a4iKX62tPw9C2afxbmkMgb8Jbj4iA/VFe1C8ohj66y2q0rwJqNUWTGJJCHA
         Or2jVixnja1sF3bd6Pr7ocHhynYUfu/LBG5isCz7RDpw04S1eUqCxlmjwIJkgITGC9Tp
         jbTg==
X-Gm-Message-State: ANhLgQ2Pcz1DBarHfq18/56Txs0ew/48DimAeypTNi4wuIe2P77CqQqy
        1adZYvOIQFqJw9Z2ahSg3bjp6Q==
X-Google-Smtp-Source: ADFU+vt032PPmh975UT1PwegSeKaA58S8zk7+EcNr5p80dx0htNQY3KSgKW9kDPPZkVlLaMDgiijEg==
X-Received: by 2002:ac8:6b95:: with SMTP id z21mr860291qts.358.1584375435596;
        Mon, 16 Mar 2020 09:17:15 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x9sm121128qtk.7.2020.03.16.09.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 09:17:14 -0700 (PDT)
Date:   Mon, 16 Mar 2020 12:17:13 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH -V2] mm: Code cleanup for MADV_FREE
Message-ID: <20200316161713.GD67986@cmpxchg.org>
References: <20200316063740.2542014-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316063740.2542014-1-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:37:40PM +0800, Huang, Ying wrote:
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
> Suggested-and-acked-by: David Rientjes <rientjes@google.com>
> Acked-by: Michal Hocko <mhocko@kernel.org>
> Acked-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Rik van Riel <riel@surriel.com>

Thanks, this is definitely an improvement.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
