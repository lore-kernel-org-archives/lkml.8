Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC71C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8D96206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ksv/jMN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388301AbgF3NvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgF3NvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2D2C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:14 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z13so20279854wrw.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNdnbgmnTgC04j2G7Lkbzd7LDEkFYQsfEXharzZcIHM=;
        b=Ksv/jMN0gnJdufSTxmKJBM3ixjVUl9r9g4ACIj5wqrpw5rSYDn3kozMb9TJ4jAZ4yi
         V2H2+fN5Sr6Bzj6CqWE/i3TsFZ3BkCy6Z3V2qtGgxMMEpCTgtZgV1N21eUQ6GbTuTP01
         fuXJ5p/8IXcKB0E9VoPdRECIc7wAIgYwIYXK9GNBiugTLOZ7eFyqOzyXi6kZidIMZ9is
         KSW+hp20jX2zaT4LRY2wuMdKmPhy27q0RvRAAvVEHR4owbHddbRgG+cuSlWbP/ERXA92
         z20HI3X9TKo7qIXAZdDkLMyUSWqARSDl85b8XGt6y3Tp544mwjSI/2yqRsKBd4zs2xZ+
         f+jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kNdnbgmnTgC04j2G7Lkbzd7LDEkFYQsfEXharzZcIHM=;
        b=W1kmXD68/Te3LjuLJpaKExrTIzeOrbrsHDYIrzI/gPCWdbWcsJ/p8Db4OueqXp9K3b
         +o2njLBiP0YHX+dfscHLrlZH+hB248DaF5OlXSU6jZp4GJwd31VIqvoAKE4xqY8kZrjy
         M+pNaI7CrUFP9KPbKD3T6rxPdygXrqX9mBx/+LClPKOOvx4VLQu1sHteEgP/7IPgljcY
         5YOm4W37FCzcbz73yo2V+M9ZY2L6xST5HViuoeEK/QOlcgav77Nu4/Jr3It4riwo0k+h
         M3oojH6vwqxVrJPU9LOPL+yRmtIKQGr4cfevkfSxqInUyz16ngjnz3EaQNx34kdNLRj8
         a2Ew==
X-Gm-Message-State: AOAM530N6baLhX8tFBniynsvm7DcCsgZL0TO9jP2rhWUmeFsaOEzEw9b
        xZu0gEMR5oHjIOCEw9En7O8lrw==
X-Google-Smtp-Source: ABdhPJy4o70MXkaZQ3ukaeco2LeW9SA+bTbS13ZLoid/OfEY3+eIbUnFDhso8l0a2zI7d0hq8BToxQ==
X-Received: by 2002:adf:df10:: with SMTP id y16mr22217001wrl.225.1593525072573;
        Tue, 30 Jun 2020 06:51:12 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:11 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 00/30] Last batch of patches to clean up Misc
Date:   Tue, 30 Jun 2020 14:50:40 +0100
Message-Id: <20200630135110.2236389-1-lee.jones@linaro.org>
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

Lee Jones (30):
  misc: genwqe: card_ddcb: Fix a variety of kerneldoc issues
  misc: genwqe: card_sysfs: Demote function/file headers from kerneldoc
  misc: genwqe: card_debugfs: Demote file header from kerneldoc
  misc: sgi-xp: xp_main: Staticify local functions xp_init() and
    xp_exit()
  misc: ibmasm: event: Demote function headers from kerneldoc
  misc: ibmasm: command: Demote function headers from kerneldoc
  misc: vmw_vmci_defs: 'struct vmci_handle VMCI_ANON_SRC_HANDLE' cannot
    be static
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

 drivers/misc/cxl/flash.c             |  7 ++---
 drivers/misc/cxl/hcalls.c            | 42 ++++++++++++++--------------
 drivers/misc/eeprom/at24.c           |  2 +-
 drivers/misc/genwqe/card_ddcb.c      | 20 +++++++++----
 drivers/misc/genwqe/card_debugfs.c   |  2 +-
 drivers/misc/genwqe/card_sysfs.c     |  8 +++---
 drivers/misc/ibmasm/command.c        |  6 ++--
 drivers/misc/ibmasm/dot_command.c    |  6 ++--
 drivers/misc/ibmasm/event.c          |  4 +--
 drivers/misc/ibmasm/r_heartbeat.c    |  2 +-
 drivers/misc/ibmvmc.c                |  6 ++--
 drivers/misc/mic/card/mic_debugfs.c  | 10 +++----
 drivers/misc/mic/cosm/cosm_debugfs.c |  4 +--
 drivers/misc/mic/cosm/cosm_main.c    |  1 +
 drivers/misc/mic/host/mic_debugfs.c  |  8 +++---
 drivers/misc/mic/host/mic_intr.c     |  4 ++-
 drivers/misc/mic/host/mic_x100.c     | 13 +++++++++
 drivers/misc/mic/host/mic_x100.h     |  9 ------
 drivers/misc/mic/scif/scif_api.c     |  6 ++--
 drivers/misc/mic/scif/scif_dma.c     |  3 +-
 drivers/misc/mic/scif/scif_epd.c     |  9 ++++++
 drivers/misc/mic/scif/scif_fence.c   | 34 +++++++++++++---------
 drivers/misc/mic/scif/scif_nm.c      | 17 +++++------
 drivers/misc/mic/scif/scif_nodeqp.c  | 18 +++++++-----
 drivers/misc/mic/scif/scif_ports.c   |  9 +++---
 drivers/misc/mic/scif/scif_rma.c     | 12 ++++++--
 drivers/misc/ocxl/config.c           | 18 ++++++------
 drivers/misc/sgi-xp/xp_main.c        |  4 +--
 include/linux/vmw_vmci_defs.h        |  2 +-
 29 files changed, 165 insertions(+), 121 deletions(-)

-- 
2.25.1

