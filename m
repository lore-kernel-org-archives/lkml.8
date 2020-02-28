Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA71BC3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DCD246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4x1Q60C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgB1JtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:49:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54730 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726005AbgB1JtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582883352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaUE2NO4gGXPZu75rog8Ham7snpA9hfQBixkkzfUHPs=;
        b=i4x1Q60Ca4Obu6gDrq7DJ2Uss8M/aqc9TTSsmhY4/UIFHPBitwkEZ4KPD7tWt/XSvmoNM0
        6bC26jEvR0kcU+pqRfOr7y6FNuxUQpkDIw3Mg5nlQHThV67Gc9ok5Ye+qMYh4kS7LFOy4v
        xb7++ex5PC70NKv0hZxV40uQqmAsHSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-cDxzfgL2P66JhpQWm0MxKg-1; Fri, 28 Feb 2020 04:49:08 -0500
X-MC-Unique: cDxzfgL2P66JhpQWm0MxKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2953E8010E8;
        Fri, 28 Feb 2020 09:49:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com [10.36.116.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CF235E1AF;
        Fri, 28 Feb 2020 09:49:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9412D17447; Fri, 28 Feb 2020 10:49:03 +0100 (CET)
Date:   Fri, 28 Feb 2020 10:49:03 +0100
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
Message-ID: <20200228094903.g7yf73mtnbjyu4ez@sirius.home.kraxel.org>
References: <20200226154752.24328-1-kraxel@redhat.com>
 <20200226154752.24328-2-kraxel@redhat.com>
 <f1afba4b-9c06-48a3-42c7-046695947e91@shipmail.org>
 <20200227075321.ki74hfjpnsqv2yx2@sirius.home.kraxel.org>
 <41ca197c-136a-75d8-b269-801db44d4cba@shipmail.org>
 <20200227105643.h4klc3ybhpwv2l3x@sirius.home.kraxel.org>
 <68a05ace-40bc-76d6-5464-2c96328874b9@shipmail.org>
 <20200227132137.irruicvlkxpdo3so@sirius.home.kraxel.org>
 <78eb099e-020f-91d1-672e-15176bf12cd4@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78eb099e-020f-91d1-672e-15176bf12cd4@shipmail.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > Not clue about the others (lima, tiny, panfrost, v3d).  Maybe they use
> > write-combine just because this is what they got by default from
> > drm_gem_mmap_obj().  Maybe they actually need that.  Trying to Cc:
> > maintainters (and drop stable@).

> > virtio-gpu needs it, otherwise the host can't show the virtual display.
> > cirrus bounces everything via blits to vram, so it should be ok without
> > decrypted.  I guess that implies we should make decrypted configurable.
> 
> Decrypted here is clearly incorrect and violates the SEV spec, regardless of
> a config option.
> 
> The only correct way is currently to use dma_alloc_coherent() and
> mmap_coherent() to allocate decrypted memory and then use the
> pgprot_decrypted flag.

Hmm, virtio-gpu uses the dma api to allow the host access the gem
object.  So I think I have to correct the statement above, if I
understands things correctly the dma api will use (properly allocated)
decrypted bounce buffers and the virtio-gpu shmem objects don't need
pgprot_decrypted mappings.

That leaves the question what to do about pgprot_writecombine().  Any
comments from the driver maintainers (see first paragraph)?

cheers,
  Gerd

