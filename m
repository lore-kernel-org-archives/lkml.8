Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B40B2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oSZInwNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391221AbgFXOQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbgFXOQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:16:06 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4A7C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:16:05 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o38so1765923qtf.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XTCcXGeK3qAQaLUsGMJxhzPxremK361bquJrJgQE1cM=;
        b=oSZInwNusWE97EVutQIRbsJeBwslSniUVMBcKNO5NzFS7QUontuAM2vj5hBHD3405f
         8/T8VTo/2qNlvZ2mO8SqIxgrFiwgjfwtdJObthz+QUT21YDapCuMiaQjzpM8i3R/K2D6
         V59F28UZQKm3pQxZiiguo1/NSuA2pV2/dBPu4jpU025NhlxFAypTeOFaHZnOiBoGOzAK
         jYUf+43UMVm+hYo50GLy/6b7ck9nYGi8syhkkTTa6r7J+nB8DUE+Vu8XsdZDuEMQ2NZO
         j689EkUzQ6ZL76x4cpO85iq+iACVRyJpNLylmnZNG0BABFBIUTTrPgIc0Gf+UGbOdOy7
         sNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XTCcXGeK3qAQaLUsGMJxhzPxremK361bquJrJgQE1cM=;
        b=MCJ2KPmiyg1pqlLLpxj8tr1VWnYcrjBDB0l6O8Yeer8HZxMR+f4sot5OPyUYUB2ld9
         pVw2c+zrCI3voNcBCMVcE5zu6e+9P/DvC2mknCcZbambSQUHG9MsU/py7u8DjgeYZHl7
         RpG6CklSTlRgszQDDCKPJLgdvghWo4WDlIBIHatK37DP+LWB9EKncYb2jxg+oP5ZjEwS
         RZexnzX79n5xufDFdM99bXCrb6Pb0tTZg+pt4LtDT7Fzjsxn/n7OtGmtKGsTs0P9yF/c
         n1FNxMdvFwrjCMeLCvVaKn8x26QnuchaY3esnj7m0iusVwvjnnRL39eS3BQVJ4xhNQog
         pg0Q==
X-Gm-Message-State: AOAM532OvHPg2zMf7wH3Oh5XMmrwa9nZc95q5E+/tnUpWzo8bbEoXg1L
        4M7bhskv1eqyB5fwSaaw1DOeaFV6qkFLNw==
X-Google-Smtp-Source: ABdhPJyW2dPUM+A7yBYIrkOOv8sORMSsfevlcFmoEvCmSNNu6lYvZkMYo+cDmLcsvnM9ij/fbJQwOA==
X-Received: by 2002:ac8:6f79:: with SMTP id u25mr27438038qtv.183.1593008165117;
        Wed, 24 Jun 2020 07:16:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id t9sm3479450qke.68.2020.06.24.07.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 07:16:04 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jo6C4-00DVi4-3z; Wed, 24 Jun 2020 11:16:04 -0300
Date:   Wed, 24 Jun 2020 11:16:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] mm/mmu_notifier: Mark up direct reclaim paths with
 MAYFAIL
Message-ID: <20200624141604.GH6578@ziepe.ca>
References: <20200624080248.3701-1-chris@chris-wilson.co.uk>
 <20200624121053.GD6578@ziepe.ca>
 <159300126338.4527.3968787379471939056@build.alporthouse.com>
 <20200624123910.GA3178169@ziepe.ca>
 <159300796224.4527.2014771396582759689@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159300796224.4527.2014771396582759689@build.alporthouse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:12:42PM +0100, Chris Wilson wrote:
> Quoting Jason Gunthorpe (2020-06-24 13:39:10)
> > On Wed, Jun 24, 2020 at 01:21:03PM +0100, Chris Wilson wrote:
> > > Quoting Jason Gunthorpe (2020-06-24 13:10:53)
> > > > On Wed, Jun 24, 2020 at 09:02:47AM +0100, Chris Wilson wrote:
> > > > > When direct reclaim enters the shrinker and tries to reclaim pages, it
> > > > > has to opportunitically unmap them [try_to_unmap_one]. For direct
> > > > > reclaim, the calling context is unknown and may include attempts to
> > > > > unmap one page of a dma object while attempting to allocate more pages
> > > > > for that object. Pass the information along that we are inside an
> > > > > opportunistic unmap that can allow that page to remain referenced and
> > > > > mapped, and let the callback opt in to avoiding a recursive wait.
> > > > 
> > > > i915 should already not be holding locks shared with the notifiers
> > > > across allocations that can trigger reclaim. This is already required
> > > > to use notifiers correctly anyhow - why do we need something in the
> > > > notifiers?
> > > 
> > > for (n = 0; n < num_pages; n++)
> > >       pin_user_page()
> > > 
> > > may call try_to_unmap_page from the lru shrinker for [0, n-1].
> > 
> > Yes, of course you can't hold any locks that intersect with notifiers
> > across pin_user_page()/get_user_page()
> 
> What lock though? It's just the page refcount, shrinker asks us to drop
> it [via mmu], we reply we would like to keep using that page as freeing
> it for the current allocation is "robbing Peter to pay Paul".

Maybe I'm unclear what this series is actually trying to fix? 

You said "avoiding a recursive wait" which sounds like some locking
deadlock to me.

Still, again, notifiers are for tracking, not for influencing MM policy.

Jason
