Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56FE2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296892086A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596829644;
	bh=3J6m0L2M1H6OYUCNqt6X/ozt7tphzFWFRd3BR+Q4sdE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Uo4YBq0thrAbF35793fAeGLS1kLWyitEkerT6fqHSVHzWHyOTZk+h8/8RFZv2S6Yx
	 hOCoj8+d6UOJ2dtcYxR1Y5YbBj7cdBoyA2ufcUH3Jn8q2/VstZm2QCD2pxU2I4gXdT
	 grqSKmFtrVDgpGGiD/wFM9aQ35g0v80U1b+/fF38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgHGTrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgHGTrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:47:22 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 630CD22CA1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 19:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596829642;
        bh=3J6m0L2M1H6OYUCNqt6X/ozt7tphzFWFRd3BR+Q4sdE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZsZVOnU0pSYlXCiknGgpzZ+yoJggEaZQgAobS6FE23rUVqN6a8RbLV9/R4gY80skh
         l2n9eHAw4Outhaghsb5o7cqPeB7bhMxJ1pXv2nojezu/Hu779bT/VAplrQWS2bVnPb
         5oQHwGBk8XQ38k63F6pkOUCGCDBITrtsK1rQSnxg=
Received: by mail-oi1-f179.google.com with SMTP id v13so2927427oiv.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:47:22 -0700 (PDT)
X-Gm-Message-State: AOAM5326D+Hm7aiRdbcJo5TN5v6ebODX/at8YO+z9pDpTW2UvEBFGDt8
        oUVQWr//G/T9lOhNGP2o+uvrQhvD2VNDy6ZGXQ==
X-Google-Smtp-Source: ABdhPJyDBKNKazQW/H5+sfR53s7164vQnk9FjIqPg3Oig0DKLylafCiJV+BIvaMmp1qTHNFx1uIlWVQ5HREMyGpLsKY=
X-Received: by 2002:aca:bb82:: with SMTP id l124mr12846734oif.106.1596829641729;
 Fri, 07 Aug 2020 12:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
In-Reply-To: <20200611085900.49740-1-tomeu.vizoso@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 7 Aug 2020 13:47:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLw9t0GJ4dDu6DgW4_Vwy3LzX_uCUJYXCN5rD-WUNEHTA@mail.gmail.com>
Message-ID: <CAL_JsqLw9t0GJ4dDu6DgW4_Vwy3LzX_uCUJYXCN5rD-WUNEHTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] panfrost: Make sure GPU is powered on when reading GPU_LATEST_FLUSH_ID
To:     Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 2:59 AM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>
> Bifrost devices do support the flush reduction feature, so on first job
> submit we were trying to read the register while still powered off.
>
> If the GPU is powered off, the feature doesn't bring any benefit, so
> don't try to read.
>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Both patches applied.
