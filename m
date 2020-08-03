Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE532C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 376AA20A8B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7JhbGjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgHCTQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:16:59 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12584C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:16:59 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t11so1541562plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=K3xR+Mjlmw7VJ1KlSnnnRlCZomuqPP6T/oWBeSA7i0s=;
        b=H7JhbGjdQX4JAAykRvrrY28GwxUGNrtEs+2zRVtE2ISJ9NvhHowtQchtf/eLI1qQlG
         /0aVphDpwKWqpykGZmkHwuE8IXwm8UN+pDOaz+1k8X+vumiu1wnbY6nxXwRb2jiFVJ3f
         JeunzMi2fjfTyk0CyULdS/70ut6mO/A45Ahd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=K3xR+Mjlmw7VJ1KlSnnnRlCZomuqPP6T/oWBeSA7i0s=;
        b=nKMfjuKJKeVQklxzrTZeJ8V4iQEYSblQN/trBE77H3399aTzx04Tc+7FLUWSoLpGPh
         sBH4Ll1417yVYcoyuPKL2rEVlt3qxO3s5qDPrZjOKjB1VQb5SR+4JPgAJH1qsYf6XvXk
         7GGF9+PhYRoyCZzqnSzHs8jhT+dTY0Z7rKciqkJdf84gZ2fJa55NebyyBpIiHbBWLqNt
         2IbDwfHyYXrCSmBR3BCldVXTkfcD1CZj7xowJmmISkqmE7Qa/yHhT0n5qTAEEszZHBSS
         Sb7WZHm4s0+UpHqVb8TaD6R71m39ZFlsako/lu45wevDog+tEjXVl/Thhc5I2IpiNbbC
         Q6TQ==
X-Gm-Message-State: AOAM533O2impJz4JlKy2qRoV36kSZtEztIISOFMTg8QDy44+iVcVi909
        /Z1QGHLeGPdgQUOioKPk5h4NIA==
X-Google-Smtp-Source: ABdhPJw5uofMAr+Zqq1y8zXtojIXjy5K5mprswhWnmC4cw7fFKxCD/J2d3VWZLL9oRbHs9eLYcV1MA==
X-Received: by 2002:a17:90a:bd0e:: with SMTP id y14mr753168pjr.13.1596482218518;
        Mon, 03 Aug 2020 12:16:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j11sm20330067pfn.38.2020.08.03.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 12:16:57 -0700 (PDT)
Date:   Mon, 3 Aug 2020 12:16:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Bart van Assche <bvanassche@acm.org>,
        Chao Yu <yuchao0@huawei.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jason Yan <yanaijie@huawei.com>, Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [GIT PULL] Remove uninitialized_var() for v5.9-rc1
Message-ID: <202008031209.CB5CC23@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this uninitialized_var() macro removal series for v5.9-rc1.
This is long overdue, and has hidden too many bugs over the years. The
series has several "by hand" fixes, and then a trivial treewide
replacement. As you might imagine, this had a few conflicts while
living in -next. Resolution is easy, of course: just remove any
uninitialize_var() wrappings, but if you want to see the specifics,
they are:

kernel/debug/kdb/kdb_io.c
https://lore.kernel.org/linux-next/20200629154305.0067d113@canb.auug.org.au/

drivers/gpu/drm/drm_edid.c
https://lore.kernel.org/linux-next/20200703143550.7ebbe771@canb.auug.org.au/

net/ipv6/ip6_flowlabel.c
https://lore.kernel.org/linux-next/20200727192721.53af345a@canb.auug.org.au/

drivers/infiniband/core/uverbs_cmd.c
https://lore.kernel.org/linux-next/20200728184520.5634a0a0@canb.auug.org.au/

If you prefer, I can rebase and re-run my script, but your default
position has been to let you deal with conflicts, so here we are. :)

Thanks!

-Kees

