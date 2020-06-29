Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D4AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63CC20672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="WyYrYczh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbgF2Tjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgF2Thm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE8BC02F008
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:48:51 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so15662357wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxWvZji5uwPrBPLXbTQpjJxSQCSpKGpn8looTURrQN8=;
        b=WyYrYczh0g57iO1M/3PZQmqqn0ef7wzvX9DLIV1uukA+2PpqHYZ7E6OBj6I7s17huF
         xmGWQRdLEubX+y6SkKC54vXAFQ6Xl/CTDEx/3KylJCe/LlZhOzvq1ElIEgk8Oa7GAkmQ
         fYm66uB0xFybdfCb4r9EeDsd00vpmTOZ8y96W7AK552t1dlbgF1QcStEa/8CUVbTKJc/
         ely4zsciMu3Fyo29Ujl2EWo4okAYj2xsRXgj1HIjUznpZL1Ie73LfKfv2kNYGQVi4Mg9
         RDQ39xjVRpeENYn7Upp83vdvwviKs08pkCW50ZCIxE2z0G0z/aaMlFa+x4uppoMBDjVN
         sNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZxWvZji5uwPrBPLXbTQpjJxSQCSpKGpn8looTURrQN8=;
        b=PBpIgyFaddagAh/8iQwGLXzRJ07HExy/97LNJQH8bl8BzC2BTUw15UJcVAE6BQ3/vc
         mgeKnE4Sdwfb5Ye2ZbHixlPA8wiWJngmN1tGfpkTYMK727BXReQ3f5wpS/th+yzOaFAg
         wC9tz4yMNwmLQBX0Q8lnLsZIwLxcTrwlRLNhtUn1QNFgQVuQ1Y2Al1uqTnfIZY4IW9ya
         T2cNDQ6DhwyHLnvmKsbxlblgg11U6valRYBhBfXtH2oHzUny1uvkdxNlbub6o3+4JFKl
         5CkRZUaau8YMfZCJGcbWaSOwnS7/bp7GLiR3fZSce80Mxp0tW8yZ5lo5Kd4oFWYtc+X7
         RALA==
X-Gm-Message-State: AOAM530ap6+KnvF+oUoV2/jmot/0ZZJDeEdNZcy9PijdXXMBZFZZrzeZ
        P79rsTJE4wJwE0J7k4WsRCOXtdUGxpwYOw==
X-Google-Smtp-Source: ABdhPJyhcL6Zm2U1C2In86LV4SojZFiIqTxId35maboanIazbArCthThg95opG9C6764Isy3fZHRpA==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr17249958wmk.143.1593442129517;
        Mon, 29 Jun 2020 07:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s8sm42786336wru.38.2020.06.29.07.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:48:48 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH v2 0/3] x86/dumpstack: Print registers with the same log level as the backtrace
Date:   Mon, 29 Jun 2020 15:48:44 +0100
Message-Id: <20200629144847.492794-1-dima@arista.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1 [3]:
- Use (enum show_regs_mode) instead of (int) [nit by Jann, thanks!]
- Add acks from Petr

show_trace_log_lvl() provides x86 platform-specific way to unwind
backtrace with a given log level. Unfortunately, registers dump(s) are
not printed with the same log level - instead, KERN_DEFAULT is always
used.

Arista's switches uses quite common setup with rsyslog, where only
urgent messages goes to console (console_log_level=KERN_ERR), everything
else goes into /var/log/ as the console baud-rate often is indecently
slow (9600 bps).

Backtrace dumps without registers printed have proven to be as useful as
morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
(which I believe is still the most elegant way to fix raciness of sysrq[1])
the log level should be passed down the stack to register dumping
functions. Besides, I have a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level than the backtrace).

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jann Horn <jannh@google.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/
[3]: https://lore.kernel.org/lkml/20200623162958.331051-1-dima@arista.com/
Dmitry Safonov (3):
  x86/dumpstack: Add log_lvl to show_iret_regs()
  x86/dumpstack: Add log_lvl to __show_regs()
  x86/dumpstack: Show registers dump with trace's log level

 arch/x86/include/asm/kdebug.h |  5 ++--
 arch/x86/kernel/dumpstack.c   | 23 +++++++++-------
 arch/x86/kernel/process_32.c  | 29 ++++++++++----------
 arch/x86/kernel/process_64.c  | 51 ++++++++++++++++++-----------------
 4 files changed, 57 insertions(+), 51 deletions(-)

-- 
2.27.0

