Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F234FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD23C2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583223574;
	bh=TbDW2j/Tj/CSOGhYw85vBh91rtzcIgojV4rBABh5ZdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJoVbazMNwsfTuXWxAI4vE2iQHS4W+VLYNpXHKrTHMZOGKeBi5HHz4ONmTGvQ4l9L
	 jr6vaGfGzqHTyYDrQPo1rbOcqPp5aV1J38lKzgN8rZF6n++BWxtXeGq7wQPBIiT179
	 tcPTlR+jCXps9y9PPKXoROjPHoMu9jj5/0BlKfzA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbgCCITd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:19:33 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41305 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbgCCITd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:19:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id v4so3126640wrs.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:19:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z04jPTegah1x+XyJrZIvWmznvuMyEVD5pNJ2ECVbFc8=;
        b=pAZhCfXJG2hgdKVvydCqct1cnlI81ChQobPPOLTFM+TV2jwjlo9iPZHbLEh+mkNKVm
         ZnAZWCRD5iwc2IzUV9wmiPnW/hHCaqp4Abf5fiYLrVHdiXSdbjBXVgyzUQVG8c8Kg1i6
         tvGaicyRi+uyB1BQgR2vBU1GF/HxvA1QXxFQhDZtS1hUZUuiWbXgda6Ta1gA2YWPl5FY
         aGUOtAsu4O5nxm5Xr4Bb5biec6lLpMb4WPzCvyI4HN3jGVNfRpX9le859OO5BMFE28Pq
         vxGKKUAV4wlOEoqQkYZs900gT8LAbSAx2SJaNkpj1eO6562SdFDy1uKkVNz4LsSfyh3K
         5iqA==
X-Gm-Message-State: ANhLgQ3PfprzNlpLzu/ZKTfIC7Ys2ZCpdsGGeWwskoxbbdBfxuJOwr9/
        dLLsNl001CKMEGAanrPdQiE=
X-Google-Smtp-Source: ADFU+vv6QbXmtXGG61XzfcFiKGH/M/nZOVa7e43A2+0bzNzWl0PZIWEdoP3t7WXQKHJWXHOegxU+EA==
X-Received: by 2002:a5d:4d8c:: with SMTP id b12mr4172049wru.253.1583223571141;
        Tue, 03 Mar 2020 00:19:31 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id k16sm33014397wrd.17.2020.03.03.00.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 00:19:30 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:19:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200303081929.GY4380@dhcp22.suse.cz>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228034248.GE29971@bombadil.infradead.org>
 <87a7538977.fsf@yhuang-dev.intel.com>
 <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
 <871rqf850z.fsf@yhuang-dev.intel.com>
 <20200228095048.GK3771@dhcp22.suse.cz>
 <87d09u7sm2.fsf@yhuang-dev.intel.com>
 <20200302142549.GO4380@dhcp22.suse.cz>
 <874kv66x8r.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874kv66x8r.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-03-20 09:30:28, Huang, Ying wrote:
[...]
> Yes.  mmap() can control whether to populate the underlying physical
> pages.

right because many usecases benefit from it. They simply know that the
mapping will be used completely and it is worth saving overhead for #PF.
See. there is a clear justification for that policy.

> But for migrating MADV_FREE pages, there's no control, all pages
> will be populated again always by default.  Maybe we should avoid to do
> that in some situations too.

Now let's have a look here. It is the userspace that decided to mark
MADV_FREE pages. It is under its full control which pages are to be
freed lazily. If the userspace wants to move those pages then it is
likely aware they have been MADV_FREE, right? If the userspace wanted to
save migration overhead then it could either chose to not migrate those
pages or simply unmap them right away. So in the end we are talking
about saving munmap/MAMDV_DONTNEED or potentially more move_pages calls
to skip over MADV_FREE holes. Which is all nice but is there any
userspace that really does care? Because this is a fundamental question
here and it doesn't make much sense to discuss this left to right unless
this is clear.
-- 
Michal Hocko
SUSE Labs
