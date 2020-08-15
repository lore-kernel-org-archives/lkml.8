Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C9E8C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A27D20657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529509;
	bh=nTbooeHnOQNWyi9FSAgCRBTzajO/a6wRi+aGZk8krpg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G+Mom9emjrkyqWpDwLJN2lHInvoMfMDt3FuvkJHVKxGw0wuXroYTo3s2Ndy2VpAav
	 a+cGy7ZqHv20BfUrJQ9sqBPpejZnGLFVBNUVHFrwNXrKvkj88RuhnUOIhkA2z3S1DS
	 0Z5jps6l4LFAKf8vtGexeMJzoacKdxtXHk25pp7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgHOWLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:11:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:41766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729357AbgHOWKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:30 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48E0B23122;
        Sat, 15 Aug 2020 14:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597500064;
        bh=nTbooeHnOQNWyi9FSAgCRBTzajO/a6wRi+aGZk8krpg=;
        h=From:To:Cc:Subject:Date:From;
        b=z6h07+JlpUWrhQFumuicQbKzh4CeaR0VYBZEkNvFfBXlHpjJbSOmHkdsfrKoENqzj
         vzRYHO6AdXB+b/zqcH16cExNLPauiJzpzUokBSTwGMDwvRBTQlotTuU37dmLezCy7O
         OjHwoxHGphyZrV3GXTMDAP+uwhfqOpwMGA98N0ZQ=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 0/6] tools/bootconfig: Add boot-time tracing script
Date:   Sat, 15 Aug 2020 23:01:00 +0900
Message-Id: <159750006069.202708.12439674123720173666.stgit@devnote2>
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

This is the 2nd version of the series to introduce scripts for the
boot-time tracing. In this version, I just updated 4/6 according to
Steve's comment.

Previous series is here:
 https://lkml.kernel.org/r/159704847064.175360.3292152056631660862.stgit@devnote2


Thank you,

---

Masami Hiramatsu (6):
      tools/bootconfig: Show bootconfig compact tree from bootconfig file
      tools/bootconfig: Add list option
      tools/bootconfig: Make all functions static
      tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig
      tools/bootconfig: Add a script to generates bootconfig from ftrace
      tools/bootconfig: Add --init option for bconf2ftrace.sh


 MAINTAINERS                              |    1 
 tools/bootconfig/main.c                  |  147 +++++++++++++-----
 tools/bootconfig/scripts/bconf2ftrace.sh |  199 ++++++++++++++++++++++++
 tools/bootconfig/scripts/ftrace.sh       |  109 +++++++++++++
 tools/bootconfig/scripts/ftrace2bconf.sh |  244 ++++++++++++++++++++++++++++++
 tools/bootconfig/scripts/xbc.sh          |   57 +++++++
 6 files changed, 715 insertions(+), 42 deletions(-)
 create mode 100755 tools/bootconfig/scripts/bconf2ftrace.sh
 create mode 100644 tools/bootconfig/scripts/ftrace.sh
 create mode 100755 tools/bootconfig/scripts/ftrace2bconf.sh
 create mode 100644 tools/bootconfig/scripts/xbc.sh

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
