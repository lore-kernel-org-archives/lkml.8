Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9652EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7291820835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 15:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591975394;
	bh=aZ5zbFgUlr+jWJ0e8ysaxSNTCOeYD7NUs6V0V1Bpp8c=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=CpvD/mTDYTBs5opNqS1prOWSo/Ay8ZXtdINrq7qOnTMFNgBkRDAQn/aELt0bIsuYZ
	 IHauwdSwTaFvQGqHMWggb18MhNVSeKHMaal6E3pfsmAvAWbCBt0JaP/L6+osNM/n08
	 N7iK0Y6rBclDQen58BU5+T7VkccoHSRlI+WHwAAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgFLPXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 11:23:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:43030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgFLPXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 11:23:12 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89098206A4;
        Fri, 12 Jun 2020 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591975392;
        bh=aZ5zbFgUlr+jWJ0e8ysaxSNTCOeYD7NUs6V0V1Bpp8c=;
        h=From:To:Cc:Subject:Date:From;
        b=BtAGtrLF01Hpw0qjYokpggMJh566Y3yNxB0TUBFVY1pWz9YVMWT9ABbWqGFyZy1JA
         sKNJ3iVlwnNLFNBV8pVAqPxxs9168/guKp2Y1cQkqXxBfyDWvAcDWLZaUcpdgy5siM
         4gAjTe0Alq1i/w3IkEZFVqhSCR31Wqps68g27OkE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] bootconfig: Fix quote-character issue and return value
Date:   Sat, 13 Jun 2020 00:23:08 +0900
Message-Id: <159197538852.80267.10091816844311950396.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

I found 2 bugs in /proc/bootconfig and tools/bootconfig.

- They always use double-quote to quote values. For the values
  which includes double-quote, it should use single-quote instead.
- tools/bootconfig always returns error code if it shows the
  bootconfig in initrd (executed without options)

This series fixes those bugs and add testcases to ensure
no regressions.

Thank you,

---

Masami Hiramatsu (4):
      proc/bootconfig: Fix to use correct quotes for value
      tools/bootconfig: Fix to use correct quotes for value
      tools/bootconfig: Fix to return 0 if succeeded to show the bootconfig
      tools/bootconfig: Add testcase for show-command and quotes test


 fs/proc/bootconfig.c                |   13 +++++++++----
 tools/bootconfig/main.c             |   18 +++++++++++-------
 tools/bootconfig/test-bootconfig.sh |   10 ++++++++++
 3 files changed, 30 insertions(+), 11 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
