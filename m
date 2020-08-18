Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10010C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9502083B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XrifYsF5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHRBwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgHRBwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:52:34 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3113EC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:52:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id f19so9558451qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 18:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szzpFDA9AlK4enccjSiFaUNDWItaYlytHuvona3L4xE=;
        b=XrifYsF5rKfoCWUjJR56iJTuvGs1mu+hofxMCRYvN1bgU+9hCume8MfdskDYx/GXUi
         qvEoW0g2PrbsvnXO5CaiZC1mOPUQAVJ9FMbksSCTsWnT24/upbZp/dhWv4hX4hHLZZ+i
         FLEIIS2aoHuICneFAVnJh2bcK/OldVdEs4CP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szzpFDA9AlK4enccjSiFaUNDWItaYlytHuvona3L4xE=;
        b=GcRT7EgOCyddY19UZytHtevuI+uIlWcXifr1g+kikPikOYvTgeeqsR8e6jyCmv6XcK
         ZrEhAl1Iqfm6y0i9tqriTY57TZ9ZrXt7Zww+qgs4R719RASB/WVkftrKxdrk/P3cmcAk
         xuea5/y0o4R26tagxiQkEayFVStgL6bloVWAD67ENIlPrC62YRZxOGHpN2gNcubDvp3c
         IOBpbFTb8hP+0YoUcD1nwnKUNLXboVTK+CCZc2ztqQ54BZMZJSZlmHA9ohjcZedy9jLE
         LoBmLeeqBfgZbpbx4GX5rVqjCZLjdmBoHlnxDAxMsrN1jlHmBIV4xCiDp9TN6Asfw/X9
         28kQ==
X-Gm-Message-State: AOAM5323nsMb5OVCRkhSs3FJ7fNkhSJyytpiFYKzwzBJM1jqSbyYoFHa
        YiZEO04bj/c4TsWePJVoA7lOhmx7mSTteiZQbMMPDg==
X-Google-Smtp-Source: ABdhPJxTMwbSOeJZ+JjlM+dBnOrWPf2Un6ZL7ISpGYM5sJBiPu9rwbZVoK+XvNs2l/kehDF6aM8NBGUpgV8YpoFB/PU=
X-Received: by 2002:ac8:45c7:: with SMTP id e7mr16254448qto.187.1597715550749;
 Mon, 17 Aug 2020 18:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200609012518.198908-1-stevensd@chromium.org>
 <20200609055021-mutt-send-email-mst@kernel.org> <CAD=HUj7wJfoKj_K44Cs9eEmh=OQHZ1+qz7ZHxoscHjYgOMXvZQ@mail.gmail.com>
 <20200817105008.mi3ukh6kxgi37gjs@sirius.home.kraxel.org> <20200817111234.i7pqtnnk2ciw4rqb@sirius.home.kraxel.org>
In-Reply-To: <20200817111234.i7pqtnnk2ciw4rqb@sirius.home.kraxel.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Mon, 17 Aug 2020 18:52:19 -0700
Message-ID: <CAD=HUj65N3ejzYgUcpHLvPHguXFDC-B4OFeNOfvSML1zdoNRPg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v5 0/3] Support virtio cross-device resources
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
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
        <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org,
        alex.williamson@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 4:12 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Aug 17, 2020 at 12:50:08PM +0200, Gerd Hoffmann wrote:
> > On Tue, Jun 23, 2020 at 10:31:28AM +0900, David Stevens wrote:
> > > Unless there are any remaining objections to these patches, what are
> > > the next steps towards getting these merged? Sorry, I'm not familiar
> > > with the workflow for contributing patches to Linux.
> >
> > Sorry, just have been busy and not paying as much attention to drm
> > patches as usual.  Playing catch-up now.  Queued for drm-misc-next,
> > unless something goes wrong in my testing the patches should land
> > in linux-next soon and be merged upstream in the next merge window.
>
> Oh, spoke too soon.  scripts/checkpatch.pl has a bunch of codestyle
> warnings.  Can you fix them and resend?

Sent a new version to fix the line length warning. There's still a
MAINTAINER warning, but I think the new virtio_dma_buf file can fall
under virtio core (and the existing wildcards do match it), rather
than get its own MAINTAINER entry. I can break it out into its own
thing if that's better, though.

-David
