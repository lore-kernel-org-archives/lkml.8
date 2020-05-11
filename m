Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA47C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B6220735
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItN+48Jc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgEKLce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726068AbgEKLcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:32:33 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EA4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:33 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s8so10484672wrt.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=bRoIPhzywEMW2nC1PP+OH7tOtDfVH3W4Ay+XMph+/U4=;
        b=ItN+48Jca7pgHLGEyItSVjmO7lnHS93ruqgj8eMIfjY45HC423mVO0WVYMX/C3GKjR
         iH0zWg1QZCwJZN6O9tQysmWyizU+u1XQ7ocrZaDBzH04MM/hnQ6KsHiuwSvvJE5mqti/
         ziIdnUG1bY74huXvqa2hwaEfxkGBQFuNrnxMkRoMHsgFtQmSXHSIsOWjXu/UTtpCDIJr
         3FFZsKBahkr78b59ctqY9nCvOtId+KRZz5niYHFz9rqyd2bXX1cSUch0RYf8SJFRN7Jh
         yyQndvnmzR/Nft+aXxnmv2Fxw/37C+oNftMkOlwPd6XNweO+sZlwB7mhOB5qwh7GZlWL
         /Ccg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=bRoIPhzywEMW2nC1PP+OH7tOtDfVH3W4Ay+XMph+/U4=;
        b=g73TTW8GM0JjSXD5B83V5wzz9jF2y/LxRE9rWpw+VmnCLk2Kd+MXbl8ddjtur6jrgm
         iV4KXoJEN3YokQELMf/Cw7hLz7qL7pmHbjdR6K6K4xUKT5/EQut2K4R5inaChp6hlmWE
         Uv5bshfEWN0RL8WIUpAdmFINj6D2lo+CADYpBVZ1Dl3ld47KHBwxKtPN0JFPFv48llfQ
         9oO1u7MM12U5VIeIcT9GwSka6HhIcu3L0PVNogkWmKkZlIVq65qOrMk/iV7F6bBdHlLj
         8MWnfcO4kGR9zoFx0XhFPbmqY5Y68s5ZGKTZd0PmmrjFGshGDl8fKL6iOa8VGxA/wqnJ
         Up+Q==
X-Gm-Message-State: AGi0PuarptOmqI8Gluj4csc4s/i2cwCV3wappqvl1sErWTf7IUkCUtaK
        x38Z5AmS1zNCsSVJeR4o+GPBEKXu
X-Google-Smtp-Source: APiQypIWxNi/9RKhCjbyYL0Piqp5EiwN2r6VO/TUMTuLR1p2c0AaTNmvlyXF83oFI9eqeVsOgZ6jSQ==
X-Received: by 2002:a5d:56c6:: with SMTP id m6mr18206382wrw.78.1589196751145;
        Mon, 11 May 2020 04:32:31 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id u12sm27830595wmu.25.2020.05.11.04.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 04:32:30 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai, gregkh@linuxfoundation.org
Subject: [PATCH 00/11] Adding GAUDI ASIC support to habanalabs driver
Date:   Mon, 11 May 2020 14:32:21 +0300
Message-Id: <20200511113232.5771-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds support for initializing and sending workloads to
habanalabs deep-learning training accelerator ASIC, called GAUDI.

The GAUDI ASIC is based on the same architecture as the GOYA ASIC and
therefore, the driver's common code is applicable to it with only a few
changes. Almost all of the code included in this patch-set is the
ASIC-depedent code which is different per ASIC.

Similar to GOYA, GAUDI includes a set of eight TPC cores, a GEMM engine and
DMA channels to move data between host and different memories of the ASIC.
Each engine has a hardware queue manager (QMAN) attached to it, which
exposes 4 streams to allow complex programs with control flows (in
GOYA you had 1 stream per QMAN).

Patches 1-4 are changes to the common code that are needed for GAUDI. patch
5 adds the registers header files. patch 6 adds the GAUDI definitions to
the uapi file. patches 7-10 adds the GAUDI code itself and patch 11 enables
the GAUDI code in the driver.

Thanks,
Oded

Oded Gabbay (7):
  habanalabs: set PM profile to auto only for goya
  habanalabs: support clock gating enable/disable
  habanalabs: add gaudi asic registers header files
  uapi: habanalabs: add gaudi defines
  habanalabs: add gaudi asic-dependent code
  habanalabs: add hwmgr module for gaudi
  habanalabs: enable gaudi code in driver

