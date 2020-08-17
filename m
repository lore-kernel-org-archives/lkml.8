Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9797C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDF1C20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JESs3yJy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgHQKlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:41:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgHQKlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:41:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597660910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVmgCdLpXIRiRlPkR73rmjLuNrF1gXDX7uw/nBpZ86A=;
        b=JESs3yJyTRp/SkvIMISKjtXRdnnACwlRkZRZH4ipqo7FaDF5OLfXqRQb659jUVG+6G+hkQ
        vc7kESyrbf347b8czwJ76GdKF3TVdoHnKTbzW+XQH2EGrd8x0M2J4dsHhDkEaew9efq84X
        gB0yzQGg/ppGj+8kYG0ScaqI+IKkVVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-ddeRsAoXN4eFuNW0N1urmA-1; Mon, 17 Aug 2020 06:41:48 -0400
X-MC-Unique: ddeRsAoXN4eFuNW0N1urmA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6348351B1;
        Mon, 17 Aug 2020 10:41:47 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72A666F15D;
        Mon, 17 Aug 2020 10:41:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 52C149D5A; Mon, 17 Aug 2020 12:41:44 +0200 (CEST)
Date:   Mon, 17 Aug 2020 12:41:44 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] drm/virtio: Use struct_size() helper in kmalloc()
Message-ID: <20200817104144.bn5mqzfggtjxwjva@sirius.home.kraxel.org>
References: <20200617215707.GA16785@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617215707.GA16785@embeddedor>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 04:57:07PM -0500, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> This code was detected with the help of Coccinelle and, audited and
> fixed manually.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Queued up for drm-misc-next.

thanks,
  Gerd

