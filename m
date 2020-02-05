Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C116C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E70D217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580910591;
	bh=60KwhO2177ORVClH4AdnGJoVBBb6iFRzm5g/PSOixTw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=tU1QF/IAvDtfZXVdr3l0E+9DcX/Y8E30x05VY7IDAHf1hrGwlrlgqwmqr8vbKBqj+
	 oX8/cDJQPZ4d0DkJyG+jUmYDOd4QvRt3TnyM+ggFtKwH3uV17jvSdrBXe8kDxMYtVS
	 aSXlIlaeK+R0oSRQVhU3o1rp9bi9fnmEVgHh+EP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgBENtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:49:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727956AbgBENtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:49:49 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 960D620702;
        Wed,  5 Feb 2020 13:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580910589;
        bh=60KwhO2177ORVClH4AdnGJoVBBb6iFRzm5g/PSOixTw=;
        h=From:To:Cc:Subject:Date:From;
        b=0JGyaMIiIvPgRzRyesX9+RGREvLiHXJMFtJaKawcYHTWAgD42NqS9q77xaELWMPqo
         A+7R3L4ZEOsMeybupGB5MFfkFs9gu8d/+NGcEohG6+7nHTq9ou5+15WXdq3fq0rNsI
         T1kjLRxwBkdGRxZTDIN0XFugEi3qCy9G3nuuK0Y8=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/4] bootconfig: Show more error information
Date:   Wed,  5 Feb 2020 22:49:45 +0900
Message-Id: <158091058484.27924.11216788166827115442.stgit@devnote2>
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

Here are some patches to show more error information and
the number of nodes on boot message and bootconfig tool.

Since the max number of the nodes are limited and it is hard
to count the number of nodes while writing the config file,
it is better that the bootconfig command informs user the
current number of the node.

Thank you,

---

Masami Hiramatsu (4):
      bootconfig: Use bootconfig instead of boot config
      bootconfig: Add more parse error messages
      tools/bootconfig: Show the number of bootconfig nodes
      bootconfig: Show the number of nodes on boot message


 init/main.c             |   10 ++++++----
 lib/bootconfig.c        |   21 ++++++++++++++++-----
 tools/bootconfig/main.c |    1 +
 3 files changed, 23 insertions(+), 9 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
