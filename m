Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D395C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63F5220848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:59:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7DGJzNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgBNW70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:59:26 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30226 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727804AbgBNW7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581721164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=R2rSJTcicY5nIJxYJ/nirD09yTB53muiLkWxosFVQPk=;
        b=C7DGJzNcVIFAiaVg0qNHCPgYcHOvMKzb1lzAaRFqJye/eyGFW+Lpi31dxGqIBKxxYCKYzG
        Is8bhqg+12PQyauqD42ueFQQJEIOoq7g3SqH3IV1LZ/PsxIS5tR7JNVNmMaGq7bfd2I+eS
        IE6bTLp7f6+iA1Rl8keX89IJYz/PVP4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-93xA8R9WO5CoyZ0rX9oztg-1; Fri, 14 Feb 2020 17:59:19 -0500
X-MC-Unique: 93xA8R9WO5CoyZ0rX9oztg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E69018C35A0;
        Fri, 14 Feb 2020 22:59:17 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76DFC60499;
        Fri, 14 Feb 2020 22:59:15 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Airlie" <airlied@redhat.com>,
        "David Airlie" <airlied@linux.ie>, "Takashi Iwai" <tiwai@suse.de>,
        "Manasi Navare" <manasi.d.navare@intel.com>,
        "Sean Paul" <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Mikita Lipski" <mikita.lipski@amd.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH v2 0/5] drm/nouveau: DP interlace fixes
Date:   Fri, 14 Feb 2020 17:58:51 -0500
Message-Id: <20200214225910.695210-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, nouveau doesn't actually bother to try probing whether or not
it can actually handle interlaced modes over DisplayPort. As a result,
on volta and later we'll end up trying to set an interlaced mode even
when it's not supported and cause the front end for the display engine
to hang.

So, let's teach nouveau to reject interlaced modes on hardware that
can't actually handle it. Additionally for MST, since we accomplish this
by simply reusing more of the SST mode validation we also get (some)
basic bw validation for modes we detect on MST connectors completely for
free.

Lyude Paul (5):
  drm/nouveau/kms/nv50-: Initialize core channel in
    nouveau_display_create()
  drm/nouveau/kms/nv50-: Probe SOR caps for DP interlacing support
  drm/nouveau/kms/gv100-: Add support for interlaced modes
  drm/nouveau/kms/nv50-: Move 8BPC limit for MST into
    nv50_mstc_get_modes()
  drm/nouveau/kms/nv50-: Share DP SST mode_valid() handling with MST

 drivers/gpu/drm/nouveau/dispnv50/core.h     |  3 ++
 drivers/gpu/drm/nouveau/dispnv50/core507d.c | 15 ++++++
 drivers/gpu/drm/nouveau/dispnv50/core827d.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/core907d.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/core917d.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c | 26 +++++++++
 drivers/gpu/drm/nouveau/dispnv50/corec57d.c |  1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 60 ++++++++++++++++-----
 drivers/gpu/drm/nouveau/dispnv50/disp.h     |  1 +
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c |  5 +-
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  5 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 43 +++++++++------
 drivers/gpu/drm/nouveau/nouveau_connector.h |  5 ++
 drivers/gpu/drm/nouveau/nouveau_dp.c        | 31 +++++++++++
 drivers/gpu/drm/nouveau/nouveau_encoder.h   |  8 +++
 15 files changed, 172 insertions(+), 34 deletions(-)

--=20
2.24.1

