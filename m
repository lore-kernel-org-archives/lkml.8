Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A38EC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4418D20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584236618;
	bh=g+qCR8rgvUwJQKXzRWc9Irj4P4HHgrILoQcAVZefOoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Gc9LYev434FCbjdGXoKATwCRjXl7pOxp9kJHux0ZQmLIbEp07xw5mlUzDAMfu8FWE
	 7hVAiaRGNYdDEsoA7jRuRsx/8sOzA930eCgFKfLc+BusanY2Hq3gEgdzeAvqYv/p4i
	 gIiCy9zLM+q1Dgy8zdq/zqNG3aweJM7yO1maaR5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgCOBnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:43:37 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36334 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbgCOBnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:43:37 -0400
Received: by mail-lf1-f67.google.com with SMTP id s1so11042736lfd.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 18:43:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cl7WWdndugVK0es2ynV4Gap0u1lguGYoJQLdlgdsR1k=;
        b=enjZmzFVTuzvc7X10a6OFFS1apt7GY1I2smgBfberq8Jz+VIEZ+2YiLfLjdmxktnBE
         2TMciEIExUafZhRF7hIQMfa8H8vCUIAUspLCDgLNuAhx9+/UhTAm10B63S3+JwoLTtpN
         HyKgZp3zyHK4gR7k49zfwP/kx24+1Lp8+hCjebhsEYyom+LW7+s0ofy8lCv5RxB4XeyY
         m7+yRa281afQgyZyIFCBd36AKhJM32hKVtaRWOQyPfrRMhrPTI+Pgh8v1cXZ228zk+Qw
         gFuCWZjvgVetWRae8vVRRyOq0IioXwuE/8ktfoAddIiLw9DEyGZzVHSxA2tPlfmRyU55
         86TA==
X-Gm-Message-State: ANhLgQ3TFJxDSDmjyLgV6Y4o5oFjSsR5Y1imlTT8Juz5gWLYAUwgLyQO
        5Ad9whKbN0bPIISSc/KkTmmjZFKy
X-Google-Smtp-Source: ADFU+vuxlwBxUpjfTjmxexdc27Fw1psiW8V9oY9DcWgyKJ2vzjLtyCJ2iKiohct9r31VozfL4/eRFA==
X-Received: by 2002:adf:f8c9:: with SMTP id f9mr7081671wrq.222.1584190602248;
        Sat, 14 Mar 2020 05:56:42 -0700 (PDT)
Received: from localhost (ip-37-188-252-125.eurotel.cz. [37.188.252.125])
        by smtp.gmail.com with ESMTPSA id p16sm19736101wmi.40.2020.03.14.05.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 05:56:41 -0700 (PDT)
Date:   Sat, 14 Mar 2020 13:56:38 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, willy@infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v3] mm/sparse.c: Use kvmalloc_node/kvfree to alloc/free
 memmap for the classic sparse
Message-ID: <20200314125638.GC10912@dhcp22.suse.cz>
References: <20200312130822.6589-1-bhe@redhat.com>
 <20200312141749.GL27711@MiWiFi-R3L-srv>
 <20200313145619.GD21007@dhcp22.suse.cz>
 <20200314005334.GO27711@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314005334.GO27711@MiWiFi-R3L-srv>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 14-03-20 08:53:34, Baoquan He wrote:
> On 03/13/20 at 03:56pm, Michal Hocko wrote:
> > On Thu 12-03-20 22:17:49, Baoquan He wrote:
> > > This change makes populate_section_memmap()/depopulate_section_memmap
> > > much simpler.
> > 
> > Not only and you should make it more explicit. It also tries to allocate
> > memmaps from the target numa node so this is a functional change. I
> > would prefer to have that in a separate patch in case we hit some weird
> > NUMA setups which would choke on memory less nodes and similar horrors.
> 
> Yes, splitting sounds more reasonable, I would love to do that. One
> question is I noticed Andrew had picked this into -mm tree, if I post a
> new patchset including these two small patches, whether it's convenient
> to drop the old one and get these two merged.

Andrew usually just drops the previous version and replaces it by the
new one. So just post a new version. Thanks!

-- 
Michal Hocko
SUSE Labs
