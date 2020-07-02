Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABD9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BC66208D5
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k5CINslm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgGBWFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgGBWFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 18:05:08 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE5EC08C5C1;
        Thu,  2 Jul 2020 15:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=rRnzHtWyFuGQXkWiWUyo4Cu7hlztJLsnt7DxGks12PU=; b=k5CINslmMkGCdiZDmiPeEzejPi
        uVLeXh7+ojrcW70RWvmBjm6Ob9YCf0Ti4/u6ytzZ9Y4ipsYukIUR4TT/p+/SEMP09gTJsMNnzuxvX
        agsv3G43fVJloUrTFFpg1wOu8+xLGjA0oW29UbaZsQvR/zrAIIg8upRkkayqjI6WriYMBW1RtEzzD
        Yht/pbHlMwi/mHCEzpQ8ccvDNkQSJUsbeflhlrQSATeYBWp8ZOlAVY2co2ijsJEFu90k9S153tA44
        jals8XIXkiNWTX7z8+dspXup+Nz+Vop3Zp7oqrvKJEKRmDy/lK95dSxcMpE4zss9GpveoyH1i74qV
        OuP6H5cg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr7KK-0000A6-C8; Thu, 02 Jul 2020 22:05:04 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [RFC] many-files Documentation patch
To:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <ca6d7248-df70-4a39-3cbe-b49f286d5e50@infradead.org>
Date:   Thu, 2 Jul 2020 15:05:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series eliminates/corrects many doubled words, such as
"the the", "of of", "with with", and "and and".
It mostly drops the doubled word, but sometimes it modifies one or two
words so that they make sense.


