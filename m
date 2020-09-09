Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77235C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 396112087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599670890;
	bh=ZHqZGCTQgaNDleSvBX55YU25SULV/gH+SlDDPoVerP0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=EZHNKwBsNVB9sItwVa/A3CKCNmwLXsOXfAaDt4ziXHUyQCdTGwRp03wd/+bAgFmYn
	 gooDJ/EFnnhEHVEZZ9mPTyJ+ZzB6tRHjXCIb69I/CSd1pMogIs90w4HjOSug85cHiO
	 5KB2n4GYW3YtJuRbihgbaJklGyawabU1Ye6NbkPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbgIIRBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730635AbgIIPuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:50:54 -0400
Received: from mail.kernel.org (ip5f5ad5d6.dynamic.kabel-deutschland.de [95.90.213.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E2A22205;
        Wed,  9 Sep 2020 14:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599660665;
        bh=ZHqZGCTQgaNDleSvBX55YU25SULV/gH+SlDDPoVerP0=;
        h=From:To:Cc:Subject:Date:From;
        b=RAFpdI14kIja8G+LS9tEUtAOBj2zBOZUGa/GEgjGyKp9kNMfWheF7HQptMe/UJmFl
         N2gfquCi/Khwef30BInm3CC8F9a2Lj7AUu8V53lkaosZcb/N+EPQSdrCzq6Szs02v0
         tFZMFOtmxsF2RbySKa9WP9WsXl/uy9tibRVNCVvs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kG0oQ-00DUWW-VI; Wed, 09 Sep 2020 16:11:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andy Gross <agross@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jean Delvare <jdelvare@suse.com>, Jens Axboe <axboe@kernel.dk>,
        Joerg Reuter <jreuter@yaina.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jyri Sarha <jsarha@ti.com>, Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 00/30] docs: fix documentation build parsing errors
Date:   Wed,  9 Sep 2020 16:10:31 +0200
Message-Id: <cover.1599660067.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there are several warnings/errors produced when building
the documentation with "make htmldocs".

This series fixes almost all such errors. It is produced against
linux-next, branch next-20200909.

Some of the patches here were already sent individually, but nobody
picked them. So, I'm re-sending the full series.

After this series,  there will be just two parse warnings due to 
Documentation/bpf/ringbuf.rst, which seems to have been
included at linux-next before the actual feature. I already wrote
an e-mail to the author asking for a fix.

There are still plenty warnings produced by kernel-doc, but those
are due to missing files and/or parameters, like:

./include/linux/blk-mq.h:267: warning: Function parameter or member 'active_queues_shared_sbitmap' not described in 'blk_mq_tag_set'
./drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c:1: warning: no structured comments found
./drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:675: warning: Excess function parameter 'dev' description in 'amdgpu_device_asic_init'
./drivers/usb/typec/bus.c:1: warning: 'typec_altmode_unregister_driver' not found

As time allows, I will try to cleanup most of those too, although
some may require a deeper knowledge of the affected subsystems.

Jon,

I know that you don't like very much patches against linux-next,
but that seems to be the only way to address issues when building
the docs, as warnings can come from random trees.

My suggestion would be for you to pick at least the ones that apply
cleanly on your tree.  I can rebase the ones later for them to be
applied along the merge window.

I'm aiming here to have Kernel 5.10 free of documentation
warnings. Hopefully, people will take more care to avoid
introducing new warnings once we get rid of all of them.

Mauro Carvalho Chehab (30):
  .gitignore: docs: ignore sphinx_*/ directories
  kernel-doc: include line numbers for function prototypes
  dt-bindings: fix references to files converted to yaml
  docs: hwmon: adm1266.rst: fix a broken reference
  docs: scheduler: fix the directory name on two files
  docs: trace: fix the location of kprobes.rst
  MAINTAINERS: fix location of qlogic/LICENSE.qla3xxx
  docs: fix location of nommu-mmap.rst file
  net: appletalk: Kconfig: Fix docs location
  drivers: net: hamradio: fix document location
  tools: docs: memory-model: fix references for some files
  scripts: device_attr_show.cocci: update location of sysfs doc
  docs: SafeSetID: fix a warning
  docs: add some new files to their respective index.rst files
  docs: powerpc: syscall64-abi.rst: fix a malformed table
  docs: watch_queue: fix some warnings
  docs: kvm: api.rst: add missing spaces
  block: bio: fix a warning at the kernel-doc markups
  docs: soundwire: fix some identation at stream.rst
  docs: dma-buf: fix some warnings
  iio: industrialio-core.c: solve a kernel-doc warning
  kunit: test.h: solve kernel-doc warnings
  docs: submitting-patches: use :doc: for references
  docs: lockdep-design: fix some warning issues
  docs: admin-guide: net.rst: add a missing blank line
  iio: iio.h: fix a warning at the kernel-doc markup
  docs: bio: fix a kerneldoc markup
  drivers: core: fix kernel-doc markup for dev_err_probe()
  kunit: test.h: fix a bad kernel-doc markup
  docs: amdgpu: fix a warning when building the documentation

 .gitignore                                    |  3 +
 Documentation/admin-guide/LSM/SafeSetID.rst   |  2 +-
 Documentation/admin-guide/sysctl/net.rst      |  1 +
 .../bindings/display/tilcdc/tilcdc.txt        |  2 +-
 .../bindings/mailbox/omap-mailbox.txt         |  2 +-
 .../devicetree/bindings/media/i2c/tvp5150.txt |  2 +-
 .../bindings/pwm/google,cros-ec-pwm.yaml      |  2 +-
 .../bindings/soc/qcom/qcom,smd-rpm.yaml       |  2 +-
 .../bindings/sound/google,cros-ec-codec.yaml  |  2 +-
 Documentation/driver-api/dma-buf.rst          |  2 +-
 Documentation/driver-api/nvdimm/index.rst     |  1 +
 Documentation/driver-api/soundwire/stream.rst |  8 +--
 Documentation/firmware-guide/acpi/index.rst   |  1 +
 Documentation/gpu/amdgpu.rst                  |  4 +-
 Documentation/hwmon/adm1266.rst               |  2 +-
 Documentation/hwmon/index.rst                 |  1 +
 Documentation/locking/lockdep-design.rst      | 69 +++++++++++--------
 Documentation/powerpc/syscall64-abi.rst       | 32 ++++-----
 Documentation/process/submitting-patches.rst  | 20 +++---
 Documentation/scheduler/sched-capacity.rst    |  2 +-
 Documentation/scheduler/sched-energy.rst      |  2 +-
 Documentation/trace/kprobetrace.rst           |  2 +-
 Documentation/virt/kvm/api.rst                |  2 +-
 Documentation/vm/index.rst                    |  1 +
 Documentation/watch_queue.rst                 | 14 ++--
 MAINTAINERS                                   | 20 +++---
 block/bio.c                                   |  4 +-
 drivers/base/core.c                           |  7 +-
 drivers/iio/industrialio-core.c               |  2 +-
 drivers/net/appletalk/Kconfig                 |  2 +-
 drivers/net/hamradio/scc.c                    |  2 +-
 .../bindings/net/wireless/siliabs,wfx.txt     |  2 +-
 include/kunit/test.h                          | 16 +++--
 include/linux/iio/iio.h                       |  2 +-
 init/Kconfig                                  |  2 +-
 mm/Kconfig                                    |  2 +-
 mm/nommu.c                                    |  2 +-
 samples/kprobes/kprobe_example.c              |  2 +-
 samples/kprobes/kretprobe_example.c           |  2 +-
 scripts/coccinelle/api/device_attr_show.cocci |  2 +-
 scripts/kernel-doc                            |  2 +
 tools/memory-model/Documentation/README       |  2 +-
 tools/memory-model/Documentation/ordering.txt |  2 +-
 43 files changed, 142 insertions(+), 114 deletions(-)

-- 
2.26.2


