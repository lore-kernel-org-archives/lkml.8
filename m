Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09225C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C169A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 17:27:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BuBH/di8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgIJR1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgIJRZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 13:25:18 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96BEC061786
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:25:16 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so6821567qkn.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 10:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/vqWihJxJulKAswDa6rjsgmUuGAobgE1eufaiUBVJcQ=;
        b=BuBH/di8r/IY0DRgUoiYCEsDFHM9rctUOHuX1VbGAlbkAifpMocTQMVHND/ttsuSPV
         IcwPxMvqGU6aHaPYXJHcHBeZTHrMs4rMSbeJy7D9Qf7oTWF6J64W0r1D1pKmVqPnl/Rt
         BAw4/MWaTiD+wz71ezOFNIdOGgOe16bIS5msss+xIvII3bzfuYyqeLffc493EBNYixbM
         2D9XxhlizMAPq+5rWIaMWGYZUV6CvG+uJANnNsxgpLOpZ0VOwpyIlWIUXdMzbrUlRxny
         AdgU086zI/ts8CK/ZmQ/67BoG9oYERcDUG4on5JtF/CvJPWlY09MK67dGoZGGcoIuBna
         85PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vqWihJxJulKAswDa6rjsgmUuGAobgE1eufaiUBVJcQ=;
        b=KyL11870ShOUGeF9f0+m9F7N8jEoPX3fqTzlMYl1EWBgpY+6WGzEu0M7e/xNYI4n7k
         EQUTMeNHQmmLCwHIZY1GWY1bpINZYwwCSo3cb/OvQ510H+QjiCRH+ADMbh8N4gtJXwmD
         /r7XYcsTwOv+qavxDwPkwQkPNAKfmDRDX7ApTXW+b4qEiY4mkQwAJVqySS9Ntkr8ZZ6N
         HS+OcoLltMRcgQXVBl2+1kRFGZHstShLqr1IHKEqI322AsBh7bUGdsX4AvYgGnuxEVqa
         F/2EH1WYFPvyPX5ZcKYC+9mi+BBKJqOtq/iEoLaiUTdpUW7Zn7hodl8KwGMJBDrSAuIM
         cQGA==
X-Gm-Message-State: AOAM5301GthqvDc5jJwQalHg0VZLU+KNj3GniST6f9F+dktio9t/Uyz6
        hSW3FaZBs6dCoAF9bg697DaLMbjNFrH1Xg==
X-Google-Smtp-Source: ABdhPJx724rN9bj08FdYQXRaOcx+RqDNAhlrS6ZL2LtUQSCPA6BRnG6RnkUZmrQtwpnrDG0fwCYhlg==
X-Received: by 2002:a37:6543:: with SMTP id z64mr9078713qkb.173.1599758715971;
        Thu, 10 Sep 2020 10:25:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j11sm6987698qko.111.2020.09.10.10.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 10:25:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kGQJu-004O47-FJ; Thu, 10 Sep 2020 14:25:14 -0300
Date:   Thu, 10 Sep 2020 14:25:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Ralph Campbell <rcampbell@nvidia.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/doc: add usage description for migrate_vma_*()
Message-ID: <20200910172514.GN87483@ziepe.ca>
References: <20200909212956.20104-1-rcampbell@nvidia.com>
 <20200910105657.6007c5ca@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910105657.6007c5ca@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:56:57AM -0600, Jonathan Corbet wrote:
> On Wed, 9 Sep 2020 14:29:56 -0700
> Ralph Campbell <rcampbell@nvidia.com> wrote:
> 
> > The migrate_vma_setup(), migrate_vma_pages(), and migrate_vma_finalize()
> > API usage by device drivers is not well documented.
> > Add a description for how device drivers are expected to use it.
> > 
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > 
> > There shouldn't be any merge conflict with my previous patch which
> > touched hmm.rst but since Jonathan Corbet took my last patch, perhaps he
> > would like to take this one through his tree too.
> 
> I'm happy to take it, but it certainly needs an ack from somebody who
> understands HMM better than I do.

Ralph wrote all the in kernel tests for this API, so I think he is
well positioned to write the documentation :)

Jason
