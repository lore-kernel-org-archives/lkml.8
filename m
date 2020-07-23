Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473D8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E5022B47
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm+TB8AM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgGWTPa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWTPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:15:30 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102BFC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:15:30 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f18so6199542wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=JxwHuUdRjuVhjtk4b4/QdjxfVDZlFCkZWM7A/RtwBQY=;
        b=Lm+TB8AMijGnb4s1oSx6evjyo3eVHaI146feGCvrSrHiIG0bya5jMoeWuKpihuEBie
         PGPhVE4xvnzKW5Zhn546AZUdoiX6rkofCbo142oNsh56ONAqcWQ8k2lgtAEvTJgglUHq
         MdzDPukKOaCKFaDfaVDng3rnnCZvMztgprHLA6LYxUKXIi5bznOoFuCVbEdc64bQDWI9
         Lt+7YD26s0rcSLA0byt62PsemhlX0iU2Z3I5MryE+iK39nUuyw6fKmAskqZfWYJj06I4
         UCUuZYHVxkt3QfrnDZxWSGojezQ8RFFe17BZNqZCFeZD13wCDOZ/Fnelg0MmNIvDbfh2
         Uj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=JxwHuUdRjuVhjtk4b4/QdjxfVDZlFCkZWM7A/RtwBQY=;
        b=itoehqCJAfYuxO6ljZfT2XZ6QHxLNuzCdGn5/ZwaF26LrUZSqOC3se2XhD9qlCKMEW
         4bUQX7czgST+49CvXacm+ZqaJcM5JOjxfUHSXFMHmXziJLspap9j/tQGW1PbgKfOrW9j
         xEPpCaAM3bZquJylKpyJzBMgl4GHYy1lNIv9V2R5fsevuZvrXX9A7oWMSAM+Uvdjd+l4
         DKLsw9geIyTqyj5v3YYykde+MF/SR5UJzXHHFelzKhLpX+PYOqQQHaq1eq9Wf+phOgxu
         /BH61HsB/gcQLzMzJ3c/XEn9PxxTrV1vUSw4eNp/jI8Q+PID1PKoaSNX8JdlS3qAT28e
         rAMw==
X-Gm-Message-State: AOAM531+OU1UrmO2B9y1o8eU6AmDzpOR2ehNzpq/jW6uVK1AY37WETB6
        ZCWQ+aTOpkXfqzD9hwqJuFaFbP2W
X-Google-Smtp-Source: ABdhPJzuCB8Hp9Df5lJmO/lIwVlrlyWN1y3g6HHuWVJA/Dv32NiLfk/TRfgxrr/08uIGsBkphKLEYw==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr5644983wmg.39.1595531728650;
        Thu, 23 Jul 2020 12:15:28 -0700 (PDT)
Received: from ogabbay-VM ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id i14sm5805126wrc.19.2020.07.23.12.15.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 12:15:27 -0700 (PDT)
Date:   Thu, 23 Jul 2020 22:15:25 +0300
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs pull request for kernel 5.9-rc1 (resend)
Message-ID: <20200723191525.GA24516@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

(Re-sending this pull request)

This is habanalabs pull request for the merge window of kernel 5.9. It
contains many small improvements to common and GAUDI code. Details are in
the tag.

Thanks,
Oded

The following changes since commit 7a4462a96777b64b22412f782de226c90290bf75:

  misc: rtsx: Use standard PCI definitions (2020-07-22 13:39:31 +0200)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-07-23

for you to fetch changes up to 961a7325e6701eeb35ae46142aabc5732004bc77:

  habanalabs: Fix memory leak in error flow of context init (2020-07-23 22:07:02 +0300)

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
      habanalabs: Fix memory leak in error flow of context init

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
