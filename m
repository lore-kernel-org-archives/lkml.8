Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739D8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447EE2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuNmkzDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHGLWo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:22:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56704 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726058AbgHGLWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:22:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596799362;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wmY0pi0vTdwUJljBgbmTvJ8LrWvebIFkEGaf8XDSBO8=;
        b=ZuNmkzDFOk1Wcn6P5hbo0vFH7mQOpZnPP5iPYw8t2WvWeHnrg2F06Qpt69g2QyygijRGhx
        eGkP0dvCiK7Qc1MlOfGIdMWwNCZ9w2Bto96PFpANUnrkmD7Fy251XBFa2wmwXxS/DZqoXh
        0SELYgG4+NrCS0vHWJWrjycB/zS43o4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-DPHROuQ_NoCSy3DJ4xdVBw-1; Fri, 07 Aug 2020 07:22:40 -0400
X-MC-Unique: DPHROuQ_NoCSy3DJ4xdVBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94714800685;
        Fri,  7 Aug 2020 11:22:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com [10.36.112.195])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 700B88AC10;
        Fri,  7 Aug 2020 11:22:36 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F26837828; Fri,  7 Aug 2020 13:22:34 +0200 (CEST)
Date:   Fri, 7 Aug 2020 13:22:34 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v3 34/38] drm/virtio: convert to LE accessors
Message-ID: <20200807112234.4ycjbtyhjvsxoeio@sirius.home.kraxel.org>
References: <20200805134226.1106164-1-mst@redhat.com>
 <20200805134226.1106164-35-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-35-mst@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 09:44:48AM -0400, Michael S. Tsirkin wrote:
> Virtgpu is modern-only. Use LE accessors for config space.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

