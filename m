Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10268C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:51:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA61E208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 08:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vx/5vkxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEIvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 03:51:04 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:36159 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgCEIvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:51:04 -0500
Received: by mail-qv1-f68.google.com with SMTP id r15so2083384qve.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 00:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=El/sfTpddW1bZLTnEnZCZcYJORrAN8Tq9vEVAml0EDE=;
        b=Vx/5vkxdn/hKg0Q8e8NxBkcGhDJsI7LG99cvLlcR/CVLIZ3nLfz++O1Kmbsg/jzf9L
         zKzg6AUYXpm1eBFv9Q/0M27de2rBPlAOqTARP+BlnJoakmL7bC0yE+sPNk6GGceazIs7
         OFDwJ48nJmQd4RvveTIeupNBOekk28UEEb3QA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=El/sfTpddW1bZLTnEnZCZcYJORrAN8Tq9vEVAml0EDE=;
        b=Z3pduk0BkkZUCamcq6yR8j7cQ7Yv1K6cMYqvvyYjo4yADpzSCLPEnys8h6sYM4wPuw
         hwytwI/LzV+Szc30yy3rpgaINIvSG0FeKGhDOAalNIZXlhA2RSU1e1X8HpQti9QnxiLv
         Jn3v8L2JIWAJPmOFpT528n9RiSolxtdw9dfY2w5pfxVTOH4YXVb+noWwFpFXfRph6DLD
         clXMrjEWFol6ep0rFBbQiUUhdXKwC5jYciGfT3VSmpn+rkFojAAGW/tjiB3Fax12Xkz/
         3mhzlx8srA3kuRav8gSLAgDDErRDhEpr5wA50OAe9DdIcM2Yz07j8O7rwUmzadCQBkoR
         DnjQ==
X-Gm-Message-State: ANhLgQ1yoJKiJtrFiTZ8CZtFsi0iRMO/0Oc1NYSxvLXxZSaicqvPwo+8
        kJjby+jOYBNT0LwiuCKuVwmugmoujtkUjgiAuTmA+A==
X-Google-Smtp-Source: ADFU+vuXxgY7/ed9EAAffDRefWFzcupI8LrsMya2Q/mcmPS0VFPAjByjJPtT1mwbJ0eu/04sihvT5tTllkXJEr3T8J8=
X-Received: by 2002:a05:6214:10c1:: with SMTP id r1mr5594398qvs.70.1583398262104;
 Thu, 05 Mar 2020 00:51:02 -0800 (PST)
MIME-Version: 1.0
References: <20200302121524.7543-1-stevensd@chromium.org> <20200302121524.7543-5-stevensd@chromium.org>
 <20200304080119.i55opxkhk4kdt4hp@sirius.home.kraxel.org>
In-Reply-To: <20200304080119.i55opxkhk4kdt4hp@sirius.home.kraxel.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 5 Mar 2020 17:50:51 +0900
Message-ID: <CAD=HUj7jS5jaRmiJwtGMSQZnR8Qd0VvPkBSbs1d-nATdczWdZA@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/virtio: Support virtgpu exported resources
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 5:01 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > +     if (vgdev->has_resource_assign_uuid) {
> > +             spin_lock(&vgdev->resource_export_lock);
> > +             if (bo->uuid_state == UUID_NOT_INITIALIZED) {
> > +                     bo->uuid_state = UUID_INITIALIZING;
> > +                     needs_init = true;
> > +             }
> > +             spin_unlock(&vgdev->resource_export_lock);
> > +
> > +             if (needs_init) {
> > +                     ret = virtio_gpu_cmd_resource_assign_uuid(vgdev, bo);
>
> You can submit a fenced command, then wait on the fence here.  Removes
> the need for UUID_INITIALIZING.

Synchronously waiting is simper, but only doing the wait when trying
to use the UUID can help to hide the latency of the virito commands.
That can save quite a bit of time when setting up multiple buffers for
a graphics pipeline, which I think is worthwhile.

-David
