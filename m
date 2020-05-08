Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F4C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1400020870
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AGitAEjA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgEHGkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726897AbgEHGkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:40:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB3FC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:40:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z1so446471pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 23:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiQcUnaOsTuYIdMr9pQhA9E0vZ/bgcYyUJ6NKwIoiA8=;
        b=AGitAEjAmIYuKXy+lG43wJaRD8vsDY21A7oS+DPw/WXhdya0M2b77Hp2SjGy4IDeA7
         0mXKCAbk5gyUBklW+6pHdkHCR05KcSgPpdfyhoVoNan7SFIeqEK/VVjckLgwFwrYPTDZ
         OpOCzvcEaiQZBjlPAHAPh8sFU5hMWxw/60ScM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qiQcUnaOsTuYIdMr9pQhA9E0vZ/bgcYyUJ6NKwIoiA8=;
        b=A6b9cXEcPUP9UF88XfwTQsAoKgryqwhN4a27XT5GoHEen0mR8WIR9FKC0urffCzBM9
         kSBLlUxiTgPzkn6PgfwNmF/yApKiveuRCCoIFQ4bl8bGWKBPNETuvvUybsvkhYnLjBHD
         uDXk1ii6dRpa+okhTYk181sn14mKgJcsNlMO1TAJCwHa96TBFHsoeOAp5GgQJg0jiiuB
         vsVO30kfVKmrOesb19vYz6fkpUX28uXZgoQUQxRaoIIAyje95nZU3i/CgKxDw+oHgrEc
         SB+SIU4GhgupUm0DXn4hnprvbMuX2waPsYksP0jd0FSAA8kdqp1bEo1TnAjzZRKzyeu8
         xsIA==
X-Gm-Message-State: AGi0PuZ2JF9udLHQ7bDoG3qqQMAfqUZtLOtMA7pEnOSBru87+hRcFbFB
        wQuBuifSpWdFhMwq+e4G5D9kWA==
X-Google-Smtp-Source: APiQypLhC9jPG3VyD0chnEVvbTzcUfM6EnXrvWXuM3nZ1Jmch+lbDR8507FGYLZRkZnFAwwsLzJRtg==
X-Received: by 2002:a63:b649:: with SMTP id v9mr832219pgt.402.1588920013880;
        Thu, 07 May 2020 23:40:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 140sm757265pfw.96.2020.05.07.23.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 23:40:12 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/12] pstore: mtd: support crash log to block and mtd device
Date:   Thu,  7 May 2020 23:39:52 -0700
Message-Id: <20200508064004.57898-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is a v4 of WeiXiong Liao's series. I spent time porting this on top
of the latest pstore (mainly to support max_reason), and I started making
various other changes, mostly just bikeshed stuff.

Changes since v3:
	fixing up various typos, alternate phrases, and language. For
	example:
	        recorder -> frontend
	        Pstore -> pstore

	filenames:
	        rename pstore_*.c -> *.c and adjust Makefile
		(I decided fs/pstore/pstore_zone.c repeated "pstore" one too many time. ;)
		pstore-block.rst -> pstore_blk.rst

	conversion of dump_oops -> max_reason

	refactor/rename get_reason_str() and move to kernel/printk/printk.c

	psz* -> pstore_zone* renamings:
	        psblk_usr_info() ->... pstore_blk_usr_info()
	        psz_zone -> pstore_zone
	        pszinfo -> pstore_zone_info

	register_pstore_zone():
	        registration reporting via pr_cont(), with max_reason
	        remove needless get/put_module()

	public API renamings: VERB_NOUN()
	        psz_*register() -> *register_pstore_zone()

v3: https://lore.kernel.org/lkml/1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com/
v2: https://lore.kernel.org/lkml/1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com/
v1: https://lore.kernel.org/lkml/1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com/

So far, I've identified the following stuff left to do:
        - settle on various function/struct renamings
        - review locking
        - implement ramoops-like probe feature for pstore/blk
	- spend time seeing how ramoops might use pstore/zone

But I wanted to get this update published just to show what I've done
so far in my bikeshed review. :)

Thanks!

-Kees


Kees Cook (1):
  printk: Introduce kmsg_dump_reason_str()

WeiXiong Liao (11):
  pstore/zone: Introduce common layer to manage storage zones
  pstore/blk: Introduce backend for block devices
  pstore/blk: Provide way to choose pstore frontend support
  pstore/blk: Add support for pmsg frontend
  pstore/blk: Add console frontend support
  pstore/blk: Add ftrace frontend support
  Documentation: Add details for pstore/blk
  pstore/zone: Provide way to skip "broken" zone for MTD devices
  pstore/blk: Provide way to query pstore configuration
  pstore/blk: Support non-block storage devices
  mtd: Support kmsg dumper based on pstore/blk

 Documentation/admin-guide/pstore-blk.rst |  243 ++++
 MAINTAINERS                              |    1 +
 drivers/mtd/Kconfig                      |   10 +
 drivers/mtd/Makefile                     |    1 +
 drivers/mtd/mtdpstore.c                  |  564 ++++++++
 fs/pstore/Kconfig                        |  109 ++
 fs/pstore/Makefile                       |    6 +
 fs/pstore/blk.c                          |  481 +++++++
 fs/pstore/platform.c                     |   22 +-
 fs/pstore/zone.c                         | 1498 ++++++++++++++++++++++
 include/linux/kmsg_dump.h                |    7 +
 include/linux/pstore_blk.h               |   77 ++
 include/linux/pstore_zone.h              |   60 +
 kernel/printk/printk.c                   |   21 +
 14 files changed, 3079 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/admin-guide/pstore-blk.rst
 create mode 100644 drivers/mtd/mtdpstore.c
 create mode 100644 fs/pstore/blk.c
 create mode 100644 fs/pstore/zone.c
 create mode 100644 include/linux/pstore_blk.h
 create mode 100644 include/linux/pstore_zone.h

-- 
2.20.1

