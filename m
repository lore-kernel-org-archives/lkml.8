Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5284AC3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23CD720709
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 20:41:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B3cs7k1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgCFUlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 15:41:36 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:40559 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCFUlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 15:41:35 -0500
Received: by mail-pj1-f48.google.com with SMTP id gv19so1575878pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 12:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=yKGKapuUKILEkemnrbPssWUGiqebVX3yxGAYmrDS0Sg=;
        b=B3cs7k1/pc/ZT6R0YkOqeR/COPust1J58A0q4JvjPIJmnA5mqdan1WT3Oi+jBKHIZj
         F5Mwj0aJKIc30RjRue2vWDtOFkFsGuoRcTyGv5/NcKRndUsykBSqfjCDdzhUWQUpW6c2
         RwGw2xSl+y0hVTPcJ11srTPOSOOmoJpWvLgEk9gkpz+m4VwSpI/FGW3eEIQPWyJdhUGR
         vBwn/KLTBojdpHoTufUudUxq6zr0bLih2tquszsygTjbcA91HPkJ10WH4tYrDTcM5Dzw
         vtAzWaWenEZcU3NrBiYCNeE+Hkrdo2Egh1Zfx7L/41inETAYdEXr3TCWRlCyfihyRpai
         qTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=yKGKapuUKILEkemnrbPssWUGiqebVX3yxGAYmrDS0Sg=;
        b=JaWJ17PCUvYtdiA51/jfELnjPNYCaPd2fJ3SZjcsxES7ILu/zVNmlXlPDpGUSjO0eR
         t3nCcOOwesgRdaKQmNMNEYbU2Q0/ixHK6uXHwe/7UW1rXNs/mgTHjWBH0LkGvl+ugJHj
         6oDai2ivKFyoVRnJSowWx3Nr8VLKvyx8kcRIy0TKGrtPl29btIYd0Svp7mZ836+vloGr
         Fv8Cu+djFmAdBe9Ww6Kg4yc7E1Lfbj3eK/OW30ycWt+XwTeqhMDVrPZ8pmFgvfiNjlW3
         FFWFCTpqzwu70I3rmDJ0rqgIfQoGA3BM3khMvxmPK3oZhnVypzAgJ/YaXcaMsmsO0HTc
         BmeQ==
X-Gm-Message-State: ANhLgQ356kuDFKFPIHdr0YrAsZnQso72nqzcOu4ATFrzq7cunFbcmrkG
        BtAFCD/jA48hxOW6L+8C014DSg==
X-Google-Smtp-Source: ADFU+vuBtlgASi4ldRcAREIzD+j0WNer4alYi/qGIzeiUCbMBirI9Tn1xqYZVv+jcSitQSUy/qcOig==
X-Received: by 2002:a17:90a:608:: with SMTP id j8mr5243607pjj.85.1583527294240;
        Fri, 06 Mar 2020 12:41:34 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m9sm3252334pga.92.2020.03.06.12.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 12:41:33 -0800 (PST)
Date:   Fri, 6 Mar 2020 12:41:32 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Huang, Ying" <ying.huang@intel.com>
cc:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V2] mm: Add PageLayzyFree() helper functions for
 MADV_FREE
In-Reply-To: <87y2sf1ki1.fsf@yhuang-dev.intel.com>
Message-ID: <alpine.DEB.2.21.2003061240480.181741@chino.kir.corp.google.com>
References: <20200304081732.563536-1-ying.huang@intel.com> <d7dcb472-76fa-9d8b-513a-793a7ab8580d@redhat.com> <87y2sf1ki1.fsf@yhuang-dev.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Mar 2020, Huang, Ying wrote:

> > In general, I don't think this patch really improves the situation ...
> > it's only a handful of places where this change slightly makes the code
> > easier to understand. And there, only slightly ... I'd prefer better
> > comments instead (e.g., in PageAnon()), documenting what it means for a
> > anon page to either have PageSwapBacked() set or not.
> 
> Personally, I still prefer the better named functions than the comments
> here and there.  But I can understand that people may have different
> flavor.
> 

Maybe add a comment to page-flags.h referring to what PageSwapBacked 
indicates when PageAnon is true?
