Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0AFF215A4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E9FCmj9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387627AbgCDIFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:05:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725271AbgCDIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583309153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kEXp+MsDMiIQ48dZsIdgW3c7/qT3rYq7zxn6pOdg4xA=;
        b=E9FCmj9jcnhbA11ESDwbYCxh/Gpv5iWydcqEE/7+VlwdQNMLtleJeKmEvHqrwO1YJ3rCw+
        orJ/1xl9wbMwQUzWehwTt3Qc1RXkyeYxyRONMwr3J1LsSP+pFg6KfXZZQt9dE4w51m3YFO
        ymSTBR/H8Hh2p4P1/OiEyy8Z1ECgoGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-LfdfQ2d3O6mP8LQD7TgVEQ-1; Wed, 04 Mar 2020 03:05:49 -0500
X-MC-Unique: LfdfQ2d3O6mP8LQD7TgVEQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6149E801E6C;
        Wed,  4 Mar 2020 08:05:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-150.ams2.redhat.com [10.36.116.150])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41D545DA60;
        Wed,  4 Mar 2020 08:05:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7778C17506; Wed,  4 Mar 2020 09:05:43 +0100 (CET)
Date:   Wed, 4 Mar 2020 09:05:43 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        open list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linaro-mm-sig@lists.linaro.org, virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] [PATCH v2 4/4] drm/virtio: Support virtgpu exported
 resources
Message-ID: <20200304080543.jtf3kcfp6cyegkag@sirius.home.kraxel.org>
References: <20200302121524.7543-1-stevensd@chromium.org>
 <20200302121524.7543-5-stevensd@chromium.org>
 <CAAfnVBk46vsP77hx3kUHqVCPG8Eakh7Kgi0kEHZtrHD-0bHzqQ@mail.gmail.com>
 <CAD=HUj5-0CE-tm4meQ_Y7KB4Df41v=kBH2GTStYJptTOSp1yVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=HUj5-0CE-tm4meQ_Y7KB4Df41v=kBH2GTStYJptTOSp1yVw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 11:42:22AM +0900, David Stevens wrote:
> > cmd_p->hdr.ctx_id =
> >
> > Before this completion of this hypercall, this resource can be
> > considered context local, while afterward it can be considered
> > "exported".
> 
> Maybe I'm misunderstanding render contexts, but exporting a resource
> doesn't seem related to render contexts.

It isn't indeed.  Binding resources to contexts might need dma-buf
imports/exports on the host side, but that is another story and not
related to dma-buf exports inside the guest.

cheers,
  Gerd

