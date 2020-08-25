Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F458C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264882072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqhZ6mVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHYOht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgHYOh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:37:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F040DC061574;
        Tue, 25 Aug 2020 07:37:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p17so7290364wrj.8;
        Tue, 25 Aug 2020 07:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1wejVjdJjFDp//zuNq4iw9VnnSrXMrBCWrU+B996tjg=;
        b=CqhZ6mVu9piKx5tIee8eVB8qt8z0qMqPF1v8MkxUl379kS2e6mFjdaoArhVrA8O2qx
         KqzfrmiQxbJSHSgwI9I0zRQe59A7IJHdIKk5s7hxMTX/BqNCuhZQuCW5K6IoY1Xe69Fw
         FK0nZeMyNIPLgPRxT9QnKpGmTM0MfqUjv5ehPMjD6rwcrKMUDy3n3JfM+freNTnLXLQF
         vAgwYb/j0y9V7ELIaDyhMaDHGwuqb4zmRaTgqyjLf7X5iUzC5OEG5xvdOKXdDmQyd/1X
         5r0BqVfJqdtQwxNTJ8jHjE+V67HK+PqsR5AQB1C+7jF+Jpf7Q6fgRTMUqV0nwUF0zIAG
         zU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1wejVjdJjFDp//zuNq4iw9VnnSrXMrBCWrU+B996tjg=;
        b=eZKbXaxEQmE6Y8JEflvQGJ3QajkwQ2EwtjQKJSdtA1WzcMsv1VRiNUT2syFJQrhKw7
         /3Y/elx7SqBIJKAq3BjqM0862RYNdCAlV8IZGaOc3d2/WgwyLl6GMxgvYrxjV4lVy+Hl
         lc26n5QG2jpUeJt9CCneNisqU70ZbeUYs3S1T3C2PkhxErwjZn2C5ioKR28D4xNQNpwb
         3vO6fGGzHcu2kjxvk7pqdFUYDXWI3hDGwPQMlKZmGVj3O8FHhqgYp0lfR6RO4fuXh5MI
         SaUv9bisiAkpw0yFRHSOjmOCX2sXzCxG7yiWfeS4vxg8kl2og2T5LDOQvKuFO+HDuByr
         ntkA==
X-Gm-Message-State: AOAM533/ZjoT8MtM2u90I6LGozXP1v7uxLRZlZ5CqHxiKo3ncCmBwfyL
        9QNQsLKrNXQf4RmEIh61gi+A+vOCHHO3GFdTdpA=
X-Google-Smtp-Source: ABdhPJy3AYFnvsgq2dH5qSiQ9b/trX2St2yH83z9ADAyiui5u4OcDWeupKkNoGSChUu6CIX5AZVQdhj9aD63JrHRbP8=
X-Received: by 2002:adf:eb0a:: with SMTP id s10mr11044637wrn.83.1598366246593;
 Tue, 25 Aug 2020 07:37:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200822175254.1105377-1-robdclark@gmail.com> <20200825065224.GB30014@infradead.org>
In-Reply-To: <20200825065224.GB30014@infradead.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 25 Aug 2020 07:38:13 -0700
Message-ID: <CAF6AEGtK8b9UkbNMJ8VQMv-909fqKk+3LEXsgtuJ_BW0gVK-CA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: drop cache sync hack
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 11:52 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Aug 22, 2020 at 10:52:54AM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Now that it isn't causing problems to use dma_map/unmap, we can drop the
> > hack of using dma_sync in certain cases.
>
> Great to see!  What did solve the problems?

should be 0e764a01015dfebff8a8ffd297d74663772e248a ("iommu/arm-smmu:
Allow client devices to select direct mapping")

I still need to confirm whether qcom_iommu needs a similar thing, but
I think it is ok as the iommu phandle link is down one level on the
'mdp' device, rather than attached to the toplevel drm device.

BR,
-R
