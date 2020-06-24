Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD20320B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kvpD+36K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403855AbgFXMK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403782AbgFXMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:10:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544D3C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:10:55 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id j80so1556312qke.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+zBDNe4l4Mn0/s3337RshcrDhwkSiI85QcYGWTtZwww=;
        b=kvpD+36KKdiLTKX0VQeyHJqK+7nGhs8ANV4vmV5MRLj/L847j9DuvoS80RODfk0E5r
         rzRwbpi+MpaB3mCmriGk+xdbtID5SW3zx/xTU8oc2SOXx6jB+IGBankk2EzhZ4yqLqa2
         5xnHyohfSctnxWr/fcNFTuKJaqkmA1CFYaPsf2whJZeHtw45+9aHKmeEewb/TBKbdgF4
         WvG+nuVViJ72pYnDDwDOQ/hBuC+egzEAj/M6DVMRwvfLvenXWi/8/XBh1lrOmsnChZ3I
         izAGFP8u0DdXgUdagVbvlZTKbLkzhVF6JvJg7XS34wvLhYG0/yA5YOX7KGrs0pCshAn0
         CRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+zBDNe4l4Mn0/s3337RshcrDhwkSiI85QcYGWTtZwww=;
        b=VxPKF1HIWOrKkYBqdgTQJKuafRIU+FdWCI2jR/D2DrGEamoXnfaW4HJpNRNaPC+V2I
         D83qSvG9f81QYfjHTeUfGLz/4dVXuqI5y0FCtpp9sgPTAILGI8N0FMBoseKpgIqunh71
         sRZaOFLq6eJDmHz3PKWBHYr3ElB5TOasVIZ2pnO3+aCXeUgnKoMQsw7Xy7LnFE7tfpPC
         15xsJESMxU6Gf9BSDvFIN3+Rl22SH3d/mmYqt2RPJ2c0vCrDDTtpt+8Yop5+iegQV/2a
         VfClilrOCiwe2MVmfVDyQ2RbTByMyk1ti7ByWkCrgEYDouSeWklcIzUkGHeRhxyaz1mf
         Xnxw==
X-Gm-Message-State: AOAM530BKsJCMd0Epbw8ZVXvSSC4+qmo98/MJj2BLFMSKBdhWuO/d+pg
        UBSuHiW8Q6bgYu+UUGV21Itv1i+1TieFiA==
X-Google-Smtp-Source: ABdhPJxuOSy3QUUVt+Un/KQUMhyCatEd67j4mOAN3EM5TI2PD4C9VbXwF1+uP8L9yAl3sCzf+WTYvQ==
X-Received: by 2002:a37:9046:: with SMTP id s67mr10123252qkd.275.1593000654583;
        Wed, 24 Jun 2020 05:10:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w18sm849280qtn.3.2020.06.24.05.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 05:10:54 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jo4Ev-00DK8g-K0; Wed, 24 Jun 2020 09:10:53 -0300
Date:   Wed, 24 Jun 2020 09:10:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with
 MAYFAIL
Message-ID: <20200624121053.GD6578@ziepe.ca>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624080248.3701-1-chris@chris-wilson.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:02:47AM +0100, Chris Wilson wrote:
> When direct reclaim enters the shrinker and tries to reclaim pages, it
> has to opportunitically unmap them [try_to_unmap_one]. For direct
> reclaim, the calling context is unknown and may include attempts to
> unmap one page of a dma object while attempting to allocate more pages
> for that object. Pass the information along that we are inside an
> opportunistic unmap that can allow that page to remain referenced and
> mapped, and let the callback opt in to avoiding a recursive wait.

i915 should already not be holding locks shared with the notifiers
across allocations that can trigger reclaim. This is already required
to use notifiers correctly anyhow - why do we need something in the
notifiers?

I really don't like this patch, the purpose of notifiers is only to
*track changes* not to influence policy of the callers.

Jason
