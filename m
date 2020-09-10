Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAEAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DEFB21D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMq/zNtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgIJTwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731226AbgIJPEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:02 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47735C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:03:34 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l17so6615615edq.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YxVn4Zbme0obY4xg7KEutnAEvJ86ItKrhQOb0G4NIT0=;
        b=SMq/zNtmcvQyKUNl1uPBTL25TrnaTYQak0wAazW6LnNHsynVKJbaqUfUFQdFuhQ9iy
         dx3MD1YFXCtxE19ZXmBM6IIRUW9h//BhHoB5STZzfasYyoTJcXXQPFHgzoyhZBI64iNq
         tuYxbmGpL0n+c0Q1Hh5mpKBk3o4XPHexCF6SwElx3NxZm3D0AFGZ9cCMrSEPmUt5gGOu
         RzQXOMtWYYHmmKy/kBQO8+aSi3RS1BYQ0ohMLZimdNFgpUFZBATeMKq40XlLyMEIEybo
         h4G9eGPSWzdtTRZWThMW39FPx1nSz8+TxTTPdtEwPInjpfHBaFaUyV41a0Dr5atjxTB6
         Q0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YxVn4Zbme0obY4xg7KEutnAEvJ86ItKrhQOb0G4NIT0=;
        b=UOcsm/fz7eOyiI7NXlkzAtRrEQHJpx/zXl2kToRH8/jVrC7JfIIakyy9NDe3Y6A2Xx
         i+Q1UgYqMudxWAa2wyMnDstekDg4fUWkZVgVhucaGZn//Iry9PnOggCasw/2pF+9MkuG
         Dpiluv2/9GTAjPvNRGDWtJm9RSFyW0QUmi1PWMDlmBU0mrpuKNtViBn/l+9OsjcxcZot
         cppIpYsr3EQSfY/pBZ1P4F3Tmy1aGKCzfL/CSZPp+Mmak7kFko19xooHuZAyLlGfI2Ee
         l0ApzeBqJ9Nh2jH403axmLaCXcBtmLILBC15vK8dWq+bBDUwvNpuhIO0d4fqQzQhiNfV
         wDYg==
X-Gm-Message-State: AOAM533vz4wctFLfuC/76MozKAuz54AEqCJX1/hbzvIgF2FgowXbC6PP
        5ftzEPMmM7dOY7861K3CyQdatm1TRgs=
X-Google-Smtp-Source: ABdhPJw15jYeAgMR0Rp/eKFT4QE4mpLLFkiNBbVGJHu2cxl49H8dTprPLeAG6gfLeohr9gib1tEvBg==
X-Received: by 2002:a50:fe0f:: with SMTP id f15mr9669706edt.235.1599750211851;
        Thu, 10 Sep 2020 08:03:31 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id o3sm7443925edt.79.2020.09.10.08.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:03:30 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 00/15] Adding GAUDI NIC code to habanalabs driver
Date:   Thu, 10 Sep 2020 18:03:13 +0300
Message-Id: <20200910150328.20545-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds support for initializing and using the GAUDI NIC ports,
functioning as scale-out interconnect when doing distributed Deep Learning
training. The training can be performed over tens of thousands of GAUDIs
and it is done using the RDMA-over-converged-Ethernet (RoCE) v2 protocol.

Each GAUDI exposes 10x100GbE ports that are designed to scale-out the
inter-GAUDI communication by integrating a complete communication engine
on-die. This native integration allows users to use the same scaling
technology, both inside the server and rack (termed as scale-up), as well
as for scaling across racks (scale-out). The racks can be connected
directly between GAUDI processors, or through any number of standard
Ethernet switches.

The driver exposes the NIC ports to the user as standard Ethernet ports by
registering each port to the networking subsystem. This allows the user to
manage the ports with standard tools such as ifconfig, ethtool, etc. It
also enables us to connect to the Linux networking stack and thus support
standard networking protocols, such as IPv4, IPv6, TCP, etc. In addition,
we can also leverage protocols such as DCB for dynamically configuring
priorities to avoid congestion.

