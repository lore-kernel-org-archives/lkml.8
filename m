Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF0EC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4986520E65
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VzVNnOpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIAA0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgIAA0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:26:36 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EC8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:26:36 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id di5so3224098qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=25EP6lDyA/VCn85jeEaspBr9VnHNH+CoU2Es2Lg6BDE=;
        b=VzVNnOpB/iZRtjs0/1dL+nyroS8pJ/JR/teYVPRC7ehg6J0uj6p4zAJr6eqtSZ2zcS
         rmxMytC4VbsLpe5JIp8JF1WcWZZLy3GlDY23qNPj+/ABik90fsRKa+S4ki9e8FJ+CvoR
         A8xblUuWz+yRHu4JwqhUE2Jzdun6FWJ0Ytx+/0mAeJ82Y47xkJ8nvg184gjVdiyrxAaG
         inDzKjNxRp63B1/Nooabo6cFApB3xKxZYphB4eN1imAT6tQO1SDWWLNoFEJBZhszfD6c
         TAQeF0yEsXqa9+LFUvUvXi6GNT7UNIUO7yWizAYb4Bk2vSaH40Cb9pvN+ZD6T4uhR0yt
         buKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=25EP6lDyA/VCn85jeEaspBr9VnHNH+CoU2Es2Lg6BDE=;
        b=CUeOKZLfqiAo2K5I/Mqk41n/qP6TTv2ceNxcURzpw4vVuS6mM6LtYK8Ihf/mAHzvoV
         Exoe5+PwnZj2tg2LihA+k1XLe+vBQOiD3yre9mpf9lfHmmz4LVcPxzIyHJXxCDQ4zUmr
         tRWt81oEzBelr9BDM8V/jLwQvmHQOvCemMcr1QFmJ4kSyd5uRO09DBFffcuhjO1b1kBC
         V635kD5QRdBHKQJjFgBttTyyBphud845a9pct9hMp+3Hfgh26BK7+qQqjZkD2ZkvCByB
         mv4I7vQ4OXSZrO75hzBqLvLH5P5VerG+SL4wUuvAgp16WlsbbLhrXegw+aKcPTqOaTk4
         LUkw==
X-Gm-Message-State: AOAM533s6yb5p9IjieGewM+Y6+wBCXJzRcRtBRLDDXtypfirj2Jo1uWO
        clB0Gi9MuorV5azs8I1SsL65wg==
X-Google-Smtp-Source: ABdhPJzJhMCsv9DIr2p50bKrzX+/ZhDja6UADS9AoiMBVU3C3F/pJwgZhRS+rIVYPK+5D15jnq+I8A==
X-Received: by 2002:a05:6214:5c8:: with SMTP id t8mr3683557qvz.86.1598919995600;
        Mon, 31 Aug 2020 17:26:35 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d15sm10918024qka.91.2020.08.31.17.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 17:26:35 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kCu8A-003WwX-Ad; Mon, 31 Aug 2020 21:26:34 -0300
Date:   Mon, 31 Aug 2020 21:26:34 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Subject: Re: [PATCH] mm/mmu_notifier: Fix mmget() assert in
 __mmu_interval_notifier_insert
Message-ID: <20200901002634.GD24045@ziepe.ca>
References: <20200901000143.207585-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901000143.207585-1-jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 02:01:43AM +0200, Jann Horn wrote:
> The comment talks about having to hold mmget() (which means mm_users), but
> the actual check is on mm_count (which would be mmgrab()).
> 
> Given that MMU notifiers are torn down in
> mmput() -> __mmput() -> exit_mmap() -> mmu_notifier_release(),
> I believe that the comment is correct and the check should be on
> mm->mm_users. Fix it up accordingly.
> 
> Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Can someone please double-check this? I'm like 90% sure that I fixed
> this the right way around, but it'd be good if someone more familiar
> with mmu notifiers could confirm.

Hmm.. I added the comment but copied the expression from older code.

The intent is certainly that the caller must have a mmget, this
function must not race with __mmu_notifier_release() and the mmget is
what prevents that.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
