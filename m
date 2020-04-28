Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28A9C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E38E20757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 15:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="JnahAMhE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgD1PcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 11:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727917AbgD1PcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 11:32:07 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFFCC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:32:06 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u16so3339801wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fyTgxWA2/HoMwR8ETQ07Hg4eZzNMuWdW9xEgr0yJj2c=;
        b=JnahAMhEEz80r2yHKCjybbTF6t6+SIYUFMUPAtQp+GL3mUUzkfUaqp5KTHLcTJv+bq
         P81fy3Eh2D06/VO0ChUgMzUqlCQznBNcz0ezSC/Grx8Mg9Ct3d9vHUd1Fi4rVLtYvIEe
         M0+tdFHnDzbT2poSNgYQX/Eonc2j0jEST5fYI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=fyTgxWA2/HoMwR8ETQ07Hg4eZzNMuWdW9xEgr0yJj2c=;
        b=IYdand+CfEkLJqK+H11ftEpxAu1OtiuemXgu7QFgWWrovcgNfgdLFbbV8jobB0lORo
         oseINBfDWdnPmjgFJDl5tTVzFoxqDR7TRJ2FCRZzXwizELm3w1GXfUHYH4w4d4R4Vi3S
         Tm0YQ43A4117WqJeMW3K55NilUxqtcdAsiZXQEvIE9SR5+n4ZWk0vefuFhctF8Y4nZD4
         bJp5pcBSQQ3SIF4LHE+p/LPWRE+0ypbJfJUKLhTgxhWgbSgJO6zUgZ62ZBx1H72sWPEf
         cv/DQp50jvRyN/Zrd9VfCTjl/AHj7AtOJOJnXMIwpsU36VSUrnT/d6dW6tUvIQpUtnBi
         HqSw==
X-Gm-Message-State: AGi0PuYAJW1nkyP5bxnmaIilpj6ksQPYmNHaCJH+taR3wsCcIdp0464O
        9+z8K6R48GoG8YuDFN9GBLTPMA==
X-Google-Smtp-Source: APiQypK6liIbViG0xJy6SG6E2JLUCRqc/Rd4DEdt0buwtJigcJZRTqgPIaD55s8f3mCsTYZkcr3q5w==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr5073523wma.24.1588087925505;
        Tue, 28 Apr 2020 08:32:05 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p7sm27283944wrf.31.2020.04.28.08.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 08:32:04 -0700 (PDT)
Date:   Tue, 28 Apr 2020 17:32:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC 00/17] DRM: fix struct sg_table nents vs. orig_nents misuse
Message-ID: <20200428153202.GY3456981@phenom.ffwll.local>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, amd-gfx@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>
References: <CGME20200428132022eucas1p2aa4716cbaca61c432ee8028be15fef7a@eucas1p2.samsung.com>
 <20200428132005.21424-1-m.szyprowski@samsung.com>
 <20200428140257.GA3433@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428140257.GA3433@lst.de>
X-Operating-System: Linux phenom 5.3.0-3-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 04:02:57PM +0200, Christoph Hellwig wrote:
> On Tue, Apr 28, 2020 at 03:19:48PM +0200, Marek Szyprowski wrote:
> > 1. introduce a dma_{map,sync,unmap}_sgtable() wrappers, which will use
> >    a proper sg_table entries and call respective DMA-mapping functions
> >    and adapt current code to it
> 
> That sounds reasonable to me.  Those could be pretty trivial wrappers.
> 
> >
> > 
> > 2. rename nents and orig_nents to nr_pages, nr_dmas to clearly state
> >    which one refers to which part of the scatterlist; I'm open for
> >    other names for those entries
> 
> nr_cpu_ents and nr_dma_ents might be better names, but it still would be
> a whole lot of churn for little gain.  I think just good wrappers like
> suggested above might be more helpful.

I guess long-term we could aim for both? I.e. roll out better wrappers
first, once that's soaked through the tree, rename the last offenders.

Personally I like nr_cpu_ents and nr_dma_ents, that's about as clear as it
gets.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
