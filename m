Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F3C8C34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C26A207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 20:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgBSUmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 15:42:24 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:44508 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSUmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:42:23 -0500
Received: by mail-pl1-f182.google.com with SMTP id d9so543796plo.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 12:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XlRxO87zkf/AZ6fh20OMIQSRLp7vbnlHaFnZNks6GNI=;
        b=Ig8pEXnfIemutf1UORp3od6pTyBx+vB6yNXBdb37XWyLJE7Yakc2GbtyI4XVC0MAqh
         s6C0cntb5Fz5iRb7jtLefJaUDRsljpg6/VujCR5sJdbJiBX+1D8KsiARIgnF8MqVrSZy
         j5IB28fYyxj7vHhZH7s96Pzr1icE5rNNRl6FsL1KyI83ULFkAK3gmWGBXBmx/n5JM7vX
         t2oH2iYEaVWpG0j/Wybk41mCG3GZ6l3VOCjNcJHTyD2UKtU3V+Sc5thZohTWgkXXc+Ej
         6uHhwpKNdOqetvKOy/8Rrg4g4YV0QYcVzqs3lvF0lVCtyzDmSxH2bddUJ91k5CqAI8Cf
         xy5g==
X-Gm-Message-State: APjAAAXrJkeKlfzylyMLpK0f41xusEdk9VquQ36A7+1/K17W0GWopH0f
        JIL618BZn+sOfftOvl/6oHw=
X-Google-Smtp-Source: APXvYqwkDymfw8D/L9PhjjHvG7D/OoNLTVBSTKhGrP8xP+IqgehdJyfbntSfF/pc3LWqhSUHIAKqPQ==
X-Received: by 2002:a17:90a:fd85:: with SMTP id cx5mr10894444pjb.80.1582144943130;
        Wed, 19 Feb 2020 12:42:23 -0800 (PST)
Received: from sultan-book.localdomain ([104.200.129.62])
        by smtp.gmail.com with ESMTPSA id q8sm713147pje.2.2020.02.19.12.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:42:22 -0800 (PST)
Date:   Wed, 19 Feb 2020 12:42:20 -0800
From:   Sultan Alsawaf <sultan@kerneltoast.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
Message-ID: <20200219204220.GA3488@sultan-book.localdomain>
References: <20200219182522.1960-1-sultan@kerneltoast.com>
 <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain>
 <20200219200527.GF11847@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219200527.GF11847@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:05:27PM +0100, Michal Hocko wrote:
> Could you be more specific please? kspwad should stop as soon as the
> high watermark is reached. If that is not the case then there is a bug
> which should be fixed.

No, there is no bug causing kswapd to continue beyond the high watermark.

> Sure it is quite possible that kswapd is busy for extended amount of
> time if the memory pressure is continuous.
> 
> > On a constrained system I tested (mem=2G), this patch had the positive effect of
> > improving overall responsiveness at high memory pressure.
> 
> Again, do you have more details about the workload and what was the
> cause of responsiveness issues? Because I would expect that the
> situation would be quite opposite because it is usually the direct
> reclaim that is a source of stalls visible from userspace. Or is this
> about a single CPU situation where kswapd saturates the single CPU and
> all other tasks are just not getting enough CPU cycles?

The workload was having lots of applications open at once. At a certain point
when memory ran low, my system became sluggish and kswapd CPU usage skyrocketed.
I added printks into kswapd with this patch, and my premature exit in kswapd
kicked in quite often.

> > On systems with more memory I tested (>=4G), kswapd becomes more expensive to
> > run at its higher scan depths, so stopping kswapd prematurely when there aren't
> > any memory allocations waiting for it prevents it from reaching the *really*
> > expensive scan depths and burning through even more resources.
> > 
> > Combine a large amount of memory with a slow CPU and the current problematic
> > behavior of kswapd at high memory pressure shows. My personal test scenario for
> > this was an arm64 CPU with a variable amount of memory (up to 4G RAM + 2G swap).
> 
> But still, somebody has to put the system into balanced state so who is
> going to do all the work?

All the work will be done by kswapd of course, but only if it's needed.

The real problem is that a single memory allocation failure, and free memory
being some amount below the high watermark, are not good heuristics to predict
*future* memory allocation needs. They are good for determining how to steer
kswapd to help satisfy a failed allocation in the present, but anything more is
pure speculation (which turns out to be wrong speculation, since this behavior
causes problems).

If there are outstanding failed allocations that won't go away, then it's
perfectly reasonable to keep kswapd running until it frees pages up to the high
watermark. But beyond that is unnecessary, since there's no way to know if or
when kswapd will need to fire up again. This makes sense considering how kswapd
is currently invoked: it's fired up due to a failed allocation of some sort, not
because the amount of free memory dropped below the high watermark.

Sultan
