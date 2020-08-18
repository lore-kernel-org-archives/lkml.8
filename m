Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4B7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58CDC20658
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cSXYbK0K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHRHLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRHLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:11:32 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5967EC061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:11:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id o22so14405208qtt.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 00:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n3a7THydnGAc5AUiVljLET4u580OnrFmLIy37AEhH7s=;
        b=cSXYbK0KhcTVcj3BN3p2cBdYHCmnPysTZnSvj9ozXtLSA19RMMmA89oJO5/M1Xu2Sv
         Q2CmHVgmJ/KCHNsetwkfVKIzQFCyjKAUb6lnuLbq1xJpxHek2X/hnt5SkFX8hXQbF2Io
         7W9qXbc0V6MaWGjCotnlmRdc76WVPPRnUfJls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n3a7THydnGAc5AUiVljLET4u580OnrFmLIy37AEhH7s=;
        b=Kxtoj776RZWdnOM4SG1wy498BLqPd0Ejn8qatgyXRtOVB4ZU2zCJuPSp0UzSW1zn1B
         iSo/nCo/nPs0A5yw2abQD7S6jbFkErhXxVrsnczirTHWHw0+xrG8+0f9UYQZF6naKPYD
         TeDFeF5gR1llI2aPqQwrix0HxICMjt+i23hq87FfsA0pZlRQaE1ccB+Mqbd1XWBZ/gUP
         be+D+SMYWQCggZiDqI7x+km43qFzEZvnyLklnNlhDp8/qdknoBlMsyB3v2OfIpuAOoY0
         V0m/E4BbsBY948g+0OOpf9TUZvQQvOgDmm6rjsqO934OjXd6h1ACTozctf55+D+4n2hI
         sBrQ==
X-Gm-Message-State: AOAM530Kga7YjGTeu4R0Ko7ZAou0eRoUxv46fG4oQGSJWGS2vezFwRNB
        y0cnMc1xj9lCdZk/qMYjCUaUh5aLp+dAJMgjvikD0Q==
X-Google-Smtp-Source: ABdhPJyZusOXlJEolyPUq2uzLSLnrLlZCeUK74TdElz/4gT5+YLKvVKLVDF3+1Btr0gUklkg9hbaYCqMSoip66/ILus=
X-Received: by 2002:aed:3587:: with SMTP id c7mr17004433qte.136.1597734691473;
 Tue, 18 Aug 2020 00:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200818013744.3327271-1-stevensd@chromium.org> <20200818055949.6si4jzuubba5dx5u@sirius.home.kraxel.org>
In-Reply-To: <20200818055949.6si4jzuubba5dx5u@sirius.home.kraxel.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 18 Aug 2020 00:11:21 -0700
Message-ID: <CAD=HUj5xqNE=7VPMH5MDq8h735-OnbancrkemJGkDKYmeddfNQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Support virtio cross-device resources
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, checkpatch still complains, full log below.
>
> IIRC "dim checkpatch" runs scripts/checkpatch.pl with --strict
> so it is a bit more picky ...

Ah, I didn't know --strict was being used. I'll send an update
momentarily. Sorry for the churn.

> -:250: CHECK:PREFER_KERNEL_TYPES: Prefer kernel type 'u32' over 'uint32_t'
> #250: FILE: drivers/gpu/drm/virtio/virtgpu_vq.c:1118:
> +       uint32_t resp_type = le32_to_cpu(resp->hdr.type);
>

For consistency with the rest of the virtgpu code, I'll leave uint32_t.

Cheers,
David
