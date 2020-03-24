Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD379C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5E120663
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 05:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgCXFer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 01:34:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:45958 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgCXFer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 01:34:47 -0400
IronPort-SDR: MwbFUU9oyzByf9aK9l7lZH/wdHiqTH23qMD/rEzXIpHMpI0GmzjIVzE3GXYZ6womaJaCHO7kVJ
 0ZfQVj7FYLwQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 22:34:44 -0700
IronPort-SDR: az3VAoNkyg5tDFINbNT+v1wM3IKCupKpvdwVT8ndNpHUOlzLdwJveHyjJUM3Zlg4liA8/NYCZ8
 +Kj3C1OfXcbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,299,1580803200"; 
   d="gz'50?scan'50,208,50";a="265025002"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 23 Mar 2020 22:34:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jGcD3-000DFG-04; Tue, 24 Mar 2020 13:34:40 +0800
Date:   Tue, 24 Mar 2020 13:34:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: include/linux/virtio_config.h:223: undefined reference to
 `scsi_scan_host'
Message-ID: <202003241348.b3jxxaF7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   979e52ca0469fb38646bc51d26a0263a740c9f03
commit: 759bdc168181abeff61399d0f7ecec2852cc3e61 RISC-V: Add kconfig option for QEMU virt machine
date:   3 weeks ago
config: riscv-randconfig-a001-20200324 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 759bdc168181abeff61399d0f7ecec2852cc3e61
        # save the attached .config to linux build tree
        GCC_VERSION=9.2.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv32-linux-ld: drivers/virtio/virtio_balloon.o: in function `leak_balloon':
   drivers/virtio/virtio_balloon.c:250: undefined reference to `balloon_page_dequeue'
   riscv32-linux-ld: drivers/virtio/virtio_balloon.o: in function `towards_target':
   drivers/virtio/virtio_balloon.c:362: undefined reference to `balloon_page_alloc'
   riscv32-linux-ld: drivers/virtio/virtio_balloon.o: in function `fill_balloon':
   drivers/virtio/virtio_balloon.c:187: undefined reference to `balloon_page_enqueue'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o: in function `virtio_gpu_remove':
   drivers/gpu/drm/virtio/virtgpu_drv.c:138: undefined reference to `drm_dev_unregister'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.c:140: undefined reference to `drm_dev_put'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o: in function `virtio_gpu_probe':
   drivers/gpu/drm/virtio/virtgpu_drv.c:107: undefined reference to `drm_dev_alloc'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.c:118: undefined reference to `drm_dev_put'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.c:132: undefined reference to `drm_dev_register'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o: in function `virtio_gpu_pci_quirk':
   drivers/gpu/drm/virtio/virtgpu_drv.c:92: undefined reference to `drm_dev_set_unique'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o: in function `.LANCHOR0':
   virtgpu_drv.c:(.data+0xdc): undefined reference to `drm_gem_prime_handle_to_fd'
   riscv32-linux-ld: virtgpu_drv.c:(.data+0xe0): undefined reference to `drm_gem_prime_fd_to_handle'
   riscv32-linux-ld: virtgpu_drv.c:(.data+0x104): undefined reference to `drm_gem_prime_mmap'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o:(.rodata+0x8): undefined reference to `drm_read'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o:(.rodata+0x24): undefined reference to `drm_poll'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o:(.rodata+0x28): undefined reference to `drm_ioctl'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o:(.rodata+0x30): undefined reference to `drm_gem_mmap'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o:(.rodata+0x38): undefined reference to `drm_open'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_drv.o:(.rodata+0x40): undefined reference to `drm_release'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_change_queue_depth':
   drivers/scsi/virtio_scsi.c:677: undefined reference to `scsi_change_queue_depth'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_device_reset':
   drivers/scsi/virtio_scsi.c:623: undefined reference to `sdev_prefix_printk'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.c:630: undefined reference to `scsi_remove_host'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtio_scsi_host':
   drivers/scsi/virtio_scsi.c:94: undefined reference to `scsi_host_put'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_complete_cmd':
   drivers/scsi/virtio_scsi.c:119: undefined reference to `scmd_printk'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtio_scsi_host':
   drivers/scsi/virtio_scsi.c:94: undefined reference to `scsi_device_lookup'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_handle_param_change':
   drivers/scsi/virtio_scsi.c:311: undefined reference to `scsi_device_put'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_handle_transport_reset':
   drivers/scsi/virtio_scsi.c:285: undefined reference to `scsi_device_lookup'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.c:285: undefined reference to `scsi_remove_device'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.c:285: undefined reference to `scsi_device_put'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_handle_event':
   drivers/scsi/virtio_scsi.c:368: undefined reference to `__scsi_iterate_devices'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_rescan_hotunplug':
   drivers/scsi/virtio_scsi.c:340: undefined reference to `__scsi_execute'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `scsi_execute_req':
   include/scsi/scsi_device.h:455: undefined reference to `__scsi_iterate_devices'
   riscv32-linux-ld: include/scsi/scsi_device.h:455: undefined reference to `scsi_remove_device'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_rescan_hotunplug':
   drivers/scsi/virtio_scsi.c:350: undefined reference to `__scsi_iterate_devices'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.c:338: undefined reference to `scsi_scan_host'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_handle_event':
   drivers/scsi/virtio_scsi.c:371: undefined reference to `scsi_add_device'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.c:371: undefined reference to `scsi_rescan_device'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_queuecommand':
   drivers/scsi/virtio_scsi.c:588: undefined reference to `scmd_printk'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtscsi_probe':
   drivers/scsi/virtio_scsi.c:850: undefined reference to `scsi_host_alloc'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtio_find_vqs':
   include/linux/virtio_config.h:197: undefined reference to `scsi_host_put'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtio_cread32':
   include/linux/virtio_config.h:423: undefined reference to `scsi_add_host_with_dma'
   riscv32-linux-ld: drivers/scsi/virtio_scsi.o: in function `virtio_device_ready':
>> include/linux/virtio_config.h:223: undefined reference to `scsi_scan_host'
   riscv32-linux-ld: drivers/crypto/virtio/virtio_crypto_core.o: in function `virtcrypto_clear_crypto_engines':
   drivers/crypto/virtio/virtio_crypto_core.c:273: undefined reference to `crypto_engine_exit'
   riscv32-linux-ld: drivers/crypto/virtio/virtio_crypto_core.o: in function `virtcrypto_find_vqs':
   drivers/crypto/virtio/virtio_crypto_core.c:94: undefined reference to `crypto_engine_alloc_init'
   riscv32-linux-ld: drivers/crypto/virtio/virtio_crypto_core.o: in function `virtqueue_set_affinity':
   include/linux/virtio_config.h:249: undefined reference to `crypto_engine_start'
   riscv32-linux-ld: drivers/crypto/virtio/virtio_crypto_core.o: in function `virtcrypto_probe':
   drivers/crypto/virtio/virtio_crypto_core.c:412: undefined reference to `crypto_engine_exit'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_kms.o: in function `virtio_gpu_config_changed_work_func':
   drivers/gpu/drm/virtio/virtgpu_kms.c:47: undefined reference to `drm_helper_hpd_irq_event'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_kms.o: in function `virtio_find_vqs':
   include/linux/virtio_config.h:197: undefined reference to `__drm_err'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_kms.o: in function `virtio_gpu_init':
   drivers/gpu/drm/virtio/virtgpu_kms.c:173: undefined reference to `__drm_err'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_kms.c:183: undefined reference to `__drm_err'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_kms.o: in function `kmalloc_array':
   include/linux/slab.h:593: undefined reference to `__drm_err'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_kms.o: in function `virtio_gpu_init':
   drivers/gpu/drm/virtio/virtgpu_kms.c:206: undefined reference to `__drm_err'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.o: in function `virtio_gpu_gem_create':
   drivers/gpu/drm/virtio/virtgpu_gem.c:46: undefined reference to `drm_gem_handle_create'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.c:52: undefined reference to `drm_gem_object_put_unlocked'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.c:59: undefined reference to `drm_gem_object_release'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.o: in function `virtio_gpu_mode_dumb_mmap':
   drivers/gpu/drm/virtio/virtgpu_gem.c:97: undefined reference to `drm_gem_object_lookup'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.o: in function `drm_vma_node_offset_addr':
   include/drm/drm_vma_manager.h:204: undefined reference to `drm_gem_object_put_unlocked'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.o: in function `virtio_gpu_array_lock_resv':
   drivers/gpu/drm/virtio/virtgpu_gem.c:201: undefined reference to `drm_gem_lock_reservations'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.o: in function `virtio_gpu_array_unlock_resv':
   drivers/gpu/drm/virtio/virtgpu_gem.c:221: undefined reference to `drm_gem_unlock_reservations'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.o: in function `virtio_gpu_array_put_free':
   drivers/gpu/drm/virtio/virtgpu_gem.c:233: undefined reference to `drm_gem_object_put_unlocked'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_gem.o: in function `virtio_gpu_array_from_handles':
   drivers/gpu/drm/virtio/virtgpu_gem.c:174: undefined reference to `drm_gem_object_lookup'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `vgdev_atomic_commit_tail':
   drivers/gpu/drm/virtio/virtgpu_display.c:331: undefined reference to `drm_atomic_helper_commit_modeset_disables'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:332: undefined reference to `drm_atomic_helper_commit_modeset_enables'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:333: undefined reference to `drm_atomic_helper_commit_planes'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:335: undefined reference to `drm_atomic_helper_commit_hw_done'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:337: undefined reference to `drm_atomic_helper_wait_for_vblanks'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:338: undefined reference to `drm_atomic_helper_cleanup_planes'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_conn_mode_valid':
   drivers/gpu/drm/virtio/virtgpu_display.c:206: undefined reference to `__drm_dbg'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_conn_get_modes':
   drivers/gpu/drm/virtio/virtgpu_display.c:163: undefined reference to `drm_add_edid_modes'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:170: undefined reference to `drm_add_modes_noedid'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:175: undefined reference to `drm_set_preferred_mode'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:177: undefined reference to `__drm_dbg'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:178: undefined reference to `drm_cvt_mode'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:181: undefined reference to `drm_mode_probed_add'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_conn_destroy':
   drivers/gpu/drm/virtio/virtgpu_display.c:236: undefined reference to `drm_connector_unregister'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:237: undefined reference to `drm_connector_cleanup'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_crtc_atomic_flush':
   drivers/gpu/drm/virtio/virtgpu_display.c:127: undefined reference to `drm_crtc_send_vblank_event'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_user_framebuffer_create':
   drivers/gpu/drm/virtio/virtgpu_display.c:309: undefined reference to `drm_gem_object_lookup'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_framebuffer_init':
   drivers/gpu/drm/virtio/virtgpu_display.c:75: undefined reference to `drm_helper_mode_fill_fb_struct'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:77: undefined reference to `drm_framebuffer_init'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_user_framebuffer_create':
   drivers/gpu/drm/virtio/virtgpu_display.c:319: undefined reference to `drm_gem_object_put_unlocked'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_modeset_init':
   drivers/gpu/drm/virtio/virtgpu_display.c:357: undefined reference to `drm_mode_config_init'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `vgdev_output_init':
   drivers/gpu/drm/virtio/virtgpu_display.c:285: undefined reference to `drm_encoder_init'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:290: undefined reference to `drm_connector_attach_encoder'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:290: undefined reference to `drm_connector_register'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:275: undefined reference to `drm_crtc_init_with_planes'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `drm_crtc_helper_add':
   include/drm/drm_modeset_helper_vtables.h:463: undefined reference to `drm_connector_init'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `drm_connector_helper_add':
   include/drm/drm_modeset_helper_vtables.h:1061: undefined reference to `drm_connector_attach_edid_property'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `vgdev_output_init':
   drivers/gpu/drm/virtio/virtgpu_display.c:283: undefined reference to `drm_mode_config_reset'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `virtio_gpu_modeset_fini':
   drivers/gpu/drm/virtio/virtgpu_display.c:377: undefined reference to `drm_atomic_helper_shutdown'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.c:378: undefined reference to `drm_mode_config_cleanup'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `.LANCHOR0':
   drivers/gpu/drm/virtio/virtgpu_display.c:59: undefined reference to `drm_gem_fb_destroy'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `.LANCHOR0':
   virtgpu_display.c:(.rodata+0x4): undefined reference to `drm_gem_fb_create_handle'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0x8): undefined reference to `drm_atomic_helper_dirtyfb'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0x1c): undefined reference to `drm_atomic_helper_check'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0x20): undefined reference to `drm_atomic_helper_commit'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `.LANCHOR0':
   drivers/gpu/drm/virtio/virtgpu_display.c:49: undefined reference to `drm_atomic_helper_crtc_reset'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_display.o: in function `.LANCHOR0':
   virtgpu_display.c:(.rodata+0x44): undefined reference to `drm_crtc_cleanup'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0x48): undefined reference to `drm_atomic_helper_set_config'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0x4c): undefined reference to `drm_atomic_helper_page_flip'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0x58): undefined reference to `drm_atomic_helper_crtc_duplicate_state'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0x5c): undefined reference to `drm_atomic_helper_crtc_destroy_state'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0xcc): undefined reference to `drm_atomic_helper_connector_reset'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0xd8): undefined reference to `drm_helper_probe_single_connector_modes'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0xec): undefined reference to `drm_atomic_helper_connector_duplicate_state'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0xf0): undefined reference to `drm_atomic_helper_connector_destroy_state'
   riscv32-linux-ld: virtgpu_display.c:(.rodata+0x128): undefined reference to `drm_encoder_cleanup'
   riscv32-linux-ld: drivers/gpu/drm/virtio/virtgpu_vq.o: in function `virtio_gpu_cmd_get_display_info_cb':

