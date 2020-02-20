Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CF3C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFA424670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582201109;
	bh=8zKBRebj3zMlhlsVYA4dH1MTx0xQ+eQ1JLnQz0mq34c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=O899al+tKakDqKgRcWiKzWMc4bag6k0tskqMElCCHunU2z4v2SVW8inFNQHgh58aa
	 Kx7yHp1eNqLwJokVzVzFDHVQT9rBVjs4mPToilwCD6RlajyE+wmwXjN60CReRtEIs8
	 dhNZMHu+0Y6ZpHhUgiAMNJ/1usAbg/DTKJ0eyKsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgBTMS2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:18:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726893AbgBTMS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:18:28 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE4A207FD;
        Thu, 20 Feb 2020 12:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582201107;
        bh=8zKBRebj3zMlhlsVYA4dH1MTx0xQ+eQ1JLnQz0mq34c=;
        h=From:To:Cc:Subject:Date:From;
        b=Ey1ngW/ZO96j8YjfdX12eWTbCM4D7nP10VPi03BTkalemNKn2ktCcvnrl2yMqeHDK
         Px4qHLdP/eQZVhuqll1vF/NW6XKVNALpWr3dK47gDprGE8b+aINOYVXLBHDnQC1pdx
         Gt5+3oqm1AvMsxNFCjmaKqYIZ/5ng4FqS+NPPeT0=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 0/8] bootconfig: Update for the recent reports
Date:   Thu, 20 Feb 2020 21:18:23 +0900
Message-Id: <158220110257.26565.4812934676257459744.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here is the 2nd version of the bootconfig updates. There are
several implementation changes and syntax fix/updates.

This version changed a bit in Kconfig and init/main.c.

 - [1/8] Use pr_warn() for warning message.
         Remove unneeded "default n" line from Kconfig.
 - [2/8][4/8] Update Kconfig comment. (data on initrd)

Thank you,

---

Masami Hiramatsu (8):
      bootconfig: Set CONFIG_BOOT_CONFIG=n by default
      bootconfig: Add bootconfig magic word for indicating bootconfig explicitly
      tools/bootconfig: Remove unneeded error message silencer
      bootconfig: Remove unneeded checksum
      bootconfig: Reject subkey and value on same parent key
      bootconfig: Overwrite value on same key by default
      bootconfig: Add append value operator support
      bootconfig: Print array as multiple commands for legacy command line


 Documentation/admin-guide/bootconfig.rst     |   37 +++++++++++-
 include/linux/bootconfig.h                   |    3 +
 init/Kconfig                                 |    3 -
 init/main.c                                  |   54 +++++++-----------
 kernel/trace/Kconfig                         |    3 +
 lib/bootconfig.c                             |   44 +++++++++++----
 tools/bootconfig/include/linux/printk.h      |    5 --
 tools/bootconfig/main.c                      |   77 +++++++++++---------------
 tools/bootconfig/samples/bad-mixed-kv1.bconf |    3 +
 tools/bootconfig/samples/bad-mixed-kv2.bconf |    3 +
 tools/bootconfig/test-bootconfig.sh          |   31 +++++++++-
 11 files changed, 164 insertions(+), 99 deletions(-)
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv1.bconf
 create mode 100644 tools/bootconfig/samples/bad-mixed-kv2.bconf

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
