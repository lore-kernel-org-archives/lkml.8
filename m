Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11116C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB0342166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eECQ0QQL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgIIPAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730022AbgIIMXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:23:39 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E4FC06179B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 05:11:21 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id q10so1351553qvs.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 05:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R3lcLuHu7q59V25Oo0x14U9H1nBkDduMKTjKjQaP/Wg=;
        b=eECQ0QQLziRX/wmd8s3D8Yw1twcG4BK3tB5rlMg5OTnfeDy6BIWHdfnIqx7rh32gpO
         GbhpP6oh79jldVWWlduFEKiZZpJTvi++c1oNspezxqclk2j3ffOLepTtNKZlxV2ssVXD
         ijjUbxMQTQrzHx731m1+ceckxCghN65uBbgm/Ze3GRNEPcBCcNPX9bRACHVFe1KA9eC5
         qupSDT12vxyYMJ9GS4DEpdC/QEgx5dHfiIS8UxU2IzuLslnqGsx0Rfm3l7F67Yk53lql
         a1qEgRnPAKYgWyEg8qLLGon/6UpFdpW7nm71ex3kbjQX3O6+NG5NJ7y48JCBFpcc20d6
         N1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R3lcLuHu7q59V25Oo0x14U9H1nBkDduMKTjKjQaP/Wg=;
        b=ExHnuToBc1oE5KSDWilRrybLbYgTzSfQP+8NeJXG8kbV18tMgLesVYzejtz3Zt2pFj
         6NWbPQuDL9PYf9+sZZl9QCg/1n+nvAZl1gIdyAY7TAAm0aUHcQqo7temjtN1Teun1/us
         4xhdvIPekJ3LMkvIgIYmJOWmcP69B7UusuR5D/LHFSZ3myRuC6BomhPaf1mhEDdaocXf
         dI9PoWsjyXkEFLlgV6Okv+zAKDnp8cIlIZNSAjUUlkMA01Bpk8wUTHYdHqXMRkzuAYe7
         BMzKXoIxJf3qHryMBs0Wq49053ZdqAaegVw/PGeX0MnlC6TkwaiAYJaUVT8tlIKqPSZ8
         1ljA==
X-Gm-Message-State: AOAM533xwML0flYRUZMFX/G3eeiqQkYAmy8/97WcdFNsAQLBJJm16ULE
        pKUC2RT4Rl0Dc4Lotsg2nVZQmA==
X-Google-Smtp-Source: ABdhPJyoXbdLBRscrOXezZ+Wo5/cD1bjrKMK4ZsF+phyZvDorDf40x5s13PfNdAwhQ8vC9eUUs6O9w==
X-Received: by 2002:a05:6214:d6b:: with SMTP id 11mr3657741qvs.30.1599653479546;
        Wed, 09 Sep 2020 05:11:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g37sm2731797qtk.76.2020.09.09.05.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 05:11:18 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kFywX-003IfU-Re; Wed, 09 Sep 2020 09:11:17 -0300
Date:   Wed, 9 Sep 2020 09:11:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200909121117.GD87483@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908142758.GF27537@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908142758.GF27537@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 03:27:58PM +0100, Matthew Wilcox wrote:
> On Tue, Sep 08, 2020 at 10:05:11AM -0400, Zi Yan wrote:
> > On 8 Sep 2020, at 7:57, David Hildenbrand wrote:
> > > I have concerns if we would silently use 1~GB THPs in most scenarios
> > > where be would have used 2~MB THP. I'd appreciate a trigger to
> > > explicitly enable that - MADV_HUGEPAGE is not sufficient because some
> > > applications relying on that assume that the THP size will be 2~MB
> > > (especially, if you want sparse, large VMAs).
> > 
> > This patchset is not intended to silently use 1GB THP in place of 2MB THP.
> > First of all, there is a knob /sys/kernel/mm/transparent_hugepage/enable_1GB
> > to enable 1GB THP explicitly. Also, 1GB THP is allocated from a reserved CMA
> > region (although I had alloc_contig_pages as a fallback, which can be removed
> > in next version), so users need to add hugepage_cma=nG kernel parameter to
> > enable 1GB THP allocation. If a finer control is necessary, we can add
> > a new MADV_HUGEPAGE_1GB for 1GB THP.
> 
> I think we do need that flag.  Machines don't run a single workload
> (arguably with VMs, we're getting closer to going back to the single
> workload per machine, but that's a different matter).  So if there's
> one app that wants 2MB pages and one that wants 1GB pages, we need to
> be able to distinguish them.
> 
> I could also see there being an app which benefits from 1GB for
> one mapping and prefers 2GB for a different mapping, so I think the
> per-mapping madvise flag is best.

I wonder if apps really care about the specific page size?
Particularly from a portability view?

The general app desire seems to be the need for 'efficient' memory (eg
because it is highly accessed) and I suspect comes with a desire to
populate the pages too.

Maybe doing something with MAP_POPULATE is an idea?

eg if I ask for 1GB of MAP_POPULATE it seems fairly natural the thing
that comes back should be a 1GB THP? If I ask for only .5GB then it
could be 2M pages, or whatever depending on arch support.

Jason