Can (will) Jon merge this patch series or do I send many separate patches
to relevant subsystem maintainers?
or trivial?


 Documentation/PCI/endpoint/pci-endpoint-cfs.rst                       |    2 -
 Documentation/PCI/endpoint/pci-endpoint.rst                           |    2 -
 Documentation/PCI/pci-error-recovery.rst                              |    2 -
 Documentation/PCI/pci.rst                                             |    2 -
 Documentation/RCU/Design/Data-Structures/Data-Structures.rst          |    2 -
 Documentation/RCU/Design/Requirements/Requirements.rst                |    4 +-
 Documentation/RCU/lockdep.rst                                         |    2 -
 Documentation/RCU/torture.rst                                         |    2 -
 Documentation/admin-guide/cgroup-v1/rdma.rst                          |    2 -
 Documentation/admin-guide/cgroup-v2.rst                               |    2 -
 Documentation/admin-guide/device-mapper/dm-integrity.rst              |    4 +-
 Documentation/admin-guide/media/building.rst                          |    4 +-
 Documentation/admin-guide/mm/ksm.rst                                  |    2 -
 Documentation/admin-guide/nfs/pnfs-block-server.rst                   |    2 -
 Documentation/admin-guide/nfs/pnfs-scsi-server.rst                    |    2 -
 Documentation/admin-guide/perf/arm-ccn.rst                            |    2 -
 Documentation/admin-guide/pm/intel-speed-select.rst                   |    4 +-
 Documentation/admin-guide/pm/intel_pstate.rst                         |    2 -
 Documentation/admin-guide/sysctl/kernel.rst                           |    2 -
 Documentation/admin-guide/tainted-kernels.rst                         |    2 -
 Documentation/admin-guide/xfs.rst                                     |    2 -
 Documentation/arm64/acpi_object_usage.rst                             |    2 -
 Documentation/arm64/arm-acpi.rst                                      |    2 -
 Documentation/arm64/sve.rst                                           |    2 -
 Documentation/block/pr.rst                                            |    2 -
 Documentation/core-api/printk-basics.rst                              |    2 -
 Documentation/dev-tools/kgdb.rst                                      |    2 -
 Documentation/devicetree/booting-without-of.rst                       |    2 -
 Documentation/driver-api/dmaengine/provider.rst                       |    2 -
 Documentation/driver-api/driver-model/platform.rst                    |    2 -
 Documentation/driver-api/firmware/built-in-fw.rst                     |    2 -
 Documentation/driver-api/firmware/direct-fs-lookup.rst                |    2 -
 Documentation/driver-api/firmware/firmware_cache.rst                  |    2 -
 Documentation/driver-api/firmware/request_firmware.rst                |    2 -
 Documentation/driver-api/generic-counter.rst                          |    2 -
 Documentation/driver-api/iio/buffers.rst                              |    2 -
 Documentation/driver-api/media/cec-core.rst                           |    2 -
 Documentation/driver-api/media/dtv-frontend.rst                       |    6 +--
 Documentation/driver-api/media/v4l2-controls.rst                      |    4 +-
 Documentation/driver-api/media/v4l2-dev.rst                           |    2 -
 Documentation/driver-api/ntb.rst                                      |    2 -
 Documentation/driver-api/nvdimm/nvdimm.rst                            |    2 -
 Documentation/driver-api/uio-howto.rst                                |    2 -
 Documentation/driver-api/usb/URB.rst                                  |    2 -
 Documentation/driver-api/xillybus.rst                                 |    2 -
 Documentation/filesystems/autofs-mount-control.rst                    |    6 +--
 Documentation/filesystems/caching/operations.rst                      |    2 -
 Documentation/filesystems/configfs.rst                                |    2 -
 Documentation/filesystems/directory-locking.rst                       |    4 +-
 Documentation/filesystems/fsverity.rst                                |    2 -
 Documentation/filesystems/mount_api.rst                               |    4 +-
 Documentation/filesystems/overlayfs.rst                               |    2 -
 Documentation/filesystems/path-lookup.rst                             |    2 -
 Documentation/filesystems/sysfs-tagging.rst                           |    2 -
 Documentation/filesystems/vfs.rst                                     |    4 +-
 Documentation/fpga/dfl.rst                                            |    2 -
 Documentation/gpu/drm-uapi.rst                                        |    2 -
 Documentation/gpu/komeda-kms.rst                                      |    2 -
 Documentation/hid/intel-ish-hid.rst                                   |    2 -
 Documentation/hwmon/f71882fg.rst                                      |    2 -
 Documentation/hwmon/lm93.rst                                          |    2 -
 Documentation/hwmon/nct6775.rst                                       |    2 -
 Documentation/hwmon/w83627ehf.rst                                     |    2 -
 Documentation/hwmon/w83l786ng.rst                                     |    2 -
 Documentation/i2c/upgrading-clients.rst                               |    2 -
 Documentation/kbuild/kconfig-language.rst                             |    2 -
 Documentation/leds/ledtrig-transient.rst                              |    2 -
 Documentation/locking/mutex-design.rst                                |    2 -
 Documentation/locking/ww-mutex-design.rst                             |    2 -
 Documentation/maintainer/maintainer-entry-profile.rst                 |    2 -
 Documentation/mips/ingenic-tcu.rst                                    |    2 -
 Documentation/misc-devices/xilinx_sdfec.rst                           |    2 -
 Documentation/networking/arcnet.rst                                   |    2 -
 Documentation/networking/ax25.rst                                     |    2 -
 Documentation/networking/can_ucan_protocol.rst                        |    4 +-
 Documentation/networking/device_drivers/ethernet/intel/i40e.rst       |    2 -
 Documentation/networking/device_drivers/ethernet/intel/iavf.rst       |    2 -
 Documentation/networking/dsa/dsa.rst                                  |    2 -
 Documentation/networking/ip-sysctl.rst                                |    2 -
 Documentation/networking/ipvs-sysctl.rst                              |    2 -
 Documentation/networking/rxrpc.rst                                    |    2 -
 Documentation/powerpc/vas-api.rst                                     |    2 -
 Documentation/s390/vfio-ap.rst                                        |    2 -
 Documentation/scsi/advansys.rst                                       |    2 -
 Documentation/security/keys/trusted-encrypted.rst                     |    2 -
 Documentation/trace/ftrace.rst                                        |    4 +-
 Documentation/trace/histogram-design.rst                              |    4 +-
 Documentation/trace/stm.rst                                           |    4 +-
 Documentation/userspace-api/media/dvb/audio.rst                       |    2 -
 Documentation/userspace-api/media/dvb/ca.rst                          |    2 -
 Documentation/userspace-api/media/dvb/demux.rst                       |    2 -
 Documentation/userspace-api/media/dvb/dmx-qbuf.rst                    |    2 -
 Documentation/userspace-api/media/dvb/net.rst                         |    2 -
 Documentation/userspace-api/media/dvb/video.rst                       |    2 -
 Documentation/userspace-api/media/v4l/buffer.rst                      |    2 -
 Documentation/userspace-api/media/v4l/dev-osd.rst                     |    2 -
 Documentation/userspace-api/media/v4l/selection-api-configuration.rst |    2 -
 Documentation/userspace-api/media/v4l/vidioc-g-ext-ctrls.rst          |    2 -
 Documentation/userspace-api/media/v4l/vidioc-g-output.rst             |    2 -
 Documentation/userspace-api/media/v4l/vidioc-qbuf.rst                 |    2 -
 Documentation/virt/kvm/api.rst                                        |   16 +++++-----
 Documentation/virt/kvm/s390-pv.rst                                    |    2 -
 Documentation/vm/memory-model.rst                                     |    2 -
 Documentation/x86/earlyprintk.rst                                     |    2 -
 Documentation/x86/x86_64/machinecheck.rst                             |    2 -
 105 files changed, 128 insertions(+), 128 deletions(-)


(BTW, it's in a quilt patch series, not a git tree.)

thanks.
-- 
~Randy

