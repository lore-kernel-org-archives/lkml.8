Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C16AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB8FD207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 17:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anholt-net.20150623.gappssmtp.com header.i=@anholt-net.20150623.gappssmtp.com header.b="mAXh/LKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbgE0Ra6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 13:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE0Ra5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 13:30:57 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323E0C03E97D
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:30:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id k5so29896946lji.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXtUXHnihi65Qkky3QBg/wO8Z4FKZ8HK0jwFU/d0C1U=;
        b=mAXh/LKAKtst4Z3OgR5OvCltmndxuNEjZQX+8dipX11S4NVUuzI1BduWwJIOd+6DbB
         6a+NxABiUGXEAf0RRGCvjxerV1sRnnXWb9tnLSD2EL0cWq62ZIoDDhmWb3h6DcFZKRnq
         vYqaWZiaXxv8mG5WFibpZalTRI7liMgwoPwfLPMs5bjBFbIiOiNdnugZKvOwMzZ6uSfX
         Vy6rNk6gQ584/+hDTLOf+SvZBSBIpqid54R/B5q4Kq+q9O1s9BbZ7hw3UWlJxyFPE8+o
         UZE1fx8or/NhVPUNdYyYiAIl2BUAVuY70wq7G5z+Y5QcQk6Lr81KS6MqXz1eHZwM3Q4k
         6Jow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXtUXHnihi65Qkky3QBg/wO8Z4FKZ8HK0jwFU/d0C1U=;
        b=nte+ZUyxPdH+yC0iRKpTi6edREX9/OJZklRb5YNEhyZJYVWVssBGFo5ucIpetlz4up
         M1SgaI+LVrkZXLYR9XOeEieTEgXh5qAQQ6c2Hb3Q5U6IYTj/nqxurmYTLbTegUonlwVM
         rHGq0OOYqNvqsvGbCiPShs+tUFpvDHR1oqxGSFqU2e2ifJhK3zC9R6ROkeCxiAueHIQQ
         DrEoFggcRoJXesMq/LCcK2ZTzwvCnMzkhlQHb7uYOhNBXevRvL41IMTmIgwp5X3X2Q4N
         QhRFbsV5Ql3y4CzagGPijPzZSoLJ819DoiXtnD2duxpq/TQTRHmDhKUQ6XhSLaI4a4rq
         UCfg==
X-Gm-Message-State: AOAM533EmE4hNI3pKYepHmpJ2pgIgkvwutYkiW9lDTqJShm+Y4v+DjRA
        LEu++pCZkn6vJeYKJaHepDvdRh4fo6RoBlEFni4GLg==
X-Google-Smtp-Source: ABdhPJxLtTyXye6ERqUE6zRYmVzfg6k8wpZJsO3V9z/mvydFM0oASGA02J46IB8UgDa1+yhgHxpCV04mqchdroj6ayc=
X-Received: by 2002:a2e:8ed3:: with SMTP id e19mr3799428ljl.367.1590600655617;
 Wed, 27 May 2020 10:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <2c6a651cac6359cb0244a40d3b7a14e72918f169.1590594512.git-series.maxime@cerno.tech>
In-Reply-To: <2c6a651cac6359cb0244a40d3b7a14e72918f169.1590594512.git-series.maxime@cerno.tech>
From:   Eric Anholt <eric@anholt.net>
Date:   Wed, 27 May 2020 10:30:44 -0700
Message-ID: <CADaigPVObO=mS5zKmB7qKPgUke-mKz7xQ+N3hatkU7dEAAAOVQ@mail.gmail.com>
Subject: Re: [PATCH v3 040/105] drm/vc4: crtc: Turn pixelvalve reset into a function
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wrote:
>
> The driver resets the pixelvalve FIFO in a number of occurences without
> always using the same sequence.
>
> Since this will be critical for BCM2711, let's move that sequence to a
> function so that we are consistent.
>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Patch 34-40 also r-b.

Going to take a little break, this is a lot to try to process at once.
Hopefully you can merge reviewed stuff to drm-misc and shorten the
series.
