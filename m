Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FA3C2D0E7
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64A02073B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 00:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXFopKyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgC1Avz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 20:51:55 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:51163 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgC1Avz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 20:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585356714;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AfM5YElagMxU4jLZCXpRalvLQEr9T943a/2CkE+p0+U=;
        b=YXFopKyELcr8CdYO9bqv4rEas6AfrKUcAxx34sX5bfoW5EqU37VKQdIaTrv0u3l2cMTurz
        NpGQqvH4OKAUwQvikxjYeIymo7BkDVoyHP6lfWeH/RHd0xBq99c71RRpP5wILhs27Ls3+i
        W1Yis9MY1EdRe6J/JocyM0UxtyK4akM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-RMN3DDxlMZGzXBqdzhX_SA-1; Fri, 27 Mar 2020 20:51:52 -0400
X-MC-Unique: RMN3DDxlMZGzXBqdzhX_SA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CA4931937FCE;
        Sat, 28 Mar 2020 00:51:50 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5563B60304;
        Sat, 28 Mar 2020 00:51:47 +0000 (UTC)
Date:   Sat, 28 Mar 2020 08:51:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Message-ID: <20200328005144.GQ3039@MiWiFi-R3L-srv>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200328002616.kjtf7dpkqbugyzi2@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200328002616.kjtf7dpkqbugyzi2@master>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/28/20 at 12:26am, Wei Yang wrote:
> On Fri, Mar 27, 2020 at 03:37:57PM -0700, John Hubbard wrote:
> >On 3/27/20 3:01 PM, Wei Yang wrote:
> >> Since we always clear node_order before getting it, we can leverage
> >> compiler to do this instead of at run time.
> >> 
> >> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> >> ---
> >>   mm/page_alloc.c | 3 +--
> >>   1 file changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index dfcf2682ed40..49dd1f25c000 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -5585,7 +5585,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
> >>   static void build_zonelists(pg_data_t *pgdat)
> >>   {
> >> -	static int node_order[MAX_NUMNODES];
> >> +	static int node_order[MAX_NUMNODES] = {0};
> >
> >
> >Looks wrong: now the single instance of node_order is initialized just once by
> >the compiler. And that means that only the first caller of this function
> >gets a zeroed node_order array...
> >
> 
> What a shame on me. You are right, I miss the static word. 
> 
> Well, then I am curious about why we want to define it as static. Each time we
> call this function, node_order would be set to 0 and find_next_best_node()
> would sort a proper value into it. I don't see the reason to reserve it in a
> global area and be used next time.
> 
> My suggestion is to remove the static and define it {0} instead of memset
> every time. Is my understanding correct here?

Removing static looks good, the node_order is calculated on the basis of
each node, it's useless for other node. It may be inherited from the old
code where it's a static global variable.

