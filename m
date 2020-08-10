Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5E6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B1E620709
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597048478;
	bh=wewKwc4xUwr9h/bb9kd7UBaLlXoMikQvARf5mWKr0dM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S14ukLjs3m+hed8JiNQQdpdWCljz7tfHmxQXgM8/2XNEkQ74q7E+ApsPaotgPguaV
	 C4pqXqYBUuiJrIG1RUHqg25bkLTdFnOqrKFnppPm+10Zs5FjJGzt/kSWm6LBlBmxWq
	 Wm/kpyI3Ca/zu7psJmIHiJkes0U3LzmVa11zSkTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgHJIeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgHJIeg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:34:36 -0400
Received: from localhost.localdomain (unknown [180.22.250.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE14F2065C;
        Mon, 10 Aug 2020 08:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597048476;
        bh=wewKwc4xUwr9h/bb9kd7UBaLlXoMikQvARf5mWKr0dM=;
        h=From:To:Cc:Subject:Date:From;
        b=Pth+6cBlLEHUqy8C8GAIZP1v2wxbT5pcqyzClgw4bu1lPqw886umU8d8zsNuv0Muw
         nVfcnBRgA0g6wu5RRxiRDxk1MbD0hwGTKtRa40BaJjFYe1P3FKT/vFtbFF6lgR1N4e
         0XdDajTScWsocu+ZzNCcJDnZnU+8m9ndbcu/Up6o=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/6] tools/bootconfig: Add boot-time tracing script
Date:   Mon, 10 Aug 2020 17:34:30 +0900
Message-Id: <159704847064.175360.3292152056631660862.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a series of patches to introduce scripts for the boot-time tracing.

- bconf2ftrace.sh generates a shell script from a bootconfig file which
  setup ftrace via tracefs. This is useful for checking whether your
  boot-time tracing bootconfig is working as you expected.

- ftrace2bconf.sh generates a bootconfig file from current ftrace setting.
  You can set up the ftrace manually and run a test on it before dump it
  to a bootconfig file.
  Note that some function-tracer/fgraph-tracer options are not supported
  by ftrace2bconf.sh, because the original wildcard expression has been
  lost during setup ftrace.

Also, this series improve the bootconfig command to increase usability.

- The bootconfig can format the bootconfig file without initrd. You don't
  need a dummy initrd anymore :)
- The bootconfig command supports -l (format as a list) option which
  outputs the bootconfig as a key-value list, as same as /proc/bootconfig.


Thank you,

---

Masami Hiramatsu (6):
      tools/bootconfig: Show bootconfig compact tree from bootconfig file
      tools/bootconfig: Add list option
      tools/bootconfig: Make all functions static
      tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig
      tools/bootconfig: Add a script to generates bootconfig from ftrace
      tools/bootconfig: Add --init option for bconf2ftrace.sh


 tools/bootconfig/main.c                  |  147 +++++++++++++-----
 tools/bootconfig/scripts/bconf2ftrace.sh |  199 ++++++++++++++++++++++++
 tools/bootconfig/scripts/ftrace.sh       |  109 +++++++++++++
 tools/bootconfig/scripts/ftrace2bconf.sh |  244 ++++++++++++++++++++++++++++++
 tools/bootconfig/scripts/xbc.sh          |   56 +++++++
 5 files changed, 713 insertions(+), 42 deletions(-)
 create mode 100755 tools/bootconfig/scripts/bconf2ftrace.sh
 create mode 100644 tools/bootconfig/scripts/ftrace.sh
 create mode 100755 tools/bootconfig/scripts/ftrace2bconf.sh
 create mode 100644 tools/bootconfig/scripts/xbc.sh

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
