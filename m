Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991ADC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4991620836
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NS+AaxhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405146AbgFXQaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405010AbgFXQ3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:29:33 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F6BC0613ED;
        Wed, 24 Jun 2020 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Lk+0LEnCF+P9xT8cYOI5jCF+HJZITcFH7htDQaK8jkE=; b=NS+AaxhH/Eaq0aIQ8iLQUOH/tK
        mRQligFQLMmu3r8rgxzL5hgKEEs7zUX9yQ/T9mx7r8biVLmyuyPVLHOdHCy7Qsv+ssNtb+TSsZK2m
        00xKG0wDbyJBv5Oj1Rd1ddA0MJBSfxtNdDA0/wGKv4ItymW84Dh6/Y7KXhn6R1PihpJlPyUN3g5Jt
        PKjx9PVHuOfz8/cXYpCwJNHgTu/AJ0FAHEeGyAkI7q+95NxOsRMjvW4zLi3ID5AelAPAZPX9IuVp9
        klebsobGVBSac6FYZgnmvV7dUuH3QtodAIqZe9PE6oGkKkExYgq4y+a3izklR4OXLH+QYkpVNoaFj
        lSKyuUKg==;
Received: from [2001:4bb8:180:a3:5c7c:8955:539d:955b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo8Gv-0006pQ-8y; Wed, 24 Jun 2020 16:29:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/11] seq_file: switch over direct seq_read method calls to seq_read_iter
Date:   Wed, 24 Jun 2020 18:28:58 +0200
Message-Id: <20200624162901.1814136-9-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624162901.1814136-1-hch@lst.de>
References: <20200624162901.1814136-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch over all instances used directly as methods using these sed
expressions:

sed -i -e 's/\.read\(\s*=\s*\)seq_read/\.read_iter\1seq_read_iter/g'

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/seq_file.rst        |  2 +-
 Documentation/process/clang-format.rst        |  4 +-
 .../it_IT/process/clang-format.rst            |  4 +-
 arch/arm/mm/ptdump_debugfs.c                  |  2 +-
 arch/arm64/kvm/vgic/vgic-debug.c              |  2 +-
 arch/c6x/platforms/pll.c                      |  2 +-
 arch/mips/cavium-octeon/oct_ilm.c             |  2 +-
 arch/mips/kernel/segment.c                    |  2 +-
 arch/mips/ralink/bootrom.c                    |  2 +-
 arch/powerpc/kvm/book3s_xive_native.c         |  2 +-
 arch/powerpc/kvm/timing.c                     |  2 +-
 arch/powerpc/mm/ptdump/bats.c                 |  2 +-
 arch/powerpc/mm/ptdump/hashpagetable.c        |  2 +-
 arch/powerpc/mm/ptdump/ptdump.c               |  2 +-
 arch/powerpc/mm/ptdump/segment_regs.c         |  2 +-
 arch/powerpc/platforms/cell/spufs/file.c      |  8 ++--
 arch/powerpc/platforms/pseries/hvCall_inst.c  |  2 +-
 arch/s390/kernel/diag.c                       |  2 +-
 arch/s390/mm/dump_pagetables.c                |  2 +-
 arch/s390/pci/pci_debug.c                     |  2 +-
 arch/sh/mm/asids-debugfs.c                    |  2 +-
 arch/sh/mm/cache-debugfs.c                    |  2 +-
 arch/sh/mm/pmb.c                              |  2 +-
 arch/sh/mm/tlb-debugfs.c                      |  2 +-
 arch/x86/kernel/cpu/mce/severity.c            |  2 +-
 arch/x86/mm/pat/memtype.c                     |  2 +-
 arch/x86/mm/pat/set_memory.c                  |  2 +-
 arch/x86/xen/p2m.c                            |  2 +-
 block/blk-mq-debugfs.c                        |  2 +-
 drivers/base/power/wakeup.c                   |  2 +-
 drivers/block/aoe/aoeblk.c                    |  2 +-
 drivers/block/drbd/drbd_debugfs.c             | 10 ++---
 drivers/block/nbd.c                           |  4 +-
 drivers/block/pktcdvd.c                       |  2 +-
 drivers/block/rsxx/core.c                     |  4 +-
 drivers/bus/mvebu-mbus.c                      |  4 +-
 drivers/char/tpm/eventlog/common.c            |  2 +-
 .../crypto/allwinner/sun8i-ce/sun8i-ce-core.c |  2 +-
 .../crypto/allwinner/sun8i-ss/sun8i-ss-core.c |  2 +-
 drivers/crypto/amlogic/amlogic-gxl-core.c     |  2 +-
 drivers/crypto/caam/dpseci-debugfs.c          |  2 +-
 drivers/crypto/cavium/zip/zip_main.c          |  6 +--
 drivers/crypto/hisilicon/qm.c                 |  2 +-
 drivers/crypto/qat/qat_common/adf_cfg.c       |  2 +-
 .../qat/qat_common/adf_transport_debug.c      |  4 +-
 drivers/firmware/tegra/bpmp-debugfs.c         |  2 +-
 drivers/gpio/gpiolib.c                        |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c      |  4 +-
 .../gpu/drm/arm/display/komeda/komeda_dev.c   |  2 +-
 drivers/gpu/drm/arm/malidp_drv.c              |  2 +-
 drivers/gpu/drm/armada/armada_debugfs.c       |  2 +-
 drivers/gpu/drm/drm_debugfs.c                 |  6 +--
 drivers/gpu/drm/drm_debugfs_crc.c             |  2 +-
 drivers/gpu/drm/drm_mipi_dbi.c                |  2 +-
 .../drm/i915/display/intel_display_debugfs.c  | 16 ++++----
 drivers/gpu/drm/i915/gt/debugfs_gt.h          |  2 +-
 drivers/gpu/drm/i915/i915_debugfs_params.c    | 12 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c  |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c      |  4 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c   |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c       |  4 +-
 drivers/gpu/drm/msm/msm_debugfs.c             |  2 +-
 drivers/gpu/drm/nouveau/nouveau_debugfs.c     |  2 +-
 drivers/gpu/drm/omapdrm/dss/dss.c             |  2 +-
 drivers/gpu/host1x/debug.c                    |  4 +-
 drivers/gpu/vga/vga_switcheroo.c              |  2 +-
 drivers/hid/hid-picolcd_debugfs.c             |  2 +-
 drivers/hid/hid-wiimote-debug.c               |  2 +-
 drivers/ide/ide-proc.c                        |  2 +-
 drivers/infiniband/hw/cxgb4/device.c          |  4 +-
 drivers/infiniband/hw/qib/qib_debugfs.c       |  2 +-
 drivers/infiniband/ulp/ipoib/ipoib_fs.c       |  4 +-
 drivers/md/bcache/closure.c                   |  2 +-
 drivers/media/cec/core/cec-core.c             |  2 +-
 drivers/media/pci/saa7164/saa7164-core.c      |  2 +-
 drivers/memory/emif.c                         |  4 +-
 drivers/memory/tegra/tegra124-emc.c           |  2 +-
 drivers/memory/tegra/tegra186-emc.c           |  2 +-
 drivers/memory/tegra/tegra20-emc.c            |  2 +-
 drivers/memory/tegra/tegra30-emc.c            |  2 +-
 drivers/mfd/ab3100-core.c                     |  2 +-
 drivers/mfd/ab3100-otp.c                      |  2 +-
 drivers/mfd/ab8500-debugfs.c                  | 14 +++----
 drivers/mfd/tps65010.c                        |  2 +-
 drivers/misc/habanalabs/debugfs.c             |  2 +-
 drivers/mmc/core/mmc_test.c                   |  2 +-
 drivers/mtd/mtdcore.c                         |  4 +-
 drivers/mtd/ubi/debug.c                       |  2 +-
 .../ethernet/chelsio/cxgb4/cxgb4_debugfs.c    | 38 +++++++++----------
 drivers/net/ethernet/chelsio/cxgb4/l2t.c      |  2 +-
 .../ethernet/chelsio/cxgb4vf/cxgb4vf_main.c   |  8 ++--
 .../freescale/dpaa2/dpaa2-eth-debugfs.c       |  6 +--
 .../net/ethernet/intel/fm10k/fm10k_debugfs.c  |  2 +-
 .../marvell/octeontx2/af/rvu_debugfs.c        |  2 +-
 drivers/net/wireless/ath/ath5k/debug.c        |  2 +-
 drivers/net/wireless/ath/wil6210/debugfs.c    | 14 +++----
 .../broadcom/brcm80211/brcmsmac/debug.c       |  2 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |  2 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  2 +-
 .../wireless/mediatek/mt76/mt7603/debugfs.c   |  2 +-
 .../wireless/mediatek/mt76/mt7615/debugfs.c   |  2 +-
 .../wireless/mediatek/mt76/mt76x02_debugfs.c  |  4 +-
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  4 +-
 .../net/wireless/mediatek/mt7601u/debugfs.c   |  4 +-
 drivers/net/wireless/realtek/rtlwifi/debug.c  |  2 +-
 drivers/net/wireless/realtek/rtw88/debug.c    |  4 +-
 drivers/net/wireless/rsi/rsi_91x_debugfs.c    |  4 +-
 drivers/net/xen-netback/xenbus.c              |  2 +-
 drivers/nvme/host/fabrics.c                   |  2 +-
 drivers/pci/controller/pci-tegra.c            |  2 +-
 drivers/platform/x86/asus-wmi.c               |  2 +-
 drivers/platform/x86/intel_pmc_core.c         |  2 +-
 .../platform/x86/intel_telemetry_debugfs.c    |  4 +-
 drivers/power/supply/da9030_battery.c         |  2 +-
 drivers/pwm/core.c                            |  2 +-
 drivers/ras/cec.c                             |  2 +-
 drivers/ras/debugfs.c                         |  2 +-
 drivers/s390/block/dasd.c                     |  2 +-
 drivers/s390/cio/qdio_debug.c                 |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c         | 32 ++++++++--------
 drivers/scsi/qedf/qedf_dbg.h                  |  2 +-
 drivers/scsi/qedi/qedi_dbg.h                  |  2 +-
 drivers/scsi/qla2xxx/qla_dfs.c                | 12 +++---
 drivers/scsi/snic/snic_debugfs.c              |  4 +-
 drivers/sh/intc/virq-debugfs.c                |  2 +-
 drivers/soc/qcom/cmd-db.c                     |  2 +-
 drivers/soc/qcom/socinfo.c                    |  4 +-
 drivers/soc/ti/knav_dma.c                     |  2 +-
 drivers/soc/ti/knav_qmss_queue.c              |  2 +-
 .../interface/vchiq_arm/vchiq_debugfs.c       |  4 +-
 drivers/usb/chipidea/debug.c                  |  4 +-
 drivers/usb/dwc2/debugfs.c                    |  2 +-
 drivers/usb/dwc3/debugfs.c                    |  8 ++--
 drivers/usb/gadget/udc/lpc32xx_udc.c          |  2 +-
 drivers/usb/gadget/udc/renesas_usb3.c         |  2 +-
 drivers/usb/host/xhci-debugfs.c               |  6 +--
 drivers/usb/mtu3/mtu3_debugfs.c               |  8 ++--
 drivers/usb/musb/musb_debugfs.c               |  4 +-
 drivers/visorbus/visorbus_main.c              |  2 +-
 drivers/xen/xenfs/xensyms.c                   |  2 +-
 fs/debugfs/file.c                             |  4 +-
 fs/dlm/debug_fs.c                             |  8 ++--
 fs/gfs2/glock.c                               |  6 +--
 fs/nfsd/nfs4state.c                           |  4 +-
 fs/nfsd/nfsctl.c                              | 10 ++---
 fs/ocfs2/cluster/netdebug.c                   |  6 +--
 fs/ocfs2/dlm/dlmdebug.c                       |  2 +-
 fs/ocfs2/dlmglue.c                            |  2 +-
 fs/openpromfs/inode.c                         |  2 +-
 fs/orangefs/orangefs-debugfs.c                |  2 +-
 fs/proc/array.c                               |  2 +-
 fs/proc/base.c                                | 24 ++++++------
 fs/proc/fd.c                                  |  2 +-
 fs/proc/task_mmu.c                            |  8 ++--
 fs/proc/task_nommu.c                          |  2 +-
 fs/proc_namespace.c                           |  6 +--
 include/linux/seq_file.h                      |  4 +-
 kernel/bpf/inode.c                            |  2 +-
 kernel/fail_function.c                        |  2 +-
 kernel/gcov/fs.c                              |  2 +-
 kernel/irq/debugfs.c                          |  2 +-
 kernel/kcsan/debugfs.c                        |  2 +-
 kernel/sched/debug.c                          |  2 +-
 kernel/time/test_udelay.c                     |  2 +-
 kernel/trace/ftrace.c                         | 16 ++++----
 kernel/trace/trace.c                          | 20 +++++-----
 kernel/trace/trace_dynevent.c                 |  2 +-
 kernel/trace/trace_events.c                   | 10 ++---
 kernel/trace/trace_events_hist.c              |  4 +-
 kernel/trace/trace_events_synth.c             |  2 +-
 kernel/trace/trace_events_trigger.c           |  2 +-
 kernel/trace/trace_kprobe.c                   |  4 +-
 kernel/trace/trace_printk.c                   |  2 +-
 kernel/trace/trace_stack.c                    |  4 +-
 kernel/trace/trace_stat.c                     |  2 +-
 kernel/trace/trace_uprobe.c                   |  4 +-
 lib/debugobjects.c                            |  2 +-
 lib/dynamic_debug.c                           |  2 +-
 lib/error-inject.c                            |  2 +-
 lib/kunit/debugfs.c                           |  2 +-
 mm/kmemleak.c                                 |  2 +-
 net/6lowpan/debugfs.c                         |  2 +-
 net/batman-adv/debugfs.c                      |  4 +-
 net/bluetooth/6lowpan.c                       |  2 +-
 net/hsr/hsr_debugfs.c                         |  2 +-
 net/l2tp/l2tp_debugfs.c                       |  2 +-
 net/sunrpc/cache.c                            |  2 +-
 net/sunrpc/debugfs.c                          |  4 +-
 net/sunrpc/rpc_pipe.c                         |  2 +-
 security/apparmor/apparmorfs.c                | 10 ++---
 security/integrity/ima/ima_fs.c               |  6 +--
 security/selinux/selinuxfs.c                  |  2 +-
 security/smack/smackfs.c                      | 20 +++++-----
 193 files changed, 375 insertions(+), 375 deletions(-)

diff --git a/Documentation/filesystems/seq_file.rst b/Documentation/filesystems/seq_file.rst
index 7f7ee06b26939f..74e07b550401d6 100644
--- a/Documentation/filesystems/seq_file.rst
+++ b/Documentation/filesystems/seq_file.rst
@@ -311,7 +311,7 @@ file_operations structure will look like::
 	static const struct file_operations ct_file_ops = {
 	        .owner   = THIS_MODULE,
 	        .open    = ct_open,
-	        .read    = seq_read,
+	        .read_iter    = seq_read_iter,
 	        .llseek  = seq_lseek,
 	        .release = seq_release
 	};
