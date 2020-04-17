Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABE6C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6D03206D9
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 19:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9rPaHTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730686AbgDQTmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 15:42:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41610 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730178AbgDQTma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 15:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587152549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0POUKn5el8rFXJ9SU/bGUJ9HAHH8PpwpgN/Gi+roguo=;
        b=a9rPaHTYlZDqtqH2OfHbtI9x0jIl+UzOdtz90avX/JTUPSpDLcJpHXosW7N+6vq4u6xQlZ
        XqUM5OdEqmsTkNy0nR43rbn6JzRGFv0Junv38F8nkDMpavN6u42erhnEeRE0HH55keORtG
        7L+5tEwHspYXvOsnjVk/8DzZk6yPOCo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-xtB5XGjZOqyG9S9NH0HXNg-1; Fri, 17 Apr 2020 15:42:27 -0400
X-MC-Unique: xtB5XGjZOqyG9S9NH0HXNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9509F8010CA;
        Fri, 17 Apr 2020 19:42:23 +0000 (UTC)
Received: from Ruby.redhat.com (ovpn-114-140.rdu2.redhat.com [10.10.114.140])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B8645D9CA;
        Fri, 17 Apr 2020 19:42:12 +0000 (UTC)
From:   Lyude Paul <lyude@redhat.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, "David Airlie" <airlied@linux.ie>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Liang Chen" <cl@rock-chips.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Johannes Weiner" <hannes@cmpxchg.org>,
        "Ben Dooks" <ben.dooks@codethink.co.uk>,
        "Petr Mladek" <pmladek@suse.com>, "Tejun Heo" <tj@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Lyude Paul" <lyude@redhat.com>,
        "Suren Baghdasaryan" <surenb@google.com>,
        nouveau@lists.freedesktop.org, "Ben Skeggs" <bskeggs@redhat.com>,
        "Ilia Mirkin" <imirkin@alum.mit.edu>,
        "Peteris Rudzusiks" <peteris.rudzusiks@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Gerd Hoffmann" <kraxel@redhat.com>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        "Pankaj Bharadiya" <pankaj.laxminarayan.bharadiya@intel.com>,
        "Takashi Iwai" <tiwai@suse.de>,
        "Sean Paul" <seanpaul@chromium.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Jani Nikula" <jani.nikula@intel.com>,
        "Nicholas Kazlauskas" <nicholas.kazlauskas@amd.com>,
        "Kate Stewart" <kstewart@linuxfoundation.org>
Subject: [RFC v3 00/11] drm/nouveau: Introduce CRC support for gf119+
Date:   Fri, 17 Apr 2020 15:40:47 -0400
Message-Id: <20200417194145.36350-1-lyude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

And finally: in order to implement the last feature, we expose some new
functions in the kernel's kthread_worker infrastructure so that we can
de-complicate our implementation of this.

Anyway-welcome to the future! :)

Major changes since v2:
* Use kthread_worker instead of kthreadd for vblank workers
* Don't check debugfs return values

Lyude Paul (11):
  drm/vblank: Register drmm cleanup action once per drm_vblank_crtc
  kthread: Introduce __kthread_queue_work()
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

 drivers/gpu/drm/drm_vblank.c                | 314 ++++++++-
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
 include/drm/drm_vblank.h                    |  31 +
 include/linux/kthread.h                     |   3 +
 kernel/kthread.c                            |  34 +-
 26 files changed, 1831 insertions(+), 145 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc.h
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crc907d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/crcc37d.c
 create mode 100644 drivers/gpu/drm/nouveau/dispnv50/handles.h

--=20
2.25.1

