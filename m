Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A15AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39C862078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 12:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591704217;
	bh=wS3HQy8ujofY6AgXsSXM0k2IJoMUpIYID9Kw+8jJcCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EzkqiXQOWbAn2BBffy2vfEcwDprqXb5zpOwW0STn7En7XkuUHfSoFdcF3mjxCRNTC
	 oqO7pSJQO3eh6AhYNkbm5lTmYdsc79jO9t6Fnj7Q4xdTuDifpkFPhvWj+YjezE6S8d
	 5Kc8qn2vE5IHeMsQnUEIVRDQ8Otel6yKKphLjdSQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgFIMDf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 08:03:35 -0400
Received: from mail-ej1-f67.google.com ([209.85.218.67]:36362 "EHLO
        mail-ej1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbgFIMDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 08:03:33 -0400
Received: by mail-ej1-f67.google.com with SMTP id dr13so2866997ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 05:03:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+o3Kw7ohvoYTBR2Cc3NZXYoBJAf9G4BYqcUbSQGVHaU=;
        b=s2AAUV3gE6Cj7UqDrkiC9cJneUnezRdoDDwjT39LlWDyOMxBS90zXFr515mFP7AQYU
         G4pavcIqb8xasJ7jS7csvlvdIodTkp9QeCq9ugIyQU5H4vR92PE+0bF7HhjxOaQfkPDH
         QaHa8w0a8pHgxr+2b1tHSXR1J7myn7o+Q/eJwA5lAwN2co37a3LE714FqXcQEeYyIPZi
         sIM5GLG39xpFyqHqyAiQC0Lxz+KJCQyI/2zOYLExZHR6/MwvKcXFlzqYgWfy06UgnaA/
         ex0vZXAlx+Zyq/zbxNThbmqS0Tp3E++Xb9qnGJUN5GQcc21O76qpSXoEbc9Fj2HSyREL
         wfbw==
X-Gm-Message-State: AOAM531C047eBvCGo72ccjEQIK9dvnhEOAwNo9bNyQjCtmVc+O7XiLmB
        Dcv921glrEm9UlEuuTDwO2pKmch+
X-Google-Smtp-Source: ABdhPJwS3q0o/7jYbGc660OIM9x94rWyHO98ZvPKLSqoXpPLHlI82UExrccENBznqIvXlrguvZ36/w==
X-Received: by 2002:a17:906:5e07:: with SMTP id n7mr2496670eju.48.1591704211892;
        Tue, 09 Jun 2020 05:03:31 -0700 (PDT)
Received: from localhost (ip-37-188-174-195.eurotel.cz. [37.188.174.195])
        by smtp.gmail.com with ESMTPSA id w13sm13442356eju.124.2020.06.09.05.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 05:03:30 -0700 (PDT)
Date:   Tue, 9 Jun 2020 14:03:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michel Lespinasse <walken@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 00/12] Add a new mmap locking API wrapping mmap_sem
 calls
Message-ID: <20200609120328.GB22623@dhcp22.suse.cz>
References: <20200520052908.204642-1-walken@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520052908.204642-1-walken@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue 19-05-20 22:28:56, Michel Lespinasse wrote:
> Reposting this patch series on top of v5.7-rc6. I think this is ready
> for inclusion into the -mm tree; however there were some minor points
> of feedback to address and also it was easier to regenerate a full
> version after the v5.5 (only updating patches 09/10 and 10/10) caused
> some confusion.
> 
> 
> This patch series adds a new mmap locking API replacing the existing
> mmap_sem lock and unlocks. Initially the API is just implemente in terms
> of inlined rwsem calls, so it doesn't provide any new functionality.
> 
> There are two justifications for the new API:
> 
> - At first, it provides an easy hooking point to instrument mmap_sem
>   locking latencies independently of any other rwsems.
> 
> - In the future, it may be a starting point for replacing the rwsem
>   implementation with a different one, such as range locks. This is
>   something that is being explored, even though there is no wide concensus
>   about this possible direction yet.
>   (see https://patchwork.kernel.org/cover/11401483/)

Sorry that I am jumping late to the game.

Even though I hoped that the new API would somehow start using a
concept of address ranges, because I believe this is a fundamental lock
granularity for this mmap_sem, this is definitely a step in the right
direction. Getting rid of all direct usage of mmap_sem is an
improvement in itself.

Feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!
-- 
Michal Hocko
SUSE Labs
