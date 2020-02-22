Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B58C35674
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E742192A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 09:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582362017;
	bh=Yz3dn0pNQ6DqgKoRpe27xbFPx6yYJdPurN9KvHO6DPM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=i5Mh3vGT2AqWpK6ZJlDtkKAY0M6RJHtQIRUeFI7UAAMA2wEdIgJFD/RlU0E8c3Y+u
	 70Ik8SBZNaQ+oT75YZ2DN6JZe/ILLI0JuO1oqpZTA6VZhnThksqQzGAkPTWQCGPYxX
	 0zGMsfko+DL8EonII9QcHp0AeOeMb1/DjJj8gwNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgBVJAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 04:00:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60472 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgBVJAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 04:00:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=aJs9pJeE+9fdOcI7/UPFRTUtMdT9B/Ve+SdsB+frIL4=; b=KL1M64rWlOXYXR2gLzTT+zPcN0
        qJErSWCTDKVHoG+nIA5ElK7DfGtiprKGHPXGLpDV1LczB13UpHImVFWeT12mRrHWh8wRjA6ILl+Mf
        OMyKSAYmpetgZS05z01j7+ITUHKu/IXpupcntKqCzHloZiUjg5AD0ppdgId0bQJVfUTAUdzk1XVl4
        8220qixRowcrOJ8sB6hqCtY4Df8/O8rWh+0qp6OkNyalcumYrcL0vlRG3cgHnEoVUvQOSSn6Dqk2e
        OayOI5TEddGtj9SVpciPhAtQ5x1JfEP4RbUYLKw9kt/b1NvuM/jZWd4XK82wzBIDhQg4fEQLwogXh
        xZ1Etujg==;
Received: from [80.156.29.194] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5Qdz-0007Hm-5U; Sat, 22 Feb 2020 09:00:15 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j5Qdx-001N48-Fd; Sat, 22 Feb 2020 10:00:13 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] Some cross-reference fixes due to fixes renames
Date:   Sat, 22 Feb 2020 10:00:00 +0100
Message-Id: <cover.1582361737.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some references that got broken due to renames
(mostly .txt to .yaml and .rst, but also some files got moved
to other directories).

The first patch actually contains a fix for
documentation-file-ref-check, with currently reports several
false positives.

Mauro Carvalho Chehab (7):
  scripts: documentation-file-ref-check: improve :doc: handling
  docs: dt: fix several broken references due to renames
  docs: fix broken references to text files
  docs: adm1177: fix a broken reference
  docs: fix broken references for ReST files that moved around
  docs: remove nompx kernel parameter and intel_mpx from index.rst
  docs: gpu: i915.rst: fix warnings due to file renames

 Documentation/admin-guide/kernel-parameters.txt    | 14 +++++---------
 Documentation/admin-guide/sysctl/kernel.rst        |  2 +-
 Documentation/devicetree/bindings/arm/arm,scmi.txt |  2 +-
 Documentation/devicetree/bindings/arm/arm,scpi.txt |  2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcm63138.txt  |  2 +-
 .../bindings/arm/hisilicon/hi3519-sysctrl.txt      |  2 +-
 .../bindings/arm/msm/qcom,idle-state.txt           |  2 +-
 Documentation/devicetree/bindings/arm/omap/mpu.txt |  2 +-
 Documentation/devicetree/bindings/arm/psci.yaml    |  2 +-
 .../bindings/clock/qcom,gcc-apq8064.yaml           |  2 +-
 .../devicetree/bindings/display/tilcdc/tilcdc.txt  |  2 +-
 Documentation/devicetree/bindings/leds/common.yaml |  2 +-
 .../devicetree/bindings/leds/register-bit-led.txt  |  2 +-
 .../bindings/memory-controllers/ti/emif.txt        |  2 +-
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      |  2 +-
 .../bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   |  2 +-
 .../bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   |  2 +-
 .../bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   |  2 +-
 .../bindings/power/amlogic,meson-ee-pwrc.yaml      |  2 +-
 .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |  2 +-
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      |  2 +-
 Documentation/doc-guide/maintainer-profile.rst     |  2 +-
 Documentation/filesystems/cifs/cifsroot.txt        |  2 +-
 Documentation/gpu/i915.rst                         |  4 ++--
 Documentation/hwmon/adm1177.rst                    |  3 +--
 Documentation/memory-barriers.txt                  |  2 +-
 Documentation/process/submit-checklist.rst         |  2 +-
 .../it_IT/process/submit-checklist.rst             |  2 +-
 .../translations/ko_KR/memory-barriers.txt         |  2 +-
 .../translations/zh_CN/filesystems/sysfs.txt       |  2 +-
 .../zh_CN/process/submit-checklist.rst             |  2 +-
 Documentation/virt/kvm/arm/pvtime.rst              |  2 +-
 Documentation/virt/kvm/devices/vcpu.rst            |  2 +-
 Documentation/virt/kvm/hypercalls.rst              |  4 ++--
 Documentation/virt/kvm/mmu.rst                     |  2 +-
 Documentation/virt/kvm/review-checklist.rst        |  2 +-
 Documentation/x86/index.rst                        |  1 -
 MAINTAINERS                                        |  8 ++++----
 arch/powerpc/include/uapi/asm/kvm_para.h           |  2 +-
 arch/x86/kvm/mmu/mmu.c                             |  2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c    |  2 +-
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c  |  2 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c    |  2 +-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c  |  2 +-
 drivers/gpu/drm/Kconfig                            |  2 +-
 drivers/gpu/drm/drm_ioctl.c                        |  2 +-
 drivers/hwtracing/coresight/Kconfig                |  2 +-
 drivers/media/v4l2-core/v4l2-fwnode.c              |  2 +-
 fs/fat/Kconfig                                     |  8 ++++----
 fs/fuse/Kconfig                                    |  2 +-
 fs/fuse/dev.c                                      |  2 +-
 fs/nfs/Kconfig                                     |  2 +-
 fs/overlayfs/Kconfig                               |  6 +++---
 include/linux/mm.h                                 |  4 ++--
 include/uapi/linux/ethtool_netlink.h               |  2 +-
 include/uapi/linux/kvm.h                           |  4 ++--
 include/uapi/rdma/rdma_user_ioctl_cmds.h           |  2 +-
 mm/gup.c                                           | 12 ++++++------
 net/ipv4/Kconfig                                   |  6 +++---
 net/ipv4/ipconfig.c                                |  2 +-
 scripts/documentation-file-ref-check               | 11 +++++++++--
 tools/include/uapi/linux/kvm.h                     |  4 ++--
 virt/kvm/arm/vgic/vgic-mmio-v3.c                   |  2 +-
 virt/kvm/arm/vgic/vgic.h                           |  4 ++--
 64 files changed, 96 insertions(+), 95 deletions(-)

-- 
2.24.1

