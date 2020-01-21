Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1666C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4A6922314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYmCEef+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUFx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:53:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41639 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725916AbgAUFx4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579586034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sCaBPZeEJdT4Pf0kOk3x5es44UV2mktFJpDyLiBTSXo=;
        b=JYmCEef+kNXP7IrJozWPoNqlhx18YT2SXHeuDZFAt3iv9DmU+6Oz7ueRut+3R3eE5L9sxo
        jJ6rebiOfmb8ZW9ENrKC+LnLNlIT5xe3TlOAwK6+Fk/o0buwPT6or1g48Vmt2Jd8p0xTlg
        f6gBZZaruKd0vNIxDA2jX8KZu+iKzCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-oRE6kHfxMxCgz2UXM4ClGQ-1; Tue, 21 Jan 2020 00:53:51 -0500
X-MC-Unique: oRE6kHfxMxCgz2UXM4ClGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34ECA800A02;
        Tue, 21 Jan 2020 05:53:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-106.ams2.redhat.com [10.36.116.106])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2D718433B;
        Tue, 21 Jan 2020 05:53:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id AFC6516E36; Tue, 21 Jan 2020 06:53:48 +0100 (CET)
Date:   Tue, 21 Jan 2020 06:53:48 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fbdev: wait for references go away
Message-ID: <20200121055348.s4anrveo2z6avin6@sirius.home.kraxel.org>
References: <CGME20200120100025eucas1p21f5e2da0fd7c1fcb33cb47a97e9e645c@eucas1p2.samsung.com>
 <20200120100014.23488-1-kraxel@redhat.com>
 <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d143e43b-8a38-940e-3ae5-e7b830a74bb3@samsung.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > open.  Which can result in drm driver not being able to grab resources
> > (and fail initialization) because the firmware framebuffer still holds
> > them.  Reportedly plymouth can trigger this.
> 
> Could you please describe issue some more?
> 
> I guess that a problem is happening during DRM driver load while fbdev
> driver is loaded? I assume do_unregister_framebuffer() is called inside
> do_remove_conflicting_framebuffers()?

Yes.  Specifically bochs-drm.ko and efifb in virtual machines.

> At first glance it seems to be an user-space issue as it should not be
> holding references on /dev/fb0 while DRM driver is being loaded.

Well, the drm driver is loaded by udev like everything else.

Dunno what plymouth (graphical boot screen tool) does to handle the
situation.  I guess listening to udev events.  So it should notice efifb
going away and drop the /dev/fb0 reference, but this races against
bochs-drm initializing.

> > Fix this by trying to wait until all references are gone.  Don't wait
> > forever though given that userspace might keep the file handle open.
> 
> Where does the 1s maximum delay come from?

Pulled out something out of thin air which I expect being on the safe
side.  plymouth responding on the udev event should need only a small
fraction of that.

cheers,
  Gerd

