Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47546C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 247DE20709
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:00:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnRhIpz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgENIAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:00:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41222 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725952AbgENIAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589443203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e4jjCqMhrz73017AHqU+ojMzDyx024B7mYUCVLrg2XA=;
        b=EnRhIpz76HdOVmzPhyaDfrZy0InWXAgfZimbjbW6G1H3JSqxry3ShJ+H4mB02mhMMro/O2
        zRipUrdV6njafFwbcdwaEpkLPr6pyhiLagp4n+O4uJROwT1fPUSujc6l7gCJzQfDA7FA3e
        jrcg2cDv6w6j4Eu4Fly0o70G23wC4tY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-DblcYXPVPo60onW8Liue0g-1; Thu, 14 May 2020 03:59:59 -0400
X-MC-Unique: DblcYXPVPo60onW8Liue0g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80E5180058A;
        Thu, 14 May 2020 07:59:57 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com [10.36.115.145])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CF086A977;
        Thu, 14 May 2020 07:59:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 6FE4417444; Thu, 14 May 2020 09:59:52 +0200 (CEST)
Date:   Thu, 14 May 2020 09:59:52 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     David Stevens <stevensd@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        David Airlie <airlied@linux.ie>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
Subject: Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
Message-ID: <20200514075952.zuc3zjtmasaqrw75@sirius.home.kraxel.org>
References: <20200311112004.47138-1-stevensd@chromium.org>
 <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> - for the runtime upcasting the usual approach is to check the ->ops
> pointer. Which means that would need to be the same for all virtio
> dma_bufs, which might get a bit awkward. But I'd really prefer we not
> add allocator specific stuff like this to dma-buf.

This is exactly the problem, it gets messy quickly, also when it comes
to using the drm_prime.c helpers ...

take care,
  Gerd

