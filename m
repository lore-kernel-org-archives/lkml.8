Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B53C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F5F920771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597334134;
	bh=f4VtwjKJr7WhsTI66Z2TOQQnMaQfTOJ9L1ZG29Tkjj0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=YURRIyAdDUod6SXUwOFQZxP1hrrMd3sGnxMXj4C1G421+lEGXOH6jvLDYEkG/MvNe
	 JadTGcU5u76NorI0pC6fwIt4KIA4AAGzCTIV5OXNXCz8cOB/VfuZ/Lh1pOYnQILiAa
	 iF54lhez8Q5E1ynB1wXV4QILu3U3OkoyEsTl5hOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHMPzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:55:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726131AbgHMPzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:55:31 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A63AB20771;
        Thu, 13 Aug 2020 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597334129;
        bh=f4VtwjKJr7WhsTI66Z2TOQQnMaQfTOJ9L1ZG29Tkjj0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=1agIIfmslQV3/n11Q32ZeIz+KiXpg+0gpYNfrRfeNAJNcdfTwYObEx0mWRpHdpxvD
         nKcWS1AbnlRC30MBd4RCh2JCbYEnpXfYVYfmi6cW/qFtZkxoBPqpcizrImVG1zG8Sz
         6vazImklhVZG5XSVs2fM/BPdoo7FUshoLM+or5h4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 61745352279C; Thu, 13 Aug 2020 08:55:29 -0700 (PDT)
Date:   Thu, 13 Aug 2020 08:55:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.08.11a 110/112] ERROR: modpost:
 "rcu_read_unlock_strict" undefined!
Message-ID: <20200813155529.GU4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202008131232.tDOTOabp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008131232.tDOTOabp%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 12:17:34PM +0800, kernel test robot wrote:
> Hi Paul,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.08.11a
> head:   9030fc13639a71b15466520f09ca07b80fc30ed1
> commit: 601cd69fa4bb0127bb774cc852203fd9fdf5e269 [110/112] rcuperf: Change rcuperf to rcuscale
> config: riscv-allmodconfig (attached as .config)
> compiler: riscv64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 601cd69fa4bb0127bb774cc852203fd9fdf5e269
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):

Good catch, forgot the EXPORT_SYMBOL_GPL(), will fix, thank you!

							Thanx, Paul

> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/intel/iwlegacy/iwl4965.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/intel/iwlegacy/iwlegacy.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/ath/ath11k/ath11k.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/ath/wcn36xx/wcn36xx.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/ath/ath10k/ath10k_core.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/ath/carl9170/carl9170.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/ath/ath9k/ath9k_htc.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/ath/ath9k/ath9k_hw.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wireless/ath/ath9k/ath9k.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wan/lapbether.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/wan/hdlc_cisco.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/hamradio/bpqether.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/via/via-velocity.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/ti/ti_cpsw_new.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/ti/ti_cpsw.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/socionext/netsec.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/sfc/sfc.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/qlogic/qede/qede.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/qlogic/netxen/netxen_nic.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/qlogic/qlcnic/qlcnic.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/netronome/nfp/nfp.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/mscc/mscc_ocelot_common.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_spectrum.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/mellanox/mlxsw/mlxsw_core.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/mellanox/mlx4/mlx4_en.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/mellanox/mlx4/mlx4_core.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/marvell/mvneta.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/intel/ice/ice.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/intel/fm10k/fm10k.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/intel/iavf/iavf.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/intel/i40e/i40e.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/intel/ixgbevf/ixgbevf.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/intel/ixgbe/ixgbe.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/intel/igc/igc.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/intel/igb/igb.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/chelsio/cxgb4/cxgb4.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/chelsio/cxgb3/cxgb3.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/cavium/thunder/nicvf.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/broadcom/bnxt/bnxt_en.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/broadcom/bnx2x/bnx2x.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/broadcom/cnic.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/broadcom/bnx2.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/net/ethernet/amazon/ena/ena.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/nvme/target/nvmet.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/cxgbi/cxgb3i/cxgb3i.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/cxgbi/libcxgbi.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/qedf/qedf.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/bnx2fc/bnx2fc.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/fcoe/fcoe.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/libfc/libfc.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/scsi_mod.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/device_handler/scsi_dh_alua.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/scsi/device_handler/scsi_dh_rdac.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/dma-buf/dmabuf_selftests.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/mfd/dln2.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/block/drbd/drbd.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/block/loop.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/block/brd.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/block/rnbd/rnbd-server.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/gpu/drm/panfrost/panfrost.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/gpu/drm/etnaviv/etnaviv.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/gpu/drm/qxl/qxl.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/gpu/drm/nouveau/nouveau.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/gpu/drm/ttm/ttm.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/gpu/drm/drm.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/gpu/drm/drm_kms_helper.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/dma/plx_dma.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/dma/sh/shdma.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [drivers/char/ipmi/ipmi_msghandler.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [lib/objagg.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [lib/crc-t10dif.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [lib/test_lockup.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [lib/test_meminit.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [lib/test_xarray.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [lib/test_rhashtable.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [lib/math/prime_numbers.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [block/bfq.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [crypto/af_alg.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/erofs/erofs.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/ceph/ceph.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/gfs2/gfs2.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/btrfs/btrfs.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/afs/kafs.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/xfs/xfs.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/fuse/fuse.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/autofs/autofs4.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/cifs/cifs.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/lockd/lockd.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/nfsd/nfsd.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/nfs/flexfilelayout/nfs_layout_flexfiles.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/nfs/blocklayout/blocklayoutdriver.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/nfs/nfsv4.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/nfs/nfs.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/jbd2/jbd2.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/ext4/ext4.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/fscache/fscache.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [fs/nfs_common/grace.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [kernel/rcu/refscale.ko] undefined!
> >> ERROR: modpost: "rcu_read_unlock_strict" [kernel/rcu/rcuscale.ko] undefined!
> ERROR: modpost: "rcu_read_unlock_strict" [kernel/rcu/rcutorture.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


