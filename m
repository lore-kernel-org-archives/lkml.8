Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D265C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0562020873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583868990;
	bh=0gNpH5Yk00VbmZ3HvMkSvkK3tQjRWa/2I/O2MPQxl4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ly85HsW2FOvk51Porz0SrTfqujKWQ3+kWrHHMq3DPLJbYt//XDrZg4rhaYI9YJzG8
	 kpd0BI1oKJOJ9RYlzwSXSbUIXvseRPtbUVrxV+zavLexMI5OVLJQRaRjCGqxAgg2aC
	 Gw7uK8Pou617u8+bFM7kx1flzDQOd6Dj7E4p6zqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbgCJTg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:36:29 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38539 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726899AbgCJTg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:36:28 -0400
Received: by mail-wm1-f66.google.com with SMTP id n2so2721146wmc.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQNxafXsQdCTqr3ErUs/r6IszKzwOyK1ozoK1kswePE=;
        b=oGrUvGBoUewzhIeg92d2q88zYkri7O9hc6Andms8ablsMwn2fB6UjS8v0kP+BaYlKq
         lSjtNIxgYgQWwwwyOGDGYYJR06uymk1Iqoey6fhTEY3gcxvA8VWFmy371+j8MGusTn7m
         rW4z3jIfvGLOalEbjzNJr3vdeF6nBh7UywyMio7MwaGx/ovRi7jRDpA+9q85KcVLmKZq
         jFnDzb4imkXPfkUhd+O8s3sdjI0Sot0nUUVPRH4yPJfwEO57EiajrZwXPGQ4zaYKYIfL
         ZaEu+VLy96dKHDfA/diUbLWTMinGCrhEIODExJzAGG0tpw3t8lcJCFs4X5rjQ/ThaMxC
         AciQ==
X-Gm-Message-State: ANhLgQ3Ohy85nwJZNwZjv6iSTLUr/2EMWqNTjNU2dy6Cf84uMag+y5Kp
        HrzjfKG1qNBNZTdOqOIT+O4=
X-Google-Smtp-Source: ADFU+vvmBQXI6EXmODjgWFHAww7aH6QevORA++ZLDSkxDomP85/Oaa/ZB0so2d/bkib0TI6RdPGJ9Q==
X-Received: by 2002:a1c:9904:: with SMTP id b4mr3635404wme.34.1583868985302;
        Tue, 10 Mar 2020 12:36:25 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id m25sm5076945wml.35.2020.03.10.12.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:36:24 -0700 (PDT)
Date:   Tue, 10 Mar 2020 20:36:22 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH v2] mm: hugetlb: optionally allocate gigantic hugepages
 using cma
Message-ID: <20200310193622.GC8447@dhcp22.suse.cz>
References: <20200310002524.2291595-1-guro@fb.com>
 <5cfa9031-fc15-2bcc-adb9-9779285ef0f7@oracle.com>
 <20200310180558.GD85000@carbon.dhcp.thefacebook.com>
 <4b78a8a9-7b5a-eb62-acaa-2677e615bea1@oracle.com>
 <20200310191906.GA96999@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310191906.GA96999@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 12:19:06, Roman Gushchin wrote:
[...]
> > I found this out by testing code and specifying hugetlb_cma=2M.  Messages
> > in log were:
> > 	kernel: hugetlb_cma: reserve 2097152, 1048576 per node
> > 	kernel: hugetlb_cma: successfully reserved 1048576 on node 0
> > 	kernel: hugetlb_cma: successfully reserved 1048576 on node 1
> > But, it really reserved 1GB per node.
> 
> Good point! In the passed size is too small to cover a single huge page,
> we should probably print a warning and bail out.

Or maybe you just want to make the interface the unit size rather than
overall size oriented. E.g. I want 10G pages per each numa node.
-- 
Michal Hocko
SUSE Labs
