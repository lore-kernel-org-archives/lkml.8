Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA61C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FE0E20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758423;
	bh=zR33c3ukV1Gcj2yfkk4F9RTylBrZ8a4WpTR7l2ZGyEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FI50IFkOaBX1/VmjzLRZ6w1haNOGtc7511ymLhJveekvrrg+n4+6CQqXBhyuJDUZm
	 1x9CGbttwRzVs5jw1uBJM3bUVbZhD+zADUDNG01IA+6jSELZl77m+d+S/ag+bdJbCL
	 Estnr1uzwMJi9rlikjHZFZG2TUqzzJ4cp1l6aoL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbgDAQ1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:27:02 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46430 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387661AbgDAQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:27:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id j17so731413wru.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 09:26:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5o65WF39ZTwNaQXXfGkY0C2ezkDV3cJK8zkl+Yba67k=;
        b=tUT5zpi1DyEwy9utUcX8lWJ1Gke/dmAaD/Z/92ZxfCOooP06FqRvm8AeOOIITLnlHL
         3rZbniG1XjtG7hNUiSxR+w2/Q2Hgi43Awgw8FadmzZ8Oz/A0QUykOWUZ1QU79jfJQgzC
         vO9STBbeo17RIssqXFaFj1mT3af2JqPDIv9crkuOM0mk09AngXflMS+4W6M2/pRm+VuO
         p/j8lD4l7hy7sqeZQgbR/hc/hno/Wp09RQb0AxbCuZILpXVa4HrZQVmX7/pWFKcaiLTt
         gymyOLOTy46ELzcnBImR4u57zUrC2WFFDt3tGmLN7HbRBmvtPN2lhnEdbfnp6DJp/pkI
         d/yA==
X-Gm-Message-State: AGi0PuYRRzuoJerUrhFNavSzLjjWPCQOu5RzkaMg5ajsenEh7P5yHqrD
        mwO0rnDg95hA1G0suWwRSvc=
X-Google-Smtp-Source: APiQypIzVS6Ypqmag+o84P4FAzvoeTwfZ/4rIAQ1v95KbNZdM46U22WRQG7EITfBWMushOM2t8LZ3Q==
X-Received: by 2002:a05:6000:108f:: with SMTP id y15mr4809824wrw.423.1585758418302;
        Wed, 01 Apr 2020 09:26:58 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id a82sm6434836wmh.0.2020.04.01.09.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 09:26:57 -0700 (PDT)
Date:   Wed, 1 Apr 2020 18:26:55 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     David Hildenbrand <david@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: fix tick timer stall during deferred page init
Message-ID: <20200401162655.GX22681@dhcp22.suse.cz>
References: <20200311123848.118638-1-shile.zhang@linux.alibaba.com>
 <20200401154217.GQ22681@dhcp22.suse.cz>
 <dfc0014a-9b85-5eeb-70ea-d622ccf5d988@redhat.com>
 <20200401160048.GU22681@dhcp22.suse.cz>
 <20200401160929.jwekhr24tb44odea@ca-dmjordan1.us.oracle.com>
 <20200401161243.GW22681@dhcp22.suse.cz>
 <20200401161810.xvqikca2x46yqrlx@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401161810.xvqikca2x46yqrlx@ca-dmjordan1.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 12:18:10, Daniel Jordan wrote:
> On Wed, Apr 01, 2020 at 06:12:43PM +0200, Michal Hocko wrote:
> > On Wed 01-04-20 12:09:29, Daniel Jordan wrote:
> > > On Wed, Apr 01, 2020 at 06:00:48PM +0200, Michal Hocko wrote:
> > > > On Wed 01-04-20 17:50:22, David Hildenbrand wrote:
> > > > > On 01.04.20 17:42, Michal Hocko wrote:
> > > > > > This needs a double checking but I strongly believe that the lock can be
> > > > > > simply dropped in this path.
> > > 
> > > This is what my fix does, it limits the time the resize lock is held.
> > 
> > Just remove it from the deferred intialization and add a comment that we
> > deliberately not taking the lock here because abc
> 
> I think it has to be a little more involved because of the window where
> interrupts might allocate during deferred init, as Vlastimil pointed out a few
> years ago when the change was made.

I do not remember any details but do we have any actual real allocation
failure or was this mostly a theoretical concern. Vlastimil? For your
context we are talking about 3a2d7fa8a3d5 ("mm: disable interrupts while
initializing deferred pages")

> I'll explain myself in the changelog.

OK, I will wait for the patch.
-- 
Michal Hocko
SUSE Labs
