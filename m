Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F12BC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133692082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 06:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QcjjrCCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgBGGqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 01:46:39 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43697 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgBGGqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 01:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581057997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JR0sLKJMwOjHuo0gNvxLVg3cMealajs17yiRzMpKjW0=;
        b=QcjjrCCPd5B9fPi1Jv96nzNS7Clcz1gAvdD8XknelfTGklbQJ4pSMVX4n9gyDVcrv+i3po
        iium72X9id9Vh88grfmBUQx9T3YuJtn2fyBe2MUbsMfhng3ADI05HSOByySJC9Gi74bD91
        Ug4f3yyQm+bvzccswHGocozQ5EarUBY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-jrthkPVwN3SST0AZHHhljw-1; Fri, 07 Feb 2020 01:46:33 -0500
X-MC-Unique: jrthkPVwN3SST0AZHHhljw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F332E8010CA;
        Fri,  7 Feb 2020 06:46:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F0B45DA7C;
        Fri,  7 Feb 2020 06:46:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id BCC461FCD6; Fri,  7 Feb 2020 07:46:30 +0100 (CET)
Date:   Fri, 7 Feb 2020 07:46:30 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Chia-I Wu <olvaffe@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/virtio: fix ring free check
Message-ID: <20200207064630.6p35spqres676cpq@sirius.home.kraxel.org>
References: <20200206111416.31269-1-kraxel@redhat.com>
 <CAPaKu7Tfp-thov9xCe-Gbq1zZe_uvDAno8SV_3tc=tU0gse=uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPaKu7Tfp-thov9xCe-Gbq1zZe_uvDAno8SV_3tc=tU0gse=uA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > +       indirect = virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC);
> > +       vqcnt = indirect ? 1 : elemcnt;
> Is the feature dynamic and require the lock held?  If not, the result
> can be cached and the fixup can happen before grabbing the lock

Not dynamic, so yes, caching makes sense.

cheers,
  Gerd

