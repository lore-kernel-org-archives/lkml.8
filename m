Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D059C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B05207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 02:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PtXGiI8T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgFAC53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 22:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgFAC52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 22:57:28 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93510C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 19:57:28 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so1851348plr.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 19:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=66uFmRriptB2u4UNdZzl7BDSBQpk4OJmv3zSYXSsu3U=;
        b=PtXGiI8TKztHXLe60Xd8IO/ZcCK5mcNv5KGV5+WM/LDhjuhOpueURMa+TpUgVr9Mdi
         EAb8e8XKcM8w1N5Hdx8eDc+vpj9spi2wtDnPXJ4Aw9ibNNQjqp+GN6ctutJxH+jemUch
         TMFX94/gKqCYAelOvJhwVxFx613HcmOFMCHN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=66uFmRriptB2u4UNdZzl7BDSBQpk4OJmv3zSYXSsu3U=;
        b=uXStvFq/All+xCxSqdv7uB0T9I0p+gZeW4Yz+v0d0EWUOLS0IsHpMcrwzjkbxu3a3C
         wybuNB1yKv8NVkqnxwR08a9Yp9qlcFbtAjZl6msIU7oMU/G7kmdAbmljIDKdZfs0VmSB
         iLD3K4r5Y8Hf2irBZMoABNlVfx3oj6VcyaSG27tLwX/HM07y5LbXMT+REsZcXD09IrAm
         5Zr1XYR+PxVBmCbGNUCC5wa8eoguB1n1fcd+l93eLsP+MmgAg74icrL6rrYq0fv2yX2T
         yttADJuuw58A+qDHCcYBUKj7YpC4KwXsfxMELQreE5n+3r6btgm0bq/VWnF+fnoiuCD2
         yzlA==
X-Gm-Message-State: AOAM5300jJJi3ffxXjjXOLY1XrRXoNjyPVVg37H4EsMki9+94YRl5VPH
        6vgdlbf0khumk94JznI6pZH/9g==
X-Google-Smtp-Source: ABdhPJxH75OsLbnQYtM4ldoZTN7zkFdA/IoYSgIrJ+hS3eQAXYTPguoWBnG0yeDOu62MMaeEaYvotw==
X-Received: by 2002:a17:902:7088:: with SMTP id z8mr15693664plk.71.1590980248061;
        Sun, 31 May 2020 19:57:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s6sm166116pgi.26.2020.05.31.19.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 19:57:26 -0700 (PDT)
Date:   Sun, 31 May 2020 19:57:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Luis Henriques <lhenriques@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Subject: [GIT PULL] pstore updates for v5.8-rc1
Message-ID: <202005311953.13A77CF20@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull these pstore updates for v5.8-rc1. This is a pretty big set
of changes (relative to past pstore pulls), but they've lived in -next
for a while. The biggest change here is the ability to support a block
device as a pstore backend, which has been desired for a while. A lot of
additional fixes and refactorings are also included, mostly in support
of the new features.

Thanks!

-Kees

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.8-rc1

for you to fetch changes up to 78c08247b9d3e03192f8b359aa079024e805a948:

  mtd: Support kmsg dumper based on pstore/blk (2020-05-31 19:49:01 -0700)

----------------------------------------------------------------
Fixes and new features for pstore

- refactor pstore locking for safer module unloading (Kees Cook)
- remove orphaned records from pstorefs when backend unloaded (Kees Cook)
- refactor dump_oops parameter into max_reason (Pavel Tatashin)
- introduce pstore/zone for common code for contiguous storage (WeiXiong Liao)
- introduce pstore/blk for block device backend (WeiXiong Liao)
- introduce mtd backend (WeiXiong Liao)

----------------------------------------------------------------
Kees Cook (22):
      pstore: Drop useless try_module_get() for backend
      pstore: Rename "pstore_lock" to "psinfo_lock"
      pstore: Convert "psinfo" locking to mutex
      pstore: Rename "allpstore" to "records_list"
      pstore: Convert "records_list" locking to mutex
      pstore: Add proper unregister lock checking
      pstore: Refactor pstorefs record list removal
      pstore: Add locking around superblock changes
      pstore: Do not leave timer disabled for next backend
      pstore: Remove filesystem records when backend is unregistered
      pstore: Make sure console capturing will restart
      pstore/platform: Switch pstore_info::name to const
      pstore/platform: Use backend name for console registration
      pstore/platform: Move module params after declarations
      pstore/ram: Adjust module param permissions to reflect reality
      pstore/ram: Refactor DT size parsing
      pstore/ram: Refactor ftrace buffer merging
      pstore/ftrace: Provide ftrace log merging routine
      printk: Collapse shutdown types into a single dump reason
      printk: Introduce kmsg_dump_reason_str()
      pstore/ram: Introduce max_reason and convert dump_oops
      pstore/blk: Introduce "best_effort" mode

Pavel Tatashin (3):
      printk: honor the max_reason field in kmsg_dumper
      pstore/platform: Pass max_reason to kmesg dump
      ramoops: Add "max-reason" optional field to ramoops DT node

WeiXiong Liao (10):
      pstore/zone: Introduce common layer to manage storage zones
      pstore/blk: Introduce backend for block devices
      pstore/zone,blk: Add support for pmsg frontend
      pstore/zone,blk: Add console frontend support
      pstore/zone,blk: Add ftrace frontend support
      Documentation: Add details for pstore/blk
      pstore/zone: Provide way to skip "broken" zone for MTD devices
      pstore/blk: Provide way to query pstore configuration
      pstore/blk: Support non-block storage devices
      mtd: Support kmsg dumper based on pstore/blk

 Documentation/admin-guide/pstore-blk.rst           |  243 ++++
 Documentation/admin-guide/ramoops.rst              |   14 +-
 .../bindings/reserved-memory/ramoops.txt           |   13 +-
 MAINTAINERS                                        |    1 +
 arch/powerpc/kernel/nvram_64.c                     |    4 +-
 drivers/mtd/Kconfig                                |   10 +
 drivers/mtd/Makefile                               |    1 +
 drivers/mtd/mtdpstore.c                            |  578 ++++++++
 drivers/platform/chrome/chromeos_pstore.c          |    2 +-
 fs/pstore/Kconfig                                  |  109 ++
 fs/pstore/Makefile                                 |    6 +
 fs/pstore/blk.c                                    |  517 +++++++
 fs/pstore/ftrace.c                                 |   54 +
 fs/pstore/inode.c                                  |  129 +-
 fs/pstore/internal.h                               |   11 +-
 fs/pstore/platform.c                               |  117 +-
 fs/pstore/ram.c                                    |  155 +--
 fs/pstore/zone.c                                   | 1465 ++++++++++++++++++++
 include/linux/kmsg_dump.h                          |   12 +-
 include/linux/pstore.h                             |    9 +-
 include/linux/pstore_blk.h                         |  118 ++
 include/linux/pstore_ram.h                         |    2 +-
 include/linux/pstore_zone.h                        |   60 +
 kernel/printk/printk.c                             |   32 +-
 kernel/reboot.c                                    |    6 +-
 tools/testing/selftests/pstore/pstore_tests        |    2 +-
 26 files changed, 3464 insertions(+), 206 deletions(-)
 create mode 100644 Documentation/admin-guide/pstore-blk.rst
 create mode 100644 drivers/mtd/mtdpstore.c
 create mode 100644 fs/pstore/blk.c
 create mode 100644 fs/pstore/zone.c
 create mode 100644 include/linux/pstore_blk.h
 create mode 100644 include/linux/pstore_zone.h

-- 
Kees Cook
