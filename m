Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60983C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38E3A20787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="aGN8/fYl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728968AbgEZLcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgEZLcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:32:00 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918A0C03E97E
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:31:59 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o13so15977479otl.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edTucrrhXN6V4llb+iJ6E89JH542mkCUYUO4cFFBSq8=;
        b=aGN8/fYlBZtC/O0HPJioAJDFXEl1EKIqh48gVGEseZge1RSD+6ZJ+Vd1Ygk7WsUiBQ
         2koLpbOnSxVT+v4ugow+jFX2DiKRsHvM/7p+yEm/ZUa0ijbY2x4j1GqJXf51BsbzMDnD
         BQSFbmNzjABlRFcmrqZN1EwG4aypCM6kLqRH0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edTucrrhXN6V4llb+iJ6E89JH542mkCUYUO4cFFBSq8=;
        b=YmPNV69LEcUatfe0ZxGdmMcj3JzL4pmnsiVMJr0gsTmKU5cYBR+6+db2qcfq0NuO4+
         TMj/6Iuu79N9YKGjowZk91CK+MqPt2xI0bILhFAXy8XdCtxRe0HVcX/GUEt/c0UQ424o
         A5RgwKQroK9rA2LEFi6iFmvkLtu8aq30jbQNz13sdhpAd31CmmymanW2LN45kO6ljgrs
         zge/UJ8HZy9wO7h3zjsNS4JDsMsWwGdM9nL9I3oguXAiSJdTbJD3Kkn5umo2sjhINiRg
         TIvq+5rYB4AdvA/l2a8768xlmPmPOrYtOAtohxFVbAoPl8Fqo+y+01MEkNLzmmyCQact
         FKtQ==
X-Gm-Message-State: AOAM531efku5uLu7G+d1GC/iMSw70CRn2MFWPRnqkKWzVqmoTtjhO3cF
        KnM65fCkOlGOxtrlEIpoNuxoksGTRcJvhn/J7OQzXA==
X-Google-Smtp-Source: ABdhPJzCrvWpIr7oiZie/ZO14zr8xx2eKHZLh/b7YFaD0J7MeUVnKhbsTaugx/2157KZB7xg+CLgr312FbFucLK+W50=
X-Received: by 2002:a9d:600e:: with SMTP id h14mr497056otj.281.1590492719014;
 Tue, 26 May 2020 04:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200513132127eucas1p23f6be10bbd627e69e36d2451068b3204@eucas1p2.samsung.com>
 <20200513132114.6046-1-m.szyprowski@samsung.com> <20200513134741.GA12712@lst.de>
 <83d04017-c6f2-d714-963c-ffa9c7248790@samsung.com>
In-Reply-To: <83d04017-c6f2-d714-963c-ffa9c7248790@samsung.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 26 May 2020 13:31:47 +0200
Message-ID: <CAKMK7uFkvhytb9vKng+2_LuaLFvnEB_5e2s5EAWnVgA9VjRwZA@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] DRM: fix struct sg_table nents vs. orig_nents misuse
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 9:01 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi
>
> On 13.05.2020 15:47, Christoph Hellwig wrote:
> > I've pushed out a branch with the first three patches here:
> >
> >     git://git.infradead.org/users/hch/dma-mapping.git dma-sg_table-helper
> >
> > Gitweb:
> >
> >     http://git.infradead.org/users/hch/dma-mapping.git/shortlog/refs/heads/dma-sg_table-helper
> >
> > and merged it into the dma-mapping for-next tree.  Unless someone shouts
> > the branch should be considered immutable in 24 hours.
>
> David & Daniel: could you merge all the DRM related changes on top of
> the provided branch? Merging those changes separately would take a lots
> of time because of the dependencies on the sgtable helpers and changes
> in the DRM core.

We generally freeze drm for big rework past -rc6 (small drivers tend
to be a bit later). I think simpler if we just land this in the merge
window and then smash the drm patches on top for 5.9 merge window.

Or all in in the same topic branch, but feels a bit late for that and
making sure nothing breaks.
-Daniel

>
> Best regards
> --
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
