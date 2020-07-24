Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBECC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE152070E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:49:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjKz3F3d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGXRta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgGXRt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:49:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6133EC0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:49:29 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so8647898wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 10:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9Q5AzBbtuYu7ME5NxD8MhcqjW9DxmclgN3iVwn5YFfo=;
        b=hjKz3F3dd4z8+Q85RKA9fwX6SO36sYWfU7iTao8VlJ26+9A8FbW+uz1pozmp8mawak
         TemATNpzfCAxcI4unAvkoB9GEAtr4nShxYLRO8IQc/niNQhGFL/boiB/4g3LhrkgyiVg
         pTVh3iFCcLspFDNPUrLQ9EZ9Cnrsa+ss5icT92Yd8uaTKaZFyS8PPAF+WRUNtBfX5QuD
         PDCJd5BG8duJ4jL92mIyp2lwejGsAlK4ausKHE8Xbh8lN1v5TDaVpsDuY4hBmHQ00TQK
         iQ9v3MS/uhLP35vssHCDhze22RXReORbCvGzftg8JVzIRYSjzjdtmPaMU/OgroiIHDEf
         DwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9Q5AzBbtuYu7ME5NxD8MhcqjW9DxmclgN3iVwn5YFfo=;
        b=bKxD4HlpOG+S2+a7V9KnLG0/gVkapC6KXK5ztZDYrKZq/6l80dLf9zwwI5U/rkEG3o
         BPPDA8Yy6DaVOr50O3hR1sdR3M7or9i/zxGCz0BuUQe0+Tmr0JYcXKzRcMCsxdqgDUKd
         e230v0wJ6dOpVZ+imQ233ocBD+rYnQnLaKSkYflktQzpFPga0PGUddqw9tpt6uPjacah
         l/yB367GV0b9HVxduHiK57ARGSjbNjsVewmBidBI/1KLdAWHt/cme8e8MFpyL6cyUCj/
         oT40Bt3YQVrQI7LfvP85pkSRJ3m0ScpHUXv45lM/JKgCi81R2cgUAl/K0xbRgkwpU1ns
         Dk4A==
X-Gm-Message-State: AOAM531wdXbSQ9CTX5er9vS0bT8a25yS38guYNgjE+83lANILSVFxeQ1
        Gx0WPnELMYOT1cNxV/AeCtfiTmQy
X-Google-Smtp-Source: ABdhPJwHsrtd3HLcVsXWuVJX5zaUHYmZ7SFxwT3aHoTmFlJBEqATuGEjwdLPMKgqKR4YNuKJ0uWwuA==
X-Received: by 2002:a1c:a78a:: with SMTP id q132mr6254721wme.27.1595612967958;
        Fri, 24 Jul 2020 10:49:27 -0700 (PDT)
Received: from ogabbay-VM ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 31sm2112897wrp.87.2020.07.24.10.49.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Jul 2020 10:49:26 -0700 (PDT)
Date:   Fri, 24 Jul 2020 20:49:24 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.9-rc1 (resend again)
Message-ID: <20200724174924.GA20186@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

(Re-sending again this pull request)

This is habanalabs pull request for the merge window of kernel 5.9. It
contains many small improvements to common and GAUDI code. Details are in
the tag.

Thanks,
Oded

The following changes since commit 92ca3dd4867bafbfd026b06d53737d61ded1bd27:

  mei: hw: don't use one element arrays (2020-07-23 19:33:09 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux misc-habanalabs-next-2020-07-24

for you to fetch changes up to 94f8be9eb065412cf069efd45053d33e8911fa9e:

  habanalabs: Fix memory leak in error flow of context initialization (2020-07-24 20:40:06 +0300)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.9-rc1:

- Remove rate limiters from GAUDI configuration (no longer needed).
- Set maximum amount of in-flight CS per ASIC type and increase
  the maximum amount for GAUDI.
- Refactor signal/wait command submissions code
- Calculate trace frequency from PLLs to show accurate profiling data
- Rephrase error messages to make them more clear to the common user
- Add statistics of dropped CS (counter per possible reason for drop)
- Get ECC information from firmware
- Remove support for partial SoC reset in Gaudi
- Halt device CPU only when reset is certain to happen. Sometimes we abort
  the reset procedure and in that case we can't leave device CPU in halt
  mode.
- set each CQ to its own work queue to prevent a race between completions
  on different CQs.
- Use queue pi/ci in order to determine queue occupancy. This is done to
  make the code reusable between current and future ASICs.
