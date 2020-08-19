Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E391C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 251C4207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YXxWdcY4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgHSUP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:15:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42301 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgHSUP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:15:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597868124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6wZSRsOZbW0ppoxwbf389BsXiaVqGjFLolCHa9KVfRI=;
        b=YXxWdcY4HFERidCUvivy2lAFiT9sXrCtM0CK/AmL6kUoEWhaG+fIW4x0YTqvfVAYBzQklc
        I2Embfj6ifM2Q14ueEhocZGy3f4hZj2HwTUbfF5HcbhHUSrnAzFaKmBv7gLIYJkJg86X52
        JzjR4gxWQOcdUSJasVNzKl9Tlo6g25I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-X3vWWMcLNg6XKdITSWTFnQ-1; Wed, 19 Aug 2020 16:15:22 -0400
X-MC-Unique: X3vWWMcLNg6XKdITSWTFnQ-1
Received: by mail-pj1-f72.google.com with SMTP id e2so2084101pjm.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6wZSRsOZbW0ppoxwbf389BsXiaVqGjFLolCHa9KVfRI=;
        b=OqtMZq7aMchOFdiqWlG4fCq+dvdmnJ7VbqOhLDeJar04E1xT+UDHOGzyAbmrKdM/XO
         pVZhuE+SdwWhpyQhP9U4UNl43pbhJbMIZDWRi3iG3gFQKMqqJPlveChp8vM1GsfhxkbS
         aWlui3pKW+KncGltfGr/fXYZsDeTKRaOSZ1GKCNEev53hvkbc3L0gB5E1XErrTLuA/5x
         bvc/Jrq719M73ktGQJ6ZZDFn1VbXTgYufWjimJqYfddSLNi5Q2LDNbjKLgPP8G7Cnou1
         6LLtI2l+ZH7NyCmBCJ4ZwY7E6OKhEdG/Jg1RqyRxG5VxA3lmZwGphXKIlD9jV/z7DNve
         UJhQ==
X-Gm-Message-State: AOAM533V/SzC1OM0YVV/jiyUqg+E+3CqK0yKtG/X6ojffEC4wPxhvMn7
        v3XZcRYfBSqdv+T3V+ytFuOarSe/adXpRNYplZnLPd3UgHq6uD6/tZs0rIBwt4+/NlSiGsf4H1x
        3Deuv1N4gIReaua0UXpySpUq1
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr5515130pjb.129.1597868121452;
        Wed, 19 Aug 2020 13:15:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZ6K3xi/zuEXaLDp+AhVXh18fIyTkt9TT32R+RhUbJpOr/tX/cuBKSRunO6DGE9U7OgqK+kw==
X-Received: by 2002:a17:90a:fa06:: with SMTP id cm6mr5515108pjb.129.1597868121185;
        Wed, 19 Aug 2020 13:15:21 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s125sm56651pfc.63.2020.08.19.13.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 13:15:20 -0700 (PDT)
Date:   Thu, 20 Aug 2020 04:15:09 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>,
        Eric Sandeen <esandeen@redhat.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH] mm, THP, swap: fix allocating cluster for swapfile by
 mistake
Message-ID: <20200819201509.GA26216@xiangao.remote.csb>
References: <20200819195613.24269-1-hsiangkao@redhat.com>
 <20200819130506.eea076dd618644cd7ff875b6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819130506.eea076dd618644cd7ff875b6@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Wed, Aug 19, 2020 at 01:05:06PM -0700, Andrew Morton wrote:
> On Thu, 20 Aug 2020 03:56:13 +0800 Gao Xiang <hsiangkao@redhat.com> wrote:
> 
> > SWP_FS doesn't mean the device is file-backed swap device,
> > which just means each writeback request should go through fs
> > by DIO. Or it'll just use extents added by .swap_activate(),
> > but it also works as file-backed swap device.
> 
> This is very hard to understand :(

Thanks for your reply...

The related logic is in __swap_writepage() and setup_swap_extents(),
and also see e.g generic_swapfile_activate() or iomap_swapfile_activate()...

I will also talk with "Huang, Ying" in person if no response here.

> 
> > So in order to achieve the goal of the original patch,
> > SWP_BLKDEV should be used instead.
> > 
> > FS corruption can be observed with SSD device + XFS +
> > fragmented swapfile due to CONFIG_THP_SWAP=y.
> > 
> > Fixes: f0eea189e8e9 ("mm, THP, swap: Don't allocate huge cluster for file backed swap device")
> > Fixes: 38d8b4e6bdc8 ("mm, THP, swap: delay splitting THP during swap out")
> 
> Why do you think it has taken three years to discover this?

I'm not sure if the Redhat BZ is available for public, it can be reproduced
since rhel 8
https://bugzilla.redhat.com/show_bug.cgi?id=1855474

It seems hard to believe, but I think just because rare user uses the SSD device +
THP + file-backed swap device combination... maybe I'm wrong here, but my test
shows as it is.

Thanks,
Gao Xiang

> 
> 
> 

