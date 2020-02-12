Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F4CC3B188
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD6821569
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OqanHHKh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgBLXAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:00:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47519 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727692AbgBLXAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581548452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VWlt+bgXIf5/iv+Jhlc8cQtwPoqiZeX+qbSML/8mt+s=;
        b=OqanHHKhfIvFlJgo4RmJi47bxvDgRunupB7gQo8ckCpV1GYgoBvCnHcBU5LlZ6ThrIK+xr
        1lI1bCKny/PHg0VoN0JtrGVrOUfZU+TYmbosx2gtbn0rLhYER9hF4x8mNSTVEQv0C3PwJu
        d3wgHy5yhu9ogOceD9a0urL8W8c45Ig=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-PPQ5D6jdPdewmS9mXXbLnA-1; Wed, 12 Feb 2020 18:00:50 -0500
X-MC-Unique: PPQ5D6jdPdewmS9mXXbLnA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60DEF107ACCC;
        Wed, 12 Feb 2020 23:00:48 +0000 (UTC)
Received: from Ruby.bss.redhat.com (dhcp-10-20-1-196.bss.redhat.com [10.20.1.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B84A5C109;
        Wed, 12 Feb 2020 23:00:46 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "Mikita Lipski" <mikita.lipski@amd.com>,
        "David Airlie" <airlied@linux.ie>, "Takashi Iwai" <tiwai@suse.de>,
        "Manasi Navare" <manasi.d.navare@intel.com>,
        "Sean Paul" <seanpaul@chromium.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        "Dave Airlie" <airlied@redhat.com>,
        "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 0/4] drm/nouveau: DP interlace fixes
Date:   Wed, 12 Feb 2020 18:00:34 -0500
Message-Id: <20200212230043.170477-1-lyude@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Lyude Paul (4):
  drm/nouveau/kms/nv50-: Probe SOR caps for DP interlacing support
  drm/nouveau/kms/gv100-: Add support for interlaced modes
  drm/nouveau/kms/nv50-: Move 8BPC limit for MST into
    nv50_mstc_get_modes()
  drm/nouveau/kms/nv50-: Share DP SST mode_valid() handling with MST

 drivers/gpu/drm/nouveau/dispnv50/disp.c     | 55 ++++++++++++++-------
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c |  5 +-
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  5 +-
 drivers/gpu/drm/nouveau/nouveau_connector.c | 43 ++++++++++------
 drivers/gpu/drm/nouveau/nouveau_connector.h |  5 ++
 drivers/gpu/drm/nouveau/nouveau_dp.c        | 27 ++++++++++
 drivers/gpu/drm/nouveau/nouveau_encoder.h   |  7 +++
 7 files changed, 108 insertions(+), 39 deletions(-)

--=20
2.24.1

