Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F377DC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8C0B2076D
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 10:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I0/bGlBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgEAKzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 06:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728352AbgEAKzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 06:55:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C3F8C08E859
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=K4EvlvZJ7sfeaanlJ/LRWp5eylv34i1As4UZqRMOABw=; b=I0/bGlBitnCCFx6DOtfBMHHrR2
        HIq5lUyjpiMWHo7whePAxr5+W4Vv/pg0XuBxeEZb38RUsg5O2/LRe8c2ZkjcNVd+UrVOmSr4KnBb3
        OCab3mFcsTlCr9Q/hs+NGP0rwU+vGIpl+2AUDHxUM2p0aJb1XJsQ1MO6capHFDYpuJX8ANpMJ06+Z
        9TYDFpG1PQkODYsOq8GlRNDvrMxPr7ECsiVWrfEnN2OXFgAf4XxlO4VccTiSxB56K/0CrGIMpqN4a
        9Cl6le1pGZ+dUSVAGtkZxS2EdqoD2kvbcGtbrRxIVcGqRLKAoVg6uFX2v8CG2mnElRt8RTX7UxADR
        NmkUDrqA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUTKb-0002ee-Mk; Fri, 01 May 2020 10:55:45 +0000
Date:   Fri, 1 May 2020 03:55:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v2 00/10] change the implementation of the PageHighMem()
Message-ID: <20200501105545.GA29460@infradead.org>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
 <20200429184711.9d603da097fdea80f574f1f1@linux-foundation.org>
 <CAAmzW4NC4LHXSoU8r6Jrh7WP8fouuaSkM--0gQVWf8G4wkDupg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmzW4NC4LHXSoU8r6Jrh7WP8fouuaSkM--0gQVWf8G4wkDupg@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 07:52:35PM +0900, Joonsoo Kim wrote:
> > - New code will pop up which gets it wrong and nobody will notice for
> >   a long time.
> 
> Hmm... I think that it's not that hard to decide correct macro. If we rename
> PageHighMem() with PageDirectMapped(), they, PageDirectMapped() and
> PageHighMemZone(), are self-explanation macro. There would be no
> confusion to use.

What confuses me is why we even need PageHighMemZone - mostly code
should not care about particular zones.  Maybe just open coding
PageHighMemZone makes more sense - it is a little more cumersome, but
at least it makes it explicit what we check for.  I already sent you
an incremental diff for one obvious place, but maybe we need to look
through the remaining ones if we can kill them or open code them in an
obvious way.
