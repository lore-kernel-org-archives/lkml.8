Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D3DC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B744520848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583234676;
	bh=rv9OqmSphTP2/Bi7sPUwcbWh5FMkNeF2by0BEe7Sn6I=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=zKaUpvSapuc0R1J+EjV9gkhJoBckaNKZ9/0At0Od8kjlO+/pTV9XNfje6s+INveHX
	 C0f7LfUbdegQ0lEH0wd/n8361F07T7+7ZwXUbBqbgODR1RaZ0WmXz+1Gpwl9/sc33Z
	 HVzZJjViOQQkq5iOONlxDhgur5hXF2ybGVSU89+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgCCLYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:24:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728928AbgCCLYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:24:35 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B3C820836;
        Tue,  3 Mar 2020 11:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583234674;
        bh=rv9OqmSphTP2/Bi7sPUwcbWh5FMkNeF2by0BEe7Sn6I=;
        h=From:To:Cc:Subject:Date:From;
        b=Dbun/+OzK23dwpHsIUxgDaAJRJUj5UO9FayvErqiPSef/P3JjiLBcHvE8/sAP2rMo
         /O+Wq1G7CD+KM7gndunf+WR+f5k/2Ae5jzGsV7FfZEIYpVjrVsDOiYidFnl6Sbsjjz
         dxVrVXXJKI0m+V4hwGyYkeoncU2VaxqTBtKA6cn4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/2] tools/bootconfig: Add O= option and enhance error message
Date:   Tue,  3 Mar 2020 20:24:30 +0900
Message-Id: <158323467008.10560.4307464503748340855.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are patches to update tools/bootconfig to add O= option
support and enhance error message so that user can easily
locate the error position.

Thank you,

---

Masami Hiramatsu (2):
      bootconfig: Support O=<builddir> option
      tools/bootconfig: Show line and column in parse error


 include/linux/bootconfig.h          |    3 ++-
 init/main.c                         |   14 ++++++++++----
 lib/bootconfig.c                    |   35 ++++++++++++++++++++++++++---------
 tools/bootconfig/Makefile           |   27 +++++++++++++++++----------
 tools/bootconfig/main.c             |   35 +++++++++++++++++++++++++++++++----
 tools/bootconfig/test-bootconfig.sh |   14 ++++++++++----
 6 files changed, 96 insertions(+), 32 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
