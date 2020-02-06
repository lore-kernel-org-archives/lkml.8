Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1B8C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B2920720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8IIrGyZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBFGns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:43:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39793 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbgBFGnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580971426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XebUo49bNGViZWk1x3tbVzqCjVaBGOH4dpQ4jrfUf70=;
        b=G8IIrGyZ0tDw9PlKycW93pRaNUgjewlPRBrSS+dnyXv46fW9DZTY8tTi8vs3eRvFXS9uyR
        8acNnY28kTdqWroEEIug0M7Xy3Unn3cx5MxkcAZqESY1l3zgEssozykBA/t2jk2b4mL5Dc
        /e1gyA05qJPkqpoVJjF/EEmD9bV23GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-nfSFAOAsPsGxoUg6EfvKSg-1; Thu, 06 Feb 2020 01:43:42 -0500
X-MC-Unique: nfSFAOAsPsGxoUg6EfvKSg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E93A21081FA0;
        Thu,  6 Feb 2020 06:43:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DA945C1B0;
        Thu,  6 Feb 2020 06:43:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9C9639D7F; Thu,  6 Feb 2020 07:43:38 +0100 (CET)
Date:   Thu, 6 Feb 2020 07:43:38 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] drm/virtio: resource teardown tweaks
Message-ID: <20200206064338.badm6ijgyo2p5mmc@sirius.home.kraxel.org>
References: <20200205105955.28143-1-kraxel@redhat.com>
 <20200205105955.28143-3-kraxel@redhat.com>
 <CAPaKu7SCk_3yeTtzFTTU_y-tyo8EDS7vR8i+mk829=0D-UjLQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7SCk_3yeTtzFTTU_y-tyo8EDS7vR8i+mk829=0D-UjLQA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > -
> > -       drm_gem_shmem_free_object(obj);
> > +       if (bo->created) {
> > +               virtio_gpu_cmd_unref_resource(vgdev, bo);
> > +               /* completion handler calls virtio_gpu_cleanup_object() */
> nitpick: we don't need this comment when virtio_gpu_cmd_unref_cb is
> defined by this file and passed to virtio_gpu_cmd_unref_resource.

I want virtio_gpu_cmd_unref_cb + virtio_gpu_cmd_unref_resource being
placed next to each other so it is easier to see how they work hand in
hand.

> I happen to be looking at our error handling paths.  I think we want
> virtio_gpu_queue_fenced_ctrl_buffer to call vbuf->resp_cb on errors.

/me was thinking about that too.  Yes, we will need either that,
or a separate vbuf->error_cb callback.  That'll be another patch
though.

> > +       /*
> > +        * We are in the release callback and do NOT want refcount
> > +        * bo, so do NOT use virtio_gpu_array_add_obj().
> > +        */
> > +       vbuf->objs = virtio_gpu_array_alloc(1);
> > +       vbuf->objs->objs[0] = &bo->base.base
> This is an abuse of obj array.  Add "void *private_data;" to
> virtio_gpu_vbuffer and use that maybe?

I'd name that *cb_data, but yes, that makes sense.

cheers,
  Gerd