- Add more validations for user inputs.
- Refactor PCIe controller configuration to make the code reusable between
  current and future ASICs.
- Update firmware interface headers to latest version
- Move all common code to a dedicated common sub-folder

----------------------------------------------------------------
Adam Aharon (1):
      habanalabs: calculate trace frequency from PLL

Christine Gharzuzi (1):
      habanalabs: extract cpu boot status lookup

Moti Haimovski (1):
      habanalabs: check for DMA errors when clearing memory

Oded Gabbay (10):
      habanalabs: remove rate limiters from GAUDI
      uapi/habanalabs: fix some comments
      habanalabs: align armcp_packet structure to 8 bytes
      habanalabs: rephrase error messages
      habanalabs: Extract ECC information from FW
      habanalabs: remove soft-reset support from GAUDI
      habanalabs: halt device CPU only upon certain reset
      habanalabs: create common folder
      habanalabs: update hl_boot_if.h from firmware
      habanalabs: enable device before hw_init()

Ofir Bitton (11):
      habanalabs: Use pending CS amount per ASIC
      habanalabs: sync stream generic functionality
      habanalabs: Use mask instead of shift in sync stream registers
      habanalabs: Increase queues depth
      habanalabs: Add dropped cs statistics info struct
      habanalabs: PCIe iATU refactoring
      habanalabs: configure maximum queues per asic
      habanalabs: use queue pi/ci in order to determine queue occupancy
      habanalabs: Assign each CQ with its own work queue
      habanalabs: verify queue can contain all cs jobs
      habanalabs: create internal CB pool

Omer Shpigelman (2):
      habanalabs: rephrase error message
      habanalabs: remove unused hash

