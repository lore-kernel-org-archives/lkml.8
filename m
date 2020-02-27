Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0386C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBD221556
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+WpjK1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729162AbgB0NVs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:21:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37335 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729100AbgB0NVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:21:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582809707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2w6PduuGzWBIJqAtGt1TzV/EmMXU0UJHklEBPBn7KWM=;
        b=i+WpjK1zsvK71tKCwbezWpkRKcbN+MrNmOAeTzzOMMyNVlUsgVFizHhBA5d/1w7yLpWe76
        F1zsKxDw+haaZsLFQpi6PCTXNOqVNio6IY0/nYyxB16DPs84j8N8GcpiJu/B7ARWOf6q2w
        E9CGx/wnSQDETzPyQD5meQSOtGcQA54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-qVqUkJBaOM6F-5_AL0sljA-1; Thu, 27 Feb 2020 08:21:43 -0500
X-MC-Unique: qVqUkJBaOM6F-5_AL0sljA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC5BE18A8C85;
        Thu, 27 Feb 2020 13:21:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com [10.36.116.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F92060BE1;
        Thu, 27 Feb 2020 13:21:38 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 4EC7B1744A; Thu, 27 Feb 2020 14:21:37 +0100 (CET)
Date:   Thu, 27 Feb 2020 14:21:37 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas =?utf-8?Q?Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     dri-devel@lists.freedesktop.org, Guillaume.Gardet@arm.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        gurchetansingh@chromium.org, tzimmermann@suse.de, yuq825@gmail.com,
        noralf@tronnes.org, robh@kernel.org
Subject: Re: [PATCH v5 1/3] drm/shmem: add support for per object caching
 flags.
Message-ID: <20200227132137.irruicvlkxpdo3so@sirius.home.kraxel.org>
References: <20200226154752.24328-1-kraxel@redhat.com>
 <20200226154752.24328-2-kraxel@redhat.com>
 <f1afba4b-9c06-48a3-42c7-046695947e91@shipmail.org>
 <20200227075321.ki74hfjpnsqv2yx2@sirius.home.kraxel.org>
 <41ca197c-136a-75d8-b269-801db44d4cba@shipmail.org>
 <20200227105643.h4klc3ybhpwv2l3x@sirius.home.kraxel.org>
 <68a05ace-40bc-76d6-5464-2c96328874b9@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68a05ace-40bc-76d6-5464-2c96328874b9@shipmail.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > So I'd like to push patches 1+2 to -fixes and sort everything else later
> > in -next.  OK?
> 
> OK with me.

Done.

>> [ context: why shmem helpers use pgprot_writecombine + pgprot_decrypted?
>>            we get conflicting mappings because of that, linear kernel
>>            map vs. gem object vmap/mmap ]

> Do we have any idea what drivers are actually using
> write-combine and decrypted?

drivers/gpu/drm# find -name Kconfig* -print | xargs grep -l DRM_GEM_SHMEM_HELPER
./lima/Kconfig
./tiny/Kconfig
./cirrus/Kconfig
./Kconfig
./panfrost/Kconfig
./udl/Kconfig
./v3d/Kconfig
./virtio/Kconfig

virtio needs cached.
cirrus+udl should be ok with cached too.

Not clue about the others (lima, tiny, panfrost, v3d).  Maybe they use
write-combine just because this is what they got by default from
drm_gem_mmap_obj().  Maybe they actually need that.  Trying to Cc:
maintainters (and drop stable@).

On decrypted: I guess that is only relevant for virtual machines, i.e.
virtio-gpu and cirrus?

virtio-gpu needs it, otherwise the host can't show the virtual display.
cirrus bounces everything via blits to vram, so it should be ok without
decrypted.  I guess that implies we should make decrypted configurable.

cheers,
  Gerd

