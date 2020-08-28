Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA81EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846CC207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 11:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d4u9wTJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgH1L2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 07:28:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27244 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729198AbgH1L2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 07:28:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598614084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vcVCnDfXCrpqdXroEZsRpzoOz05edQsOh2pIT4QY95E=;
        b=d4u9wTJIhYCrrklCfYatvJ9ry1ZYxNLYhLyL6BtFCNGqMG38xjtTiIXHcUkdnk4bItdP99
        Y8uD9oC2y7fCfjnIJ4gM3FyzqqZTpuUiLcxQi4xIwGaqaIYNluhdFIdG1DudZaALBl/ZHg
        YdFCHwGUW9pV/AB0uQrtaxKH4A7Hel4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-KhS13XkaMoyyK4EiseYxow-1; Fri, 28 Aug 2020 07:28:02 -0400
X-MC-Unique: KhS13XkaMoyyK4EiseYxow-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43BEF64090;
        Fri, 28 Aug 2020 11:28:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-54.ams2.redhat.com [10.36.112.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCF325D9F3;
        Fri, 28 Aug 2020 11:28:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C877C9C87; Fri, 28 Aug 2020 13:27:59 +0200 (CEST)
Date:   Fri, 28 Aug 2020 13:27:59 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        1882851@bugs.launchpad.net
Subject: Re: [PATCH 1/2] drm/virtio: fix unblank
Message-ID: <20200828112759.rmeeh5bonrewiqte@sirius.home.kraxel.org>
References: <20200818072511.6745-1-kraxel@redhat.com>
 <20200818072511.6745-2-kraxel@redhat.com>
 <88ae71c2-c3ed-e0e4-e62c-bdf9d6534f2a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88ae71c2-c3ed-e0e4-e62c-bdf9d6534f2a@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 09:24:40AM +0200, Jiri Slaby wrote:
> On 18. 08. 20, 9:25, Gerd Hoffmann wrote:
> > When going through a disable/enable cycle without changing the
> > framebuffer the optimization added by commit 3954ff10e06e ("drm/virtio:
> > skip set_scanout if framebuffer didn't change") causes the screen stay
> > blank.  Add a bool to force an update to fix that.
> > 
> > v2: use drm_atomic_crtc_needs_modeset() (Daniel).
> > 
> > Cc: 1882851@bugs.launchpad.net
> > Fixes: 3954ff10e06e ("drm/virtio: skip set_scanout if framebuffer didn't change")
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Tested-by: Jiri Slaby <jirislaby@kernel.org>

Ping.  Need an ack or an review to merge this.

thanks,
  Gerd

