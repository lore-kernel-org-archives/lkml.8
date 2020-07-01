Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E03C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C3C2073E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Boox+tm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgGAH5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbgGAH5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:57:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61395C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 00:57:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so25791029ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 00:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nppZMn8IG/x/P34XDI8YF5pOl6MlI1Bm1JmwS3tV0yQ=;
        b=Boox+tm54fOiXje1cmofks27n2hoUJw88n9u/2LWX5hJdcJ+OF6k+EH1ahpVpH8hD8
         l5NVq0SCnbe9lZJKWbXYwV1+hx5foXPSbl+aGuuohkWDtvx/BBuXQCl0R4EjQTV6wc9X
         p8XWJfALmcucOvoVjiFK11m16U6t1ufvjBduiF7jscXrRUoZIudTB/qWHlp6W9zW+FoI
         xdu4Qyz+5aA/KGWScXwb5p6egeUCBrN4vjO/fXESjcXc/qfL7BlefEF3OjoBxSOhUTxa
         2nFIbgsbQ4BLOMaB0/SGGT2dg6V/mJjNziOhlFNNjYJN+QJI6Ohu7sov9dBq8cOem4PP
         cBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nppZMn8IG/x/P34XDI8YF5pOl6MlI1Bm1JmwS3tV0yQ=;
        b=RNpi/Xk/BpBxVpjHAWs0b8BjTftXFY81B6Gg6zzDkdLPZ2bM7T7uH2rNOwN8kzs2Fh
         U32Lj9+UKsJ5OlKyV92NYOM2GOm8W9G8X+6DjM6IPtWgb3jHAm9Pl/HkWNDiyC8csaP8
         L7Hzj/iliVivh45yDQ8QYOoYTDjClrVTHboiBxb3GD+HSEFVTNGfjcj1t84FElAHZs22
         X8bZEiztonLLJ4z/P0325dS+gHsKYZNH29eHQC8TBZDGEZvf8w7ZWUJJSMKYxH1snMnY
         5z0urnptHx9Ds1gj9BKGywzFMZugSWd3X9vYQVH3oO+sjv513gmLpq0xbRZw32wnaWCU
         OhnA==
X-Gm-Message-State: AOAM532/dEz8wbm5OV6/yzJR8dwnWMFOZ5Sk6d/jdQJ/xKgaB2la1x2h
        oreg9r+DuK7Xi8w7QfgSRxCGxg==
X-Google-Smtp-Source: ABdhPJwBA7EZ9ifbC0OQDRGW5amYBrScua4tcV+VnmhMNzDwOw4Z+So/IRbP3OCKrea7bo9EmvuzpQ==
X-Received: by 2002:a2e:9b89:: with SMTP id z9mr12333738lji.163.1593590242821;
        Wed, 01 Jul 2020 00:57:22 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id c14sm1534598ljj.112.2020.07.01.00.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:57:22 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F3D64101196; Wed,  1 Jul 2020 10:57:19 +0300 (+03)
Date:   Wed, 1 Jul 2020 10:57:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     James Jones <jajones@nvidia.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [git pull] drm for 5.8-rc1
Message-ID: <20200701075719.p7h5zypdtlhqxtgv@box>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200630230808.wj2xlt44vrszqfzx@box>
 <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef7816b4-72ee-9e0e-8cac-4d80d8343f9f@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:40:19PM -0700, James Jones wrote:
> This implies something is trying to use one of the old
> DRM_FORMAT_MOD_NVIDIA_16BX2_BLOCK format modifiers with DRM-KMS without
> first checking whether it is supported by the kernel.  I had tried to force
> an Xorg+Mesa stack without my userspace patches to hit this error when
> testing, but must have missed some permutation.  If the stalled Mesa patches
> go in, this would stop happening of course, but those were held up for a
> long time in review, and are now waiting on me to make some modifications.
> 
> Are you using the modesetting driver in X? If so, with glamor I presume?

Yes and yes. I attached Xorg.log.

> What version of Mesa?

20.0.8

> Any distro patches?

I don't see any. It's Gentoo.

> Any non-default xorg.conf options that would affect modesetting, your X
> driver if it isn't modesetting, or glamour?

Modesetting without anything tricky.

-- 
 Kirill A. Shutemov
