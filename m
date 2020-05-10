Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534CBC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2951D206F5
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jxnIlVzj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729388AbgEJUYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729356AbgEJUYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:24:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A33C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:45 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k7so1771477pjs.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMnvmwdf0lD4TWDxpQeCiDqgUg/BNY/6yd0J6c0RUaw=;
        b=jxnIlVzjg4LuX0x4ZxxB1JEkhMutYk9n+d2bj8maSEKQYCpP8QW0AvSZM2+MydWo17
         hFg6spS4Y8qyZldiFLK7H6lD7DqCwh+ptn93hbbWPLowJU5q3HpQS2XQ7NI8YXkdrfmC
         XKExDDq/gQbLg5YH+GX/v6KMd7og+GDHK5M8k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jMnvmwdf0lD4TWDxpQeCiDqgUg/BNY/6yd0J6c0RUaw=;
        b=RmJE6OtlUTV0kBqQQr4arS0F9qo/e9w2WFF0e5tRZ/flWCeZF0N+S+ffENYMO9JJlX
         vuYl7q74DRk9WKMWdPEI7Jicft0Tc1QQRulWrfIu1eD39C63SVEicoVi9KrzYOMF/Ntf
         Yeon5gGCtM649bIE+4/OzSjs6hqxmOJKphy/ZnND83JRQAElbDuxM1FkimHoCytONocx
         l5TmftfbtpY9VSjLaFnNIEaxzx4YrA47AFdjkB1o3zHSZKHp/jJidbZGiYM3t9cvHYJs
         TuyeKCgFvCY0yKPq1fEp48Lbw3HxhwaBqr6Xqb5SmrUQxxTuwftdG5ddSft6V5X6WnD7
         NHyA==
X-Gm-Message-State: AGi0PubqeHKHzC2ZwdF3x6PgaORsAvCsJoBWlldzrXMaxMGUwuUiHBdJ
        hXIOzhxdKK2nbUtPoBCKkNT3jQ==
X-Google-Smtp-Source: APiQypLvN7WjM+iFu647e6o7NyvuJP0SZANsYUCqdd2Q7tf4QMuUe/X50yR6CDzAlEROB6zdXlLglg==
X-Received: by 2002:a17:902:9b8e:: with SMTP id y14mr12182467plp.109.1589142285531;
        Sun, 10 May 2020 13:24:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id gm3sm7871240pjb.49.2020.05.10.13.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 13:24:41 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v7 00/18] pstore: mtd: support crash log to block and mtd device
Date:   Sun, 10 May 2020 13:24:18 -0700
Message-Id: <20200510202436.63222-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Well, I guess I spoke too soon. :) Here is v7. Hopefully this is
it. WeiXiong, can you test this and make sure you're happy with the
results?

Take care!

-Kees

v7:
- more renamings in the exported APIs and structs
- fix mtd build
- replace psblk_blkdev_info with passing in a struct to fill
- consolidate bdev opening/checking
- rename psblk_device -> pstore_device_info
- kerndoc for pstore_blk_get_config
- fix hunks in wrong patch
- add missing "static"s for local functions (0day)

v6: https://lore.kernel.org/lkml/20200509234103.46544-1-keescook@chromium.org/
v5: https://lore.kernel.org/lkml/1589022854-19821-1-git-send-email-liaoweixiong@allwinnertech.com/
v4: https://lore.kernel.org/lkml/20200508064004.57898-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com/
v2: https://lore.kernel.org/lkml/1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com/
v1: https://lore.kernel.org/lkml/1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com/


Kees Cook (8):
  pstore/ram: Move dump_oops to end of module_param list
  pstore/platform: Switch pstore_info::name to const
  pstore/platform: Move module params after declarations
  pstore/platform: Use backend name for console registration
  pstore/ram: Refactor ftrace buffer merging
  pstore/ftrace: Provide ftrace log merging routine
  printk: Introduce kmsg_dump_reason_str()
  pstore/blk: Introduce "best_effort" mode

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

 Documentation/admin-guide/pstore-blk.rst |  243 ++++
 MAINTAINERS                              |    1 +
 drivers/mtd/Kconfig                      |   10 +
 drivers/mtd/Makefile                     |    1 +
 drivers/mtd/mtdpstore.c                  |  564 +++++++++
 fs/pstore/Kconfig                        |  109 ++
 fs/pstore/Makefile                       |    6 +
 fs/pstore/blk.c                          |  520 ++++++++
 fs/pstore/ftrace.c                       |   54 +
 fs/pstore/internal.h                     |    9 +
 fs/pstore/platform.c                     |   40 +-
 fs/pstore/ram.c                          |   70 +-
 fs/pstore/zone.c                         | 1463 ++++++++++++++++++++++
 include/linux/kmsg_dump.h                |    7 +
 include/linux/pstore.h                   |    2 +-
 include/linux/pstore_blk.h               |  118 ++
 include/linux/pstore_zone.h              |   60 +
 kernel/printk/printk.c                   |   21 +
 18 files changed, 3210 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/admin-guide/pstore-blk.rst
 create mode 100644 drivers/mtd/mtdpstore.c
 create mode 100644 fs/pstore/blk.c
 create mode 100644 fs/pstore/zone.c
 create mode 100644 include/linux/pstore_blk.h
 create mode 100644 include/linux/pstore_zone.h

-- 
2.20.1

