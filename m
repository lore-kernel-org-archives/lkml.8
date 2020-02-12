Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B2AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26DAA20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HOsohDmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgBLJfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:35:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39575 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728626AbgBLJfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581500151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Co8sI2fabCgvVIAdRsnaywT6jDF6jkLMvIt7c5U+e2k=;
        b=HOsohDmKIpWVXo3nTz1n6nbguz1/epD8I/8KMiwh0nY0drVtNy236X+FzzHBhKMS5V9aCc
        2g2zNqUx5gBJv0QVvFxOMeO2Y4A+Z4JjeW8Oi4lj60oYzjtf5gijaroTXqHNKMZOFvW91D
        IpTMmVtVrRLNJZSDiVvxWmInjq2QSS8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-KA2V6KLsMOaMd2oUQYkYQQ-1; Wed, 12 Feb 2020 04:35:45 -0500
X-MC-Unique: KA2V6KLsMOaMd2oUQYkYQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC5C68017DF;
        Wed, 12 Feb 2020 09:35:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-39.ams2.redhat.com [10.36.117.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5ACBE60BF4;
        Wed, 12 Feb 2020 09:35:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 937FE9D6B; Wed, 12 Feb 2020 10:35:43 +0100 (CET)
Date:   Wed, 12 Feb 2020 10:35:43 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, olvaffe@gmail.com,
        gurchetansingh@chromium.org, David Airlie <airlied@linux.ie>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] drm/virtio: add drm_driver.release callback.
Message-ID: <20200212093543.qg4j2nk5wxlii7wr@sirius.home.kraxel.org>
References: <20200211135805.24436-1-kraxel@redhat.com>
 <20200211142711.GE2363188@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211142711.GE2363188@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 03:27:11PM +0100, Daniel Vetter wrote:
> On Tue, Feb 11, 2020 at 02:58:04PM +0100, Gerd Hoffmann wrote:
> > Split virtio_gpu_deinit(), move the drm shutdown and release to
> > virtio_gpu_release().  Drop vqs_ready variable, instead use
> > drm_dev_{enter,exit,unplug} to avoid touching hardware after
> > device removal.  Tidy up here and there.
> > 
> > v4: add changelog.
> > v3: use drm_dev_*().
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Looks reasonable I think.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> I didn't review whether you need more drm_dev_enter/exit pairs, virtio is
> a bit more complex for that and I have no idea how exactly it works.

virtio uses two rings to send commands to the device, one to move the
cursor and one for everything else.  So pretty much everything ends up
calling either this ...

> > @@ -330,7 +330,14 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,

... or this ...

> > @@ -460,12 +460,13 @@ static void virtio_gpu_queue_cursor(struct virtio_gpu_device *vgdev,

... to submit some request to the (virtual) hardware.  Therefore we
don't need many drm_dev_enter/exit pairs to cover everything ;)

cheers,
  Gerd

