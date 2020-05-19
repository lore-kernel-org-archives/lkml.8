Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B618C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A272206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5vqsKtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgESNJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727057AbgESNJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:09:29 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852B2C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:09:28 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n18so3482208wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x/ybFaqWBVfeTanHhYGJIrbofn7odp4ejvThDZ0cb2E=;
        b=P5vqsKtq8uW+K9wo2e90huvEIiMfWyFeYyUnOYtULKKHEEDZJ6EDVrIEhtwOdgHMcr
         ZFhufhHK6IxPTSxWIMZ2gBwj6O5avR8uBzcFOnkfJwd5I84HM5Ak4yc7iWdWZfZppB6t
         ukLABuoDh9qWPNIwhhSa1P7YHm7ImXa7MQvE/Hdl4pZOrvLB1viEKYRhBIuV26Pk8Z23
         9XeObYjZxc8HgupqVT3z4CzslqTPJwvbW++dwE78m4Em1ARE/PDsXJv4PTIXYCCQwo46
         RjEbD9o0oWgr0mWdcBcRVFRIkBeYHdPPQUdlrLFUbb8wEMqqC1Ak8GbgGDVcIBD4gqVz
         7GYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x/ybFaqWBVfeTanHhYGJIrbofn7odp4ejvThDZ0cb2E=;
        b=kSNLQDntCHblE1l/tF6NO6FMSYmkgQbLMub5ZBwIPFGc2qseuhJnGLX1IEEEHF93Nk
         Ir5BNKFw9A7J8fxDxRjWQBetTk4nu9wlGFhWILfp6+9k+8DR31MKpIxt1uzKAfA+13fm
         KlbnvAIyGxuLkX95uhnDWq+vRinvEjxUQ6+/50omL2r+eeyrOp7vrjkbF4d40ZV/FkQ2
         J0uEHj2rgVuxwsJhrax207mEnFW4NPalNHIS8d1ycM4ds/hJJRiq6GOIUqGYH6fkn/xg
         6DOUcCs/xW/7E4Jj5ZmTAphwCUZ4pQTacVfLvDBuyfKFV31FlVFLnUVeC0V31Rjkj5dd
         Y8Xw==
X-Gm-Message-State: AOAM531AruTRhcIgbseLV88xApG8usTtw3uBUcwoCAnI4IG8XTWs78Ea
        LpiAkZLrf5TnzRiQeUfiFGiduGxI
X-Google-Smtp-Source: ABdhPJykMNK187enLKgnf5aY7W9y3OB84Bnf2b+UE3pm63lWGNSZ3+TtdPtxocXKNy9JVfcqqqIz/w==
X-Received: by 2002:a1c:6a12:: with SMTP id f18mr5403968wmc.134.1589893766928;
        Tue, 19 May 2020 06:09:26 -0700 (PDT)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id z12sm15432355wrq.7.2020.05.19.06.09.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 May 2020 06:09:25 -0700 (PDT)
Date:   Tue, 19 May 2020 16:09:24 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.8
Message-ID: <20200519130924.GA27366@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is the pull request for habanalabs driver for kernel 5.8.

This pull-request finally contains the code to handle the GAUDI ASIC. It
contains both minor changes to the common code of the driver and of course
the GAUDI-specific code, which is similar to the GOYA-specific code.

In addition, there is a new feature for command submission of signals and
wait for signals through the driver. And of course other improvements.

Please see the tag message for more details on what this pull request
contains.

Thanks,
Oded

