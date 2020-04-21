Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F63AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45AB0206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hONjiqy/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgDUJAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726052AbgDUJAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:00:13 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6710C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 02:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d40xS3Zbw/pMXgln3ygv6nRVMsVWeln3BpvTx1qiDQU=; b=hONjiqy/vUe6UnxP0LCJ1byLyL
        h5QuDIAr63PlmihkCb/6V8z8UVshOrBPKi4wq2Ydw8XBaqx0JjXgHWj7QkKlXuQ41EeGYhBwwOhAe
        aKEqwdkpXZGVjLr0ZuY7ggJqL2HXl6EeEJkpGiyjAsyOa826Llzv6/1KExDbqCXQHvXwU8KIM9fZC
        qPIIJLwjl3cUGfvgYEvqvRWN7d3X/MQxUmbxu9J6sZTKna6LlRIdeNqaNenjO8woWN70PGKuYubSP
        hcCBDihkubEbnWG2YwZ4+V77M7sR7K/WSIivz7pEPqKSv/l8f7AvFbexcCipgpa5ubMmHrathS5tQ
        AZ/SfUSw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQolB-0007rq-Lu; Tue, 21 Apr 2020 09:00:05 +0000
Date:   Tue, 21 Apr 2020 02:00:05 -0700
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
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
Message-ID: <20200421090005.GA23085@infradead.org>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think the names are very good.  I'd keep PageHighMem for the
existing highmem zone, and add something like PageDirectMapped or
similar for ay page that has a valid direct mapping address.  This will
also come in handy if we plan to go ahead with the xpfo work.
