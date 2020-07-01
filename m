Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E20420722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UMcfD9zG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgGAIb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgGAIb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:31:26 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A18C061755
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 01:31:26 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so21485378wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 01:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9v5ZhaBrcQYaLm5M9l3n62k/9mN7q94+6p+PKOExIU=;
        b=UMcfD9zGhvRO9DrvSQm2GbSILQKqc4DE4sYiig5aTnBLzwT5b7XGYYifgaqDpjEEYs
         tfQjP5jVgOOYH0+87VvyjxXmsYawkBfRl85zUt12zNXe+4LASkZHABHTm83P58XJgpnW
         GAik9OfvR5S/Z5gc04k0kQRGgGe5EhsIjPs3/GCRZDGzvW50YCfHP/eo5R9I9vyQ1Fzd
         rrUTjIT0GjAAyMBHnZYpk7ZVGEUQP1xPzXk+o0xhu+bOWF7PqJywjrywzfSNIGJGJO/w
         2b7OG0ZsGHMSvOcrFi9ae1eeSulw86ly3WTmsUmW8hq9Du9iQ+kS3qqK9LxYjpwFSJxl
         wrMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z9v5ZhaBrcQYaLm5M9l3n62k/9mN7q94+6p+PKOExIU=;
        b=cT/Hxd3eQdOlMl1dOTM6XT/G8DBDQEdA/jBBniweDFPrKtFtPS+oCARMEudmFZTHy/
         /JVsGhmRqOwznfuwJZg3uWZ4AieDib/Rthuu+KSI2PyLUMUBkIV1Ph5HsvDlAVFEQpfe
         FncZtF4rKn6AX8F9Hwfkdew1DGL/FjaidYAaMIfa4GVr8qWU8cusBjqJh317DnMx3Smp
         uAD+OaLGHFDLRGH4wnVpE9nQX346i2+3IURK1TqlBRWDxF1JaPuY9Yb4baaQtT7kkjd5
         venL2LWoTP36tGOKXy+2e+if3GIsCrM7V1gIEMKt+CX7pTFjHffFQ6sq8K8EtU9DKzwX
         35PA==
X-Gm-Message-State: AOAM532JtCMHP8Pc4nUmlvo6h3J7ZlgJfns0go73CTrPHoM9Qn8K/fnv
        8Cab/QKsHAZ+lAVYdaDH1Aq9sdoXlJA=
X-Google-Smtp-Source: ABdhPJxUssPvh4jRvO3aGqTc1vJbB3WSQyW0qr/5XeylV4LNrCemumOC3+j8NdumgdXitTyooG54Mw==
X-Received: by 2002:a1c:dd86:: with SMTP id u128mr25398186wmg.123.1593592284676;
        Wed, 01 Jul 2020 01:31:24 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id 59sm6717816wrj.37.2020.07.01.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 01:31:24 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 00/30] Last batch of patches to clean up Misc
Date:   Wed,  1 Jul 2020 09:30:48 +0100
Message-Id: <20200701083118.45744-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

After these patches are applied, the build system no longer
complains about any W=0 nor W=1 level warnings in drivers/misc.
 
Hurrah!

Changelog:

v1 => v2:
 - Fix 'kernel test robot' issue in 07/30

