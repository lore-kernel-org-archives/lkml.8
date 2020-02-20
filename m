Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F6AC11D02
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF73A24656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 07:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582185144;
	bh=FVOkIiq9sMU/f2sNfTeRH0KGRCeRtmFxujtwgW3jYQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l6Al/QGT/p7kymSlCVaHVkcCBivcdEfdABuZajsO7jUgHKTiK1E9/2hcLNvwK9sVk
	 XrQsavB+14o9A4rxmNfk5nVp9VWfREqU12m3J1SY5PIlHJcwQ4HPLPj9Sa+ZZr+f3I
	 eE9+nUivBGsTVyaFH8+DTz8bRr+/ukPyMg/UTmKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgBTHwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:52:22 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:35446 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgBTHwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 02:52:22 -0500
Received: by mail-wr1-f54.google.com with SMTP id w12so3495407wrt.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 23:52:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BRUOLe+9hQR/ITm5+YG7M6svLA53jZ3MH/HgtB82Z1U=;
        b=UzHODRAOVzuGLIaKhJ0IGBwxkoAWWFh0epkV45gdikvOj24gtp7EAWZaDCtSCgFrw3
         SHq/B6fYWbsOPH356eugFb8U9/9p5392UKII6vEf0ZnTySF+hj+5rsHRARlXBfVBaC4y
         zIHpyDMTrQX490MNxgABnjWVRXuWf6ADbpwjxbzGrXN4+lffy6LLvYUS19nZIJ0ziF/s
         OIZCAMyzKqCnR5As6pDx9mhIAGapuZ9Hgk3Pl3ExMVB0IOzEuJX2W3j6UuB91qJMY5ua
         1H7dXRTIrLSJ5OVETp8fCm5/x/QQZGczxPsFOg2NeSdor0WucJPto51eeRpU+V9gUgrT
         dtgg==
X-Gm-Message-State: APjAAAVw1UFrpg8aKC7owj3bgdFZv+7zsA5zmsWWSWlkMfOC4isUlzCw
        5jbBpGwbCtTS6WAA6geKn4Q=
X-Google-Smtp-Source: APXvYqyhlff/LxgRNqOws+WVTd2HA+haEntq07ZgsqFyewbboJqON2lpO85QAYD69p8fjfC1Fzg7xg==
X-Received: by 2002:adf:f64b:: with SMTP id x11mr40043422wrp.355.1582185140366;
        Wed, 19 Feb 2020 23:52:20 -0800 (PST)
Received: from localhost (ip-37-188-133-21.eurotel.cz. [37.188.133.21])
        by smtp.gmail.com with ESMTPSA id a8sm3198701wmc.20.2020.02.19.23.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 23:52:19 -0800 (PST)
Date:   Thu, 20 Feb 2020 08:52:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com
Subject: Re: [Patch v4] mm/vmscan.c: remove cpu online notification for now
Message-ID: <20200220075218.GA20509@dhcp22.suse.cz>
References: <20200218224422.3407-1-richardw.yang@linux.intel.com>
 <20200219120810.c7677fa58594f5423549f59d@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219120810.c7677fa58594f5423549f59d@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-02-20 12:08:10, Andrew Morton wrote:
> On Wed, 19 Feb 2020 06:44:22 +0800 Wei Yang <richardw.yang@linux.intel.com> wrote:
> 
> > kswapd kernel thread starts either with a CPU affinity set to the full
> > cpu mask of its target node or without any affinity at all if the node
> > is CPUless. There is a cpu hotplug callback (kswapd_cpu_online) that
> > implements an elaborate way to update this mask when a cpu is onlined.
> > 
> > It is not really clear whether there is any actual benefit from this
> > scheme. Completely CPU-less NUMA nodes rarely gain a new CPU during
> > runtime.
> 
> This is the case across all platforms, all architectures, all users for
> the next N years?  I'm surprised that we know this with sufficient
> confidence.  Can you explain how you came to make this assertion?

CPUless NUMA nodes are quite rare - mostly ppc with crippled LPARs.
I am not aware those would dynamically get CPUs for those nodes later in
the runtime. Maybe they do but we would like to learn about that. A
missing cpu mask is not going cause any fatal problems anyway.

As the changelog states the callback can be reintroduced with a sign of
testing and usecase description. I prefer we drop this code in the mean
time as the benefit is not really clear or testable.

> > Drop the code for that reason. If there is a real usecase then
> > we can resurrect and simplify the code.

-- 
Michal Hocko
SUSE Labs