Tomer Tayar (2):
      habanalabs: use no flags on MMU cache invalidation
      habanalabs: Fix memory leak in error flow of context initialization

 drivers/misc/habanalabs/Makefile                   |  11 +-
 drivers/misc/habanalabs/common/Makefile            |   9 +
 drivers/misc/habanalabs/{ => common}/asid.c        |   0
 .../misc/habanalabs/{ => common}/command_buffer.c  |  82 +-
 .../habanalabs/{ => common}/command_submission.c   |  97 ++-
 drivers/misc/habanalabs/{ => common}/context.c     |  39 +-
 drivers/misc/habanalabs/{ => common}/debugfs.c     |   0
 drivers/misc/habanalabs/{ => common}/device.c      |  88 +-
 drivers/misc/habanalabs/{ => common}/firmware_if.c | 101 +--
 drivers/misc/habanalabs/{ => common}/habanalabs.h  | 172 ++--
 .../misc/habanalabs/{ => common}/habanalabs_drv.c  |   1 -
 .../habanalabs/{ => common}/habanalabs_ioctl.c     |  24 +
 drivers/misc/habanalabs/{ => common}/hw_queue.c    | 165 ++--
 drivers/misc/habanalabs/{ => common}/hwmon.c       |   0
 drivers/misc/habanalabs/{ => common}/irq.c         |  13 +-
 drivers/misc/habanalabs/{ => common}/memory.c      |   3 +-
 drivers/misc/habanalabs/{ => common}/mmu.c         |   1 -
 drivers/misc/habanalabs/{ => common}/pci.c         | 136 ++--
 drivers/misc/habanalabs/{ => common}/sysfs.c       |   3 +
 drivers/misc/habanalabs/gaudi/Makefile             |   2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 894 ++++++++-------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  16 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |   6 +-
 drivers/misc/habanalabs/goya/goya.c                | 172 ++--
 drivers/misc/habanalabs/goya/goyaP.h               |  14 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |   6 +-
 .../habanalabs/include/{ => common}/armcp_if.h     |  14 +-
 .../habanalabs/include/{ => common}/hl_boot_if.h   |  14 +
 .../misc/habanalabs/include/{ => common}/qman_if.h |   0
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |  21 +-
 .../include/gaudi/asic_reg/psoc_cpu_pll_regs.h     | 114 +++
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   3 +
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |   4 +-
 include/uapi/misc/habanalabs.h                     |  27 +-
 34 files changed, 1260 insertions(+), 992 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/Makefile
 rename drivers/misc/habanalabs/{ => common}/asid.c (100%)
 rename drivers/misc/habanalabs/{ => common}/command_buffer.c (85%)
 rename drivers/misc/habanalabs/{ => common}/command_submission.c (92%)
 rename drivers/misc/habanalabs/{ => common}/context.c (84%)
 rename drivers/misc/habanalabs/{ => common}/debugfs.c (100%)
 rename drivers/misc/habanalabs/{ => common}/device.c (94%)
 rename drivers/misc/habanalabs/{ => common}/firmware_if.c (89%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs.h (94%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs_drv.c (99%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs_ioctl.c (95%)
 rename drivers/misc/habanalabs/{ => common}/hw_queue.c (86%)
 rename drivers/misc/habanalabs/{ => common}/hwmon.c (100%)
 rename drivers/misc/habanalabs/{ => common}/irq.c (95%)
 rename drivers/misc/habanalabs/{ => common}/memory.c (99%)
 rename drivers/misc/habanalabs/{ => common}/mmu.c (99%)
 rename drivers/misc/habanalabs/{ => common}/pci.c (73%)
 rename drivers/misc/habanalabs/{ => common}/sysfs.c (99%)
 rename drivers/misc/habanalabs/include/{ => common}/armcp_if.h (98%)
 rename drivers/misc/habanalabs/include/{ => common}/hl_boot_if.h (84%)
 rename drivers/misc/habanalabs/include/{ => common}/qman_if.h (100%)
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_cpu_pll_regs.h
The following changes since commit 92ca3dd4867bafbfd026b06d53737d61ded1bd27:

  mei: hw: don't use one element arrays (2020-07-23 19:33:09 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-07-24

for you to fetch changes up to 94f8be9eb065412cf069efd45053d33e8911fa9e:

  habanalabs: Fix memory leak in error flow of context initialization (2020-07-24 20:40:06 +0300)

----------------------------------------------------------------
This tag contains the following changes for kernel 5.9-rc1:

- Remove rate limiters from GAUDI configuration (no longer needed).
- Set maximum amount of in-flight CS per ASIC type and increase
  the maximum amount for GAUDI.
- Refactor signal/wait command submissions code
- Calculate trace frequency from PLLs to show accurate profiling data
- Rephrase error messages to make them more clear to the common user
- Add statistics of dropped CS (counter per possible reason for drop)
- Get ECC information from firmware
- Remove support for partial SoC reset in Gaudi
- Halt device CPU only when reset is certain to happen. Sometimes we abort
  the reset procedure and in that case we can't leave device CPU in halt
  mode.
- set each CQ to its own work queue to prevent a race between completions
  on different CQs.
- Use queue pi/ci in order to determine queue occupancy. This is done to
  make the code reusable between current and future ASICs.
- Add more validations for user inputs.
- Refactor PCIe controller configuration to make the code reusable between
  current and future ASICs.
- Update firmware interface headers to latest version
- Move all common code to a dedicated common sub-folder

----------------------------------------------------------------
Adam Aharon (1):
      habanalabs: calculate trace frequency from PLL

Christine Gharzuzi (1):
      habanalabs: extract cpu boot status lookup

Moti Haimovski (1):
      habanalabs: check for DMA errors when clearing memory

Oded Gabbay (10):
      habanalabs: remove rate limiters from GAUDI
      uapi/habanalabs: fix some comments
      habanalabs: align armcp_packet structure to 8 bytes
      habanalabs: rephrase error messages
      habanalabs: Extract ECC information from FW
      habanalabs: remove soft-reset support from GAUDI
      habanalabs: halt device CPU only upon certain reset
      habanalabs: create common folder
      habanalabs: update hl_boot_if.h from firmware
      habanalabs: enable device before hw_init()

Ofir Bitton (11):
      habanalabs: Use pending CS amount per ASIC
      habanalabs: sync stream generic functionality
      habanalabs: Use mask instead of shift in sync stream registers
      habanalabs: Increase queues depth
      habanalabs: Add dropped cs statistics info struct
      habanalabs: PCIe iATU refactoring
      habanalabs: configure maximum queues per asic
      habanalabs: use queue pi/ci in order to determine queue occupancy
      habanalabs: Assign each CQ with its own work queue
      habanalabs: verify queue can contain all cs jobs
      habanalabs: create internal CB pool

Omer Shpigelman (2):
      habanalabs: rephrase error message
      habanalabs: remove unused hash

Tomer Tayar (2):
      habanalabs: use no flags on MMU cache invalidation
      habanalabs: Fix memory leak in error flow of context initialization

 drivers/misc/habanalabs/Makefile                   |  11 +-
 drivers/misc/habanalabs/common/Makefile            |   9 +
 drivers/misc/habanalabs/{ => common}/asid.c        |   0
 .../misc/habanalabs/{ => common}/command_buffer.c  |  82 +-
 .../habanalabs/{ => common}/command_submission.c   |  97 ++-
 drivers/misc/habanalabs/{ => common}/context.c     |  39 +-
 drivers/misc/habanalabs/{ => common}/debugfs.c     |   0
 drivers/misc/habanalabs/{ => common}/device.c      |  88 +-
 drivers/misc/habanalabs/{ => common}/firmware_if.c | 101 +--
 drivers/misc/habanalabs/{ => common}/habanalabs.h  | 172 ++--
 .../misc/habanalabs/{ => common}/habanalabs_drv.c  |   1 -
 .../habanalabs/{ => common}/habanalabs_ioctl.c     |  24 +
 drivers/misc/habanalabs/{ => common}/hw_queue.c    | 165 ++--
 drivers/misc/habanalabs/{ => common}/hwmon.c       |   0
 drivers/misc/habanalabs/{ => common}/irq.c         |  13 +-
 drivers/misc/habanalabs/{ => common}/memory.c      |   3 +-
 drivers/misc/habanalabs/{ => common}/mmu.c         |   1 -
 drivers/misc/habanalabs/{ => common}/pci.c         | 136 ++--
 drivers/misc/habanalabs/{ => common}/sysfs.c       |   3 +
 drivers/misc/habanalabs/gaudi/Makefile             |   2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c              | 894 ++++++++-------------
 drivers/misc/habanalabs/gaudi/gaudiP.h             |  16 +-
 drivers/misc/habanalabs/gaudi/gaudi_coresight.c    |   6 +-
 drivers/misc/habanalabs/goya/goya.c                | 172 ++--
 drivers/misc/habanalabs/goya/goyaP.h               |  14 +-
 drivers/misc/habanalabs/goya/goya_coresight.c      |   6 +-
 .../habanalabs/include/{ => common}/armcp_if.h     |  14 +-
 .../habanalabs/include/{ => common}/hl_boot_if.h   |  14 +
 .../misc/habanalabs/include/{ => common}/qman_if.h |   0
 .../habanalabs/include/gaudi/asic_reg/gaudi_regs.h |  21 +-
 .../include/gaudi/asic_reg/psoc_cpu_pll_regs.h     | 114 +++
 .../misc/habanalabs/include/gaudi/gaudi_masks.h    |   3 +
 .../misc/habanalabs/include/gaudi/gaudi_packets.h  |   4 +-
 include/uapi/misc/habanalabs.h                     |  27 +-
 34 files changed, 1260 insertions(+), 992 deletions(-)
 create mode 100644 drivers/misc/habanalabs/common/Makefile
 rename drivers/misc/habanalabs/{ => common}/asid.c (100%)
 rename drivers/misc/habanalabs/{ => common}/command_buffer.c (85%)
 rename drivers/misc/habanalabs/{ => common}/command_submission.c (92%)
 rename drivers/misc/habanalabs/{ => common}/context.c (84%)
 rename drivers/misc/habanalabs/{ => common}/debugfs.c (100%)
 rename drivers/misc/habanalabs/{ => common}/device.c (94%)
 rename drivers/misc/habanalabs/{ => common}/firmware_if.c (89%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs.h (94%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs_drv.c (99%)
 rename drivers/misc/habanalabs/{ => common}/habanalabs_ioctl.c (95%)
 rename drivers/misc/habanalabs/{ => common}/hw_queue.c (86%)
 rename drivers/misc/habanalabs/{ => common}/hwmon.c (100%)
 rename drivers/misc/habanalabs/{ => common}/irq.c (95%)
 rename drivers/misc/habanalabs/{ => common}/memory.c (99%)
 rename drivers/misc/habanalabs/{ => common}/mmu.c (99%)
 rename drivers/misc/habanalabs/{ => common}/pci.c (73%)
 rename drivers/misc/habanalabs/{ => common}/sysfs.c (99%)
 rename drivers/misc/habanalabs/include/{ => common}/armcp_if.h (98%)
 rename drivers/misc/habanalabs/include/{ => common}/hl_boot_if.h (84%)
 rename drivers/misc/habanalabs/include/{ => common}/qman_if.h (100%)
 create mode 100644 drivers/misc/habanalabs/include/gaudi/asic_reg/psoc_cpu_pll_regs.h