vim +223 include/linux/virtio_config.h

66846048f55c6c Rick Jones         2011-11-14  190  
9b2bbdb2275884 Michael S. Tsirkin 2017-03-06  191  static inline
9b2bbdb2275884 Michael S. Tsirkin 2017-03-06  192  int virtio_find_vqs(struct virtio_device *vdev, unsigned nvqs,
9b2bbdb2275884 Michael S. Tsirkin 2017-03-06  193  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
9b2bbdb2275884 Michael S. Tsirkin 2017-03-06  194  			const char * const names[],
9b2bbdb2275884 Michael S. Tsirkin 2017-03-06  195  			struct irq_affinity *desc)
9b2bbdb2275884 Michael S. Tsirkin 2017-03-06  196  {
f94682dde5ed23 Michael S. Tsirkin 2017-03-06 @197  	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, NULL, desc);
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  198  }
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  199  
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  200  static inline
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  201  int virtio_find_vqs_ctx(struct virtio_device *vdev, unsigned nvqs,
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  202  			struct virtqueue *vqs[], vq_callback_t *callbacks[],
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  203  			const char * const names[], const bool *ctx,
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  204  			struct irq_affinity *desc)
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  205  {
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  206  	return vdev->config->find_vqs(vdev, nvqs, vqs, callbacks, names, ctx,
f94682dde5ed23 Michael S. Tsirkin 2017-03-06  207  				      desc);
9b2bbdb2275884 Michael S. Tsirkin 2017-03-06  208  }
9b2bbdb2275884 Michael S. Tsirkin 2017-03-06  209  
3569db593081fd Michael S. Tsirkin 2014-10-15  210  /**
3569db593081fd Michael S. Tsirkin 2014-10-15  211   * virtio_device_ready - enable vq use in probe function
3569db593081fd Michael S. Tsirkin 2014-10-15  212   * @vdev: the device
3569db593081fd Michael S. Tsirkin 2014-10-15  213   *
3569db593081fd Michael S. Tsirkin 2014-10-15  214   * Driver must call this to use vqs in the probe function.
3569db593081fd Michael S. Tsirkin 2014-10-15  215   *
3569db593081fd Michael S. Tsirkin 2014-10-15  216   * Note: vqs are enabled automatically after probe returns.
3569db593081fd Michael S. Tsirkin 2014-10-15  217   */
3569db593081fd Michael S. Tsirkin 2014-10-15  218  static inline
3569db593081fd Michael S. Tsirkin 2014-10-15  219  void virtio_device_ready(struct virtio_device *dev)
3569db593081fd Michael S. Tsirkin 2014-10-15  220  {
3569db593081fd Michael S. Tsirkin 2014-10-15  221  	unsigned status = dev->config->get_status(dev);
3569db593081fd Michael S. Tsirkin 2014-10-15  222  
3569db593081fd Michael S. Tsirkin 2014-10-15 @223  	BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
3569db593081fd Michael S. Tsirkin 2014-10-15  224  	dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
3569db593081fd Michael S. Tsirkin 2014-10-15  225  }
3569db593081fd Michael S. Tsirkin 2014-10-15  226  

:::::: The code at line 223 was first introduced by commit
:::::: 3569db593081fd88bbd6df21b9b0531873f2042c virtio: add API to enable VQs early

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: Rusty Russell <rusty@rustcorp.com.au>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2oS5YaxWCcQjTEyO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2oS5YaxWCcQjTEyO--