The following changes since commit 57c76221d5af648c8355a55c09b050c5d8d38189:

  w1_therm: adding bulk read support to trigger multiple conversion on bus (2020-05-15 16:29:00 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-05-19

for you to fetch changes up to 87eaea1cf8b3357eed49fe93539788307bf8d971:

  habanalabs: update patched_cb_size for Wreg32 (2020-05-19 14:48:41 +0300)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.8:

- GAUDI ASIC support. The tag contains code and header files needed to
  initialize the GAUDI ASIC and run workloads on it. There are changes to
  the common code that are needed for GAUDI and there is the addition of
  new ASIC-dependent code of GAUDI.

- Add new feature of signal/wait command submissions. This is relevant to
  GAUDI only and allows the user to sync between streams (queues) inside
  the device.

- Allow user to retrieve the device time alongside the host time, to allow
  a user application to synchronize device time together with host
  time during profiling.

- Change ASIC's CPU initialization by loading its boot loader code from the
  Host memory (instead of it being programmed on the on-board FLASH).

- Expose more attributes through HWMON.

- Move the ASIC event handling code to be "common code". This will be
  shared between GAUDI and future ASICs. Goya will still use its own code.

- Fix bug in command submission parsing in Goya.

- Small fixes to security configuration (open up some registers for user
  access).

- Improvements to ASIC reset code.

----------------------------------------------------------------
Adam Aharon (1):
      habanalabs: enable trace data compression (profiler)

Christine Gharzuzi (1):
      habanalabs: support hwmon_reset_history attribute

Dotan Barak (1):
      habanalabs: print all CB handles as hex numbers

Oded Gabbay (17):
      habanalabs: don't wait for ASIC CPU after reset
      habanalabs: unify and improve device cpu init
      habanalabs: print warning when reset is requested
      habanalabs: increase timeout during reset
      habanalabs: update firmware definitions
      habanalabs: retrieve DMA mask indication from firmware
      habanalabs: handle barriers in DMA QMAN streams
      habanalabs: leave space for 2xMSG_PROT in CB
      habanalabs: update F/W register map
      habanalabs: add missing MODULE_DEVICE_TABLE
      habanalabs: set PM profile to auto only for goya
      habanalabs: support clock gating enable/disable
      habanalabs: add gaudi asic registers header files
      uapi: habanalabs: add gaudi defines
      habanalabs: add gaudi asic-dependent code
      habanalabs: add hwmgr module for gaudi
      habanalabs: enable gaudi code in driver

Ofir Bitton (2):
      habanalabs: load CPU device boot loader from host
      habanalabs: move event handling to common firmware file

Omer Shpigelman (11):
      habanalabs: remove stop-on-error flag from DMA
      habanalabs: re-factor H/W queues initialization
      uapi: habanalabs: add signal/wait operations
      habanalabs: define ASIC-dependent interface for signal/wait
      habanalabs: handle the h/w sync object
      habanalabs: add signal/wait to CS IOCTL operations
      habanalabs: check if CoreSight is supported
      habanalabs: add dedicated define for hard reset
      habanalabs: get card type, location from F/W
      habanalabs: add gaudi security module
      habanalabs: add gaudi profiler module

Rachel Stahl (1):
      habanalabs: update patched_cb_size for Wreg32

Tomer Tayar (3):
      habanalabs: Add INFO IOCTL opcode for time sync information
      habanalabs: Allow access to TPC LFSR register
      habanalabs: Align protection bits configuration of all TPCs

kbuild test robot (1):
      habanalabs: hl_pci_set_dma_mask() can be static

 .../ABI/testing/debugfs-driver-habanalabs          |   17 +
 Documentation/ABI/testing/sysfs-driver-habanalabs  |   17 +
 drivers/misc/habanalabs/Makefile                   |    3 +
 drivers/misc/habanalabs/command_buffer.c           |   28 +-
 drivers/misc/habanalabs/command_submission.c       |  384 +-
 drivers/misc/habanalabs/context.c                  |    8 -
 drivers/misc/habanalabs/debugfs.c                  |  116 +
 drivers/misc/habanalabs/device.c                   |   30 +-
 drivers/misc/habanalabs/firmware_if.c              |  297 +-
 drivers/misc/habanalabs/gaudi/Makefile             |    5 +
 drivers/misc/habanalabs/gaudi/gaudi.c              | 6726 +++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  261 +
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |  884 ++
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c        |  121 +
 drivers/misc/habanalabs/gaudi/gaudi_security.c     | 9090 ++++++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c                |  310 +-
 drivers/misc/habanalabs/goya/goyaP.h               |   12 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |    2 +-
 drivers/misc/habanalabs/goya/goya_security.c       |  100 +-
 drivers/misc/habanalabs/habanalabs.h               |  177 +-
 drivers/misc/habanalabs/habanalabs_drv.c           |   14 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c         |   21 +
 drivers/misc/habanalabs/hw_queue.c                 |  118 +-
 drivers/misc/habanalabs/hwmon.c                    |   75 +
 drivers/misc/habanalabs/include/armcp_if.h         |   43 +-
 .../include/gaudi/asic_reg/cpu_if_regs.h           |  174 +
 .../include/gaudi/asic_reg/dma0_core_masks.h       |  348 +
 .../include/gaudi/asic_reg/dma0_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma0_qm_masks.h         |  800 ++
 .../include/gaudi/asic_reg/dma0_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma1_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma1_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma2_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma2_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma3_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma3_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma4_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma4_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma5_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma5_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma6_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma6_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/dma7_core_regs.h        |  156 +
 .../include/gaudi/asic_reg/dma7_qm_regs.h          |  834 ++
 .../gaudi/asic_reg/dma_if_e_n_down_ch0_regs.h      |  896 ++
 .../gaudi/asic_reg/dma_if_e_n_down_ch1_regs.h      |  896 ++
 .../include/gaudi/asic_reg/dma_if_e_n_regs.h       |  860 ++
 .../gaudi/asic_reg/dma_if_e_s_down_ch0_regs.h      |  896 ++
 .../gaudi/asic_reg/dma_if_e_s_down_ch1_regs.h      |  896 ++
 .../include/gaudi/asic_reg/dma_if_e_s_regs.h       |  860 ++
 .../gaudi/asic_reg/dma_if_w_n_down_ch0_regs.h      |  896 ++
 .../gaudi/asic_reg/dma_if_w_n_down_ch1_regs.h      |  896 ++
 .../include/gaudi/asic_reg/dma_if_w_n_regs.h       |  860 ++
 .../gaudi/asic_reg/dma_if_w_s_down_ch0_regs.h      |  896 ++
 .../gaudi/asic_reg/dma_if_w_s_down_ch1_regs.h      |  896 ++
 .../include/gaudi/asic_reg/dma_if_w_s_regs.h       |  860 ++
 .../include/gaudi/asic_reg/gaudi_blocks.h          | 4974 +++++++++++
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |  299 +
 .../include/gaudi/asic_reg/mme0_ctrl_regs.h        | 1456 ++++
 .../include/gaudi/asic_reg/mme0_qm_masks.h         |  800 ++
 .../include/gaudi/asic_reg/mme0_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/mme1_ctrl_regs.h        | 1456 ++++
 .../include/gaudi/asic_reg/mme2_ctrl_regs.h        | 1456 ++++
 .../include/gaudi/asic_reg/mme2_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/mme3_ctrl_regs.h        | 1456 ++++
 .../include/gaudi/asic_reg/mmu_up_regs.h           |   72 +
 .../include/gaudi/asic_reg/nif_rtr_ctrl_0_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_1_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_2_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_3_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_4_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_5_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_6_regs.h   |  896 ++
 .../include/gaudi/asic_reg/nif_rtr_ctrl_7_regs.h   |  896 ++
 .../include/gaudi/asic_reg/psoc_etr_regs.h         |  114 +
 .../gaudi/asic_reg/psoc_global_conf_masks.h        |  502 ++
 .../include/gaudi/asic_reg/psoc_global_conf_regs.h | 1062 +++
 .../include/gaudi/asic_reg/psoc_hbm_pll_regs.h     |  114 +
 .../include/gaudi/asic_reg/psoc_pci_pll_regs.h     |  114 +
 .../include/gaudi/asic_reg/psoc_timestamp_regs.h   |   56 +
 .../include/gaudi/asic_reg/sif_rtr_ctrl_0_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_1_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_2_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_3_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_4_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_5_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_6_regs.h   |  896 ++
 .../include/gaudi/asic_reg/sif_rtr_ctrl_7_regs.h   |  896 ++
 .../habanalabs/include/gaudi/asic_reg/stlb_regs.h  |   82 +
 .../include/gaudi/asic_reg/tpc0_cfg_masks.h        | 2578 ++++++
 .../include/gaudi/asic_reg/tpc0_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc0_qm_masks.h         |  800 ++
 .../include/gaudi/asic_reg/tpc0_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc1_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc1_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc2_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc2_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc3_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc3_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc4_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc4_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc5_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc5_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc6_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc6_qm_regs.h          |  834 ++
 .../include/gaudi/asic_reg/tpc7_cfg_regs.h         | 1226 +++
 .../include/gaudi/asic_reg/tpc7_qm_regs.h          |  834 ++
 drivers/misc/habanalabs/include/gaudi/gaudi.h      |   59 +
 .../habanalabs/include/gaudi/gaudi_async_events.h  |  310 +
 .../include/gaudi/gaudi_async_ids_map_extended.h   |  694 ++
 .../habanalabs/include/gaudi/gaudi_coresight.h     |  367 +
 .../misc/habanalabs/include/gaudi/gaudi_fw_if.h    |   36 +
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |  458 +
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |  212 +
 .../misc/habanalabs/include/gaudi/gaudi_reg_map.h  |   27 +
 .../habanalabs/include/goya/asic_reg/goya_masks.h  |    3 +-
 .../habanalabs/include/goya/asic_reg/goya_regs.h   |    1 +
 .../include/goya/asic_reg/psoc_timestamp_regs.h    |   56 +
 .../misc/habanalabs/include/goya/goya_reg_map.h    |   43 +-
 drivers/misc/habanalabs/include/hl_boot_if.h       |   58 +-
 .../habanalabs/include/hw_ip/mmu/mmu_general.h     |    2 +-
 .../misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h   |   16 +
 drivers/misc/habanalabs/pci.c                      |   63 +-
 drivers/misc/habanalabs/sysfs.c                    |   12 +-
 include/uapi/misc/habanalabs.h                     |  245 +-
 125 files changed, 90875 insertions(+), 371 deletions(-)
 create mode 100644 drivers/misc/habanalabs/gaudi/Makefile
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudiP.h
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_coresight.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_security.c
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/cpu_if_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma0_core_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma0_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma1_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma1_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma2_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma3_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma3_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma4_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma4_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma5_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma5_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma6_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma6_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma7_core_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma7_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_n_down_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_n_down_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_n_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_s_down_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_s_down_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_e_s_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_n_down_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_n_down_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_n_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_s_down_ch0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_s_down_ch1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/dma_if_w_s_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_blocks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/gaudi_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme0_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme1_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme2_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mme3_ctrl_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/mmu_up_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_5_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_6_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nif_rtr_ctrl_7_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_etr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_global_conf_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_global_conf_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_hbm_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_pci_pll_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_timestamp_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_2_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_3_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_4_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_5_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_6_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/sif_rtr_ctrl_7_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/stlb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc0_cfg_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc0_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc0_qm_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc0_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc1_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc1_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc2_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc2_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc3_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc3_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc4_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc4_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc5_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc5_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc6_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc6_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc7_cfg_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/tpc7_qm_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_async_events.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map_extended.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_coresight.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
 create mode 100644 drivers/misc/habanalabs/include/goya/asic_reg/psoc_timestamp_regs.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h
