Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAACC2D0ED
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BFD206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cUr2PJjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgC1LZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:25:30 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:31009 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgC1LZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585394729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MkhqG+9pJjWDz5YSa/ZfjozmXA6/H2qbLbttt1sv2Dw=;
        b=cUr2PJjpwc5rlN9rtn2oGPB4HIzmCUu1bNyX9KHcSbowFpkdUyYgrSL4Xo6x2Q0G+/Z+0Y
        Bh98V5GqVqmQnQF1SQQtxjVVTEf2uUiINFLkNbnDM5DUgqBpTQ+LGWkYlLZtRVK3+gcoz2
        SkaUock4e9ullio2xJPXJ+qTSgGKXwI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-T21r-Y38N2GSk0dDrCOBYg-1; Sat, 28 Mar 2020 07:25:25 -0400
X-MC-Unique: T21r-Y38N2GSk0dDrCOBYg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A4B2100726A;
        Sat, 28 Mar 2020 11:25:23 +0000 (UTC)
Received: from localhost (ovpn-12-98.pek2.redhat.com [10.72.12.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F36519756;
        Sat, 28 Mar 2020 11:25:19 +0000 (UTC)
Date:   Sat, 28 Mar 2020 19:25:17 +0800
From:   Baoquan He <bhe@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        david@redhat.com
Subject: Re: [Patch v2 2/2] mm/page_alloc.c: define node_order with all zero
Message-ID: <20200328112517.GR3039@MiWiFi-R3L-srv>
References: <20200327220121.27823-1-richard.weiyang@gmail.com>
 <20200327220121.27823-2-richard.weiyang@gmail.com>
 <4c9d8138-d379-810f-64e7-0d018ed019df@nvidia.com>
 <20200328002616.kjtf7dpkqbugyzi2@master>
 <97a6bf40-792b-6216-d35b-691027c85aad@nvidia.com>
 <20200328011031.olsaehwdev2gqdsn@master>
 <40facd34-40b2-0925-90ca-a4c53fc520e8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40facd34-40b2-0925-90ca-a4c53fc520e8@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/27/20 at 06:28pm, John Hubbard wrote:
> On 3/27/20 6:10 PM, Wei Yang wrote:
> ...
> > > It's not just about preserving the value. Sometimes it's about stack space.
> > > Here's the trade-offs for static variables within a function:
> > > 
> > > Advantages of static variables within a function (compared to non-static
> > > variables, also within a function):
> > > -----------------------------------
> > > 
> > > * Doesn't use any of the scarce kernel stack space
> > > * Preserves values (not always necessarily and advantage)
> > > 
> > > Disadvantages:
> > > -----------------------------------
> > > 
> > > * Removes basic thread safety: multiple threads can no longer independently
> > >   call the function without getting interaction, and generally that means
> > >   data corruption.
> > > 
> > > So here, I suspect that the original motivation was probably to conserve stack
> > > space, and the author likely observed that there was no concurrency to worry
> > > about: the function was only being called by one thread at a time.  Given those
> > > constraints (which I haven't confirmed just yet, btw), a static function variable
> > > fits well.
> > > 
> > > > 
> > > > My suggestion is to remove the static and define it {0} instead of memset
> > > > every time. Is my understanding correct here?
> > > 
> > > 
> > > Not completely:
> > > 
> > > a) First of all, "instead of memset every time" is a misconception, because
> > >    there is still a memset happening every time with {0}. It's just that the
> > >    compiler silently writes that code for you, and you don't see it on the
> > >    screen. But it's still there.
> > > 
> > > b) Switching away from a static to an on-stack variable requires that you first
> > >    verify that stack space is not an issue. Or, if you determine that this
> > >    function needs the per-thread isolation that a non-static variable provides,
> > >    then you can switch to either an on-stack variable, or a *alloc() function.
> > > 
> > 
> > I think you get some point. While one more question about stack and static. If
> > one function is thread safe, which factor determines whether we choose on
> > stack value or static? Any reference size? It looks currently we don't have a
> > guide line for this.
> > 
> 
> 
> There's not really any general guideline, but applying the points above (plus keeping
> in mind that kernel stack space is quite small) to each case, you'll come to a good
> answer.
> 
> In this case, if we really are only ever calling this function in one thread at a time,
> then it's probably best to let the "conserve stack space" point win. Which leads to
> just leaving the code nearly as-is. The only thing left to do would be to (optionally,
> because this is an exceedingly minor point) delete the arguably misleading "= {0}" part.
> And as Jason points out, doing so also moves node_order into .bss :
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 4bd35eb83d34..cb4b07458249 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5607,7 +5607,7 @@ static void build_thisnode_zonelists(pg_data_t *pgdat)
>  static void build_zonelists(pg_data_t *pgdat)
>  {
> -       static int node_order[MAX_NUMNODES] = {0};
> +       static int node_order[MAX_NUMNODES];
>         int node, load, nr_nodes = 0;
>         nodemask_t used_mask = NODE_MASK_NONE;
>         int local_node, prev_node;
> 
> 
> 
> Further note: On my current testing .config, I've got MAX_NUMNODES set to 64, which makes
> 256 bytes required for node_order array. 256 bytes on a 16KB stack is a little bit above
> my mental watermark for "that's too much in today's kernels".

Oh, so Michal was deliberate to do so. I have CONFIG_NODES_SHIFT as 10
in my laptop config. That truly will cost much kernel stack. Thanks for
telling this.

