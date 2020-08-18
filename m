Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D63C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24162206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brekEtiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgHRJBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:01:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32250 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgHRJBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:01:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597741261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LwYlioqpHS/gmxgOcffqAwVxuvHCLYruQxEepn5wr38=;
        b=brekEtiubhn089zUnXdUhyElBn+swpGj+xb4HJIPMUZa9I33U2xhMMriwzAifF7n9Bv/zB
        afT3VylL3J4nVI+7x+qLw4qKiBhjvV2m4xg9/KgdDqmp0rPZ6PZQWdQVDhYYhWBF0y38IL
        I5CKNfXtF5WKK5wQ0r2wXsjat3G0ho4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-mlrecaKvN2iRk-aKQOmtPQ-1; Tue, 18 Aug 2020 05:00:57 -0400
X-MC-Unique: mlrecaKvN2iRk-aKQOmtPQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5813A0BC2;
        Tue, 18 Aug 2020 09:00:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFEDA5D9D2;
        Tue, 18 Aug 2020 09:00:49 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 078151753B; Tue, 18 Aug 2020 11:00:49 +0200 (CEST)
Date:   Tue, 18 Aug 2020 11:00:49 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>, Sandy Huang <hjc@rock-chips.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        "moderated list:DRM DRIVERS FOR XEN" <xen-devel@lists.xenproject.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "moderated list:DRM DRIVERS FOR VIVANTE GPU IP" 
        <etnaviv@lists.freedesktop.org>,
        "open list:DRM DRIVERS FOR NVIDIA TEGRA" 
        <linux-tegra@vger.kernel.org>, Sean Paul <sean@poorly.run>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm: allow limiting the scatter list size.
Message-ID: <20200818090049.qomgyyw6hif4cmah@sirius.home.kraxel.org>
References: <20200818074828.9509-1-kraxel@redhat.com>
 <20200818074828.9509-2-kraxel@redhat.com>
 <9c355d64-1a61-eb59-be80-d9fc863ddf22@amd.com>
 <20200818082703.7z6fcvoymiqow5kw@sirius.home.kraxel.org>
 <03c03129-db27-c6da-df8f-909141d2a3f7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03c03129-db27-c6da-df8f-909141d2a3f7@amd.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > > I'm missing an explanation why this should be useful (it certainly is).
> > virtio-gpu needs this to work properly with SEV (see patch 2/2 of this
> > series).
> 
> Yeah, that's the problem patch 2/2 never showed up here :)

The list should have everything.

Your inbox probably has 1/2 only because 2/2 doesn't touch amd code and
'git send-email' evaluates sendemail.cccmd (pointing to
get_maintainer.pl) for each patch individually.

I've found this behavior confusing at times before.  Is there some way
to send the whole series to everybody?  Or at least the cover letter?
The git-send-email manpage doesn't give a clue :(

> > Placing it in drm_device instead would indeed work for virtio-gpu, so I
> > guess you are suggesting that instead?
> 
> That is probably the best approach, yes.

Ok, I'll go that route then.

thanks,
  Gerd