diff --git a/Documentation/process/clang-format.rst b/Documentation/process/clang-format.rst
index 6710c0707721da..7f04493cba4f20 100644
--- a/Documentation/process/clang-format.rst
+++ b/Documentation/process/clang-format.rst
@@ -136,7 +136,7 @@ In particular, some very common ones you will notice are:
         static const struct file_operations uprobe_events_ops = {
                 .owner          = THIS_MODULE,
                 .open           = probes_open,
-                .read           = seq_read,
+                .read_iter           = seq_read_iter,
                 .llseek         = seq_lseek,
                 .release        = seq_release,
                 .write          = probes_write,
@@ -147,7 +147,7 @@ In particular, some very common ones you will notice are:
         static const struct file_operations uprobe_events_ops = {
                 .owner = THIS_MODULE,
                 .open = probes_open,
-                .read = seq_read,
+                .read_iter = seq_read_iter,
                 .llseek = seq_lseek,
                 .release = seq_release,
                 .write = probes_write,
diff --git a/Documentation/translations/it_IT/process/clang-format.rst b/Documentation/translations/it_IT/process/clang-format.rst
index 77eac809a63929..b491789877a726 100644
--- a/Documentation/translations/it_IT/process/clang-format.rst
+++ b/Documentation/translations/it_IT/process/clang-format.rst
@@ -149,7 +149,7 @@ In particolare, quelli più comuni che noterete sono:
         static const struct file_operations uprobe_events_ops = {
                 .owner          = THIS_MODULE,
                 .open           = probes_open,
-                .read           = seq_read,
+                .read_iter           = seq_read_iter,
                 .llseek         = seq_lseek,
                 .release        = seq_release,
                 .write          = probes_write,
@@ -160,7 +160,7 @@ In particolare, quelli più comuni che noterete sono:
         static const struct file_operations uprobe_events_ops = {
                 .owner = THIS_MODULE,
                 .open = probes_open,
-                .read = seq_read,
+                .read_iter = seq_read_iter,
                 .llseek = seq_lseek,
                 .release = seq_release,
                 .write = probes_write,
diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index 598b636615a29a..ec30bf13c41635 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -19,7 +19,7 @@ static int ptdump_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ptdump_fops = {
 	.open		= ptdump_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/arm64/kvm/vgic/vgic-debug.c b/arch/arm64/kvm/vgic/vgic-debug.c
index b13a9e3f99ddc1..76998af2449bb0 100644
--- a/arch/arm64/kvm/vgic/vgic-debug.c
+++ b/arch/arm64/kvm/vgic/vgic-debug.c
@@ -284,7 +284,7 @@ static int debug_open(struct inode *inode, struct file *file)
 static const struct file_operations vgic_debug_fops = {
 	.owner   = THIS_MODULE,
 	.open    = debug_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
diff --git a/arch/c6x/platforms/pll.c b/arch/c6x/platforms/pll.c
index 6fdf20d64dc753..a952faff19ce9a 100644
--- a/arch/c6x/platforms/pll.c
+++ b/arch/c6x/platforms/pll.c
@@ -424,7 +424,7 @@ static int c6x_ck_open(struct inode *inode, struct file *file)
 
 static const struct file_operations c6x_ck_operations = {
 	.open		= c6x_ck_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/mips/cavium-octeon/oct_ilm.c b/arch/mips/cavium-octeon/oct_ilm.c
index 99e27155b3991f..4d91cb8da0a75a 100644
--- a/arch/mips/cavium-octeon/oct_ilm.c
+++ b/arch/mips/cavium-octeon/oct_ilm.c
@@ -51,7 +51,7 @@ static int oct_ilm_open(struct inode *inode, struct file *file)
 
 static const struct file_operations oct_ilm_ops = {
 	.open = oct_ilm_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/arch/mips/kernel/segment.c b/arch/mips/kernel/segment.c
index 0a9bd7b0983b93..9ea0c2e7915814 100644
--- a/arch/mips/kernel/segment.c
+++ b/arch/mips/kernel/segment.c
@@ -88,7 +88,7 @@ static int segments_open(struct inode *inode, struct file *file)
 
 static const struct file_operations segments_fops = {
 	.open		= segments_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/mips/ralink/bootrom.c b/arch/mips/ralink/bootrom.c
index 94ca8379b83c90..bc83a355fdb18d 100644
--- a/arch/mips/ralink/bootrom.c
+++ b/arch/mips/ralink/bootrom.c
@@ -26,7 +26,7 @@ static int bootrom_open(struct inode *inode, struct file *file)
 
 static const struct file_operations bootrom_file_ops = {
 	.open		= bootrom_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/powerpc/kvm/book3s_xive_native.c b/arch/powerpc/kvm/book3s_xive_native.c
index bdea91df149742..02e3cbbeac5b37 100644
--- a/arch/powerpc/kvm/book3s_xive_native.c
+++ b/arch/powerpc/kvm/book3s_xive_native.c
@@ -1234,7 +1234,7 @@ static int xive_native_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations xive_native_debug_fops = {
 	.open = xive_native_debug_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index ba56a5cbba97f3..e045b6d5c7180f 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -198,7 +198,7 @@ static int kvmppc_exit_timing_open(struct inode *inode, struct file *file)
 static const struct file_operations kvmppc_exit_timing_fops = {
 	.owner   = THIS_MODULE,
 	.open    = kvmppc_exit_timing_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.write   = kvmppc_exit_timing_write,
 	.llseek  = seq_lseek,
 	.release = single_release,
diff --git a/arch/powerpc/mm/ptdump/bats.c b/arch/powerpc/mm/ptdump/bats.c
index e29b338d499f4d..7afcdac48a1617 100644
--- a/arch/powerpc/mm/ptdump/bats.c
+++ b/arch/powerpc/mm/ptdump/bats.c
@@ -154,7 +154,7 @@ static int bats_open(struct inode *inode, struct file *file)
 
 static const struct file_operations bats_fops = {
 	.open		= bats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index a2c33efc7ce8d9..94a6124f974060 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -533,7 +533,7 @@ static int ptdump_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ptdump_fops = {
 	.open		= ptdump_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index de6e05ef871c1b..2306235b72a33a 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -407,7 +407,7 @@ static int ptdump_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ptdump_fops = {
 	.open		= ptdump_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/powerpc/mm/ptdump/segment_regs.c b/arch/powerpc/mm/ptdump/segment_regs.c
index dde2fe8de4b2a8..8b15bad5ab2737 100644
--- a/arch/powerpc/mm/ptdump/segment_regs.c
+++ b/arch/powerpc/mm/ptdump/segment_regs.c
@@ -48,7 +48,7 @@ static int sr_open(struct inode *inode, struct file *file)
 
 static const struct file_operations sr_fops = {
 	.open		= sr_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 62d90a5e23d1ef..dd2a5af8285e59 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -1943,7 +1943,7 @@ static int spufs_caps_open(struct inode *inode, struct file *file)
 
 static const struct file_operations spufs_caps_fops = {
 	.open		= spufs_caps_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -2189,7 +2189,7 @@ static int spufs_tid_open(struct inode *inode, struct file *file)
 
 static const struct file_operations spufs_tid_fops = {
 	.open		= spufs_tid_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -2279,7 +2279,7 @@ static int spufs_stat_open(struct inode *inode, struct file *file)
 
 static const struct file_operations spufs_stat_fops = {
 	.open		= spufs_stat_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -2532,7 +2532,7 @@ static int spufs_ctx_open(struct inode *inode, struct file *file)
 
 static const struct file_operations spufs_ctx_fops = {
 	.open           = spufs_ctx_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = single_release,
 };
diff --git a/arch/powerpc/platforms/pseries/hvCall_inst.c b/arch/powerpc/platforms/pseries/hvCall_inst.c
index c40c62ec432e27..5bee57a0a975b5 100644
--- a/arch/powerpc/platforms/pseries/hvCall_inst.c
+++ b/arch/powerpc/platforms/pseries/hvCall_inst.c
@@ -91,7 +91,7 @@ static int hcall_inst_seq_open(struct inode *inode, struct file *file)
 
 static const struct file_operations hcall_inst_seq_fops = {
 	.open = hcall_inst_seq_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index ccba63aaeb470b..83ed3df5f7ebdb 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -111,7 +111,7 @@ static int show_diag_stat_open(struct inode *inode, struct file *file)
 
 static const struct file_operations show_diag_stat_fops = {
 	.open		= show_diag_stat_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
diff --git a/arch/s390/mm/dump_pagetables.c b/arch/s390/mm/dump_pagetables.c
index c2ac9b8ae61206..9adb10a0508e30 100644
--- a/arch/s390/mm/dump_pagetables.c
+++ b/arch/s390/mm/dump_pagetables.c
@@ -268,7 +268,7 @@ static int ptdump_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations ptdump_fops = {
 	.open		= ptdump_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
index 3408c0df3ebf11..e86fbaa4e331cd 100644
--- a/arch/s390/pci/pci_debug.c
+++ b/arch/s390/pci/pci_debug.c
@@ -163,7 +163,7 @@ static int pci_perf_seq_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations debugfs_pci_perf_fops = {
 	.open	 = pci_perf_seq_open,
-	.read	 = seq_read,
+	.read_iter	 = seq_read_iter,
 	.write	 = pci_perf_seq_write,
 	.llseek  = seq_lseek,
 	.release = single_release,
diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index 4c1ca197e9c5f2..065519ba6c902f 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -56,7 +56,7 @@ static int asids_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations asids_debugfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= asids_debugfs_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index 17d78079449715..114085cd560961 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -102,7 +102,7 @@ static int cache_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations cache_debugfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= cache_debugfs_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index b20aba6e1b37c3..1944c412f37cfb 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -854,7 +854,7 @@ static int pmb_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations pmb_debugfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= pmb_debugfs_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/sh/mm/tlb-debugfs.c b/arch/sh/mm/tlb-debugfs.c
index 11c6148283f3c7..ecd1c639f42d0b 100644
--- a/arch/sh/mm/tlb-debugfs.c
+++ b/arch/sh/mm/tlb-debugfs.c
@@ -142,7 +142,7 @@ static int tlb_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations tlb_debugfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= tlb_debugfs_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index e1da619add1921..19825b0042c664 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -397,7 +397,7 @@ static ssize_t severities_coverage_write(struct file *file,
 static const struct file_operations severities_coverage_fops = {
 	.open		= severities_coverage_open,
 	.release	= seq_release,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= severities_coverage_write,
 	.llseek		= seq_lseek,
 };
diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
index 8f665c352bf0d3..0f915e25052ddf 100644
--- a/arch/x86/mm/pat/memtype.c
+++ b/arch/x86/mm/pat/memtype.c
@@ -1200,7 +1200,7 @@ static int memtype_seq_open(struct inode *inode, struct file *file)
 
 static const struct file_operations memtype_fops = {
 	.open    = memtype_seq_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 77e04304a2a71d..95b12dd5bf0e08 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -173,7 +173,7 @@ static int cpastats_open(struct inode *inode, struct file *file)
 
 static const struct file_operations cpastats_fops = {
 	.open		= cpastats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 0acba2c712ab84..4cf680e2e30b77 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -806,7 +806,7 @@ static int p2m_dump_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations p2m_dump_fops = {
 	.open		= p2m_dump_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 15df3a36e9fa43..824a11828c7d35 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -770,7 +770,7 @@ static int blk_mq_debugfs_release(struct inode *inode, struct file *file)
 
 static const struct file_operations blk_mq_debugfs_fops = {
 	.open		= blk_mq_debugfs_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= blk_mq_debugfs_write,
 	.llseek		= seq_lseek,
 	.release	= blk_mq_debugfs_release,
diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 92073ac68473c5..6742b20ff3fc98 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -1172,7 +1172,7 @@ static int wakeup_sources_stats_open(struct inode *inode, struct file *file)
 static const struct file_operations wakeup_sources_stats_fops = {
 	.owner = THIS_MODULE,
 	.open = wakeup_sources_stats_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index 5ca7216e9e01f3..57905a4959a829 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -188,7 +188,7 @@ static const struct attribute_group *aoe_attr_groups[] = {
 
 static const struct file_operations aoe_debugfs_fops = {
 	.open = aoe_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/block/drbd/drbd_debugfs.c b/drivers/block/drbd/drbd_debugfs.c
index b3b9cd5628fdf7..be08bb0d8ed5f8 100644
--- a/drivers/block/drbd/drbd_debugfs.c
+++ b/drivers/block/drbd/drbd_debugfs.c
@@ -457,7 +457,7 @@ static int in_flight_summary_release(struct inode *inode, struct file *file)
 static const struct file_operations in_flight_summary_fops = {
 	.owner		= THIS_MODULE,
 	.open		= in_flight_summary_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= in_flight_summary_release,
 };
@@ -565,7 +565,7 @@ static int callback_history_release(struct inode *inode, struct file *file)
 static const struct file_operations connection_callback_history_fops = {
 	.owner		= THIS_MODULE,
 	.open		= callback_history_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= callback_history_release,
 };
@@ -612,7 +612,7 @@ static int connection_oldest_requests_release(struct inode *inode, struct file *
 static const struct file_operations connection_oldest_requests_fops = {
 	.owner		= THIS_MODULE,
 	.open		= connection_oldest_requests_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= connection_oldest_requests_release,
 };
@@ -757,7 +757,7 @@ static int device_ ## name ## _release(struct inode *inode, struct file *file)	\
 static const struct file_operations device_ ## name ## _fops = {		\
 	.owner		= THIS_MODULE,						\
 	.open		= device_ ## name ## _open,				\
-	.read		= seq_read,						\
+	.read_iter		= seq_read_iter,						\
 	.llseek		= seq_lseek,						\
 	.release	= device_ ## name ## _release,				\
 };
@@ -859,7 +859,7 @@ static const struct file_operations drbd_version_fops = {
 	.owner = THIS_MODULE,
 	.open = drbd_version_open,
 	.llseek = seq_lseek,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.release = single_release,
 };
 
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 43cff01a5a675d..291adae3eddac9 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1539,7 +1539,7 @@ static int nbd_dbg_tasks_open(struct inode *inode, struct file *file)
 
 static const struct file_operations nbd_dbg_tasks_ops = {
 	.open = nbd_dbg_tasks_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -1574,7 +1574,7 @@ static int nbd_dbg_flags_open(struct inode *inode, struct file *file)
 
 static const struct file_operations nbd_dbg_flags_ops = {
 	.open = nbd_dbg_flags_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 27a33adc41e487..50c6d6eacb5907 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -464,7 +464,7 @@ static int pkt_debugfs_fops_open(struct inode *inode, struct file *file)
 
 static const struct file_operations debug_fops = {
 	.open		= pkt_debugfs_fops_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 	.owner		= THIS_MODULE,
diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index 10f6368117d814..1adfd0f273b4e0 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -209,7 +209,7 @@ static const struct file_operations debugfs_cram_fops = {
 static const struct file_operations debugfs_stats_fops = {
 	.owner		= THIS_MODULE,
 	.open		= rsxx_attr_stats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -217,7 +217,7 @@ static const struct file_operations debugfs_stats_fops = {
 static const struct file_operations debugfs_pci_regs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= rsxx_attr_pci_regs_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/bus/mvebu-mbus.c b/drivers/bus/mvebu-mbus.c
index 5b2a11a88951b5..e76c866cda6a4d 100644
--- a/drivers/bus/mvebu-mbus.c
+++ b/drivers/bus/mvebu-mbus.c
@@ -477,7 +477,7 @@ static int mvebu_sdram_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations mvebu_sdram_debug_fops = {
 	.open = mvebu_sdram_debug_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -527,7 +527,7 @@ static int mvebu_devs_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations mvebu_devs_debug_fops = {
 	.open = mvebu_devs_debug_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 7460f230bae4c6..5a738a7efe9aa8 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -66,7 +66,7 @@ static int tpm_bios_measurements_release(struct inode *inode,
 static const struct file_operations tpm_bios_measurements_ops = {
 	.owner = THIS_MODULE,
 	.open = tpm_bios_measurements_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = tpm_bios_measurements_release,
 };
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index b957061424a1f7..52c7785c0db11c 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -310,7 +310,7 @@ static int sun8i_ce_dbgfs_open(struct inode *inode, struct file *file)
 static const struct file_operations sun8i_ce_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = sun8i_ce_dbgfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 5d9d0fedcb0689..fde5364695272e 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -294,7 +294,7 @@ static int sun8i_ss_dbgfs_open(struct inode *inode, struct file *file)
 static const struct file_operations sun8i_ss_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = sun8i_ss_dbgfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index 411857fad8ba60..112be244136908 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -125,7 +125,7 @@ static int meson_dbgfs_open(struct inode *inode, struct file *file)
 static const struct file_operations meson_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = meson_dbgfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/crypto/caam/dpseci-debugfs.c b/drivers/crypto/caam/dpseci-debugfs.c
index c5bfc923abd811..aa10841b6bc5e9 100644
--- a/drivers/crypto/caam/dpseci-debugfs.c
+++ b/drivers/crypto/caam/dpseci-debugfs.c
@@ -60,7 +60,7 @@ static int dpseci_dbg_fqs_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dpseci_dbg_fq_ops = {
 	.open = dpseci_dbg_fqs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/crypto/cavium/zip/zip_main.c b/drivers/crypto/cavium/zip/zip_main.c
index 194624b4855bd2..451e97fd893111 100644
--- a/drivers/crypto/cavium/zip/zip_main.c
+++ b/drivers/crypto/cavium/zip/zip_main.c
@@ -592,7 +592,7 @@ static int zip_stats_open(struct inode *inode, struct file *file)
 static const struct file_operations zip_stats_fops = {
 	.owner = THIS_MODULE,
 	.open  = zip_stats_open,
-	.read  = seq_read,
+	.read_iter  = seq_read_iter,
 	.release = single_release,
 };
 
@@ -604,7 +604,7 @@ static int zip_clear_open(struct inode *inode, struct file *file)
 static const struct file_operations zip_clear_fops = {
 	.owner = THIS_MODULE,
 	.open  = zip_clear_open,
-	.read  = seq_read,
+	.read_iter  = seq_read_iter,
 	.release = single_release,
 };
 
@@ -616,7 +616,7 @@ static int zip_regs_open(struct inode *inode, struct file *file)
 static const struct file_operations zip_regs_fops = {
 	.owner = THIS_MODULE,
 	.open  = zip_regs_open,
-	.read  = seq_read,
+	.read_iter  = seq_read_iter,
 	.release = single_release,
 };
 
diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index 9bb263cec6c306..a5c3e21e0fe6a1 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -1054,7 +1054,7 @@ static int qm_regs_open(struct inode *inode, struct file *file)
 static const struct file_operations qm_regs_fops = {
 	.owner = THIS_MODULE,
 	.open = qm_regs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.release = single_release,
 };
 
diff --git a/drivers/crypto/qat/qat_common/adf_cfg.c b/drivers/crypto/qat/qat_common/adf_cfg.c
index 5c7fdb0fc53d94..4b77c6f05b3ee0 100644
--- a/drivers/crypto/qat/qat_common/adf_cfg.c
+++ b/drivers/crypto/qat/qat_common/adf_cfg.c
@@ -110,7 +110,7 @@ static int qat_dev_cfg_open(struct inode *inode, struct file *file)
 
 static const struct file_operations qat_dev_cfg_fops = {
 	.open = qat_dev_cfg_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release
 };
diff --git a/drivers/crypto/qat/qat_common/adf_transport_debug.c b/drivers/crypto/qat/qat_common/adf_transport_debug.c
index e794e9d97b2cbb..6133a869aeb1db 100644
--- a/drivers/crypto/qat/qat_common/adf_transport_debug.c
+++ b/drivers/crypto/qat/qat_common/adf_transport_debug.c
@@ -142,7 +142,7 @@ static int adf_ring_open(struct inode *inode, struct file *file)
 
 static const struct file_operations adf_ring_debug_fops = {
 	.open = adf_ring_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release
 };
@@ -253,7 +253,7 @@ static int adf_bank_open(struct inode *inode, struct file *file)
 
 static const struct file_operations adf_bank_debug_fops = {
 	.open = adf_bank_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release
 };
diff --git a/drivers/firmware/tegra/bpmp-debugfs.c b/drivers/firmware/tegra/bpmp-debugfs.c
index 636b40d4364dff..3f0a89ce131acb 100644
--- a/drivers/firmware/tegra/bpmp-debugfs.c
+++ b/drivers/firmware/tegra/bpmp-debugfs.c
@@ -292,7 +292,7 @@ static ssize_t debugfs_store(struct file *file, const char __user *buf,
 
 static const struct file_operations debugfs_fops = {
 	.open		= debugfs_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.write		= debugfs_store,
 	.release	= single_release,
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4fa075d49fbc9d..0ca1acff0e37d6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -5529,7 +5529,7 @@ static int gpiolib_open(struct inode *inode, struct file *file)
 static const struct file_operations gpiolib_operations = {
 	.owner		= THIS_MODULE,
 	.open		= gpiolib_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 511712c2e382dd..d2b33ea38b7602 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -69,7 +69,7 @@ static ssize_t kfd_debugfs_hang_hws_write(struct file *file,
 static const struct file_operations kfd_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = kfd_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -77,7 +77,7 @@ static const struct file_operations kfd_debugfs_fops = {
 static const struct file_operations kfd_debugfs_hang_hws_fops = {
 	.owner = THIS_MODULE,
 	.open = kfd_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = kfd_debugfs_hang_hws_write,
 	.llseek = seq_lseek,
 	.release = single_release,
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 1d767473ba8a06..0246b2e94d8cbd 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -49,7 +49,7 @@ static int komeda_register_open(struct inode *inode, struct file *filp)
 static const struct file_operations komeda_register_fops = {
 	.owner		= THIS_MODULE,
 	.open		= komeda_register_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index def8c9ffafcaf5..029a26def9f770 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -542,7 +542,7 @@ static ssize_t malidp_debugfs_write(struct file *file, const char __user *ubuf,
 static const struct file_operations malidp_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = malidp_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = malidp_debugfs_write,
 	.llseek = seq_lseek,
 	.release = single_release,
diff --git a/drivers/gpu/drm/armada/armada_debugfs.c b/drivers/gpu/drm/armada/armada_debugfs.c
index c6fc2f1d58e99f..dd2b2892a2901c 100644
--- a/drivers/gpu/drm/armada/armada_debugfs.c
+++ b/drivers/gpu/drm/armada/armada_debugfs.c
@@ -85,7 +85,7 @@ static int armada_debugfs_crtc_reg_write(struct file *file,
 static const struct file_operations armada_debugfs_crtc_reg_fops = {
 	.owner = THIS_MODULE,
 	.open = armada_debugfs_crtc_reg_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = armada_debugfs_crtc_reg_write,
 	.llseek = seq_lseek,
 	.release = single_release,
diff --git a/drivers/gpu/drm/drm_debugfs.c b/drivers/gpu/drm/drm_debugfs.c
index 2bea221307037a..a0a1a598826fcd 100644
--- a/drivers/gpu/drm/drm_debugfs.c
+++ b/drivers/gpu/drm/drm_debugfs.c
@@ -154,7 +154,7 @@ static int drm_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations drm_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -379,7 +379,7 @@ static ssize_t edid_write(struct file *file, const char __user *ubuf,
 static const struct file_operations drm_edid_fops = {
 	.owner = THIS_MODULE,
 	.open = edid_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = edid_write
@@ -389,7 +389,7 @@ static const struct file_operations drm_edid_fops = {
 static const struct file_operations drm_connector_fops = {
 	.owner = THIS_MODULE,
 	.open = connector_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = connector_write
diff --git a/drivers/gpu/drm/drm_debugfs_crc.c b/drivers/gpu/drm/drm_debugfs_crc.c
index 5d67a41f7c3a8f..e78fa4411dd186 100644
--- a/drivers/gpu/drm/drm_debugfs_crc.c
+++ b/drivers/gpu/drm/drm_debugfs_crc.c
@@ -167,7 +167,7 @@ static ssize_t crc_control_write(struct file *file, const char __user *ubuf,
 static const struct file_operations drm_crtc_crc_control_fops = {
 	.owner = THIS_MODULE,
 	.open = crc_control_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = crc_control_write
diff --git a/drivers/gpu/drm/drm_mipi_dbi.c b/drivers/gpu/drm/drm_mipi_dbi.c
index bb27c82757f17c..d0298376d28a19 100644
--- a/drivers/gpu/drm/drm_mipi_dbi.c
+++ b/drivers/gpu/drm/drm_mipi_dbi.c
@@ -1279,7 +1279,7 @@ static int mipi_dbi_debugfs_command_open(struct inode *inode,
 static const struct file_operations mipi_dbi_debugfs_command_fops = {
 	.owner = THIS_MODULE,
 	.open = mipi_dbi_debugfs_command_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = mipi_dbi_debugfs_command_write,
diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs.c b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
index 70525623bcdf09..147448e6f75032 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs.c
@@ -1009,7 +1009,7 @@ static ssize_t i915_ipc_status_write(struct file *file, const char __user *ubuf,
 static const struct file_operations i915_ipc_status_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_ipc_status_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = i915_ipc_status_write
@@ -1326,7 +1326,7 @@ static int i915_displayport_test_active_open(struct inode *inode,
 static const struct file_operations i915_displayport_test_active_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_displayport_test_active_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = i915_displayport_test_active_write
@@ -1627,7 +1627,7 @@ static ssize_t cur_wm_latency_write(struct file *file, const char __user *ubuf,
 static const struct file_operations i915_pri_wm_latency_fops = {
 	.owner = THIS_MODULE,
 	.open = pri_wm_latency_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = pri_wm_latency_write
@@ -1636,7 +1636,7 @@ static const struct file_operations i915_pri_wm_latency_fops = {
 static const struct file_operations i915_spr_wm_latency_fops = {
 	.owner = THIS_MODULE,
 	.open = spr_wm_latency_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = spr_wm_latency_write
@@ -1645,7 +1645,7 @@ static const struct file_operations i915_spr_wm_latency_fops = {
 static const struct file_operations i915_cur_wm_latency_fops = {
 	.owner = THIS_MODULE,
 	.open = cur_wm_latency_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = cur_wm_latency_write
@@ -1728,7 +1728,7 @@ static int i915_hpd_storm_ctl_open(struct inode *inode, struct file *file)
 static const struct file_operations i915_hpd_storm_ctl_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_hpd_storm_ctl_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = i915_hpd_storm_ctl_write
@@ -1801,7 +1801,7 @@ static ssize_t i915_hpd_short_storm_ctl_write(struct file *file,
 static const struct file_operations i915_hpd_short_storm_ctl_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_hpd_short_storm_ctl_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = i915_hpd_short_storm_ctl_write,
@@ -2179,7 +2179,7 @@ static int i915_dsc_fec_support_open(struct inode *inode,
 static const struct file_operations i915_dsc_fec_support_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_dsc_fec_support_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = i915_dsc_fec_support_write
diff --git a/drivers/gpu/drm/i915/gt/debugfs_gt.h b/drivers/gpu/drm/i915/gt/debugfs_gt.h
index f77540f727e94d..d4cebf4c9f5b4e 100644
--- a/drivers/gpu/drm/i915/gt/debugfs_gt.h
+++ b/drivers/gpu/drm/i915/gt/debugfs_gt.h
@@ -18,7 +18,7 @@ struct intel_gt;
 static const struct file_operations __name ## _fops = {			\
 	.owner = THIS_MODULE,						\
 	.open = __name ## _open,					\
-	.read = seq_read,						\
+	.read_iter = seq_read_iter,						\
 	.llseek = seq_lseek,						\
 	.release = single_release,					\
 }
diff --git a/drivers/gpu/drm/i915/i915_debugfs_params.c b/drivers/gpu/drm/i915/i915_debugfs_params.c
index 62b2c5f0495d79..58ef14b028ead5 100644
--- a/drivers/gpu/drm/i915/i915_debugfs_params.c
+++ b/drivers/gpu/drm/i915/i915_debugfs_params.c
@@ -48,7 +48,7 @@ static ssize_t i915_param_int_write(struct file *file,
 static const struct file_operations i915_param_int_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_param_int_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = i915_param_int_write,
 	.llseek = default_llseek,
 	.release = single_release,
@@ -57,7 +57,7 @@ static const struct file_operations i915_param_int_fops = {
 static const struct file_operations i915_param_int_fops_ro = {
 	.owner = THIS_MODULE,
 	.open = i915_param_int_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -101,7 +101,7 @@ static ssize_t i915_param_uint_write(struct file *file,
 static const struct file_operations i915_param_uint_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_param_uint_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = i915_param_uint_write,
 	.llseek = default_llseek,
 	.release = single_release,
@@ -110,7 +110,7 @@ static const struct file_operations i915_param_uint_fops = {
 static const struct file_operations i915_param_uint_fops_ro = {
 	.owner = THIS_MODULE,
 	.open = i915_param_uint_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
@@ -160,7 +160,7 @@ static ssize_t i915_param_charp_write(struct file *file,
 static const struct file_operations i915_param_charp_fops = {
 	.owner = THIS_MODULE,
 	.open = i915_param_charp_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = i915_param_charp_write,
 	.llseek = default_llseek,
 	.release = single_release,
@@ -169,7 +169,7 @@ static const struct file_operations i915_param_charp_fops = {
 static const struct file_operations i915_param_charp_fops_ro = {
 	.owner = THIS_MODULE,
 	.open = i915_param_charp_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = default_llseek,
 	.release = single_release,
 };
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c
index f1bc6a1af7a714..99be6d8d4d1abb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_core_irq.c
@@ -297,7 +297,7 @@ static const struct file_operations __prefix ## _fops = {		\
 	.owner = THIS_MODULE,						\
 	.open = __prefix ## _open,					\
 	.release = single_release,					\
-	.read = seq_read,						\
+	.read_iter = seq_read_iter,						\
 	.llseek = seq_lseek,						\
 }
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
index e15b42a780e041..2fa8d07979eb72 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c
@@ -1256,7 +1256,7 @@ static const struct file_operations __prefix ## _fops = {		\
 	.owner = THIS_MODULE,						\
 	.open = __prefix ## _open,					\
 	.release = single_release,					\
-	.read = seq_read,						\
+	.read_iter = seq_read_iter,						\
 	.llseek = seq_lseek,						\
 }
 
@@ -1283,7 +1283,7 @@ static int _dpu_crtc_init_debugfs(struct drm_crtc *crtc)
 
 	static const struct file_operations debugfs_status_fops = {
 		.open =		_dpu_debugfs_status_open,
-		.read =		seq_read,
+		.read_iter =		seq_read_iter,
 		.llseek =	seq_lseek,
 		.release =	single_release,
 	};
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 63976dcd2ac87f..64c37ac4b550a5 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -1881,7 +1881,7 @@ static int _dpu_encoder_init_debugfs(struct drm_encoder *drm_enc)
 
 	static const struct file_operations debugfs_status_fops = {
 		.open =		_dpu_encoder_debugfs_status_open,
-		.read =		seq_read,
+		.read_iter =		seq_read_iter,
 		.llseek =	seq_lseek,
 		.release =	single_release,
 	};
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index b8615d4fe8a3f7..a5ab16df27c347 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -107,7 +107,7 @@ static const struct file_operations __prefix ## _fops = {		\
 	.owner = THIS_MODULE,						\
 	.open = __prefix ## _open,					\
 	.release = single_release,					\
-	.read = seq_read,						\
+	.read_iter = seq_read_iter,						\
 	.llseek = seq_lseek,						\
 }
 
@@ -176,7 +176,7 @@ static int dpu_debugfs_open_regset32(struct inode *inode,
 
 static const struct file_operations dpu_fops_regset32 = {
 	.open =		dpu_debugfs_open_regset32,
-	.read =		seq_read,
+	.read_iter =		seq_read_iter,
 	.llseek =	seq_lseek,
 	.release =	single_release,
 };
diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index ee2e270f464c1d..7952d56f2c0fe8 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -103,7 +103,7 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 static const struct file_operations msm_gpu_fops = {
 	.owner = THIS_MODULE,
 	.open = msm_gpu_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = msm_gpu_release,
 };
diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 63b5c8cf9ae430..838394c6fd3701 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -203,7 +203,7 @@ nouveau_debugfs_pstate_open(struct inode *inode, struct file *file)
 static const struct file_operations nouveau_pstate_fops = {
 	.owner = THIS_MODULE,
 	.open = nouveau_debugfs_pstate_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = nouveau_debugfs_pstate_set,
 };
 
diff --git a/drivers/gpu/drm/omapdrm/dss/dss.c b/drivers/gpu/drm/omapdrm/dss/dss.c
index 4d5739fa4a5d81..4f19dde961a475 100644
--- a/drivers/gpu/drm/omapdrm/dss/dss.c
+++ b/drivers/gpu/drm/omapdrm/dss/dss.c
@@ -912,7 +912,7 @@ static int dss_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dss_debug_fops = {
 	.open		= dss_debug_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/gpu/host1x/debug.c b/drivers/gpu/host1x/debug.c
index c0392672a84214..545fc0afb45a6b 100644
--- a/drivers/gpu/host1x/debug.c
+++ b/drivers/gpu/host1x/debug.c
@@ -141,7 +141,7 @@ static int host1x_debug_open_all(struct inode *inode, struct file *file)
 
 static const struct file_operations host1x_debug_all_fops = {
 	.open = host1x_debug_open_all,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -153,7 +153,7 @@ static int host1x_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations host1x_debug_fops = {
 	.open = host1x_debug_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 087304b1a5d71b..1be2ebabbfdbdc 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -900,7 +900,7 @@ static const struct file_operations vga_switcheroo_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = vga_switcheroo_debugfs_open,
 	.write = vga_switcheroo_debugfs_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/hid/hid-picolcd_debugfs.c b/drivers/hid/hid-picolcd_debugfs.c
index d01176da889627..36a58f60094d62 100644
--- a/drivers/hid/hid-picolcd_debugfs.c
+++ b/drivers/hid/hid-picolcd_debugfs.c
@@ -60,7 +60,7 @@ static ssize_t picolcd_debug_reset_write(struct file *f, const char __user *user
 static const struct file_operations picolcd_debug_reset_fops = {
 	.owner    = THIS_MODULE,
 	.open     = picolcd_debug_reset_open,
-	.read     = seq_read,
+	.read_iter     = seq_read_iter,
 	.llseek   = seq_lseek,
 	.write    = picolcd_debug_reset_write,
 	.release  = single_release,
diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
index a99dcca2e09938..51bf8fca0c1dcd 100644
--- a/drivers/hid/hid-wiimote-debug.c
+++ b/drivers/hid/hid-wiimote-debug.c
@@ -163,7 +163,7 @@ static ssize_t wiidebug_drm_write(struct file *f, const char __user *u,
 static const struct file_operations wiidebug_drm_fops = {
 	.owner = THIS_MODULE,
 	.open = wiidebug_drm_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.write = wiidebug_drm_write,
 	.release = single_release,
diff --git a/drivers/ide/ide-proc.c b/drivers/ide/ide-proc.c
index 15c17f3781ee91..8ea282a3a19f0d 100644
--- a/drivers/ide/ide-proc.c
+++ b/drivers/ide/ide-proc.c
@@ -457,7 +457,7 @@ static int ide_media_proc_open(struct inode *inode, struct file *file)
 static const struct file_operations ide_media_proc_fops = {
 	.owner		= THIS_MODULE,
 	.open		= ide_media_proc_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/infiniband/hw/cxgb4/device.c b/drivers/infiniband/hw/cxgb4/device.c
index 541dbcf22d0ebf..b1d3bdced23bcc 100644
--- a/drivers/infiniband/hw/cxgb4/device.c
+++ b/drivers/infiniband/hw/cxgb4/device.c
@@ -191,7 +191,7 @@ static const struct file_operations wr_log_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = wr_log_open,
 	.release = single_release,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.write   = wr_log_clear,
 };
@@ -550,7 +550,7 @@ static const struct file_operations stats_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = stats_open,
 	.release = single_release,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.write   = stats_clear,
 };
diff --git a/drivers/infiniband/hw/qib/qib_debugfs.c b/drivers/infiniband/hw/qib/qib_debugfs.c
index caeb77d07a5859..bc166896b93641 100644
--- a/drivers/infiniband/hw/qib/qib_debugfs.c
+++ b/drivers/infiniband/hw/qib/qib_debugfs.c
@@ -61,7 +61,7 @@ static int _##name##_open(struct inode *inode, struct file *s) \
 static const struct file_operations _##name##_file_ops = { \
 	.owner   = THIS_MODULE, \
 	.open    = _##name##_open, \
-	.read    = seq_read, \
+	.read_iter    = seq_read_iter, \
 	.llseek  = seq_lseek, \
 	.release = seq_release \
 };
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_fs.c b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
index 64c19f6fa93167..06c00dff1f51d0 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_fs.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_fs.c
@@ -149,7 +149,7 @@ static int ipoib_mcg_open(struct inode *inode, struct file *file)
 static const struct file_operations ipoib_mcg_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ipoib_mcg_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -254,7 +254,7 @@ static int ipoib_path_open(struct inode *inode, struct file *file)
 static const struct file_operations ipoib_path_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ipoib_path_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
diff --git a/drivers/md/bcache/closure.c b/drivers/md/bcache/closure.c
index 0164a1fe94a9b5..99222aa5d6e672 100644
--- a/drivers/md/bcache/closure.c
+++ b/drivers/md/bcache/closure.c
@@ -196,7 +196,7 @@ static int debug_seq_open(struct inode *inode, struct file *file)
 static const struct file_operations debug_ops = {
 	.owner		= THIS_MODULE,
 	.open		= debug_seq_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.release	= single_release
 };
 
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index 0c52e1bb391050..87e856788e0bf2 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -226,7 +226,7 @@ static int cec_error_inj_open(struct inode *inode, struct file *file)
 static const struct file_operations cec_error_inj_fops = {
 	.open = cec_error_inj_open,
 	.write = cec_error_inj_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 126d085be9a7fd..50293396658cb5 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -1155,7 +1155,7 @@ static int saa7164_open(struct inode *inode, struct file *file)
 static const struct file_operations saa7164_operations = {
 	.owner          = THIS_MODULE,
 	.open           = saa7164_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
 };
diff --git a/drivers/memory/emif.c b/drivers/memory/emif.c
index 9d9127bf2a5906..58a82eea585047 100644
--- a/drivers/memory/emif.c
+++ b/drivers/memory/emif.c
@@ -138,7 +138,7 @@ static int emif_regdump_open(struct inode *inode, struct file *file)
 
 static const struct file_operations emif_regdump_fops = {
 	.open			= emif_regdump_open,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.release		= single_release,
 };
 
@@ -157,7 +157,7 @@ static int emif_mr4_open(struct inode *inode, struct file *file)
 
 static const struct file_operations emif_mr4_fops = {
 	.open			= emif_mr4_open,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.release		= single_release,
 };
 
diff --git a/drivers/memory/tegra/tegra124-emc.c b/drivers/memory/tegra/tegra124-emc.c
index 33b8216bac30c7..794431b2102c9c 100644
--- a/drivers/memory/tegra/tegra124-emc.c
+++ b/drivers/memory/tegra/tegra124-emc.c
@@ -1068,7 +1068,7 @@ static int tegra_emc_debug_available_rates_open(struct inode *inode,
 
 static const struct file_operations tegra_emc_debug_available_rates_fops = {
 	.open = tegra_emc_debug_available_rates_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 97f26bc77ad41f..1445ab51af6a91 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -94,7 +94,7 @@ static int tegra186_emc_debug_available_rates_open(struct inode *inode,
 
 static const struct file_operations tegra186_emc_debug_available_rates_fops = {
 	.open = tegra186_emc_debug_available_rates_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index b16715e9515d03..c63b14f7b356cd 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -546,7 +546,7 @@ static int tegra_emc_debug_available_rates_open(struct inode *inode,
 
 static const struct file_operations tegra_emc_debug_available_rates_fops = {
 	.open = tegra_emc_debug_available_rates_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index b42bdb667e8530..2ed027408af204 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1174,7 +1174,7 @@ static int tegra_emc_debug_available_rates_open(struct inode *inode,
 
 static const struct file_operations tegra_emc_debug_available_rates_fops = {
 	.open = tegra_emc_debug_available_rates_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 57723f116bb585..0f461180d29f74 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -473,7 +473,7 @@ static int ab3100_registers_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ab3100_registers_fops = {
 	.open = ab3100_registers_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
diff --git a/drivers/mfd/ab3100-otp.c b/drivers/mfd/ab3100-otp.c
index c4751fb9bc224b..3667fa4c9fedcc 100644
--- a/drivers/mfd/ab3100-otp.c
+++ b/drivers/mfd/ab3100-otp.c
@@ -117,7 +117,7 @@ static int ab3100_otp_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ab3100_otp_operations = {
 	.open		= ab3100_otp_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 1a9a3414d4fa85..fcdb618fe2db03 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -1376,7 +1376,7 @@ static int ab8500_all_banks_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ab8500_all_banks_fops = {
 	.open = ab8500_all_banks_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -1959,7 +1959,7 @@ static ssize_t ab8500_unsubscribe_write(struct file *file,
 static const struct file_operations ab8500_bank_fops = {
 	.open = ab8500_bank_open,
 	.write = ab8500_bank_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -1968,7 +1968,7 @@ static const struct file_operations ab8500_bank_fops = {
 static const struct file_operations ab8500_address_fops = {
 	.open = ab8500_address_open,
 	.write = ab8500_address_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -1977,7 +1977,7 @@ static const struct file_operations ab8500_address_fops = {
 static const struct file_operations ab8500_val_fops = {
 	.open = ab8500_val_open,
 	.write = ab8500_val_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -1986,7 +1986,7 @@ static const struct file_operations ab8500_val_fops = {
 static const struct file_operations ab8500_subscribe_fops = {
 	.open = ab8500_subscribe_unsubscribe_open,
 	.write = ab8500_subscribe_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -1995,7 +1995,7 @@ static const struct file_operations ab8500_subscribe_fops = {
 static const struct file_operations ab8500_unsubscribe_fops = {
 	.open = ab8500_subscribe_unsubscribe_open,
 	.write = ab8500_unsubscribe_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -2004,7 +2004,7 @@ static const struct file_operations ab8500_unsubscribe_fops = {
 static const struct file_operations ab8500_hwreg_fops = {
 	.open = ab8500_hwreg_open,
 	.write = ab8500_hwreg_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
diff --git a/drivers/mfd/tps65010.c b/drivers/mfd/tps65010.c
index 65fcc58c02da8b..19ed0a37238978 100644
--- a/drivers/mfd/tps65010.c
+++ b/drivers/mfd/tps65010.c
@@ -290,7 +290,7 @@ static int dbg_tps_open(struct inode *inode, struct file *file)
 
 static const struct file_operations debug_fops = {
 	.open		= dbg_tps_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 3c8dcdfba20cf1..01028a850c841b 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -1151,7 +1151,7 @@ static ssize_t hl_debugfs_write(struct file *file, const char __user *buf,
 static const struct file_operations hl_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = hl_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = hl_debugfs_write,
 	.llseek = seq_lseek,
 	.release = single_release,
diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index c21b3cb71775eb..41bddd115ee97e 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3148,7 +3148,7 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 
 static const struct file_operations mmc_test_fops_test = {
 	.open		= mtf_test_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= mtf_test_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 76d832a88e0c4f..bb7bb1fcbe55ce 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -351,7 +351,7 @@ static int mtd_partid_debugfs_open(struct inode *inode, struct file *file)
 
 static const struct file_operations mtd_partid_debug_fops = {
 	.open           = mtd_partid_debugfs_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = single_release,
 };
@@ -372,7 +372,7 @@ static int mtd_partname_debugfs_open(struct inode *inode, struct file *file)
 
 static const struct file_operations mtd_partname_debug_fops = {
 	.open           = mtd_partname_debugfs_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = single_release,
 };
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index ac2bdba8bb1a3b..4f13e7b6942469 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -488,7 +488,7 @@ static int eraseblk_count_release(struct inode *inode, struct file *f)
 static const struct file_operations eraseblk_count_fops = {
 	.owner = THIS_MODULE,
 	.open = eraseblk_count_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = eraseblk_count_release,
 };
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
index 828499256004b3..f8115e3d638b2d 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_debugfs.c
@@ -229,7 +229,7 @@ static int cim_la_open(struct inode *inode, struct file *file)
 static const struct file_operations cim_la_fops = {
 	.owner   = THIS_MODULE,
 	.open    = cim_la_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -272,7 +272,7 @@ static int cim_pif_la_open(struct inode *inode, struct file *file)
 static const struct file_operations cim_pif_la_fops = {
 	.owner   = THIS_MODULE,
 	.open    = cim_pif_la_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -318,7 +318,7 @@ static int cim_ma_la_open(struct inode *inode, struct file *file)
 static const struct file_operations cim_ma_la_fops = {
 	.owner   = THIS_MODULE,
 	.open    = cim_ma_la_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -411,7 +411,7 @@ static int cim_ibq_open(struct inode *inode, struct file *file)
 static const struct file_operations cim_ibq_fops = {
 	.owner   = THIS_MODULE,
 	.open    = cim_ibq_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -440,7 +440,7 @@ static int cim_obq_open(struct inode *inode, struct file *file)
 static const struct file_operations cim_obq_fops = {
 	.owner   = THIS_MODULE,
 	.open    = cim_obq_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -686,7 +686,7 @@ static ssize_t tp_la_write(struct file *file, const char __user *buf,
 static const struct file_operations tp_la_fops = {
 	.owner   = THIS_MODULE,
 	.open    = tp_la_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private,
 	.write   = tp_la_write
@@ -722,7 +722,7 @@ static int ulprx_la_open(struct inode *inode, struct file *file)
 static const struct file_operations ulprx_la_fops = {
 	.owner   = THIS_MODULE,
 	.open    = ulprx_la_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -812,7 +812,7 @@ static ssize_t pm_stats_clear(struct file *file, const char __user *buf,
 static const struct file_operations pm_stats_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = pm_stats_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = single_release,
 	.write   = pm_stats_clear
@@ -1136,7 +1136,7 @@ static int devlog_open(struct inode *inode, struct file *file)
 static const struct file_operations devlog_fops = {
 	.owner   = THIS_MODULE,
 	.open    = devlog_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -1234,7 +1234,7 @@ static int mboxlog_open(struct inode *inode, struct file *file)
 static const struct file_operations mboxlog_fops = {
 	.owner   = THIS_MODULE,
 	.open    = mboxlog_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
@@ -1317,7 +1317,7 @@ static ssize_t mbox_write(struct file *file, const char __user *buf,
 static const struct file_operations mbox_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = mbox_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = single_release,
 	.write   = mbox_write
@@ -1610,7 +1610,7 @@ inval:				count = -EINVAL;
 static const struct file_operations mps_trc_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = mps_trc_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = single_release,
 	.write   = mps_trc_write
@@ -1930,7 +1930,7 @@ static int mps_tcam_open(struct inode *inode, struct file *file)
 static const struct file_operations mps_tcam_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = mps_tcam_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
@@ -2007,7 +2007,7 @@ static int rss_open(struct inode *inode, struct file *file)
 static const struct file_operations rss_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = rss_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -2226,7 +2226,7 @@ static ssize_t rss_key_write(struct file *file, const char __user *buf,
 static const struct file_operations rss_key_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = rss_key_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = single_release,
 	.write   = rss_key_write
@@ -2310,7 +2310,7 @@ static int rss_pf_config_open(struct inode *inode, struct file *file)
 static const struct file_operations rss_pf_config_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = rss_pf_config_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -2373,7 +2373,7 @@ static int rss_vf_config_open(struct inode *inode, struct file *file)
 static const struct file_operations rss_vf_config_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = rss_vf_config_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release_private
 };
@@ -2562,7 +2562,7 @@ static int dcb_info_open(struct inode *inode, struct file *file)
 static const struct file_operations dcb_info_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = dcb_info_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
@@ -3184,7 +3184,7 @@ static int sge_qinfo_open(struct inode *inode, struct file *file)
 static const struct file_operations sge_qinfo_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = sge_qinfo_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
diff --git a/drivers/net/ethernet/chelsio/cxgb4/l2t.c b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
index 72b37a66c7d889..a213270edfa7b6 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/l2t.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/l2t.c
@@ -759,7 +759,7 @@ static int l2t_seq_open(struct inode *inode, struct file *file)
 const struct file_operations t4_l2t_fops = {
 	.owner = THIS_MODULE,
 	.open = l2t_seq_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
diff --git a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
index cec865a97464d2..1352a03a4563d3 100644
--- a/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4vf/cxgb4vf_main.c
@@ -2040,7 +2040,7 @@ static int mboxlog_open(struct inode *inode, struct file *file)
 static const struct file_operations mboxlog_fops = {
 	.owner   = THIS_MODULE,
 	.open    = mboxlog_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
@@ -2193,7 +2193,7 @@ static int sge_qinfo_open(struct inode *inode, struct file *file)
 static const struct file_operations sge_qinfo_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = sge_qinfo_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
@@ -2339,7 +2339,7 @@ static int sge_qstats_open(struct inode *inode, struct file *file)
 static const struct file_operations sge_qstats_proc_fops = {
 	.owner   = THIS_MODULE,
 	.open    = sge_qstats_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
@@ -2437,7 +2437,7 @@ static int interfaces_open(struct inode *inode, struct file *file)
 static const struct file_operations interfaces_proc_fops = {
 	.owner   = THIS_MODULE,
 	.open    = interfaces_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c
index c453a23045c11c..bc99fe0aabf0cd 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-debugfs.c
@@ -56,7 +56,7 @@ static int dpaa2_dbg_cpu_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dpaa2_dbg_cpu_ops = {
 	.open = dpaa2_dbg_cpu_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -116,7 +116,7 @@ static int dpaa2_dbg_fqs_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dpaa2_dbg_fq_ops = {
 	.open = dpaa2_dbg_fqs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -161,7 +161,7 @@ static int dpaa2_dbg_ch_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dpaa2_dbg_ch_ops = {
 	.open = dpaa2_dbg_ch_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
index 1d27b2fb23af8f..6caf722a991b03 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_debugfs.c
@@ -134,7 +134,7 @@ static int fm10k_dbg_desc_open(struct inode *inode, struct file *filep)
 static const struct file_operations fm10k_dbg_desc_fops = {
 	.owner   = THIS_MODULE,
 	.open    = fm10k_dbg_desc_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 77adad4adb1bc2..f2b41fa0af602a 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -123,7 +123,7 @@ static int rvu_dbg_open_##name(struct inode *inode, struct file *file) \
 static const struct file_operations rvu_dbg_##name##_fops = { \
 	.owner		= THIS_MODULE, \
 	.open		= rvu_dbg_open_##name, \
-	.read		= seq_read, \
+	.read_iter		= seq_read_iter, \
 	.write		= rvu_dbg_##write_op, \
 	.llseek		= seq_lseek, \
 	.release	= single_release, \
diff --git a/drivers/net/wireless/ath/ath5k/debug.c b/drivers/net/wireless/ath/ath5k/debug.c
index 2eaba1ccab2082..c62d0b78437f28 100644
--- a/drivers/net/wireless/ath/ath5k/debug.c
+++ b/drivers/net/wireless/ath/ath5k/debug.c
@@ -182,7 +182,7 @@ static int open_file_registers(struct inode *inode, struct file *file)
 
 static const struct file_operations fops_registers = {
 	.open = open_file_registers,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 	.owner = THIS_MODULE,
diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 11d0c79e905626..4e0408f0cd4680 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -957,7 +957,7 @@ static int wil_pmcring_seq_open(struct inode *inode, struct file *file)
 static const struct file_operations fops_pmcring = {
 	.open		= wil_pmcring_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 };
 
@@ -1833,7 +1833,7 @@ static ssize_t wil_tx_latency_write(struct file *file, const char __user *buf,
 static const struct file_operations fops_tx_latency = {
 	.open		= wil_tx_latency_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= wil_tx_latency_write,
 	.llseek		= seq_lseek,
 };
@@ -1996,7 +1996,7 @@ static ssize_t wil_link_stats_write(struct file *file, const char __user *buf,
 static const struct file_operations fops_link_stats = {
 	.open		= wil_link_stats_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= wil_link_stats_write,
 	.llseek		= seq_lseek,
 };
@@ -2050,7 +2050,7 @@ wil_link_stats_global_write(struct file *file, const char __user *buf,
 static const struct file_operations fops_link_stats_global = {
 	.open		= wil_link_stats_global_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= wil_link_stats_global_write,
 	.llseek		= seq_lseek,
 };
@@ -2187,7 +2187,7 @@ static int wil_fw_capabilities_seq_open(struct inode *inode, struct file *file)
 static const struct file_operations fops_fw_capabilities = {
 	.open		= wil_fw_capabilities_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 };
 
@@ -2213,7 +2213,7 @@ static int wil_fw_version_seq_open(struct inode *inode, struct file *file)
 static const struct file_operations fops_fw_version = {
 	.open		= wil_fw_version_seq_open,
 	.release	= single_release,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 };
 
@@ -2326,7 +2326,7 @@ wil_compressed_rx_status_seq_open(struct inode *inode, struct file *file)
 static const struct file_operations fops_compressed_rx_status = {
 	.open  = wil_compressed_rx_status_seq_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = wil_compressed_rx_status_write,
 	.llseek	= seq_lseek,
 };
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
index 6d776ef6ff54eb..cfc7ff6d35038c 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/debug.c
@@ -182,7 +182,7 @@ static const struct file_operations brcms_debugfs_def_ops = {
 	.owner = THIS_MODULE,
 	.open = brcms_debugfs_entry_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek
 };
 
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
index 6e72c27f527bfd..cf3b7ec4db73b8 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/debugfs.c
@@ -419,7 +419,7 @@ static int iwl_dbgfs_fw_info_open(struct inode *inode, struct file *filp)
 static const struct file_operations iwl_dbgfs_fw_info_ops = {
 	.owner = THIS_MODULE,
 	.open = iwl_dbgfs_fw_info_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
index e5160d62086880..b3e740f1b601f4 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/trans.c
@@ -2947,7 +2947,7 @@ DEBUGFS_READ_WRITE_FILE_OPS(rfkill);
 static const struct file_operations iwl_dbgfs_tx_queue_ops = {
 	.owner = THIS_MODULE,
 	.open = iwl_dbgfs_tx_queue_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
index 8ce6880b2bb83e..fc913aad29b262 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/debugfs.c
@@ -99,7 +99,7 @@ mt7603_ampdu_stat_open(struct inode *inode, struct file *f)
 
 static const struct file_operations fops_ampdu_stat = {
 	.open = mt7603_ampdu_stat_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index fd3ef483a87ce7..c61bd9803078a0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -181,7 +181,7 @@ mt7615_ampdu_stat_open(struct inode *inode, struct file *f)
 
 static const struct file_operations fops_ampdu_stat = {
 	.open = mt7615_ampdu_stat_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index ff448a1ad4e398..eda1e49c61dfcd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -50,7 +50,7 @@ static int read_txpower(struct seq_file *file, void *data)
 
 static const struct file_operations fops_ampdu_stat = {
 	.open = mt76x02_ampdu_stat_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -89,7 +89,7 @@ mt76x02_dfs_stat_open(struct inode *inode, struct file *f)
 
 static const struct file_operations fops_dfs_stat = {
 	.open = mt76x02_dfs_stat_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 5278bee812f1cc..9ef9743ac9e80c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -224,7 +224,7 @@ mt7915_tx_stats_open(struct inode *inode, struct file *f)
 
 static const struct file_operations fops_tx_stats = {
 	.open = mt7915_tx_stats_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -450,7 +450,7 @@ mt7915_sta_stats_open(struct inode *inode, struct file *f)
 
 static const struct file_operations fops_sta_stats = {
 	.open = mt7915_sta_stats_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/net/wireless/mediatek/mt7601u/debugfs.c b/drivers/net/wireless/mediatek/mt7601u/debugfs.c
index 300242bce799a4..eaabba20d2ac70 100644
--- a/drivers/net/wireless/mediatek/mt7601u/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt7601u/debugfs.c
@@ -81,7 +81,7 @@ mt7601u_ampdu_stat_open(struct inode *inode, struct file *f)
 
 static const struct file_operations fops_ampdu_stat = {
 	.open = mt7601u_ampdu_stat_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -139,7 +139,7 @@ mt7601u_eeprom_param_open(struct inode *inode, struct file *f)
 
 static const struct file_operations fops_eeprom_param = {
 	.open = mt7601u_eeprom_param_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/net/wireless/realtek/rtlwifi/debug.c b/drivers/net/wireless/realtek/rtlwifi/debug.c
index 55db71c766fe3b..004c5296bd3dd5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/debug.c
+++ b/drivers/net/wireless/realtek/rtlwifi/debug.c
@@ -86,7 +86,7 @@ static int dl_debug_open_common(struct inode *inode, struct file *file)
 
 static const struct file_operations file_ops_common = {
 	.open = dl_debug_open_common,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/net/wireless/realtek/rtw88/debug.c b/drivers/net/wireless/realtek/rtw88/debug.c
index 09f04feb8fe180..189b4eff55e204 100644
--- a/drivers/net/wireless/realtek/rtw88/debug.c
+++ b/drivers/net/wireless/realtek/rtw88/debug.c
@@ -76,7 +76,7 @@ static int rtw_debugfs_close(struct inode *inode, struct file *filp)
 static const struct file_operations file_ops_single_r = {
 	.owner = THIS_MODULE,
 	.open = rtw_debugfs_single_open_rw,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -85,7 +85,7 @@ static const struct file_operations file_ops_single_rw = {
 	.owner = THIS_MODULE,
 	.open = rtw_debugfs_single_open_rw,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.write = rtw_debugfs_single_write,
 };
diff --git a/drivers/net/wireless/rsi/rsi_91x_debugfs.c b/drivers/net/wireless/rsi/rsi_91x_debugfs.c
index c71b41e45423b1..9896792ab683d4 100644
--- a/drivers/net/wireless/rsi/rsi_91x_debugfs.c
+++ b/drivers/net/wireless/rsi/rsi_91x_debugfs.c
@@ -253,14 +253,14 @@ static ssize_t rsi_debug_zone_write(struct file *filp,
 #define FOPS(fopen) { \
 	.owner = THIS_MODULE, \
 	.open = (fopen), \
-	.read = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek = seq_lseek, \
 }
 
 #define FOPS_RW(fopen, fwrite) { \
 	.owner = THIS_MODULE, \
 	.open = (fopen), \
-	.read = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek = seq_lseek, \
 	.write = (fwrite), \
 }
diff --git a/drivers/net/xen-netback/xenbus.c b/drivers/net/xen-netback/xenbus.c
index 286054b60d4743..06b253eba25d8d 100644
--- a/drivers/net/xen-netback/xenbus.c
+++ b/drivers/net/xen-netback/xenbus.c
@@ -152,7 +152,7 @@ static int xenvif_io_ring_open(struct inode *inode, struct file *filp)
 static const struct file_operations xenvif_dbg_io_ring_ops_fops = {
 	.owner = THIS_MODULE,
 	.open = xenvif_io_ring_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.write = xenvif_write_io_ring,
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 2a6c8190eeb766..13496542b6d719 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1140,7 +1140,7 @@ static int nvmf_dev_release(struct inode *inode, struct file *file)
 static const struct file_operations nvmf_dev_fops = {
 	.owner		= THIS_MODULE,
 	.write		= nvmf_dev_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.open		= nvmf_dev_open,
 	.release	= nvmf_dev_release,
 };
diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index 235b456698fc79..bfb8dbc2d0ea10 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -2634,7 +2634,7 @@ static int tegra_pcie_ports_open(struct inode *inode, struct file *file)
 static const struct file_operations tegra_pcie_ports_ops = {
 	.owner = THIS_MODULE,
 	.open = tegra_pcie_ports_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 877aade194979d..9efa854fff133f 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -2502,7 +2502,7 @@ static int asus_wmi_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations asus_wmi_debugfs_io_ops = {
 	.owner = THIS_MODULE,
 	.open = asus_wmi_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 7c8bdab078cf5e..4941349004f604 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -894,7 +894,7 @@ static int pmc_core_ltr_ignore_open(struct inode *inode, struct file *file)
 
 static const struct file_operations pmc_core_ltr_ignore_ops = {
 	.open           = pmc_core_ltr_ignore_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.write          = pmc_core_ltr_ignore_write,
 	.llseek         = seq_lseek,
 	.release        = single_release,
diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
index 1d4d0fbfd63cc6..2a1083f251d801 100644
--- a/drivers/platform/x86/intel_telemetry_debugfs.c
+++ b/drivers/platform/x86/intel_telemetry_debugfs.c
@@ -706,7 +706,7 @@ static int telem_pss_trc_verb_open(struct inode *inode, struct file *file)
 
 static const struct file_operations telem_pss_trc_verb_ops = {
 	.open		= telem_pss_trc_verb_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= telem_pss_trc_verb_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -754,7 +754,7 @@ static int telem_ioss_trc_verb_open(struct inode *inode, struct file *file)
 
 static const struct file_operations telem_ioss_trc_verb_ops = {
 	.open		= telem_ioss_trc_verb_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= telem_ioss_trc_verb_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index 88582423b87d40..292ecf875163a5 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -179,7 +179,7 @@ static int debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations bat_debug_fops = {
 	.open		= debug_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 004b2ea9b5fde3..ad39b0bb0b03d2 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1342,7 +1342,7 @@ static int pwm_seq_open(struct inode *inode, struct file *file)
 static const struct file_operations pwm_debugfs_ops = {
 	.owner = THIS_MODULE,
 	.open = pwm_seq_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index 569d9ad2c59428..a992bb426fdb37 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -475,7 +475,7 @@ static int array_open(struct inode *inode, struct file *filp)
 static const struct file_operations array_ops = {
 	.owner	 = THIS_MODULE,
 	.open	 = array_open,
-	.read	 = seq_read,
+	.read_iter	 = seq_read_iter,
 	.llseek	 = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 0d4f985afbf37f..3da982426904a8 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -32,7 +32,7 @@ static int trace_release(struct inode *inode, struct file *file)
 
 static const struct file_operations trace_fops = {
 	.open    = trace_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = trace_release,
 };
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index cf87eb27879f08..17a9a35e9aedbf 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1089,7 +1089,7 @@ static int dasd_stats_open(struct inode *inode, struct file *file)
 static const struct file_operations dasd_stats_raw_fops = {
 	.owner		= THIS_MODULE,
 	.open		= dasd_stats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 	.write		= dasd_stats_write,
diff --git a/drivers/s390/cio/qdio_debug.c b/drivers/s390/cio/qdio_debug.c
index da95c923d81a2e..31e3f86ac81dc6 100644
--- a/drivers/s390/cio/qdio_debug.c
+++ b/drivers/s390/cio/qdio_debug.c
@@ -281,7 +281,7 @@ static int qperf_seq_open(struct inode *inode, struct file *filp)
 static const struct file_operations debugfs_perf_fops = {
 	.owner	 = THIS_MODULE,
 	.open	 = qperf_seq_open,
-	.read	 = seq_read,
+	.read_iter	 = seq_read_iter,
 	.write	 = qperf_seq_write,
 	.llseek  = seq_lseek,
 	.release = single_release,
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 11caa4b0d79773..852d2620e40833 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2878,7 +2878,7 @@ static int hisi_sas_debugfs_global_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations hisi_sas_debugfs_global_fops = {
 	.open = hisi_sas_debugfs_global_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -2905,7 +2905,7 @@ static int hisi_sas_debugfs_axi_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations hisi_sas_debugfs_axi_fops = {
 	.open = hisi_sas_debugfs_axi_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -2932,7 +2932,7 @@ static int hisi_sas_debugfs_ras_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations hisi_sas_debugfs_ras_fops = {
 	.open = hisi_sas_debugfs_ras_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -2958,7 +2958,7 @@ static int hisi_sas_debugfs_port_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations hisi_sas_debugfs_port_fops = {
 	.open = hisi_sas_debugfs_port_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -3026,7 +3026,7 @@ static int hisi_sas_debugfs_cq_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations hisi_sas_debugfs_cq_fops = {
 	.open = hisi_sas_debugfs_cq_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -3059,7 +3059,7 @@ static int hisi_sas_debugfs_dq_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations hisi_sas_debugfs_dq_fops = {
 	.open = hisi_sas_debugfs_dq_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -3087,7 +3087,7 @@ static int hisi_sas_debugfs_iost_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations hisi_sas_debugfs_iost_fops = {
 	.open = hisi_sas_debugfs_iost_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -3126,7 +3126,7 @@ static int hisi_sas_debugfs_iost_cache_open(struct inode *inode,
 
 static const struct file_operations hisi_sas_debugfs_iost_cache_fops = {
 	.open = hisi_sas_debugfs_iost_cache_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -3154,7 +3154,7 @@ static int hisi_sas_debugfs_itct_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations hisi_sas_debugfs_itct_fops = {
 	.open = hisi_sas_debugfs_itct_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -3193,7 +3193,7 @@ static int hisi_sas_debugfs_itct_cache_open(struct inode *inode,
 
 static const struct file_operations hisi_sas_debugfs_itct_cache_fops = {
 	.open = hisi_sas_debugfs_itct_cache_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 	.owner = THIS_MODULE,
@@ -3422,7 +3422,7 @@ static int hisi_sas_debugfs_bist_linkrate_open(struct inode *inode,
 
 static const struct file_operations hisi_sas_debugfs_bist_linkrate_ops = {
 	.open = hisi_sas_debugfs_bist_linkrate_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = hisi_sas_debugfs_bist_linkrate_write,
 	.llseek = seq_lseek,
 	.release = single_release,
@@ -3512,7 +3512,7 @@ static int hisi_sas_debugfs_bist_code_mode_open(struct inode *inode,
 
 static const struct file_operations hisi_sas_debugfs_bist_code_mode_ops = {
 	.open = hisi_sas_debugfs_bist_code_mode_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = hisi_sas_debugfs_bist_code_mode_write,
 	.llseek = seq_lseek,
 	.release = single_release,
@@ -3561,7 +3561,7 @@ static int hisi_sas_debugfs_bist_phy_open(struct inode *inode,
 
 static const struct file_operations hisi_sas_debugfs_bist_phy_ops = {
 	.open = hisi_sas_debugfs_bist_phy_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = hisi_sas_debugfs_bist_phy_write,
 	.llseek = seq_lseek,
 	.release = single_release,
@@ -3640,7 +3640,7 @@ static int hisi_sas_debugfs_bist_mode_open(struct inode *inode,
 
 static const struct file_operations hisi_sas_debugfs_bist_mode_ops = {
 	.open = hisi_sas_debugfs_bist_mode_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = hisi_sas_debugfs_bist_mode_write,
 	.llseek = seq_lseek,
 	.release = single_release,
@@ -3696,7 +3696,7 @@ static int hisi_sas_debugfs_bist_enable_open(struct inode *inode,
 
 static const struct file_operations hisi_sas_debugfs_bist_enable_ops = {
 	.open = hisi_sas_debugfs_bist_enable_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = hisi_sas_debugfs_bist_enable_write,
 	.llseek = seq_lseek,
 	.release = single_release,
@@ -3742,7 +3742,7 @@ static int hisi_sas_debugfs_phy_down_cnt_open(struct inode *inode,
 
 static const struct file_operations hisi_sas_debugfs_phy_down_cnt_ops = {
 	.open = hisi_sas_debugfs_phy_down_cnt_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = hisi_sas_debugfs_phy_down_cnt_write,
 	.llseek = seq_lseek,
 	.release = single_release,
diff --git a/drivers/scsi/qedf/qedf_dbg.h b/drivers/scsi/qedf/qedf_dbg.h
index 2386bfb73c4616..df4d4aa4b1dd4f 100644
--- a/drivers/scsi/qedf/qedf_dbg.h
+++ b/drivers/scsi/qedf/qedf_dbg.h
@@ -141,7 +141,7 @@ struct qedf_list_of_funcs {
 { \
 	.owner = THIS_MODULE, \
 	.open = drv##_dbg_##ops##_open, \
-	.read = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek = seq_lseek, \
 	.release = single_release, \
 }
diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index 37d084086fd434..5399116d862b5b 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -124,7 +124,7 @@ struct qedi_debugfs_ops {
 { \
 	.owner = THIS_MODULE, \
 	.open = drv##_dbg_##ops##_open, \
-	.read = seq_read, \
+	.read_iter = seq_read_iter, \
 	.llseek = seq_lseek, \
 	.release = single_release, \
 }
diff --git a/drivers/scsi/qla2xxx/qla_dfs.c b/drivers/scsi/qla2xxx/qla_dfs.c
index e62b2115235e15..581ed75973e611 100644
--- a/drivers/scsi/qla2xxx/qla_dfs.c
+++ b/drivers/scsi/qla2xxx/qla_dfs.c
@@ -47,7 +47,7 @@ qla2x00_dfs_tgt_sess_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_tgt_sess_ops = {
 	.open		= qla2x00_dfs_tgt_sess_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -116,7 +116,7 @@ qla2x00_dfs_tgt_port_database_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_tgt_port_database_ops = {
 	.open		= qla2x00_dfs_tgt_port_database_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -164,7 +164,7 @@ qla_dfs_fw_resource_cnt_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_fw_resource_cnt_ops = {
 	.open           = qla_dfs_fw_resource_cnt_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = single_release,
 };
@@ -254,7 +254,7 @@ qla_dfs_tgt_counters_open(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_tgt_counters_ops = {
 	.open           = qla_dfs_tgt_counters_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = single_release,
 };
@@ -351,7 +351,7 @@ qla2x00_dfs_fce_release(struct inode *inode, struct file *file)
 
 static const struct file_operations dfs_fce_ops = {
 	.open		= qla2x00_dfs_fce_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= qla2x00_dfs_fce_release,
 };
@@ -424,7 +424,7 @@ qla_dfs_naqp_write(struct file *file, const char __user *buffer,
 
 static const struct file_operations dfs_naqp_ops = {
 	.open		= qla_dfs_naqp_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 	.write		= qla_dfs_naqp_write,
diff --git a/drivers/scsi/snic/snic_debugfs.c b/drivers/scsi/snic/snic_debugfs.c
index 2b349365592f8c..dbaee7b69e0840 100644
--- a/drivers/scsi/snic/snic_debugfs.c
+++ b/drivers/scsi/snic/snic_debugfs.c
@@ -349,7 +349,7 @@ snic_stats_open(struct inode *inode, struct file *filp)
 static const struct file_operations snic_stats_fops = {
 	.owner	= THIS_MODULE,
 	.open	= snic_stats_open,
-	.read	= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -455,7 +455,7 @@ snic_trc_open(struct inode *inode, struct file *filp)
 static const struct file_operations snic_trc_fops = {
 	.owner	= THIS_MODULE,
 	.open	= snic_trc_open,
-	.read	= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
diff --git a/drivers/sh/intc/virq-debugfs.c b/drivers/sh/intc/virq-debugfs.c
index 9e62ba9311f077..a2759073ee6d1d 100644
--- a/drivers/sh/intc/virq-debugfs.c
+++ b/drivers/sh/intc/virq-debugfs.c
@@ -44,7 +44,7 @@ static int intc_irq_xlate_open(struct inode *inode, struct file *file)
 
 static const struct file_operations intc_irq_xlate_fops = {
 	.open = intc_irq_xlate_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
index fc5610603b1732..d60ef44b1b62c7 100644
--- a/drivers/soc/qcom/cmd-db.c
+++ b/drivers/soc/qcom/cmd-db.c
@@ -303,7 +303,7 @@ static const struct file_operations cmd_db_debugfs_ops = {
 #ifdef CONFIG_DEBUG_FS
 	.open = open_cmd_db_debugfs,
 #endif
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 5983c6ffb07801..ab2a56c75f13e6 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -228,7 +228,7 @@ static int qcom_open_##name(struct inode *inode, struct file *file)	\
 									\
 static const struct file_operations qcom_ ##name## _ops = {		\
 	.open = qcom_open_##name,					\
-	.read = seq_read,						\
+	.read_iter = seq_read_iter,						\
 	.llseek = seq_lseek,						\
 	.release = single_release,					\
 }
@@ -291,7 +291,7 @@ static int open_image_##type(struct inode *inode, struct file *file)	  \
 									  \
 static const struct file_operations qcom_image_##type##_ops = {	  \
 	.open = open_image_##type,					  \
-	.read = seq_read,						  \
+	.read_iter = seq_read_iter,						  \
 	.llseek = seq_lseek,						  \
 	.release = single_release,					  \
 }
diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 6285cd8efb21bb..fa6bb14f88527f 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -377,7 +377,7 @@ static int knav_dma_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations knav_dma_debug_ops = {
 	.open		= knav_dma_debug_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index aa071d96ef362d..85702d66b05abc 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -485,7 +485,7 @@ static int knav_queue_debug_open(struct inode *inode, struct file *file)
 
 static const struct file_operations knav_queue_debug_ops = {
 	.open		= knav_queue_debug_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
index 89cc52211de44f..f5a4c4c33c0f9e 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_debugfs.c
@@ -110,7 +110,7 @@ static const struct file_operations debugfs_log_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debugfs_log_open,
 	.write		= debugfs_log_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -178,7 +178,7 @@ static const struct file_operations debugfs_trace_fops = {
 	.owner		= THIS_MODULE,
 	.open		= debugfs_trace_open,
 	.write		= debugfs_trace_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/usb/chipidea/debug.c b/drivers/usb/chipidea/debug.c
index e0376ee646adff..d734b97a7327bd 100644
--- a/drivers/usb/chipidea/debug.c
+++ b/drivers/usb/chipidea/debug.c
@@ -110,7 +110,7 @@ static int ci_port_test_open(struct inode *inode, struct file *file)
 static const struct file_operations ci_port_test_fops = {
 	.open		= ci_port_test_open,
 	.write		= ci_port_test_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -296,7 +296,7 @@ static int ci_role_open(struct inode *inode, struct file *file)
 static const struct file_operations ci_role_fops = {
 	.open		= ci_role_open,
 	.write		= ci_role_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index 3a0dcbfbc82721..19a083e4f3968d 100644
--- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -109,7 +109,7 @@ static const struct file_operations testmode_fops = {
 	.owner		= THIS_MODULE,
 	.open		= testmode_open,
 	.write		= testmode_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/usb/dwc3/debugfs.c b/drivers/usb/dwc3/debugfs.c
index 6d9de334e46ad0..14c075ad29f93d 100644
--- a/drivers/usb/dwc3/debugfs.c
+++ b/drivers/usb/dwc3/debugfs.c
@@ -380,7 +380,7 @@ static ssize_t dwc3_lsp_write(struct file *file, const char __user *ubuf,
 static const struct file_operations dwc3_lsp_fops = {
 	.open			= dwc3_lsp_open,
 	.write			= dwc3_lsp_write,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -445,7 +445,7 @@ static ssize_t dwc3_mode_write(struct file *file,
 static const struct file_operations dwc3_mode_fops = {
 	.open			= dwc3_mode_open,
 	.write			= dwc3_mode_write,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -528,7 +528,7 @@ static ssize_t dwc3_testmode_write(struct file *file,
 static const struct file_operations dwc3_testmode_fops = {
 	.open			= dwc3_testmode_open,
 	.write			= dwc3_testmode_write,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -620,7 +620,7 @@ static ssize_t dwc3_link_state_write(struct file *file,
 static const struct file_operations dwc3_link_state_fops = {
 	.open			= dwc3_link_state_open,
 	.write			= dwc3_link_state_write,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
diff --git a/drivers/usb/gadget/udc/lpc32xx_udc.c b/drivers/usb/gadget/udc/lpc32xx_udc.c
index 465d0b7c6522a7..bac74bb6729062 100644
--- a/drivers/usb/gadget/udc/lpc32xx_udc.c
+++ b/drivers/usb/gadget/udc/lpc32xx_udc.c
@@ -532,7 +532,7 @@ static int proc_udc_open(struct inode *inode, struct file *file)
 static const struct file_operations proc_ops = {
 	.owner		= THIS_MODULE,
 	.open		= proc_udc_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/drivers/usb/gadget/udc/renesas_usb3.c b/drivers/usb/gadget/udc/renesas_usb3.c
index 0c418ce50ba0f4..619d70d7086b16 100644
--- a/drivers/usb/gadget/udc/renesas_usb3.c
+++ b/drivers/usb/gadget/udc/renesas_usb3.c
@@ -2543,7 +2543,7 @@ static ssize_t renesas_usb3_b_device_write(struct file *file,
 static const struct file_operations renesas_usb3_b_device_fops = {
 	.open = renesas_usb3_b_device_open,
 	.write = renesas_usb3_b_device_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/usb/host/xhci-debugfs.c b/drivers/usb/host/xhci-debugfs.c
index 76c3f29562d2b9..4a640031d944ee 100644
--- a/drivers/usb/host/xhci-debugfs.c
+++ b/drivers/usb/host/xhci-debugfs.c
@@ -248,7 +248,7 @@ static int xhci_ring_open(struct inode *inode, struct file *file)
 
 static const struct file_operations xhci_ring_fops = {
 	.open			= xhci_ring_open,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -329,7 +329,7 @@ static int xhci_context_open(struct inode *inode, struct file *file)
 
 static const struct file_operations xhci_context_fops = {
 	.open			= xhci_context_open,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -390,7 +390,7 @@ static ssize_t xhci_port_write(struct file *file,  const char __user *ubuf,
 static const struct file_operations port_fops = {
 	.open			= xhci_port_open,
 	.write                  = xhci_port_write,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
diff --git a/drivers/usb/mtu3/mtu3_debugfs.c b/drivers/usb/mtu3/mtu3_debugfs.c
index fdeade6254aecc..3530f1aa4af6d5 100644
--- a/drivers/usb/mtu3/mtu3_debugfs.c
+++ b/drivers/usb/mtu3/mtu3_debugfs.c
@@ -271,7 +271,7 @@ static int mtu3_ep_open(struct inode *inode, struct file *file)
 
 static const struct file_operations mtu3_ep_fops = {
 	.open = mtu3_ep_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -341,7 +341,7 @@ static ssize_t mtu3_probe_write(struct file *file, const char __user *ubuf,
 static const struct file_operations mtu3_probe_fops = {
 	.open = mtu3_probe_open,
 	.write = mtu3_probe_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -467,7 +467,7 @@ static ssize_t ssusb_mode_write(struct file *file, const char __user *ubuf,
 static const struct file_operations ssusb_mode_fops = {
 	.open = ssusb_mode_open,
 	.write = ssusb_mode_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -513,7 +513,7 @@ static ssize_t ssusb_vbus_write(struct file *file, const char __user *ubuf,
 static const struct file_operations ssusb_vbus_fops = {
 	.open = ssusb_vbus_open,
 	.write = ssusb_vbus_write,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/usb/musb/musb_debugfs.c b/drivers/usb/musb/musb_debugfs.c
index 30a89aa8a3e7ad..14b0f094e8f56b 100644
--- a/drivers/usb/musb/musb_debugfs.c
+++ b/drivers/usb/musb/musb_debugfs.c
@@ -224,7 +224,7 @@ static ssize_t musb_test_mode_write(struct file *file,
 static const struct file_operations musb_test_mode_fops = {
 	.open			= musb_test_mode_open,
 	.write			= musb_test_mode_write,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
@@ -316,7 +316,7 @@ static ssize_t musb_softconnect_write(struct file *file,
 static const struct file_operations musb_softconnect_fops = {
 	.open			= musb_softconnect_open,
 	.write			= musb_softconnect_write,
-	.read			= seq_read,
+	.read_iter			= seq_read_iter,
 	.llseek			= seq_lseek,
 	.release		= single_release,
 };
diff --git a/drivers/visorbus/visorbus_main.c b/drivers/visorbus/visorbus_main.c
index 152fd29f04f295..a0b8142bdd114e 100644
--- a/drivers/visorbus/visorbus_main.c
+++ b/drivers/visorbus/visorbus_main.c
@@ -479,7 +479,7 @@ static int bus_info_debugfs_open(struct inode *inode, struct file *file)
 static const struct file_operations bus_info_debugfs_fops = {
 	.owner = THIS_MODULE,
 	.open = bus_info_debugfs_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/drivers/xen/xenfs/xensyms.c b/drivers/xen/xenfs/xensyms.c
index c6c73a33c44d55..bfc92190d1b695 100644
--- a/drivers/xen/xenfs/xensyms.c
+++ b/drivers/xen/xenfs/xensyms.c
@@ -146,7 +146,7 @@ static int xensyms_release(struct inode *inode, struct file *file)
 
 const struct file_operations xensyms_ops = {
 	.open = xensyms_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = xensyms_release
 };
diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index ae49a55bda001b..8ba32c2feb1b73 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -1080,7 +1080,7 @@ static int debugfs_open_regset32(struct inode *inode, struct file *file)
 
 static const struct file_operations fops_regset32 = {
 	.open =		debugfs_open_regset32,
-	.read =		seq_read,
+	.read_iter =		seq_read_iter,
 	.llseek =	seq_lseek,
 	.release =	single_release,
 };
@@ -1126,7 +1126,7 @@ static const struct file_operations debugfs_devm_entry_ops = {
 	.owner = THIS_MODULE,
 	.open = debugfs_devm_entry_open,
 	.release = single_release,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek
 };
 
diff --git a/fs/dlm/debug_fs.c b/fs/dlm/debug_fs.c
index d6bbccb0ed152f..95aebaca9033b1 100644
--- a/fs/dlm/debug_fs.c
+++ b/fs/dlm/debug_fs.c
@@ -663,7 +663,7 @@ static int table_open4(struct inode *inode, struct file *file)
 static const struct file_operations format1_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open1,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -671,7 +671,7 @@ static const struct file_operations format1_fops = {
 static const struct file_operations format2_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open2,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -679,7 +679,7 @@ static const struct file_operations format2_fops = {
 static const struct file_operations format3_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open3,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
@@ -687,7 +687,7 @@ static const struct file_operations format3_fops = {
 static const struct file_operations format4_fops = {
 	.owner   = THIS_MODULE,
 	.open    = table_open4,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release
 };
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 2299dcc417eae9..91e9f4da7a5f22 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -2470,7 +2470,7 @@ static int gfs2_sbstats_open(struct inode *inode, struct file *file)
 static const struct file_operations gfs2_glocks_fops = {
 	.owner   = THIS_MODULE,
 	.open    = gfs2_glocks_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = gfs2_glocks_release,
 };
@@ -2478,7 +2478,7 @@ static const struct file_operations gfs2_glocks_fops = {
 static const struct file_operations gfs2_glstats_fops = {
 	.owner   = THIS_MODULE,
 	.open    = gfs2_glstats_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = gfs2_glocks_release,
 };
@@ -2486,7 +2486,7 @@ static const struct file_operations gfs2_glstats_fops = {
 static const struct file_operations gfs2_sbstats_fops = {
 	.owner   = THIS_MODULE,
 	.open	 = gfs2_sbstats_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index bb3d2c32664ad9..a4dadd2c5aa122 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2364,7 +2364,7 @@ static int client_info_open(struct inode *inode, struct file *file)
 
 static const struct file_operations client_info_fops = {
 	.open		= client_info_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -2611,7 +2611,7 @@ static int client_opens_release(struct inode *inode, struct file *file)
 
 static const struct file_operations client_states_fops = {
 	.open		= client_states_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= client_opens_release,
 };
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index b68e96681522ec..1b36a8ba82d204 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -171,7 +171,7 @@ static int exports_nfsd_open(struct inode *inode, struct file *file)
 
 static const struct file_operations exports_nfsd_operations = {
 	.open		= exports_nfsd_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -189,7 +189,7 @@ static int export_features_open(struct inode *inode, struct file *file)
 
 static const struct file_operations export_features_operations = {
 	.open		= export_features_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -208,7 +208,7 @@ static int supported_enctypes_open(struct inode *inode, struct file *file)
 
 static const struct file_operations supported_enctypes_ops = {
 	.open		= supported_enctypes_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -216,14 +216,14 @@ static const struct file_operations supported_enctypes_ops = {
 
 static const struct file_operations pool_stats_operations = {
 	.open		= nfsd_pool_stats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= nfsd_pool_stats_release,
 };
 
 static const struct file_operations reply_cache_stats_operations = {
 	.open		= nfsd_reply_cache_stats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/fs/ocfs2/cluster/netdebug.c b/fs/ocfs2/cluster/netdebug.c
index 667a5c5e1f663c..eb9b7f60bbfb76 100644
--- a/fs/ocfs2/cluster/netdebug.c
+++ b/fs/ocfs2/cluster/netdebug.c
@@ -186,7 +186,7 @@ static int nst_fop_release(struct inode *inode, struct file *file)
 
 static const struct file_operations nst_seq_fops = {
 	.open = nst_fop_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = nst_fop_release,
 };
@@ -418,7 +418,7 @@ static int stats_fop_open(struct inode *inode, struct file *file)
 
 static const struct file_operations stats_seq_fops = {
 	.open = stats_fop_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = sc_fop_release,
 };
@@ -430,7 +430,7 @@ static int sc_fop_open(struct inode *inode, struct file *file)
 
 static const struct file_operations sc_seq_fops = {
 	.open = sc_fop_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = sc_fop_release,
 };
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index 4b8b41d23e91d5..3166d544245df6 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -653,7 +653,7 @@ static int debug_lockres_release(struct inode *inode, struct file *file)
 static const struct file_operations debug_lockres_fops = {
 	.open =		debug_lockres_open,
 	.release =	debug_lockres_release,
-	.read =		seq_read,
+	.read_iter =		seq_read_iter,
 	.llseek =	seq_lseek,
 };
 /* end - debug lockres funcs */
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 152a0fc4e90514..92e8adf843499e 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3269,7 +3269,7 @@ static int ocfs2_dlm_debug_open(struct inode *inode, struct file *file)
 static const struct file_operations ocfs2_dlm_debug_fops = {
 	.open =		ocfs2_dlm_debug_open,
 	.release =	ocfs2_dlm_debug_release,
-	.read =		seq_read,
+	.read_iter =		seq_read_iter,
 	.llseek =	seq_lseek,
 };
 
diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 40c8c2e32fa3e5..bc327cb2673e08 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -159,7 +159,7 @@ static int property_open(struct inode *inode, struct file *file)
 
 static const struct file_operations openpromfs_prop_ops = {
 	.open		= property_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index 29eaa454437279..dc314c6d83722d 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -116,7 +116,7 @@ static const struct seq_operations help_debug_ops = {
 static const struct file_operations debug_help_fops = {
 	.owner		= THIS_MODULE,
 	.open           = orangefs_debug_help_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.release        = seq_release,
 	.llseek         = seq_lseek,
 };
diff --git a/fs/proc/array.c b/fs/proc/array.c
index 55ecbeb3a7213c..49456efa31e381 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -766,7 +766,7 @@ static int children_seq_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_tid_children_operations = {
 	.open    = children_seq_open,
-	.read    = seq_read,
+	.read_iter    = seq_read_iter,
 	.llseek  = seq_lseek,
 	.release = seq_release,
 };
diff --git a/fs/proc/base.c b/fs/proc/base.c
index d86c0afc8a8590..6f2e921c471e2d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -538,7 +538,7 @@ static ssize_t lstats_write(struct file *file, const char __user *buf,
 
 static const struct file_operations proc_lstats_operations = {
 	.open		= lstats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= lstats_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -776,7 +776,7 @@ static int proc_single_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_single_file_operations = {
 	.open		= proc_single_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -1460,7 +1460,7 @@ static int sched_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_sched_operations = {
 	.open		= sched_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= sched_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -1535,7 +1535,7 @@ static int sched_autogroup_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_sched_autogroup_operations = {
 	.open		= sched_autogroup_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= sched_autogroup_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -1638,7 +1638,7 @@ static int timens_offsets_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_timens_offsets_operations = {
 	.open		= timens_offsets_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= timens_offsets_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -1695,7 +1695,7 @@ static int comm_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_set_comm_operations = {
 	.open		= comm_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= comm_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -2484,7 +2484,7 @@ static int proc_timers_open(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_timers_operations = {
 	.open		= proc_timers_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release_private,
 };
@@ -2576,7 +2576,7 @@ static int timerslack_ns_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations proc_pid_set_timerslack_ns_operations = {
 	.open		= timerslack_ns_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= timerslack_ns_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -3028,7 +3028,7 @@ static int proc_projid_map_open(struct inode *inode, struct file *file)
 static const struct file_operations proc_uid_map_operations = {
 	.open		= proc_uid_map_open,
 	.write		= proc_uid_map_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
@@ -3036,7 +3036,7 @@ static const struct file_operations proc_uid_map_operations = {
 static const struct file_operations proc_gid_map_operations = {
 	.open		= proc_gid_map_open,
 	.write		= proc_gid_map_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
@@ -3044,7 +3044,7 @@ static const struct file_operations proc_gid_map_operations = {
 static const struct file_operations proc_projid_map_operations = {
 	.open		= proc_projid_map_open,
 	.write		= proc_projid_map_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_id_map_release,
 };
@@ -3095,7 +3095,7 @@ static int proc_setgroups_release(struct inode *inode, struct file *file)
 static const struct file_operations proc_setgroups_operations = {
 	.open		= proc_setgroups_open,
 	.write		= proc_setgroups_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_setgroups_release,
 };
diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 81882a13212d3d..4259f3dd46985a 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -76,7 +76,7 @@ static int seq_fdinfo_open(struct inode *inode, struct file *file)
 
 static const struct file_operations proc_fdinfo_file_operations = {
 	.open		= seq_fdinfo_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index dbda4499a859a5..df2f0f05f5ba72 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -351,7 +351,7 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
@@ -933,14 +933,14 @@ static int smaps_rollup_release(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_smaps_operations = {
 	.open		= pid_smaps_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
 
 const struct file_operations proc_pid_smaps_rollup_operations = {
 	.open		= smaps_rollup_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= smaps_rollup_release,
 };
@@ -1879,7 +1879,7 @@ static int pid_numa_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_numa_maps_operations = {
 	.open		= pid_numa_maps_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= proc_map_release,
 };
diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c64..b9ea64ddcf7d7b 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -295,7 +295,7 @@ static int pid_maps_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_pid_maps_operations = {
 	.open		= pid_maps_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= map_release,
 };
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 3059a9394c2d6d..5b06fc7f5a5f35 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -319,7 +319,7 @@ static int mountstats_open(struct inode *inode, struct file *file)
 
 const struct file_operations proc_mounts_operations = {
 	.open		= mounts_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 	.poll		= mounts_poll,
@@ -327,7 +327,7 @@ const struct file_operations proc_mounts_operations = {
 
 const struct file_operations proc_mountinfo_operations = {
 	.open		= mountinfo_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 	.poll		= mounts_poll,
@@ -335,7 +335,7 @@ const struct file_operations proc_mountinfo_operations = {
 
 const struct file_operations proc_mountstats_operations = {
 	.open		= mountstats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= mounts_release,
 };
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index b83b3ae3c877f3..0c9e9c8607e788 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -160,7 +160,7 @@ static int __name ## _open(struct inode *inode, struct file *file)	\
 static const struct file_operations __name ## _fops = {			\
 	.owner		= THIS_MODULE,					\
 	.open		= __name ## _open,				\
-	.read		= seq_read,					\
+	.read_iter		= seq_read_iter,					\
 	.llseek		= seq_lseek,					\
 	.release	= seq_release,					\
 }
@@ -174,7 +174,7 @@ static int __name ## _open(struct inode *inode, struct file *file)	\
 static const struct file_operations __name ## _fops = {			\
 	.owner		= THIS_MODULE,					\
 	.open		= __name ## _open,				\
-	.read		= seq_read,					\
+	.read_iter		= seq_read_iter,					\
 	.llseek		= seq_lseek,					\
 	.release	= single_release,				\
 }
diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index fb878ba3f22f03..9f73d2ab6e7d28 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -311,7 +311,7 @@ static int bpffs_map_release(struct inode *inode, struct file *file)
  */
 static const struct file_operations bpffs_map_fops = {
 	.open		= bpffs_map_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.release	= bpffs_map_release,
 };
 
diff --git a/kernel/fail_function.c b/kernel/fail_function.c
index 63b349168da725..d4b5501e944fe0 100644
--- a/kernel/fail_function.c
+++ b/kernel/fail_function.c
@@ -314,7 +314,7 @@ static ssize_t fei_write(struct file *file, const char __user *buffer,
 
 static const struct file_operations fei_ops = {
 	.open =		fei_open,
-	.read =		seq_read,
+	.read_iter =		seq_read_iter,
 	.write =	fei_write,
 	.llseek =	seq_lseek,
 	.release =	seq_release,
diff --git a/kernel/gcov/fs.c b/kernel/gcov/fs.c
index 82babf5aa077b7..e17f2fc6f2509f 100644
--- a/kernel/gcov/fs.c
+++ b/kernel/gcov/fs.c
@@ -401,7 +401,7 @@ static void add_links(struct gcov_node *node, struct dentry *parent)
 static const struct file_operations gcov_data_fops = {
 	.open		= gcov_seq_open,
 	.release	= gcov_seq_release,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.write		= gcov_seq_write,
 };
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index 4f9f844074db15..bac13f73cb52e7 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -201,7 +201,7 @@ static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 static const struct file_operations dfs_irq_ops = {
 	.open		= irq_debug_open,
 	.write		= irq_debug_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 023e49c58d55ec..a069114d147148 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -337,7 +337,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 
 static const struct file_operations debugfs_ops =
 {
-	.read	 = seq_read,
+	.read_iter	 = seq_read_iter,
 	.open	 = debugfs_open,
 	.write	 = debugfs_write,
 	.release = single_release
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 36c54265bb2b0f..f0f79d7f1e8c97 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -164,7 +164,7 @@ static int sched_feat_open(struct inode *inode, struct file *filp)
 static const struct file_operations sched_feat_fops = {
 	.open		= sched_feat_open,
 	.write		= sched_feat_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 77c63005dc4e03..f6b964a17c1972 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -129,7 +129,7 @@ static ssize_t udelay_test_write(struct file *file, const char __user *buf,
 static const struct file_operations udelay_test_debugfs_ops = {
 	.owner = THIS_MODULE,
 	.open = udelay_test_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = udelay_test_write,
 	.llseek = seq_lseek,
 	.release = single_release,
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1903b80db6ebc5..6a645f2ebf4752 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5561,21 +5561,21 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 
 static const struct file_operations ftrace_avail_fops = {
 	.open = ftrace_avail_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
 
 static const struct file_operations ftrace_enabled_fops = {
 	.open = ftrace_enabled_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 };
 
 static const struct file_operations ftrace_filter_fops = {
 	.open = ftrace_filter_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = ftrace_filter_write,
 	.llseek = tracing_lseek,
 	.release = ftrace_regex_release,
@@ -5583,7 +5583,7 @@ static const struct file_operations ftrace_filter_fops = {
 
 static const struct file_operations ftrace_notrace_fops = {
 	.open = ftrace_notrace_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = ftrace_notrace_write,
 	.llseek = tracing_lseek,
 	.release = ftrace_regex_release,
@@ -5981,7 +5981,7 @@ ftrace_graph_write(struct file *file, const char __user *ubuf,
 
 static const struct file_operations ftrace_graph_fops = {
 	.open		= ftrace_graph_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= ftrace_graph_write,
 	.llseek		= tracing_lseek,
 	.release	= ftrace_graph_release,
@@ -5989,7 +5989,7 @@ static const struct file_operations ftrace_graph_fops = {
 
 static const struct file_operations ftrace_graph_notrace_fops = {
 	.open		= ftrace_graph_notrace_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= ftrace_graph_write,
 	.llseek		= tracing_lseek,
 	.release	= ftrace_graph_release,
@@ -7306,7 +7306,7 @@ ftrace_pid_release(struct inode *inode, struct file *file)
 static const struct file_operations ftrace_pid_fops = {
 	.open		= ftrace_pid_open,
 	.write		= ftrace_pid_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= tracing_lseek,
 	.release	= ftrace_pid_release,
 };
@@ -7314,7 +7314,7 @@ static const struct file_operations ftrace_pid_fops = {
 static const struct file_operations ftrace_no_pid_fops = {
 	.open		= ftrace_no_pid_open,
 	.write		= ftrace_no_pid_write,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= tracing_lseek,
 	.release	= ftrace_pid_release,
 };
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index bb62269724d5f4..36dbb58680fc33 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4611,7 +4611,7 @@ loff_t tracing_lseek(struct file *file, loff_t offset, int whence)
 
 static const struct file_operations tracing_fops = {
 	.open		= tracing_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= tracing_write_stub,
 	.llseek		= tracing_lseek,
 	.release	= tracing_release,
@@ -4619,7 +4619,7 @@ static const struct file_operations tracing_fops = {
 
 static const struct file_operations show_traces_fops = {
 	.open		= show_traces_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= show_traces_release,
 };
@@ -4957,7 +4957,7 @@ static int tracing_trace_options_open(struct inode *inode, struct file *file)
 
 static const struct file_operations tracing_iter_fops = {
 	.open		= tracing_trace_options_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tracing_single_release_tr,
 	.write		= tracing_trace_options_write,
@@ -5297,7 +5297,7 @@ static int tracing_saved_tgids_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations tracing_saved_tgids_fops = {
 	.open		= tracing_saved_tgids_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -5376,7 +5376,7 @@ static int tracing_saved_cmdlines_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations tracing_saved_cmdlines_fops = {
 	.open		= tracing_saved_cmdlines_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -5542,7 +5542,7 @@ static int tracing_eval_map_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations tracing_eval_map_fops = {
 	.open		= tracing_eval_map_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -7119,7 +7119,7 @@ static const struct file_operations tracing_mark_raw_fops = {
 
 static const struct file_operations trace_clock_fops = {
 	.open		= tracing_clock_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tracing_single_release_tr,
 	.write		= tracing_clock_write,
@@ -7127,7 +7127,7 @@ static const struct file_operations trace_clock_fops = {
 
 static const struct file_operations trace_time_stamp_mode_fops = {
 	.open		= tracing_time_stamp_mode_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tracing_single_release_tr,
 };
@@ -7135,7 +7135,7 @@ static const struct file_operations trace_time_stamp_mode_fops = {
 #ifdef CONFIG_TRACER_SNAPSHOT
 static const struct file_operations snapshot_fops = {
 	.open		= tracing_snapshot_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= tracing_snapshot_write,
 	.llseek		= tracing_lseek,
 	.release	= tracing_snapshot_release,
@@ -7391,7 +7391,7 @@ static int tracing_err_log_release(struct inode *inode, struct file *file)
 static const struct file_operations tracing_err_log_fops = {
 	.open           = tracing_err_log_open,
 	.write		= tracing_err_log_write,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = tracing_err_log_release,
 };
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 9f2e8520b7486e..2c435fdef5659d 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -197,7 +197,7 @@ static ssize_t dyn_event_write(struct file *file, const char __user *buffer,
 static const struct file_operations dynamic_events_ops = {
 	.owner          = THIS_MODULE,
 	.open           = dyn_event_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
 	.write		= dyn_event_write,
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index f6f55682d3e2d0..780cf3be35d15a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1828,14 +1828,14 @@ static const struct seq_operations show_set_no_pid_seq_ops = {
 
 static const struct file_operations ftrace_avail_fops = {
 	.open = ftrace_event_avail_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
 
 static const struct file_operations ftrace_set_event_fops = {
 	.open = ftrace_event_set_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = ftrace_event_write,
 	.llseek = seq_lseek,
 	.release = ftrace_event_release,
@@ -1843,7 +1843,7 @@ static const struct file_operations ftrace_set_event_fops = {
 
 static const struct file_operations ftrace_set_event_pid_fops = {
 	.open = ftrace_event_set_pid_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = ftrace_event_pid_write,
 	.llseek = seq_lseek,
 	.release = ftrace_event_release,
@@ -1851,7 +1851,7 @@ static const struct file_operations ftrace_set_event_pid_fops = {
 
 static const struct file_operations ftrace_set_event_notrace_pid_fops = {
 	.open = ftrace_event_set_npid_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = ftrace_event_npid_write,
 	.llseek = seq_lseek,
 	.release = ftrace_event_release,
@@ -1866,7 +1866,7 @@ static const struct file_operations ftrace_enable_fops = {
 
 static const struct file_operations ftrace_event_format_fops = {
 	.open = trace_format_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0b933546142e8b..f7bcfeb7edd0c9 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4724,7 +4724,7 @@ static int event_hist_open(struct inode *inode, struct file *file)
 
 const struct file_operations event_hist_fops = {
 	.open = event_hist_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
@@ -4996,7 +4996,7 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 
 const struct file_operations event_hist_debug_fops = {
 	.open = event_hist_debug_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index c6cca0d1d5840a..e2a623f2136c60 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -1749,7 +1749,7 @@ static ssize_t synth_events_write(struct file *file,
 static const struct file_operations synth_events_fops = {
 	.open           = synth_events_open,
 	.write		= synth_events_write,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
 };
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 3a74736da363ae..bea3026c02ff41 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -310,7 +310,7 @@ event_trigger_release(struct inode *inode, struct file *file)
 
 const struct file_operations event_trigger_fops = {
 	.open = event_trigger_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = event_trigger_write,
 	.llseek = tracing_lseek,
 	.release = event_trigger_release,
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index aefb6065b508de..467a3c8512abbd 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1148,7 +1148,7 @@ static ssize_t probes_write(struct file *file, const char __user *buffer,
 static const struct file_operations kprobe_events_ops = {
 	.owner          = THIS_MODULE,
 	.open           = probes_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
 	.write		= probes_write,
@@ -1193,7 +1193,7 @@ static int profile_open(struct inode *inode, struct file *file)
 static const struct file_operations kprobe_profile_ops = {
 	.owner          = THIS_MODULE,
 	.open           = profile_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
 };
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index d4e31e96920650..941bbfcd326640 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -360,7 +360,7 @@ ftrace_formats_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ftrace_formats_fops = {
 	.open = ftrace_formats_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 98bba4764c5273..5810fb81bfa288 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -487,7 +487,7 @@ static int stack_trace_open(struct inode *inode, struct file *file)
 
 static const struct file_operations stack_trace_fops = {
 	.open		= stack_trace_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
@@ -506,7 +506,7 @@ stack_trace_filter_open(struct inode *inode, struct file *file)
 
 static const struct file_operations stack_trace_filter_fops = {
 	.open = stack_trace_filter_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.write = ftrace_filter_write,
 	.llseek = tracing_lseek,
 	.release = ftrace_regex_release,
diff --git a/kernel/trace/trace_stat.c b/kernel/trace/trace_stat.c
index d1fa19773cc8e6..759a51f95f4e30 100644
--- a/kernel/trace/trace_stat.c
+++ b/kernel/trace/trace_stat.c
@@ -269,7 +269,7 @@ static int tracing_stat_release(struct inode *i, struct file *f)
 
 static const struct file_operations tracing_stat_fops = {
 	.open		= tracing_stat_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tracing_stat_release
 };
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fdd47f99b18fdb..5ce4e80ccf4c67 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -786,7 +786,7 @@ static ssize_t probes_write(struct file *file, const char __user *buffer,
 static const struct file_operations uprobe_events_ops = {
 	.owner		= THIS_MODULE,
 	.open		= probes_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 	.write		= probes_write,
@@ -828,7 +828,7 @@ static int profile_open(struct inode *inode, struct file *file)
 static const struct file_operations uprobe_profile_ops = {
 	.owner		= THIS_MODULE,
 	.open		= profile_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 48054dbf1b51fb..5d2bbfc55345bc 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1030,7 +1030,7 @@ static int debug_stats_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations debug_stats_fops = {
 	.open		= debug_stats_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 321437bbf87dd3..76750e73dcaf9d 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -870,7 +870,7 @@ static int ddebug_proc_open(struct inode *inode, struct file *file)
 static const struct file_operations ddebug_proc_fops = {
 	.owner = THIS_MODULE,
 	.open = ddebug_proc_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release_private,
 	.write = ddebug_proc_write
diff --git a/lib/error-inject.c b/lib/error-inject.c
index aa63751c916fa1..fd9345f40d6eaa 100644
--- a/lib/error-inject.c
+++ b/lib/error-inject.c
@@ -208,7 +208,7 @@ static int ei_open(struct inode *inode, struct file *filp)
 
 static const struct file_operations debugfs_ei_ops = {
 	.open           = ei_open,
-	.read           = seq_read,
+	.read_iter           = seq_read_iter,
 	.llseek         = seq_lseek,
 	.release        = seq_release,
 };
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 9214c493d8b761..5d767103444c1e 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -84,7 +84,7 @@ static int debugfs_results_open(struct inode *inode, struct file *file)
 
 static const struct file_operations debugfs_results_fops = {
 	.open = debugfs_results_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = debugfs_release,
 };
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index e362dc3d2028c3..29a684a4656a99 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1834,7 +1834,7 @@ static ssize_t kmemleak_write(struct file *file, const char __user *user_buf,
 static const struct file_operations kmemleak_fops = {
 	.owner		= THIS_MODULE,
 	.open		= kmemleak_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= kmemleak_write,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
diff --git a/net/6lowpan/debugfs.c b/net/6lowpan/debugfs.c
index 1c140af06d5273..f37d439eda04f1 100644
--- a/net/6lowpan/debugfs.c
+++ b/net/6lowpan/debugfs.c
@@ -157,7 +157,7 @@ static ssize_t lowpan_ctx_pfx_write(struct file *fp,
 
 static const struct file_operations lowpan_ctx_pfx_fops = {
 	.open		= lowpan_ctx_pfx_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= lowpan_ctx_pfx_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
diff --git a/net/batman-adv/debugfs.c b/net/batman-adv/debugfs.c
index 452856c27d20b7..111c2103e9fa42 100644
--- a/net/batman-adv/debugfs.c
+++ b/net/batman-adv/debugfs.c
@@ -204,7 +204,7 @@ struct batadv_debuginfo batadv_debuginfo_##_name = {	\
 	.fops = {					\
 		.owner = THIS_MODULE,			\
 		.open = _open,				\
-		.read	= seq_read,			\
+		.read_iter	= seq_read_iter,			\
 		.llseek = seq_lseek,			\
 		.release = single_release,		\
 	},						\
@@ -272,7 +272,7 @@ struct batadv_debuginfo batadv_hardif_debuginfo_##_name = {	\
 	.fops = {						\
 		.owner = THIS_MODULE,				\
 		.open = _open,					\
-		.read	= seq_read,				\
+		.read_iter	= seq_read_iter,				\
 		.llseek = seq_lseek,				\
 		.release = single_release,			\
 	},							\
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index bb55d92691b068..573ef0c8052101 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1205,7 +1205,7 @@ static int lowpan_control_open(struct inode *inode, struct file *file)
 
 static const struct file_operations lowpan_control_fops = {
 	.open		= lowpan_control_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= lowpan_control_write,
 	.llseek		= seq_lseek,
 	.release	= single_release,
diff --git a/net/hsr/hsr_debugfs.c b/net/hsr/hsr_debugfs.c
index 9787ef11ca71cd..d994c83b01787a 100644
--- a/net/hsr/hsr_debugfs.c
+++ b/net/hsr/hsr_debugfs.c
@@ -80,7 +80,7 @@ void hsr_debugfs_rename(struct net_device *dev)
 
 static const struct file_operations hsr_fops = {
 	.open	= hsr_node_table_open,
-	.read	= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek = seq_lseek,
 	.release = single_release,
 };
diff --git a/net/l2tp/l2tp_debugfs.c b/net/l2tp/l2tp_debugfs.c
index 35bb4f3bdbe017..6268c42e6beee3 100644
--- a/net/l2tp/l2tp_debugfs.c
+++ b/net/l2tp/l2tp_debugfs.c
@@ -318,7 +318,7 @@ static int l2tp_dfs_seq_release(struct inode *inode, struct file *file)
 static const struct file_operations l2tp_dfs_fops = {
 	.owner		= THIS_MODULE,
 	.open		= l2tp_dfs_seq_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= l2tp_dfs_seq_release,
 };
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index baef5ee43dbbdb..e5c01697c3f1d6 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -1842,7 +1842,7 @@ static int content_release_pipefs(struct inode *inode, struct file *filp)
 
 const struct file_operations content_file_operations_pipefs = {
 	.open		= content_open_pipefs,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= content_release_pipefs,
 };
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index fd9bca24272427..2453042f6daf42 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -112,7 +112,7 @@ tasks_release(struct inode *inode, struct file *filp)
 static const struct file_operations tasks_fops = {
 	.owner		= THIS_MODULE,
 	.open		= tasks_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= tasks_release,
 };
@@ -211,7 +211,7 @@ xprt_info_release(struct inode *inode, struct file *filp)
 static const struct file_operations xprt_info_fops = {
 	.owner		= THIS_MODULE,
 	.open		= xprt_info_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= xprt_info_release,
 };
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index 39e14d5edaf132..3a7427d661747a 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -449,7 +449,7 @@ rpc_info_release(struct inode *inode, struct file *file)
 static const struct file_operations rpc_info_operations = {
 	.owner		= THIS_MODULE,
 	.open		= rpc_info_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= rpc_info_release,
 };
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 5fd4a64e431f67..ae77761011e9c6 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -1015,7 +1015,7 @@ static int aa_sfs_seq_open(struct inode *inode, struct file *file)
 const struct file_operations aa_sfs_seq_file_ops = {
 	.owner		= THIS_MODULE,
 	.open		= aa_sfs_seq_open,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= single_release,
 };
@@ -1034,7 +1034,7 @@ static int seq_profile_ ##NAME ##_open(struct inode *inode, struct file *file)\
 static const struct file_operations seq_profile_ ##NAME ##_fops = {	      \
 	.owner		= THIS_MODULE,					      \
 	.open		= seq_profile_ ##NAME ##_open,			      \
-	.read		= seq_read,					      \
+	.read_iter		= seq_read_iter,					      \
 	.llseek		= seq_lseek,					      \
 	.release	= seq_profile_release,				      \
 }									      \
@@ -1136,7 +1136,7 @@ static int seq_ns_ ##NAME ##_open(struct inode *inode, struct file *file)     \
 static const struct file_operations seq_ns_ ##NAME ##_fops = {	      \
 	.owner		= THIS_MODULE,					      \
 	.open		= seq_ns_ ##NAME ##_open,			      \
-	.read		= seq_read,					      \
+	.read_iter		= seq_read_iter,					      \
 	.llseek		= seq_lseek,					      \
 	.release	= single_release,				      \
 }									      \
@@ -1212,7 +1212,7 @@ static int seq_rawdata_ ##NAME ##_open(struct inode *inode, struct file *file)\
 static const struct file_operations seq_rawdata_ ##NAME ##_fops = {	      \
 	.owner		= THIS_MODULE,					      \
 	.open		= seq_rawdata_ ##NAME ##_open,			      \
-	.read		= seq_read,					      \
+	.read_iter		= seq_read_iter,					      \
 	.llseek		= seq_lseek,					      \
 	.release	= seq_rawdata_release,				      \
 }									      \
@@ -2280,7 +2280,7 @@ static int profiles_release(struct inode *inode, struct file *file)
 
 static const struct file_operations aa_sfs_profiles_fops = {
 	.open = profiles_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = profiles_release,
 };
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e3fcad871861a3..7cc4c5862c3f6e 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -199,7 +199,7 @@ static int ima_measurements_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_measurements_ops = {
 	.open = ima_measurements_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
@@ -265,7 +265,7 @@ static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 
 static const struct file_operations ima_ascii_measurements_ops = {
 	.open = ima_ascii_measurements_open,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
@@ -441,7 +441,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 static const struct file_operations ima_measure_policy_ops = {
 	.open = ima_open_policy,
 	.write = ima_write_policy,
-	.read = seq_read,
+	.read_iter = seq_read_iter,
 	.release = ima_release_policy,
 	.llseek = generic_file_llseek,
 };
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 4781314c251094..4809fb4203aadf 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1598,7 +1598,7 @@ static int sel_open_avc_cache_stats(struct inode *inode, struct file *file)
 
 static const struct file_operations sel_avc_cache_stats_ops = {
 	.open		= sel_open_avc_cache_stats,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index c21b656b32631e..02d48f363f0570 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -671,7 +671,7 @@ static ssize_t smk_write_load(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_load_ops = {
 	.open           = smk_open_load,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek         = seq_lseek,
 	.write		= smk_write_load,
 	.release        = seq_release,
@@ -944,7 +944,7 @@ static ssize_t smk_write_cipso(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_cipso_ops = {
 	.open           = smk_open_cipso,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek         = seq_lseek,
 	.write		= smk_write_cipso,
 	.release        = seq_release,
@@ -1018,7 +1018,7 @@ static ssize_t smk_write_cipso2(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_cipso2_ops = {
 	.open           = smk_open_cipso2,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek         = seq_lseek,
 	.write		= smk_write_cipso2,
 	.release        = seq_release,
@@ -1283,7 +1283,7 @@ static ssize_t smk_write_net4addr(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_net4addr_ops = {
 	.open           = smk_open_net4addr,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek         = seq_lseek,
 	.write		= smk_write_net4addr,
 	.release        = seq_release,
@@ -1540,7 +1540,7 @@ static ssize_t smk_write_net6addr(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_net6addr_ops = {
 	.open           = smk_open_net6addr,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek         = seq_lseek,
 	.write		= smk_write_net6addr,
 	.release        = seq_release,
@@ -2028,7 +2028,7 @@ static ssize_t smk_write_onlycap(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_onlycap_ops = {
 	.open		= smk_open_onlycap,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.write		= smk_write_onlycap,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
@@ -2252,7 +2252,7 @@ static ssize_t smk_write_load_self(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_load_self_ops = {
 	.open           = smk_open_load_self,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek         = seq_lseek,
 	.write		= smk_write_load_self,
 	.release        = seq_release,
@@ -2386,7 +2386,7 @@ static ssize_t smk_write_load2(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_load2_ops = {
 	.open           = smk_open_load2,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek         = seq_lseek,
 	.write		= smk_write_load2,
 	.release        = seq_release,
@@ -2459,7 +2459,7 @@ static ssize_t smk_write_load_self2(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_load_self2_ops = {
 	.open           = smk_open_load_self2,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek         = seq_lseek,
 	.write		= smk_write_load_self2,
 	.release        = seq_release,
@@ -2756,7 +2756,7 @@ static ssize_t smk_write_relabel_self(struct file *file, const char __user *buf,
 
 static const struct file_operations smk_relabel_self_ops = {
 	.open		= smk_open_relabel_self,
-	.read		= seq_read,
+	.read_iter		= seq_read_iter,
 	.llseek		= seq_lseek,
 	.write		= smk_write_relabel_self,
 	.release	= seq_release,
-- 
2.26.2

