Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13BBC54E4A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCD4C24957
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 23:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a2OffO+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgEIXlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 19:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727124AbgEIXlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 19:41:11 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B794C05BD0A
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 16:41:11 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id f23so2007620pgj.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LN02kQGLgElFDT6YhRYkfrDyShhneRM4gygOe7piDXw=;
        b=a2OffO+4m00dWKoHHUMauc+9jzQitgt4pi5ica/PG9O+dw/0wGtT6L+v2xUTv9XT1e
         iNdEQJVHXZOZW0hpuyCL4cSKScaWt/EWbnysgj0OTX9SwhZiWxil5wqslLkSp25G6e3m
         JEcY8KRnfLgY67mjWFvFRdcLvho/YQqSPY/WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LN02kQGLgElFDT6YhRYkfrDyShhneRM4gygOe7piDXw=;
        b=c1G6m4uyEqA4ir5txTtP7Mg+X7i3pEKcRG6OOxNNcIW7l84574mNtYdwVarijz4OiY
         fOxxbkg0h7IVbj+wF4jNegPP/y+XnyH6hjy94foiXCQKhhvc818l1km0DDKmX/B3QMT4
         j3vMr5BAm+rS34InPTpc2QbrpOaC0hpphH6IcNUMKFRsgXlZAYhXBAY+hCh2WPkeQwRl
         AfHUjKA/LtrsJtoS47Vn3KzkOBqwIEvVAMV+pJ66JDHwQCQlvGSc//ZN8NiFzJHn7pfu
         XSqDOvvcmCgY69Uby8IGt3aIg4a12LFUmUsLEjPdhl35+gW2XkylwQSvJF7xjpbxJqAs
         oOMA==
X-Gm-Message-State: AGi0PubwVpzzl0UnWsbGuwEqxFyGXuzfiyWKyhQHL/1uK6EWYSnclqMD
        YnQCbon22BuQCIwhad40xb/v0g==
X-Google-Smtp-Source: APiQypIkzVjEFHa2Lrg3QC1KeNRQ6+ilOe2KWxjDWNTEq5yVdbPKmnUsIO6mBJKyCEQYBRh4Q1LiuA==
X-Received: by 2002:a63:9e53:: with SMTP id r19mr8385908pgo.5.1589067670765;
        Sat, 09 May 2020 16:41:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b16sm5448636pfp.89.2020.05.09.16.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 16:41:06 -0700 (PDT)
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
Subject: [PATCH v6 00/18] pstore: mtd: support crash log to block and mtd device
Date:   Sat,  9 May 2020 16:40:45 -0700
Message-Id: <20200509234103.46544-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Okay, I'm happy enough with this series to get it landed so we can start
doing incremental changes, etc. Here's the v6 I'll land in for-next/pstore
unless there's some objection.

Thank you again for all your patience! As you can see, I had a lot of
things I needed to fix up in the core pstore code, and I had a lot of
opinions about names. ;) I'm glad to have a block device backend for
this -- it makes testing the core much easier.

After spending so much time looking at pstore/zone, I've got some ideas
about how to merge it with pstore/ram's way of doing things. For example,
I'd like to get ECC support into pstore/zone, and once it's generalized
enough, I think other storage systems (EFI?) could use it to solve
some problems there (growing without bounds, not supporting the other
frontends, etc).

One last thought I had on naming would be to have mtdpstore be named
pstore_mtd.c, etc. That'd make it more like pstore/zone,blk,ram,
etc. (I'd really like to get pstore/ram renamed and keep the "ramoops"
name for backward compat.) What do you think about that?

Thanks!

-Kees


v6:
- more renamings, typo fixes, rewordings
- reset pstore_zone global counters/state on unregister
- add best_effort param to allow easy block device testing
- extract ftrace merging code from ram.c to avoid duplication
- use backend name for console name
- rearrange module parameters

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
 fs/pstore/blk.c                          |  571 +++++++++
 fs/pstore/ftrace.c                       |   54 +
 fs/pstore/internal.h                     |    9 +
 fs/pstore/platform.c                     |   40 +-
 fs/pstore/ram.c                          |   70 +-
 fs/pstore/zone.c                         | 1463 ++++++++++++++++++++++
 include/linux/kmsg_dump.h                |    7 +
 include/linux/pstore.h                   |    2 +-
 include/linux/pstore_blk.h               |   77 ++
 include/linux/pstore_zone.h              |   60 +
 kernel/printk/printk.c                   |   21 +
 18 files changed, 3220 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/admin-guide/pstore-blk.rst
 create mode 100644 drivers/mtd/mtdpstore.c
 create mode 100644 fs/pstore/blk.c
 create mode 100644 fs/pstore/zone.c
 create mode 100644 include/linux/pstore_blk.h
 create mode 100644 include/linux/pstore_zone.h

-- 
2.20.1