For each NIC port there is a matching QMAN entity. For RoCE, the user
submits workloads to the NIC through the QMAN, same as he does for the
compute engines. For regular Ethernet, the user sends and receives packets
through the standard Ethernet sockets. Those sockets are used only as a
control path. The data path that is used for AI training goes through the
RoCE interface.

It is important to note that there are some limitations and uniqueness
in GAUDI's NIC H/W, compared to other networking adapters that enforced us
to use a less-than-common driver design:

1. The NIC functionality is NOT exposed as different PCI Physical
   Functions. There is a single PF which is used for compute and
   networking, as the main goal of the NIC ports is to be used as
   intra-communication and not as standard network interfaces. This
   implies we can't connect different drivers to handle the networking
   ports because it is the same device, from the kernel POV, as the
   compute. Therefore, we must integrate the networking code into the
   main habanalabs driver.

2. Although our communication engine implements RDMA, and the driver code
   uses well-known RDMA concepts such as QP context, CQ, WQ, etc., the
   GAUDI architecture does NOT support other basic IBverbs concepts, such
   as MR and protection domain. Therefore, we can't connect to the standard
   IBverb infrastructure in the user-space and kernel (rdma-core library
   and infiniband subsystem, respectively) because the standard RDMA s/w
   and tools won't work on our H/W. Instead, we added a new IOCTL to the
   driver's existing IOCTL API. The new IOCTL exposes the available
   NIC control operations to the user (e.g. Create a QP context).

3. The die-on communication engine provides minimal offloading for standard
   Ethernet and TCP/IP protocols, as those are only used for control plane.
   E.g. the packets are copied rather than using descriptors.
   Therefore, the Ethernet performance is quite low compared to standard
   Ethernet adapters.

4. There is no virtualization support per port.

Most or all of the above limitations will hopefully be improved in future
ASIC generations.

Patch-set organization:

- Patches 1 & 2 are just adding some auto-generated register header files
  and NIC-related definitions to the interface between the driver and the
  GAUDI firmware. 

- Patch 3 adds initialization of security restrictions on the NIC engines.

- Patch 4 adds initialization of the NIC QMANs. The QMANs are needed to
  send RDMA packets through the NIC engines.

- Patches 5-11 adds the NIC driver code. It contains the basic Ethernet
  driver and H/W initialization, the NIC PHY driver code and the new NIC
  control IOCTL operations.

- Patch 12-14 adds support for debugfs, ethtool and DCB.

- Patch 15 adds the implementation of the high-level init/fini functions
  and their calls from the common code. This is the patch that actually
  enables the NIC ports and allows the user to work with them.

Thanks,
Oded


