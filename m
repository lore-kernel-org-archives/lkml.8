Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E84C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91D26206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hoYYWEfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgCRAmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:42:33 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:42386 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbgCRAmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584492152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TOKpkDx1+1S5gT8u85nuwajZFgWwJ6Fhafzgm2jG6Zg=;
        b=hoYYWEfaa/RcWrVeUhTy2pSYlH/Dw0D1wy+f02eboLAL30w1jjDUhLmcaf4s35+uOkprQM
        37mb+tmaH4sCmrZlug04YeZWuOVFV4SxGf3lyatUqoWBNWu9nJdlFLeeMIvfFrOjTGetQ8
        dN7c4masUYw6tLqY5GrAxIEmOiUn2og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-396-mxb62zmLO5OAnbbMfQwoaw-1; Tue, 17 Mar 2020 20:42:30 -0400
X-MC-Unique: mxb62zmLO5OAnbbMfQwoaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5D2F8014CE;
        Wed, 18 Mar 2020 00:42:27 +0000 (UTC)
Received: from whitewolf.redhat.com (ovpn-113-173.rdu2.redhat.com [10.10.113.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB9D760BE0;
        Wed, 18 Mar 2020 00:42:21 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        "Peteris Rudzusiks" <peteris.rudzusiks@gmail.com>,
        "Lyude Paul" <lyude@redhat.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        "Pankaj Bharadiya" <pankaj.laxminarayan.bharadiya@intel.com>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Sean Paul" <seanpaul@chromium.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [PATCH 0/9] drm/nouveau: Introduce CRC support for gf119+
Date:   Tue, 17 Mar 2020 20:40:57 -0400
Message-Id: <20200318004159.235623-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nvidia released some documentation on how CRC support works on their
GPUs, hooray!

So: this patch series implements said CRC support in nouveau, along with
adding some special debugfs interfaces for some relevant igt-gpu-tools
tests that we'll be sending in just a short bit.

This additionally adds a feature that Ville Syrj=C3=A4l=C3=A4 came up wit=
h: vblank
works. Basically, this is just a generic DRM interface that allows for
scheduling high-priority workers that start on a given vblank interrupt.
Note that while we're currently only using this in nouveau, Intel has
plans to use this for i915 as well (hence why they came up with it!).

Anyway-welcome to the future! :)

Lyude Paul (8):
  drm/nouveau/kms/nv50-: Unroll error cleanup in nv50_head_create()
  drm/nouveau/kms/nv140-: Don't modify depth in state during atomic
    commit
  drm/nouveau/kms/nv50-: Fix disabling dithering
  drm/nouveau/kms/nv50-: s/harm/armh/g
  drm/nouveau/kms/nv140-: Track wndw mappings in nv50_head_atom
  drm/nouveau/kms/nv50-: Expose nv50_outp_atom in disp.h
  drm/nouveau/kms/nv50-: Move hard-coded object handles into header
  drm/nouveau/kms/nvd9-: Add CRC support

Ville Syrj=C3=A4l=C3=A4 (1):
  drm/vblank: Add vblank works

 drivers/gpu/drm/drm_vblank.c                | 322 +++++++++
 drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  25 +-
 drivers/gpu/drm/nouveau/dispnv50/Kbuild     |   4 +
 drivers/gpu/drm/nouveau/dispnv50/atom.h     |  21 +
 drivers/gpu/drm/nouveau/dispnv50/core.h     |   4 +
 drivers/gpu/drm/nouveau/dispnv50/core907d.c |   3 +
 drivers/gpu/drm/nouveau/dispnv50/core917d.c |   3 +
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c |   3 +
 drivers/gpu/drm/nouveau/dispnv50/corec57d.c |   3 +
 drivers/gpu/drm/nouveau/dispnv50/crc.c      | 716 ++++++++++++++++++++
 drivers/gpu/drm/nouveau/dispnv50/crc.h      | 125 ++++
 drivers/gpu/drm/nouveau/dispnv50/crc907d.c  | 139 ++++
 drivers/gpu/drm/nouveau/dispnv50/crcc37d.c  | 153 +++++
 drivers/gpu/drm/nouveau/dispnv50/disp.c     |  65 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.h     |  24 +
 drivers/gpu/drm/nouveau/dispnv50/handles.h  |  16 +
 drivers/gpu/drm/nouveau/dispnv50/head.c     | 142 +++-
 drivers/gpu/drm/nouveau/dispnv50/head.h     |  13 +-
 drivers/gpu/drm/nouveau/dispnv50/head907d.c |  14 +-
 drivers/gpu/drm/nouveau/dispnv50/headc37d.c |  27 +-
 drivers/gpu/drm/nouveau/dispnv50/headc57d.c |  20 +-
 drivers/gpu/drm/nouveau/dispnv50/wndw.c     |  15 +-
 drivers/gpu/drm/nouveau/nouveau_display.c   |  60 +-
 include/drm/drm_vblank.h                    |  34 +
 24 files changed, 1821 insertions(+), 130 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc907d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crcc37d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/handles.h

--=20
2.24.1

