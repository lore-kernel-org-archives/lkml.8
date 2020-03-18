Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4668C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 06:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C44020768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 06:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyFmmsmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCRGmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 02:42:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25484 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726478AbgCRGmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 02:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584513736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PPs09uZ6i6ElWTAW3541z8pnB9L17d/mtUgzs6Ul94Q=;
        b=TyFmmsmH0tlW5FuCWxxYhXZKddGjK+H7jlT9Zord1OQq10FYqLAID5YCmRhGgjvUcPErRN
        3Ol/3pmnR4PwhC+sshaOOFFlilnagaO1WNgJhIRQm+EqkuzlaQgTBc0+ajJzob27V1p2dF
        NXpkraDfJW6JEbIDRsWBXtFg1bLZUdg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-WhmNS_73OdaTi778wON5Sw-1; Wed, 18 Mar 2020 02:42:14 -0400
X-MC-Unique: WhmNS_73OdaTi778wON5Sw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B23A8017CC;
        Wed, 18 Mar 2020 06:42:12 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-49.ams2.redhat.com [10.36.112.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1D487E323;
        Wed, 18 Mar 2020 06:42:11 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 2070717444; Wed, 18 Mar 2020 07:42:11 +0100 (CET)
Date:   Wed, 18 Mar 2020 07:42:11 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
        David Airlie <airlied@linux.ie>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] drm/bochs: downgrade pci_request_region failure from
 error to warning
Message-ID: <20200318064211.rg5s4sgrnqhht3f4@sirius.home.kraxel.org>
References: <20200313084152.2734-1-kraxel@redhat.com>
 <20200317164941.GP2363188@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317164941.GP2363188@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 05:49:41PM +0100, Daniel Vetter wrote:
> On Fri, Mar 13, 2020 at 09:41:52AM +0100, Gerd Hoffmann wrote:
> > Shutdown of firmware framebuffer has a bunch of problems.  Because
> > of this the framebuffer region might still be reserved even after
> > drm_fb_helper_remove_conflicting_pci_framebuffers() returned.
> 
> Is that still the fbdev lifetime fun where the cleanup might be delayed if
> the char device node is still open?

Yes.

cheers,
  Gerd

