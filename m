Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3E0C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DF12137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 12:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TZFNVyLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgEAMec (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 08:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728682AbgEAMeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 08:34:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F994C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OFdEjkK9jwgd0OlQdpKQakLpH/7u8tRK6UnJTEvP0yE=; b=TZFNVyLmvaFYCPmOoBQtCT8LbO
        KtKzjwYT3U74sRbqJs/Z1oBAzhMS/kd6rAH3tl7VxdFTJeIMAur6Yj+mZ85A4krspgMQy3rWsH6qo
        HusitmEyOqEqd0kgFe6dLVdM7TMD+lRvDuN+OUsa6o+/JR+C0yK6xftYg6vh89a3f6nTKJwEmKwca
        78UrEHxNth3LG15agZHExbxpowRrDLJzWTduaQ3YDfej9H7lIPyOU2RBVPE1ugVKsSVkX59dkby4B
        +mKvFK1Bla71Q/8523zGvGK9xtYDeEix7V0D2qeZDEItMJxtYiSp25ByXhADkdTVm2P1CGGeY3+Hm
        /pCJqLew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUUs9-0007mt-MI; Fri, 01 May 2020 12:34:29 +0000
Date:   Fri, 1 May 2020 05:34:29 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 00/10] change the implementation of the PageHighMem()
Message-ID: <20200501123429.GA26861@infradead.org>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200429184711.9d603da097fdea80f574f1f1@linux-foundation.org>
 <CAAmzW4NC4LHXSoU8r6Jrh7WP8fouuaSkM--0gQVWf8G4wkDupg@mail.gmail.com>
 <20200501105545.GA29460@infradead.org>
 <CAAmzW4M+EoPqhossgJKxpZ_5=uto1jXK56qYmUd6SNKmbswuJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmzW4M+EoPqhossgJKxpZ_5=uto1jXK56qYmUd6SNKmbswuJQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 09:15:30PM +0900, Joonsoo Kim wrote:
> I think that PageHighMemZone() is long and complicated enough to have
> a macro.

It is.  But then again it also shouldn't really be used by anything
but MM internals.

> 
> PageHighMemZone(page) = is_highmem_idx(zone_idx(page_zone(page))
> 
> Instead of open-code, how about changing the style of macro like as
> page_from_highmem()? What PageHighMemZone() represent is derivated
> attribute from the page so PageXXX() style may not be appropriate.

Maybe page_is_highmem_zone() with a big kerneldoc comment explaining
the use case?  Bonus points of killing enough users that it can be
in mm/internal.h.
