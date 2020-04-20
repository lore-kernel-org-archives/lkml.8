Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9F0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D0F2078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 07:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587368081;
	bh=SvA/EF5fT57d5qmZCdKN27UQ9akEUxpAm+jdRo2RlZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WwQ6Qfv/PgznS7B4SxF3y7Zss70U0MXvmI8OOazux7DEheiM8KWV6iP121QHbuE4u
	 4aqTaqMEqMLGCQRCQyht1uJdwDMTIy3yXLVAMtt6unyotaxoQTCK+x83tus8u1NHRH
	 MhrMYtD4+1J2+DO/mKLcCnhI/tGi+CmTa7ZjwYl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgDTHel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:34:41 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40206 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgDTHek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 03:34:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id k13so9596971wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 00:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J6rJMn+wy517qK6LezauDPAAdzw8pIiAhiJfakvu9RQ=;
        b=CqN18lsOv7fQll9IjJqroG+4nX3gGZ9AYlVrG39JeEX1IV9H0BDz545zA3Nhs5zW5d
         VHcEx283YbXXmoB/MI5EAIY36W+FZw0r05Em74gEAmle8jn4+R4VRkAAfQZDKpLAxfe6
         /8V9K+zDv6/6wFvTA2umH+iAxl6VhyWWnU+zfNr9OZTqDry4+fNccbssKpXhOR9MDZQs
         ejKA3/ntMEmJvKThIdZ1qEgfVdR4ME8LzUQyodxeu9WenSX/N8RVqr65xKn+uLiV0R8R
         NChEc2YHqNwLOwp3E1DKfSP8rFl+ozBHglfz186hb+BLIlvIXbHyiM8ZrEZV+qyL3why
         K9aQ==
X-Gm-Message-State: AGi0PuaQujGAXOuK1v80CUHcWwkSjYffZWDKRLoqmalB1hsDFiqr6bxj
        Is7n2+yxd0Q3o9W+o9J0obTecJjQ
X-Google-Smtp-Source: APiQypLpNr3MZecJqP2+GqR3GqelU7seRMQZPFBobVF04nv7LWcIPzyQ5dbWLrvq1yrMMyhx2dsVpw==
X-Received: by 2002:adf:ff89:: with SMTP id j9mr17118764wrr.245.1587368076910;
        Mon, 20 Apr 2020 00:34:36 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id v1sm41809wrv.19.2020.04.20.00.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:34:36 -0700 (PDT)
Date:   Mon, 20 Apr 2020 09:34:34 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Baoquan He <bhe@redhat.com>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v2] mm/page_alloc: fix watchdog soft lockups during
 set_zone_contiguous()
Message-ID: <20200420073434.GE27314@dhcp22.suse.cz>
References: <20200416073417.5003-1-david@redhat.com>
 <20200417151247.0068d5aa3f026ced2289ce31@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417151247.0068d5aa3f026ced2289ce31@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-04-20 15:12:47, Andrew Morton wrote:
> On Thu, 16 Apr 2020 09:34:17 +0200 David Hildenbrand <david@redhat.com> wrote:
> 
> > Without CONFIG_PREEMPT, it can happen that we get soft lockups detected,
> > e.g., while booting up.
> > 
> > ...
> > 
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1607,6 +1607,7 @@ void set_zone_contiguous(struct zone *zone)
> >  		if (!__pageblock_pfn_to_page(block_start_pfn,
> >  					     block_end_pfn, zone))
> >  			return;
> > +		cond_resched();
> >  	}
> >  
> >  	/* We confirm that there is no hole */
> 
> I added cc:stable to this one.  Please let me know if that wasn't a
> good idea.

Really large memory setups tend to run on distribution kernels so
backporting to old kernels doesn't really harm.
-- 
Michal Hocko
SUSE Labs
