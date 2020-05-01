Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BD5C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C56920708
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dji+CYTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgEAM05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgEAM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:26:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEC1C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yeu2kLlQ23lsZ803EULEomW60F2CDNhWySXXznjx8dw=; b=dji+CYTLHiO5SZ320pGZsMsiuT
        rz6JBvg9mvXchDKcC4UVqZKvXom+zfd6GBahELnYAG5eLakruJMGiwNgVclv/oPT152cddi254sXr
        lQa1vmUJqWvvX73PKr4AMjsdvBxwcBw+gTFAslKWR0c2+Wjd0bQ7RJYtjgRD+fvUr2tVMq8mWCbIa
        HiB7ZNlKzGAHO/WynUu0K5GwBE2vLrgXd6hAJcgYQPzObZiCuBD2i1kjXLRDuditkFy2xyAdnWYmU
        9aedb2pieBhH3zCH+Glms41At1qQ0oot4O1RAaXHwJS+96bBk6rFsP8AguFz6gM+CozCbP2fp7XAD
        iPXFnWDA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUUkp-0003rt-MB; Fri, 01 May 2020 12:26:55 +0000
Date:   Fri, 1 May 2020 05:26:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 06/10] mm/hugetlb: separate PageHighMem() and
 PageHighMemZone() use case
Message-ID: <20200501122655.GC21897@infradead.org>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1588130803-20527-7-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588130803-20527-7-git-send-email-iamjoonsoo.kim@lge.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:26:39PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Until now, PageHighMem() is used for two different cases. One is to check
> if there is a direct mapping for this page or not. The other is to check
> the zone of this page, that is, weather it is the highmem type zone or not.
> 
> Now, we have separate functions, PageHighMem() and PageHighMemZone() for
> each cases. Use appropriate one.
> 
> Note that there are some rules to determine the proper macro.
> 
> 1. If PageHighMem() is called for checking if the direct mapping exists
> or not, use PageHighMem().
> 2. If PageHighMem() is used to predict the previous gfp_flags for
> this page, use PageHighMemZone(). The zone of the page is related to
> the gfp_flags.
> 3. If purpose of calling PageHighMem() is to count highmem page and
> to interact with the system by using this count, use PageHighMemZone().
> This counter is usually used to calculate the available memory for an
> kernel allocation and pages on the highmem zone cannot be available
> for an kernel allocation.
> 4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
> is just copy of the previous PageHighMem() implementation and won't
> be changed.
> 
> I apply the rule #3 for this patch.
> 
> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Why do we care about the zone here?  This only cares about having
kernel direct mapped pages as far as I can tell.
