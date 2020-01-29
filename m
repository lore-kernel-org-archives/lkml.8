Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D6B1C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7DB2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580290591;
	bh=+FanBVM14tAK6ZplYSaFihP2YgUbZwG+nxNI0QjKp18=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TR/bAr/wQborOW/8lyjpPM1KGJK/3X1fXIiBtGpGTLlUYIuWXH/Gc9twGoy3KI9Fk
	 J4MMHk2VFhCjvYErEOJ1LaAu/CiBd+xjvllSLUF1LyVL7KQilnUrGVabH3Fxpz0e2F
	 eeZev0Fjfwbb9xAUg0YzKpe2/ap2uRVBcVXZILrE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgA2Jga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:36:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:47158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgA2Jga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:36:30 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B73B20716;
        Wed, 29 Jan 2020 09:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580290589;
        bh=+FanBVM14tAK6ZplYSaFihP2YgUbZwG+nxNI0QjKp18=;
        h=From:To:Cc:Subject:Date:From;
        b=H+CZNO3SbbCiOqq4+Y8bqXGIR+cdxusQrw46+9n9u7Dx8alOND101z4H1qHUz8Fx5
         CMC5IqbM/e1M8mBS86rQmO83vF+HrC3cMO60l1ToNTPI+/b67KtowmhaM3FdbhVxnC
         Aoc+syhvsgrFgzXQK9j4oH5eltZZxd0OQ7chyhV4=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] tracing/boot: Cleanup prototypes
Date:   Wed, 29 Jan 2020 18:36:24 +0900
Message-Id: <158029058421.12381.6615257646562417558.stgit@devnote2>
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

Here is a couple of patches to cleanup prototypes and includes
in boot time tracer.
I left 2 externs in trace_boot.c which will be removed by
Tom's in-kernel dynamic event API series.

Thank you,

---

Masami Hiramatsu (2):
      tracing/boot: Include required headers and sort it alphabetically
      tracing/boot: Move external function declarations to kernel/trace/trace.h


 kernel/trace/trace.h      |   17 +++++++++++++++++
 kernel/trace/trace_boot.c |   24 ++++++++----------------
 2 files changed, 25 insertions(+), 16 deletions(-)

--
Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
