Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8EBC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B922070B
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 20:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7fUtC8h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEHUsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 16:48:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45712 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726883AbgEHUsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 16:48:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588970911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=PABbYX5l1s1Q7QOkyDr67VfhHwZx5DccKVnVnS2WJ7Q=;
        b=A7fUtC8hkDfHM+LbvdcB4mOP6Q7psRZqatWsS4Ni5YaXKjAKhcEun7wT7qywzFhtASd+jD
        F0ZaaBUenMZyHveRFQ7zDBCY/5pqPlDaj3P5JGZrvgVRwyxzGcSO9xIgRTBsqW7h7MUyIb
        ONkD0+ptBNm63GNdqtGP3/Hjlk7KBXY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-unhX4jLNPO2o-MomrFUNfQ-1; Fri, 08 May 2020 16:48:29 -0400
X-MC-Unique: unhX4jLNPO2o-MomrFUNfQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 664A48018A6;
        Fri,  8 May 2020 20:48:25 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-118-29.rdu2.redhat.com [10.10.118.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8EE5B5D9CA;
        Fri,  8 May 2020 20:48:17 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Liang Chen" <cl@rock-chips.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        "Tejun Heo" <tj@kernel.org>, "Petr Mladek" <pmladek@suse.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        "Lyude Paul" <lyude@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        "Peteris Rudzusiks" <peteris.rudzusiks@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Chris Wilson" <chris@chris-wilson.co.uk>,
        "Pankaj Bharadiya" <pankaj.laxminarayan.bharadiya@intel.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Sean Paul" <seanpaul@chromium.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Subject: [RFC v4 00/12] drm/nouveau: Introduce CRC support for gf119+
Date:   Fri,  8 May 2020 16:46:50 -0400
Message-Id: <20200508204751.155488-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nvidia released some documentation on how CRC support works on their
GPUs, hooray!

So: this patch series implements said CRC support in nouveau, along with
adding some special debugfs interfaces for some relevant igt-gpu-tools
tests (already on the ML).

First - we add some new functionality to kthread_work in the kernel, and
then use this to add a new feature to DRM that Ville Syrjälä came up
with: vblank workers. Basically, this is just a generic DRM interface
that allows for scheduling high-priority workers that start on a given
vblank interrupt. Note that while we're currently only using this in
nouveau, Intel has plans to use this for i915 as well (hence why they
came up with it!).

And finally: in order to implement the last feature, we expose some new
functions in the kernel's kthread_worker infrastructure so that we can
de-complicate our implementation of this.

Anyway-welcome to the future! :)

Major changes since v3:
* Style fixes on nouveau patches from checkpatch, no functional changes
* Don't integrate so tightly with kthread_work (and use our own lock),
  instead introduce some new functions for doing simple async flushing
  and cancelling. I think this interface looks a lot more acceptable
  then what I was previously trying.
* Apply some changes requested by danvet
Major changes since v2:
* Use kthread_worker instead of kthreadd for vblank workers
* Don't check debugfs return values

Lyude Paul (12):
  kthread: Add kthread_queue_flush_work()
  kthread: Add kthread_(un)block_work_queuing() and
    kthread_work_queuable()
  drm/vblank: Register drmm cleanup action once per drm_vblank_crtc
  drm/vblank: Add vblank works
  drm/nouveau/kms/nv50-: Unroll error cleanup in nv50_head_create()
  drm/nouveau/kms/nv140-: Don't modify depth in state during atomic
    commit
  drm/nouveau/kms/nv50-: Fix disabling dithering
  drm/nouveau/kms/nv50-: s/harm/armh/g
  drm/nouveau/kms/nv140-: Track wndw mappings in nv50_head_atom
  drm/nouveau/kms/nv50-: Expose nv50_outp_atom in disp.h
  drm/nouveau/kms/nv50-: Move hard-coded object handles into header
  drm/nouveau/kms/nvd9-: Add CRC support

 drivers/gpu/drm/drm_vblank.c                | 280 +++++++-
 drivers/gpu/drm/nouveau/dispnv04/crtc.c     |  25 +-
 drivers/gpu/drm/nouveau/dispnv50/Kbuild     |   4 +
 drivers/gpu/drm/nouveau/dispnv50/atom.h     |  21 +
 drivers/gpu/drm/nouveau/dispnv50/core.h     |   4 +
 drivers/gpu/drm/nouveau/dispnv50/core907d.c |   3 +
 drivers/gpu/drm/nouveau/dispnv50/core917d.c |   3 +
 drivers/gpu/drm/nouveau/dispnv50/corec37d.c |   3 +
 drivers/gpu/drm/nouveau/dispnv50/corec57d.c |   3 +
 drivers/gpu/drm/nouveau/dispnv50/crc.c      | 715 ++++++++++++++++++++
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
 include/drm/drm_vblank.h                    |  35 +
 include/linux/kthread.h                     |  35 +
 kernel/kthread.c                            | 133 +++-
 26 files changed, 1903 insertions(+), 174 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc907d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crcc37d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/handles.h

-- 
2.25.4