The following changes since commit 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68:

  Linux 5.8-rc3 (2020-06-28 15:00:24 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/uninit-macro-v5.9-rc1

for you to fetch changes up to 63a0895d960aa3d3653ef0ecad5bd8579388f14b:

  compiler: Remove uninitialized_var() macro (2020-07-16 12:35:31 -0700)

----------------------------------------------------------------
Remove uninitialized_var() macro for v5.9-rc1

- Clean up non-trivial uses of uninitialized_var()
- Update documentation and checkpatch for uninitialized_var() removal
- Treewide removal of uninitialized_var()

----------------------------------------------------------------
Jason Yan (1):
      f2fs: Eliminate usage of uninitialized_var() macro

Kees Cook (15):
      docs: deprecated.rst: Add uninitialized_var()
      x86/mm/numa: Remove uninitialized_var() usage
      drbd: Remove uninitialized_var() usage
      b43: Remove uninitialized_var() usage
      rtlwifi: rtl8192cu: Remove uninitialized_var() usage
      ide: Remove uninitialized_var() usage
      spi: davinci: Remove uninitialized_var() usage
      clk: st: Remove uninitialized_var() usage
      clk: spear: Remove uninitialized_var() usage
      KVM: PPC: Book3S PR: Remove uninitialized_var() usage
      media: sur40: Remove uninitialized_var() usage
      mm/debug_vm_pgtable: Remove uninitialized_var() usage
      checkpatch: Remove awareness of uninitialized_var() macro
      treewide: Remove uninitialized_var() usage
      compiler: Remove uninitialized_var() macro

 Documentation/process/deprecated.rst                | 18 ++++++++++++++++++
 arch/arm/mach-sa1100/assabet.c                      |  2 +-
 arch/arm/mm/alignment.c                             |  2 +-
 arch/ia64/kernel/process.c                          |  2 +-
 arch/ia64/mm/discontig.c                            |  2 +-
 arch/ia64/mm/tlb.c                                  |  2 +-
 arch/mips/lib/dump_tlb.c                            |  2 +-
 arch/mips/mm/init.c                                 |  2 +-
 arch/mips/mm/tlb-r4k.c                              |  6 +++---
 arch/powerpc/kvm/book3s_64_mmu_radix.c              |  2 +-
 arch/powerpc/kvm/book3s_pr.c                        |  3 ---
 arch/powerpc/kvm/powerpc.c                          |  2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pic.c           |  2 +-
 arch/s390/kernel/smp.c                              |  2 +-
 arch/x86/kernel/quirks.c                            | 10 +++++-----
 arch/x86/kvm/mmu/mmu.c                              |  2 +-
 arch/x86/kvm/mmu/paging_tmpl.h                      |  2 +-
 arch/x86/kvm/x86.c                                  |  2 +-
 arch/x86/mm/numa.c                                  | 18 +++++++++---------
 block/blk-merge.c                                   |  2 +-
 drivers/acpi/acpi_pad.c                             |  2 +-
 drivers/ata/libata-scsi.c                           |  2 +-
 drivers/atm/zatm.c                                  |  2 +-
 drivers/block/drbd/drbd_nl.c                        |  6 +++---
 drivers/block/drbd/drbd_state.c                     |  2 +-
 drivers/block/rbd.c                                 |  2 +-
 drivers/clk/clk-gate.c                              |  2 +-
 drivers/clk/spear/clk-vco-pll.c                     |  2 +-
 drivers/clk/st/clkgen-fsyn.c                        |  1 -
 drivers/firewire/ohci.c                             | 14 +++++++-------
 drivers/gpu/drm/bridge/sil-sii8620.c                |  2 +-
 drivers/gpu/drm/drm_edid.c                          |  2 +-
 drivers/gpu/drm/exynos/exynos_drm_dsi.c             |  6 +++---
 drivers/gpu/drm/i915/display/intel_fbc.c            |  2 +-
 drivers/gpu/drm/i915/gt/intel_lrc.c                 |  2 +-
 drivers/gpu/drm/i915/intel_uncore.c                 |  2 +-
 drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c     |  4 ++--
 drivers/i2c/busses/i2c-rk3x.c                       |  2 +-
 drivers/ide/ide-acpi.c                              |  2 +-
 drivers/ide/ide-atapi.c                             |  2 +-
 drivers/ide/ide-io-std.c                            |  4 ++--
 drivers/ide/ide-io.c                                |  8 ++++----
 drivers/ide/ide-sysfs.c                             |  2 +-
 drivers/ide/ide-taskfile.c                          |  1 -
 drivers/ide/umc8672.c                               |  2 +-
 drivers/idle/intel_idle.c                           |  2 +-
 drivers/infiniband/core/uverbs_cmd.c                |  4 ++--
 drivers/infiniband/hw/cxgb4/cm.c                    |  2 +-
 drivers/infiniband/hw/cxgb4/cq.c                    |  2 +-
 drivers/infiniband/hw/mlx4/qp.c                     |  6 +++---
 drivers/infiniband/hw/mlx5/cq.c                     |  6 +++---
 drivers/infiniband/hw/mlx5/devx.c                   |  2 +-
 drivers/infiniband/hw/mlx5/wr.c                     |  2 +-
 drivers/infiniband/hw/mthca/mthca_qp.c              | 10 +++++-----
 drivers/infiniband/sw/siw/siw_qp_rx.c               |  2 +-
 drivers/input/serio/serio_raw.c                     |  2 +-
 drivers/input/touchscreen/sur40.c                   |  4 +---
 drivers/iommu/intel/iommu.c                         |  2 +-
 drivers/md/dm-io.c                                  |  2 +-
 drivers/md/dm-ioctl.c                               |  2 +-
 drivers/md/dm-snap-persistent.c                     |  2 +-
 drivers/md/dm-table.c                               |  2 +-
 drivers/md/dm-writecache.c                          |  2 +-
 drivers/md/raid5.c                                  |  2 +-
 drivers/media/dvb-frontends/rtl2832.c               |  2 +-
 drivers/media/tuners/qt1010.c                       |  4 ++--
 drivers/media/usb/gspca/vicam.c                     |  2 +-
 drivers/media/usb/uvc/uvc_video.c                   |  8 ++++----
 drivers/memstick/host/jmb38x_ms.c                   |  2 +-
 drivers/memstick/host/tifm_ms.c                     |  2 +-
 drivers/mmc/host/sdhci.c                            |  2 +-
 drivers/mtd/nand/raw/nand_ecc.c                     |  2 +-
 drivers/mtd/nand/raw/s3c2410.c                      |  2 +-
 drivers/mtd/parsers/afs.c                           |  4 ++--
 drivers/mtd/ubi/eba.c                               |  2 +-
 drivers/net/can/janz-ican3.c                        |  2 +-
 drivers/net/ethernet/broadcom/bnx2.c                |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c |  4 ++--
 drivers/net/ethernet/neterion/s2io.c                |  2 +-
 drivers/net/ethernet/qlogic/qla3xxx.c               |  2 +-
 drivers/net/ethernet/sun/cassini.c                  |  2 +-
 drivers/net/ethernet/sun/niu.c                      |  6 +++---
 drivers/net/wan/z85230.c                            |  2 +-
 drivers/net/wireless/ath/ath10k/core.c              |  2 +-
 drivers/net/wireless/ath/ath6kl/init.c              |  2 +-
 drivers/net/wireless/ath/ath9k/init.c               |  2 +-
 drivers/net/wireless/broadcom/b43/debugfs.c         |  2 +-
 drivers/net/wireless/broadcom/b43/dma.c             |  2 +-
 drivers/net/wireless/broadcom/b43/lo.c              |  2 +-
 drivers/net/wireless/broadcom/b43/phy_n.c           |  4 ++--
 drivers/net/wireless/broadcom/b43/xmit.c            | 12 ++++++------
 drivers/net/wireless/broadcom/b43legacy/debugfs.c   |  2 +-
 drivers/net/wireless/broadcom/b43legacy/main.c      |  2 +-
 drivers/net/wireless/intel/iwlegacy/3945.c          |  2 +-
 drivers/net/wireless/intel/iwlegacy/4965-mac.c      |  2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/hw.c |  8 ++++----
 drivers/pci/pcie/aer.c                              |  2 +-
 drivers/platform/x86/hdaps.c                        |  4 ++--
 drivers/scsi/dc395x.c                               |  2 +-
 drivers/scsi/pm8001/pm8001_hwi.c                    |  2 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                    |  2 +-
 drivers/spi/spi-davinci.c                           |  1 -
 drivers/ssb/driver_chipcommon.c                     |  4 ++--
 drivers/tty/cyclades.c                              |  2 +-
 drivers/tty/isicom.c                                |  2 +-
 drivers/usb/musb/cppi_dma.c                         |  2 +-
 drivers/usb/storage/sddr55.c                        |  4 ++--
 drivers/vhost/net.c                                 |  6 +++---
 drivers/video/fbdev/matrox/matroxfb_maven.c         |  6 +++---
 drivers/video/fbdev/pm3fb.c                         |  6 +++---
 drivers/video/fbdev/riva/riva_hw.c                  |  3 +--
 drivers/virtio/virtio_ring.c                        |  6 +++---
 fs/afs/dir.c                                        |  2 +-
 fs/afs/security.c                                   |  2 +-
 fs/dlm/netlink.c                                    |  2 +-
 fs/erofs/data.c                                     |  4 ++--
 fs/erofs/zdata.c                                    |  2 +-
 fs/f2fs/data.c                                      |  4 +---
 fs/fat/dir.c                                        |  2 +-
 fs/fuse/control.c                                   |  4 ++--
 fs/fuse/cuse.c                                      |  2 +-
 fs/fuse/file.c                                      |  2 +-
 fs/gfs2/aops.c                                      |  2 +-
 fs/gfs2/bmap.c                                      |  2 +-
 fs/gfs2/lops.c                                      |  2 +-
 fs/hfsplus/unicode.c                                |  2 +-
 fs/isofs/namei.c                                    |  4 ++--
 fs/jffs2/erase.c                                    |  2 +-
 fs/nfsd/nfsctl.c                                    |  2 +-
 fs/ocfs2/alloc.c                                    |  4 ++--
 fs/ocfs2/dir.c                                      | 14 +++++++-------
 fs/ocfs2/extent_map.c                               |  4 ++--
 fs/ocfs2/namei.c                                    |  2 +-
 fs/ocfs2/refcounttree.c                             |  2 +-
 fs/ocfs2/xattr.c                                    |  2 +-
 fs/omfs/file.c                                      |  2 +-
 fs/overlayfs/copy_up.c                              |  2 +-
 fs/ubifs/commit.c                                   |  6 +++---
 fs/ubifs/dir.c                                      |  2 +-
 fs/ubifs/file.c                                     |  4 ++--
 fs/ubifs/journal.c                                  |  4 ++--
 fs/ubifs/lpt.c                                      |  2 +-
 fs/ubifs/tnc.c                                      |  6 +++---
 fs/ubifs/tnc_misc.c                                 |  4 ++--
 fs/udf/balloc.c                                     |  2 +-
 fs/xfs/xfs_bmap_util.c                              |  2 +-
 include/linux/compiler-clang.h                      |  2 --
 include/linux/compiler-gcc.h                        |  6 ------
 include/linux/page-flags-layout.h                   |  4 +++-
 include/net/flow_offload.h                          |  2 +-
 kernel/async.c                                      |  4 ++--
 kernel/audit.c                                      |  2 +-
 kernel/debug/kdb/kdb_io.c                           |  2 +-
 kernel/dma/debug.c                                  |  2 +-
 kernel/events/core.c                                |  2 +-
 kernel/events/uprobes.c                             |  2 +-
 kernel/exit.c                                       |  2 +-
 kernel/futex.c                                      | 14 +++++++-------
 kernel/locking/lockdep.c                            | 16 ++++++++--------
 kernel/trace/ring_buffer.c                          |  2 +-
 lib/radix-tree.c                                    |  2 +-
 lib/test_lockup.c                                   |  2 +-
 mm/debug_vm_pgtable.c                               |  2 +-
 mm/frontswap.c                                      |  2 +-
 mm/ksm.c                                            |  2 +-
 mm/memcontrol.c                                     |  2 +-
 mm/memory.c                                         |  2 +-
 mm/mempolicy.c                                      |  4 ++--
 mm/page_alloc.c                                     |  2 +-
 mm/percpu.c                                         |  2 +-
 mm/slub.c                                           |  4 ++--
 mm/swap.c                                           |  4 ++--
 net/dccp/options.c                                  |  2 +-
 net/ipv4/netfilter/nf_socket_ipv4.c                 |  6 +++---
 net/ipv6/ip6_flowlabel.c                            |  2 +-
 net/ipv6/netfilter/nf_socket_ipv6.c                 |  2 +-
 net/netfilter/nf_conntrack_ftp.c                    |  2 +-
 net/netfilter/nfnetlink_log.c                       |  2 +-
 net/netfilter/nfnetlink_queue.c                     |  4 ++--
 net/sched/cls_flow.c                                |  2 +-
 net/sched/sch_cake.c                                |  2 +-
 net/sched/sch_cbq.c                                 |  2 +-
 net/sched/sch_fq_codel.c                            |  2 +-
 net/sched/sch_fq_pie.c                              |  2 +-
 net/sched/sch_hfsc.c                                |  2 +-
 net/sched/sch_htb.c                                 |  2 +-
 net/sched/sch_sfq.c                                 |  2 +-
 net/sunrpc/svcsock.c                                |  4 ++--
 net/sunrpc/xprtsock.c                               | 10 +++++-----
 net/tls/tls_sw.c                                    |  2 +-
 scripts/checkpatch.pl                               | 16 +++++-----------
 sound/core/control_compat.c                         |  2 +-
 sound/isa/sb/sb16_csp.c                             |  2 +-
 sound/usb/endpoint.c                                |  2 +-
 tools/include/linux/compiler.h                      |  2 --
 tools/virtio/linux/kernel.h                         |  2 --
 196 files changed, 321 insertions(+), 330 deletions(-)

-- 
Kees Cook
