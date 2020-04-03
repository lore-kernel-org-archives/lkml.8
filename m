Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E8C2BA17
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7B0921556
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 10:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585908085;
	bh=MvMvhKUfLZWHOyD15kKxWI7zF3UoWs6qfcxOpwmQ41Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YqNQIh+v/48zuQyrhdeVz3WegQhbNUEWsG53JdUZCxRprZO3mtFQPzgJFk8wxH44Q
	 13ze5jnO7s+hA9a1wwZiW+iCYYrwTELK9AA8E5Popp/zluYzYsO5CEU9ebHJClSmXQ
	 nP2DIa0gUj3luPBzqfoMO92Yismo4jTEjcoc8XQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390593AbgDCKBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 06:01:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37582 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:01:24 -0400
Received: by mail-wr1-f67.google.com with SMTP id w10so7826600wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 03:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jYXQbnu/Oi974qhNjSFy5pRIJC0tTSSAvVWrXVkMiaM=;
        b=f9jXWkGd/SUoZijMzwljdg3VzLw+L4WrnVp3Ca6jyRlzXvDwIucJleDzGrOnGqAywY
         3SJiQRppazdkgIfiafD0y363gL/iRWV6Z8q+omPZsiyluehsdGNgMaikZ6rNcG06SzCc
         DjBg2K8DEbm5CPzw1oTXSuIJBl4wnFzSGZahtBlJaGQZWJ9dW+dgzhdaVqi7jMRimYcM
         oC6n3TqKwjHOAdaiGkTGMb3yp7JcTY0uxzawk592B1yQWENG2d2KQdGLnEol9wjmJ5qK
         nbrz+0h5+gLJwrhzDHorgmE5zorOc2+FGUPU9+EYrzJ+falr4w2y6gf84h3gZ1/oO5wy
         UHhQ==
X-Gm-Message-State: AGi0PuYDPByvDgQHTN5SBqdct4VLIELin+r/QGwiNZ1fj+6QaT36KcOa
        0EHmmad2AgYJVV61ejtYtkM=
X-Google-Smtp-Source: APiQypLgiYupoXaD9R5zABwqMgbYZI0KQAYTivfAw3CSUMkXzEfl/iXsdKbvlVPO+gTJwGowyftDIg==
X-Received: by 2002:adf:f401:: with SMTP id g1mr7876035wro.140.1585908082788;
        Fri, 03 Apr 2020 03:01:22 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id z129sm10951833wmb.7.2020.04.03.03.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 03:01:21 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:01:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Aslan Bakirov <aslanbekirov@gmail.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Aslan Bakirov <aslan@fb.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@fb.com, riel@surriel.com,
        Roman Gushchin <guro@fb.com>, hannes@cmpxchg.org
Subject: Re: [PATCH v3] mm: cma: NUMA node interface
Message-ID: <20200403100120.GY22681@dhcp22.suse.cz>
References: <20200403021254.2842224-1-aslan@fb.com>
 <20200403050205.GI3952565@iweiny-DESK2.sc.intel.com>
 <CAJth39gjy34swBqVUy7mOo0-Dbxzb5TZn2jUNsrcq8iHpK_ToA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJth39gjy34swBqVUy7mOo0-Dbxzb5TZn2jUNsrcq8iHpK_ToA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-04-20 10:51:32, Aslan Bakirov wrote:
> On Fri, Apr 3, 2020 at 6:02 AM Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > On Thu, Apr 02, 2020 at 07:12:56PM -0700, Aslan Bakirov wrote:
> > > I've noticed that there is no interfaces exposed by CMA which would let
> > me
> > > to declare contigous memory on particular NUMA node.
> > >
> > > This patchset adds the ability to try to allocate contiguous memory on
> > > specific node. It will fallback to other nodes if the specified one
> > > doesn't work.
> > >
> > > Implement a new method for declaring contigous memory on particular node
> > > and keep cma_declare_contiguous() as a wrapper.
> >
> > Is there an additional patch which uses this new interface?
> >
> > Generally the patch seems reasonable but we should have a user.
> 
> 
>  Thanks for the comments. Yes, actually, this is the version 3 of first
> patch ([PATCH 1/2] mm: cma: NUMA node interface)
>  of patchset. Second patch, which uses this interface is  "[PATCH 2/2] mm:
> hugetlb: Use node interface of cma"

It would have been much more clear to send those two patches together as
you can see.
-- 
Michal Hocko
SUSE Labs