Omer Shpigelman (15):
  habanalabs/gaudi: add NIC H/W and registers definitions
  habanalabs/gaudi: add NIC firmware-related definitions
  habanalabs/gaudi: add NIC security configuration
  habanalabs/gaudi: add support for NIC QMANs
  habanalabs/gaudi: add NIC Ethernet support
  habanalabs/gaudi: add NIC PHY code
  habanalabs/gaudi: allow user to get MAC addresses in INFO IOCTL
  habanalabs/gaudi: add a new IOCTL for NIC control operations
  habanalabs/gaudi: add CQ control operations
  habanalabs/gaudi: add WQ control operations
  habanalabs/gaudi: add QP error handling
  habanalabs/gaudi: add debugfs entries for the NIC
  habanalabs/gaudi: Add ethtool support using coresight
  habanalabs/gaudi: support DCB protocol
  habanalabs/gaudi: add NIC init/fini calls from common code

 .../ABI/testing/debugfs-driver-habanalabs     |   69 +
 drivers/misc/habanalabs/common/context.c      |    1 +
 drivers/misc/habanalabs/common/device.c       |   24 +-
 drivers/misc/habanalabs/common/firmware_if.c  |   44 +
 drivers/misc/habanalabs/common/habanalabs.h   |   33 +-
 .../misc/habanalabs/common/habanalabs_drv.c   |   11 +
 .../misc/habanalabs/common/habanalabs_ioctl.c |  151 +-
 drivers/misc/habanalabs/common/pci.c          |    1 +
 drivers/misc/habanalabs/gaudi/Makefile        |    4 +
 drivers/misc/habanalabs/gaudi/gaudi.c         |  958 +++-
 drivers/misc/habanalabs/gaudi/gaudiP.h        |  333 +-
 .../misc/habanalabs/gaudi/gaudi_coresight.c   |  144 +
 drivers/misc/habanalabs/gaudi/gaudi_nic.c     | 4063 +++++++++++++++++
 drivers/misc/habanalabs/gaudi/gaudi_nic.h     |  354 ++
 .../misc/habanalabs/gaudi/gaudi_nic_dcbnl.c   |  108 +
 .../misc/habanalabs/gaudi/gaudi_nic_debugfs.c |  402 ++
 .../misc/habanalabs/gaudi/gaudi_nic_ethtool.c |  582 +++
 drivers/misc/habanalabs/gaudi/gaudi_phy.c     | 1272 ++++++
 .../misc/habanalabs/gaudi/gaudi_security.c    | 3973 ++++++++++++++++
 drivers/misc/habanalabs/goya/goya.c           |   44 +
 .../misc/habanalabs/include/common/cpucp_if.h |   34 +-
 .../include/gaudi/asic_reg/gaudi_regs.h       |   26 +-
 .../include/gaudi/asic_reg/nic0_qm0_masks.h   |  800 ++++
 .../include/gaudi/asic_reg/nic0_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic0_qm1_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic0_qpc0_masks.h  |  500 ++
 .../include/gaudi/asic_reg/nic0_qpc0_regs.h   |  710 +++
 .../include/gaudi/asic_reg/nic0_qpc1_regs.h   |  710 +++
 .../include/gaudi/asic_reg/nic0_rxb_regs.h    |  508 +++
 .../include/gaudi/asic_reg/nic0_rxe0_masks.h  |  354 ++
 .../include/gaudi/asic_reg/nic0_rxe0_regs.h   |  158 +
 .../include/gaudi/asic_reg/nic0_rxe1_regs.h   |  158 +
 .../include/gaudi/asic_reg/nic0_stat_regs.h   |  518 +++
 .../include/gaudi/asic_reg/nic0_tmr_regs.h    |  184 +
 .../include/gaudi/asic_reg/nic0_txe0_masks.h  |  336 ++
 .../include/gaudi/asic_reg/nic0_txe0_regs.h   |  264 ++
 .../include/gaudi/asic_reg/nic0_txe1_regs.h   |  264 ++
 .../include/gaudi/asic_reg/nic0_txs0_masks.h  |  336 ++
 .../include/gaudi/asic_reg/nic0_txs0_regs.h   |  214 +
 .../include/gaudi/asic_reg/nic0_txs1_regs.h   |  214 +
 .../include/gaudi/asic_reg/nic1_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic1_qm1_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic2_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic2_qm1_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic3_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic3_qm1_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic4_qm0_regs.h    |  834 ++++
 .../include/gaudi/asic_reg/nic4_qm1_regs.h    |  834 ++++
 drivers/misc/habanalabs/include/gaudi/gaudi.h |   12 +
 .../habanalabs/include/gaudi/gaudi_fw_if.h    |   24 +
 .../habanalabs/include/gaudi/gaudi_masks.h    |   15 +
 .../include/hw_ip/nic/nic_general.h           |   13 +
 include/uapi/misc/habanalabs.h                |  296 +-
 53 files changed, 27497 insertions(+), 62 deletions(-)
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic.h
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic_dcbnl.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic_debugfs.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_nic_ethtool.c
 create mode 100644 drivers/misc/habanalabs/gaudi/gaudi_phy.c
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qpc0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qpc0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_qpc1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_rxb_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_rxe0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_rxe0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_rxe1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_stat_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_tmr_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txe0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txe0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txe1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txs0_masks.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txs0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic0_txs1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic1_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic2_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic3_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm0_regs.h
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/nic4_qm1_regs.h
 create mode 100644 drivers/misc/habanalabs/include/hw_ip/nic/nic_general.h

-- 
2.17.1