Lee Jones (30):
  misc: genwqe: card_ddcb: Fix a variety of kerneldoc issues
  misc: genwqe: card_sysfs: Demote function/file headers from kerneldoc
  misc: genwqe: card_debugfs: Demote file header from kerneldoc
  misc: sgi-xp: xp_main: Staticify local functions xp_init() and
    xp_exit()
  misc: ibmasm: event: Demote function headers from kerneldoc
  misc: ibmasm: command: Demote function headers from kerneldoc
  misc: vmw_vmci_defs: Mark 'struct vmci_handle VMCI_ANON_SRC_HANDLE' as
    __maybe_unused
  misc: ibmasm: r_heartbeat: Demote function headers from kerneldoc
  misc: mic: host: mic_x100: Move declaration of mic_x100_intr_init[]
    into c-file
  misc: ibmasm: dot_command: Demote function headers from kerneldoc
  misc: mic: host: mic_intr: Properly document function arguments
  misc: mic: host: mic_x100: Add missing descriptions to kerneldoc
    headers
  misc: mic: card: mic_debugfs: Demote function headers from kerneldoc
  misc: mic: host: mic_debugfs: Demote function headers from kerneldoc
  misc: mic: cosm: cosm_main: Document 'force' function argument
  misc: mic: scif: scif_ports: Fix copy 'n' paste error
  misc: mic: cosm: cosm_debugfs: Demote function headers from kerneldoc
  misc: mic: scif: scif_api: Remove set but unused variable 'read_size'
  misc: mic: scif: scif_api: Demote scif_accept() function header
  misc: mic: scif: scif_epd: Describe missing 'scifdev' argument(s)
  misc: mic: scif: scif_nodeqp: Fix a bunch of kerneldoc issues
  misc: mic: scif: scif_nm: Supply various kerneldoc fix-ups
  misc: mic: scif: scif_dma: Fix a couple of kerneldoc issues
  misc: mic: scif: scif_fence: Fix a bunch of different documentation
    issues
  misc: mic: scif: scif_rma: Repair a bunch of kerneldoc issues
  misc: eeprom: at24: Tell the compiler that ACPI functions may not be
    used
  misc: cxl: hcalls: Demote half-assed kerneldoc attempt
  misc: ocxl: config: Provide correct formatting to function headers
  misc: ibmvmc: Repair ill-named function argument descriptions
  misc: cxl: flash: Remove unused pointer

 arch/arm/mach-omap2/mmc.h              |  4 ---
 drivers/misc/cxl/flash.c               |  7 ++---
 drivers/misc/cxl/hcalls.c              | 42 +++++++++++++-------------
 drivers/misc/eeprom/at24.c             |  2 +-
 drivers/misc/genwqe/card_ddcb.c        | 20 +++++++++---
 drivers/misc/genwqe/card_debugfs.c     |  2 +-
 drivers/misc/genwqe/card_sysfs.c       |  8 ++---
 drivers/misc/ibmasm/command.c          |  6 ++--
 drivers/misc/ibmasm/dot_command.c      |  6 ++--
 drivers/misc/ibmasm/event.c            |  4 +--
 drivers/misc/ibmasm/r_heartbeat.c      |  2 +-
 drivers/misc/ibmvmc.c                  |  6 ++--
 drivers/misc/mic/card/mic_debugfs.c    | 10 +++---
 drivers/misc/mic/cosm/cosm_debugfs.c   |  4 +--
 drivers/misc/mic/cosm/cosm_main.c      |  1 +
 drivers/misc/mic/host/mic_debugfs.c    |  8 ++---
 drivers/misc/mic/host/mic_intr.c       |  4 ++-
 drivers/misc/mic/host/mic_x100.c       | 13 ++++++++
 drivers/misc/mic/host/mic_x100.h       |  9 ------
 drivers/misc/mic/scif/scif_api.c       |  6 ++--
 drivers/misc/mic/scif/scif_dma.c       |  3 +-
 drivers/misc/mic/scif/scif_epd.c       |  9 ++++++
 drivers/misc/mic/scif/scif_fence.c     | 34 +++++++++++++--------
 drivers/misc/mic/scif/scif_nm.c        | 17 ++++++-----
 drivers/misc/mic/scif/scif_nodeqp.c    | 18 ++++++-----
 drivers/misc/mic/scif/scif_ports.c     |  9 +++---
 drivers/misc/mic/scif/scif_rma.c       | 12 ++++++--
 drivers/misc/ocxl/config.c             | 18 +++++------
 drivers/misc/sgi-xp/xp_main.c          |  4 +--
 drivers/mmc/host/omap.c                |  1 -
 include/linux/platform_data/mmc-omap.h |  3 ++
 include/linux/vmw_vmci_defs.h          |  2 +-
 32 files changed, 168 insertions(+), 126 deletions(-)

-- 
2.25.1

