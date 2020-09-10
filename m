Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA884C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84A6A206B8
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599733611;
	bh=tRtzpV/EaF+F+QPhRVFzfaGCqPgsZhD/m9MP9pqx2tU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yhvcGOzzlUI2tcaWQEU3Pzr2a7Yf0q0SmkbD6QGq3a/9qIxhQlKBsZlxXEyy8dlXg
	 hb4UdrOY6pS0R+I2+NLANYnyDUapPlESXVW59IloyUJK7taHfoRmeJVxBnteDXXYf5
	 jcxWRUCVVJL9G0xXMURboaO/jci/WwD4sMU90vzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgIJK0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730108AbgIJKYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:24:13 -0400
Received: from mail.kernel.org (ip5f5ad5ac.dynamic.kabel-deutschland.de [95.90.213.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85BB721D79;
        Thu, 10 Sep 2020 10:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599733450;
        bh=tRtzpV/EaF+F+QPhRVFzfaGCqPgsZhD/m9MP9pqx2tU=;
        h=From:To:Cc:Subject:Date:From;
        b=GfvHfC3hvpMyqbY1P+AWvVdzenAOXwch1FJsK65zZvz43xH6l07AsEgOEyTaX39yN
         Qk9MY75s7B3FTZcnds+w3c0SAjZ8vqhHeNCnqaN8Bi9XhNkAH8zGRyCXkQvMYJ5rCj
         3+tsRBiYcE3xjGP/4CvZHV3XNymiNb+F0khkE3q8=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kGJkO-00EINc-7a; Thu, 10 Sep 2020 12:24:08 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Jakub Kicinski <kuba@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 00/14] get rid of the remaining kernel-doc warnings when building the docs
Date:   Thu, 10 Sep 2020 12:23:53 +0200
Message-Id: <cover.1599732764.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described on its subject, this series finally get rid of all kernel-doc warnings.

With this series applied (plus my last series fixing other warnings), building
the docs is now clean[1] against next-20200909:

    $ make cleandocs >/dev/null 2>/dev/null && make htmldocs
    Warning: Documentation/bpf/ringbuf.rst references a file that doesn't exist: Documentation/litmus_tests/bpf-rb/_
    rm -f   /devel/v4l/docs/Documentation/output/audio.h.rst /devel/v4l/docs/Documentation/output/ca.h.rst /devel/v4l/docs/Documentation/output/dmx.h.rst /devel/v4l/docs/Documentation/output/frontend.h.rst /devel/v4l/docs/Documentation/output/net.h.rst /devel/v4l/docs/Documentation/output/video.h.rst /devel/v4l/docs/Documentation/output/videodev2.h.rst /devel/v4l/docs/Documentation/output/media.h.rst /devel/v4l/docs/Documentation/output/cec.h.rst /devel/v4l/docs/Documentation/output/lirc.h.rst 2>/dev/null
    Warning: Documentation/bpf/ringbuf.rst references a file that doesn't exist: Documentation/litmus_tests/bpf-rb/_
      SPHINX  htmldocs --> file:///devel/v4l/docs/Documentation/output
      PARSE   include/uapi/linux/dvb/audio.h
      PARSE   include/uapi/linux/dvb/ca.h
      PARSE   include/uapi/linux/dvb/dmx.h
      PARSE   include/uapi/linux/dvb/frontend.h
      PARSE   include/uapi/linux/dvb/net.h
      PARSE   include/uapi/linux/dvb/video.h
      PARSE   include/uapi/linux/videodev2.h
      PARSE   include/uapi/linux/media.h
      PARSE   include/uapi/linux/cec.h
      PARSE   include/uapi/linux/lirc.h
    Running Sphinx v2.4.4
    enabling CJK for LaTeX builder
    building [mo]: targets for 0 po files that are out of date
    building [html]: targets for 2672 source files that are out of date
    updating environment: [new config] 2672 added, 0 changed, 0 removed
    reading sources... [100%] x86/kernel-stacks .. xtensa/mmu                                                                                                                                     
    waiting for workers...
    /devel/v4l/docs/Documentation/bpf/ringbuf.rst:197: WARNING: Unknown target name: "bench_ringbuf.c".
    looking for now-outdated files... none found
    pickling environment... done
    checking consistency... done
    preparing documents... done
    writing output... [100%] w1/w1-netlink .. xtensa/mmu                                                                                                                                          
    waiting for workers...
    generating indices...  genindexdone
    writing additional pages...  searchdone
    copying images... [100%] userspace-api/media/v4l/constraints.svg                                                                                                                              
    copying static files... ... done
    copying extra files... done
    dumping search index in English (code: en)... done
    dumping object inventory... done
    build succeeded, 1 warning.
    
    The HTML pages are in Documentation/output.


At least part of those patches won't apply against docs-next, as they depend
on stuff at linux-next. So, it is preferred if they can be applied via each
sub-maintainer's tree.

I'll rebase those during the next merge window. This way, if some
patches ended being missed, they can be applied by the end of the
merge window.

Hopefully, we can make Kernel 5.10 free of documentation warnings.

[1] with the exception of two latmus warnings that seems to require a patch
      that it was not merged yet.

Regards,
Mauro

Mauro Carvalho Chehab (14):
  locking/refcount: document the new "oldp" pointer value
  usb: docs: document altmode register/unregister functions
  XArray: docs: add missing kernel-doc parameters for xas_split_alloc()
  blk-mq: docs: add kernel-doc description for a new struct member
  iio: docs: add description for a new function member
  nl80211: docs: add a description for s1g_cap parameter
  IB/srpt: docs: add a description for cq_size member
  rcu/tree: docs: document bkvcache new members at struct kfree_rcu_cpu
  Input: sparse-keymap: add a description for @sw
  drm: amdgpu: kernel-doc: update some adev parameters
  drm/amd/display: kernel-doc: document force_timing_sync
  drm: kernel-doc: document drm_dp_set_subconnector_property() params
  drm: kernel-doc: drm_dp_helper.h: fix a typo
  gpu: docs: amdgpu.rst: get rid of wrong kernel-doc markups

 Documentation/driver-api/usb/typec_bus.rst       |  8 +++++++-
 Documentation/gpu/amdgpu.rst                     |  7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c      |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c     |  5 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h    |  2 ++
 drivers/gpu/drm/drm_dp_helper.c                  |  7 ++++++-
 drivers/iio/industrialio-core.c                  |  2 ++
 drivers/infiniband/ulp/srpt/ib_srpt.h            |  1 +
 include/drm/drm_dp_helper.h                      |  2 +-
 include/linux/blk-mq.h                           |  2 ++
 include/linux/input/sparse-keymap.h              |  1 +
 include/linux/refcount.h                         |  7 +++++++
 include/linux/usb/typec_altmode.h                | 16 ++++++++++++++++
 include/net/cfg80211.h                           |  1 +
 kernel/rcu/tree.c                                | 14 ++++++--------
 lib/xarray.c                                     | 11 +++++++++--
 17 files changed, 67 insertions(+), 27 deletions(-)

-- 
2.26.2


