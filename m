Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF78C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E786C20715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SJSezu3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgBGMjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:39:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40816 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgBGMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581079153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2IwNz7m8EBxgaV/gA8k+cJl/cgQQuSz8wqKKuyY3Q8c=;
        b=SJSezu3VpGPCtR/7BUxTxf/uSTxGD0A+MAshzdi7xCOBMnhNmnHKrwVTIZo6OTBgQPw2Pg
        BbER/CQLhA6ZGiISN+6lW74LNHz4bHEmcdQkA7Iafg9acBLKbVeqG/8C/U/ZgDhO2tdAV7
        In86+ggS2jmQtNWs2/hzeuoC1ucAUpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-8tXZMvjUMeS2wSNC7jAClg-1; Fri, 07 Feb 2020 07:39:07 -0500
X-MC-Unique: 8tXZMvjUMeS2wSNC7jAClg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CC52800E21;
        Fri,  7 Feb 2020 12:39:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-112.ams2.redhat.com [10.36.116.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A617487B1C;
        Fri,  7 Feb 2020 12:39:05 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id E73C5A1E0; Fri,  7 Feb 2020 13:39:04 +0100 (CET)
Date:   Fri, 7 Feb 2020 13:39:04 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     dri-devel@lists.freedesktop.org, marmarek@invisiblethingslab.com,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v2] drm/bochs: downgrade pci_request_region failure from
 error to warning
Message-ID: <20200207123904.vvueifnbcfzlb7gx@sirius.home.kraxel.org>
References: <20200207115744.4559-1-kraxel@redhat.com>
 <04783a3f-daae-47a3-d2a7-d42f192daf23@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04783a3f-daae-47a3-d2a7-d42f192daf23@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 01:06:00PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 07.02.20 um 12:57 schrieb Gerd Hoffmann:
> > Shutdown of firmware framebuffer has a bunch of problems.  Because
> > of this the framebuffer region might still be reserved even after
> > drm_fb_helper_remove_conflicting_pci_framebuffers() returned.
> 
> Out of curiosity: what's going wrong here?

Very short version: userspace keeping /dev/fb0 open delays
firmware framebuffer deinit.

Long version by Daniel Vetter:
https://www.spinics.net/lists/linux-fbdev/msg28178.html

cheers,
  Gerd