Omer Shpigelman (4):
  habanalabs: add dedicated define for hard reset
  habanalabs: get card type, location from F/W
  habanalabs: add gaudi security module
  habanalabs: add gaudi profiler module

 .../ABI/testing/debugfs-driver-habanalabs     |   10 +
 .../ABI/testing/sysfs-driver-habanalabs       |   17 +
 drivers/misc/habanalabs/Makefile              |    3 +
 drivers/misc/habanalabs/debugfs.c             |   61 +
 drivers/misc/habanalabs/device.c              |   13 +-
 drivers/misc/habanalabs/gaudi/Makefile        |    5 +
 drivers/misc/habanalabs/gaudi/gaudi.c         | 7430 ++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudiP.h        |  259 +
 .../misc/habanalabs/gaudi/gaudi_coresight.c   |  885 ++
 drivers/misc/habanalabs/gaudi/gaudi_hwmgr.c   |  117 +
 .../misc/habanalabs/gaudi/gaudi_security.c    | 9114 +++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c           |   12 +
 drivers/misc/habanalabs/habanalabs.h          |   32 +-
 drivers/misc/habanalabs/habanalabs_drv.c      |   13 +-
 drivers/misc/habanalabs/habanalabs_ioctl.c    |    2 +
 drivers/misc/habanalabs/include/armcp_if.h    |   22 +-
 .../include/gaudi/asic_reg/cpu_if_regs.h      |  174 +
 .../include/gaudi/asic_reg/dma0_core_masks.h  |  348 +
 .../include/gaudi/asic_reg/dma0_core_regs.h   |  156 +
 .../include/gaudi/asic_reg/dma0_qm_masks.h    |  800 ++
 .../include/gaudi/asic_reg/dma0_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/dma1_core_regs.h   |  156 +
 .../include/gaudi/asic_reg/dma1_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/dma2_core_regs.h   |  156 +
 .../include/gaudi/asic_reg/dma2_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/dma3_core_regs.h   |  156 +
 .../include/gaudi/asic_reg/dma3_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/dma4_core_regs.h   |  156 +
 .../include/gaudi/asic_reg/dma4_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/dma5_core_regs.h   |  156 +
 .../include/gaudi/asic_reg/dma5_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/dma6_core_regs.h   |  156 +
 .../include/gaudi/asic_reg/dma6_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/dma7_core_regs.h   |  156 +
 .../include/gaudi/asic_reg/dma7_qm_regs.h     |  834 ++
 .../gaudi/asic_reg/dma_if_e_n_down_ch0_regs.h |  896 ++
 .../gaudi/asic_reg/dma_if_e_n_down_ch1_regs.h |  896 ++
 .../include/gaudi/asic_reg/dma_if_e_n_regs.h  |  860 ++
 .../gaudi/asic_reg/dma_if_e_s_down_ch0_regs.h |  896 ++
 .../gaudi/asic_reg/dma_if_e_s_down_ch1_regs.h |  896 ++
 .../include/gaudi/asic_reg/dma_if_e_s_regs.h  |  860 ++
 .../gaudi/asic_reg/dma_if_w_n_down_ch0_regs.h |  896 ++
 .../gaudi/asic_reg/dma_if_w_n_down_ch1_regs.h |  896 ++
 .../include/gaudi/asic_reg/dma_if_w_n_regs.h  |  860 ++
 .../gaudi/asic_reg/dma_if_w_s_down_ch0_regs.h |  896 ++
 .../gaudi/asic_reg/dma_if_w_s_down_ch1_regs.h |  896 ++
 .../include/gaudi/asic_reg/dma_if_w_s_regs.h  |  860 ++
 .../include/gaudi/asic_reg/gaudi_blocks.h     | 4974 +++++++++
 .../include/gaudi/asic_reg/gaudi_regs.h       |  299 +
 .../include/gaudi/asic_reg/mme0_ctrl_regs.h   | 1456 +++
 .../include/gaudi/asic_reg/mme0_qm_masks.h    |  800 ++
 .../include/gaudi/asic_reg/mme0_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/mme1_ctrl_regs.h   | 1456 +++
 .../include/gaudi/asic_reg/mme2_ctrl_regs.h   | 1456 +++
 .../include/gaudi/asic_reg/mme2_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/mme3_ctrl_regs.h   | 1456 +++
 .../include/gaudi/asic_reg/mmu_up_regs.h      |   72 +
 .../gaudi/asic_reg/nif_rtr_ctrl_0_regs.h      |  896 ++
 .../gaudi/asic_reg/nif_rtr_ctrl_1_regs.h      |  896 ++
 .../gaudi/asic_reg/nif_rtr_ctrl_2_regs.h      |  896 ++
 .../gaudi/asic_reg/nif_rtr_ctrl_3_regs.h      |  896 ++
 .../gaudi/asic_reg/nif_rtr_ctrl_4_regs.h      |  896 ++
 .../gaudi/asic_reg/nif_rtr_ctrl_5_regs.h      |  896 ++
 .../gaudi/asic_reg/nif_rtr_ctrl_6_regs.h      |  896 ++
 .../gaudi/asic_reg/nif_rtr_ctrl_7_regs.h      |  896 ++
 .../include/gaudi/asic_reg/psoc_etr_regs.h    |  114 +
 .../gaudi/asic_reg/psoc_global_conf_masks.h   |  502 +
 .../gaudi/asic_reg/psoc_global_conf_regs.h    | 1062 ++
 .../gaudi/asic_reg/psoc_hbm_pll_regs.h        |  114 +
 .../gaudi/asic_reg/psoc_pci_pll_regs.h        |  114 +
 .../gaudi/asic_reg/psoc_timestamp_regs.h      |   56 +
 .../gaudi/asic_reg/sif_rtr_ctrl_0_regs.h      |  896 ++
 .../gaudi/asic_reg/sif_rtr_ctrl_1_regs.h      |  896 ++
 .../gaudi/asic_reg/sif_rtr_ctrl_2_regs.h      |  896 ++
 .../gaudi/asic_reg/sif_rtr_ctrl_3_regs.h      |  896 ++
 .../gaudi/asic_reg/sif_rtr_ctrl_4_regs.h      |  896 ++
 .../gaudi/asic_reg/sif_rtr_ctrl_5_regs.h      |  896 ++
 .../gaudi/asic_reg/sif_rtr_ctrl_6_regs.h      |  896 ++
 .../gaudi/asic_reg/sif_rtr_ctrl_7_regs.h      |  896 ++
 .../include/gaudi/asic_reg/stlb_regs.h        |   82 +
 .../include/gaudi/asic_reg/tpc0_cfg_masks.h   | 2578 +++++
 .../include/gaudi/asic_reg/tpc0_cfg_regs.h    | 1226 +++
 .../include/gaudi/asic_reg/tpc0_qm_masks.h    |  800 ++
 .../include/gaudi/asic_reg/tpc0_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/tpc1_cfg_regs.h    | 1226 +++
 .../include/gaudi/asic_reg/tpc1_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/tpc2_cfg_regs.h    | 1226 +++
 .../include/gaudi/asic_reg/tpc2_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/tpc3_cfg_regs.h    | 1226 +++
 .../include/gaudi/asic_reg/tpc3_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/tpc4_cfg_regs.h    | 1226 +++
 .../include/gaudi/asic_reg/tpc4_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/tpc5_cfg_regs.h    | 1226 +++
 .../include/gaudi/asic_reg/tpc5_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/tpc6_cfg_regs.h    | 1226 +++
 .../include/gaudi/asic_reg/tpc6_qm_regs.h     |  834 ++
 .../include/gaudi/asic_reg/tpc7_cfg_regs.h    | 1226 +++
 .../include/gaudi/asic_reg/tpc7_qm_regs.h     |  834 ++
 drivers/misc/habanalabs/include/gaudi/gaudi.h |   59 +
 .../include/gaudi/gaudi_async_events.h        |  310 +
 .../include/gaudi/gaudi_async_ids_map.h       |  687 ++
 .../include/gaudi/gaudi_coresight.h           |  367 +
 .../habanalabs/include/gaudi/gaudi_fw_if.h    |   36 +
 .../habanalabs/include/gaudi/gaudi_masks.h    |  450 +
 .../habanalabs/include/gaudi/gaudi_packets.h  |  212 +
 .../habanalabs/include/gaudi/gaudi_reg_map.h  |   27 +
 .../include/hw_ip/mmu/mmu_general.h           |    2 +-
 .../habanalabs/include/hw_ip/mmu/mmu_v1_1.h   |   16 +
 drivers/misc/habanalabs/sysfs.c               |    8 +-
 include/uapi/misc/habanalabs.h                |  167 +-
 110 files changed, 90045 insertions(+), 16 deletions(-)
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
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_async_ids_map.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_coresight.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_fw_if.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_packets.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/gaudi_reg_map.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/mmu/mmu_v1_1.h

-- 
2.17.1

