Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF2C5ACBF
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E62206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0zpuQED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgCORKI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:10:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41696 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgCORKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:10:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id f11so1510126wrp.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 10:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2c5NC7DS/hFQ+9kSaUL5gHgVLY4OAyfbaAYiD0ezTVg=;
        b=p0zpuQEDYUBmGayplCo5JC8bBC5UCN4OrQ5ghlWvJQiuCZt3QLaNlLV7QEw7iylTCA
         zpWpdUMvWWGvn7NzrTaVvEoTcm+QCVsuG3FmoOKXHKcFnzM10DU0WbkFak10ph2cgxro
         kFa8qfX+Z/Ggt+XYvm5frUrOSFe+Mux7/voWf3ZtYPgN1jqW4EJ8TVjYp+I8PtyhHTJf
         2C8fJEtHbjKGhsir+xNZKISCpMW0iynNYboIDZNL7oTCgUgnvFHBGRtMFy0B/IYYBVFJ
         ibCERxVSFvIqAuJZdXRz5GU0HiokkHV1imPhP9ql/QD53S0J0NrVaYQ0IvhcfALbZLGV
         wZeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2c5NC7DS/hFQ+9kSaUL5gHgVLY4OAyfbaAYiD0ezTVg=;
        b=ruG5mWGk1senH+zWXWVM2CcihFnpVZd+UJlJ8HFbfkXl1UpjN91mmunXP2UgaSLMsc
         1JGiJybzyIyhEZRuqm7ey5OEx3vaqS6dr9injWg2xQu0hq8ANSLDBToYoCQrw4iwafnR
         V3+LwL3wsGvMJHzJPxSIB9r/mj1IpioN+vXdCe0RhooCB9hfaWa6sPaRUVWzzkwO2R+g
         bszy0Hl5SrbWqKB4pHilTTNcZryeB/86PZtVucV8h5KywfDj/nNILzVnO9NuCNdHqRcw
         o814ZHR/ocYZlCJgVdrlYiE+6AWUZyUCRAu+1sftwZz1CWA4vJh73SBJhIBayqs00hmY
         L/7w==
X-Gm-Message-State: ANhLgQ0etmTHDF5y/4d0A5bgPTf8S+GccXltsUex7qg2ErJtv91cx3D2
        fQUthrjKVeuw92X67XD8757Cas1dwqa9ekHZ
X-Google-Smtp-Source: ADFU+vseNdksrPVQziekev+S0tfQ+AaruvzgCMeLZ2xwDnVzbw03Eu3C5GffQ3s7foUdergbcu5fpg==
X-Received: by 2002:a5d:694e:: with SMTP id r14mr29997479wrw.312.1584292204742;
        Sun, 15 Mar 2020 10:10:04 -0700 (PDT)
Received: from localhost.localdomain (ipb218f56a.dynamic.kabel-deutschland.de. [178.24.245.106])
        by smtp.gmail.com with ESMTPSA id u25sm25874774wml.17.2020.03.15.10.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 10:10:04 -0700 (PDT)
From:   Eugeniu Rosca <roscaeugeniu@gmail.com>
X-Google-Original-From: Eugeniu Rosca <erosca@de.adit-jv.com>
To:     linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: [RFC PATCH 3/3] watchdog: Turn console verbosity on when reporting softlockup
Date:   Sun, 15 Mar 2020 18:09:03 +0100
Message-Id: <20200315170903.17393-4-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200315170903.17393-1-erosca@de.adit-jv.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out in v5.0 commit 168e06f7937d96 ("kernel/hung_task.c:
force console verbose before panic"), users may miss crucial information
in pre-panic scenarios, depending on the loglevel value set by the
distribion/platform maintainers.

For example, assuming loglevel=3 (i.e. print EMERG/ALERT/CRIT only),
below is the output of a softlockup got with pure vanilla kernel [1].
In contrast, with current patch applied, output [2] is far more helpful.

Save potentially days/weeks/months of debugging efforts for those who:
  * deal with a softlockup whose reproduction scenario is not clear
  * are constrainted to use a low loglevel value in production
  * mostly/exclusively rely on logs like [2] post-mortem

[1] Softlockup output [loglevel=3, pure v5.6-rc5, H3ULCB]
watchdog: BUG: soft lockup - CPU#3 stuck for 22s! [modprobe:2354]

[2] Softlockup output [loglevel=3, v5.6-rc5 + this patch, H3ULCB]
[  292.259324] watchdog: BUG: soft lockup - CPU#3 stuck for 23s! [modprobe:2437]
[  292.266834] Modules linked in: <-- cut -->
[  292.302880] irq event stamp: 519660
[  292.306555] hardirqs last  enabled at (519659): [<ffffa00010082a18>] el1_irq+0xd8/0x180
[  292.314909] hardirqs last disabled at (519660): [<ffffa000100829bc>] el1_irq+0x7c/0x180
[  292.323274] softirqs last  enabled at (519658): [<ffffa00010080d0c>] __do_softirq+0x2e4/0x7c4
[  292.332179] softirqs last disabled at (519651): [<ffffa000100c3e48>] irq_exit+0x150/0x1e0
[  292.340720] CPU: 3 PID: 2437 Comm: modprobe Not tainted 5.6.0-rc5+ #96
[  292.347538] Hardware name: Renesas H3ULCB Kingfisher board based on r8a77951 (DT)
[  292.355355] pstate: 20000005 (nzCv daif -PAN -UAO)
[  292.360435] pc : lkdtm_SOFTLOCKUP+0x18/0x20 [lkdtm]
[  292.365592] lr : lkdtm_SOFTLOCKUP+0x18/0x20 [lkdtm]
[  292.370699] sp : ffff0006cd9af780
[  292.374187] x29: ffff0006cd9af780 x28: ffffa0000907d000
[  292.379757] x27: ffff0006cbaebc10 x26: ffffa000090751c0
[  292.385327] x25: ffffa0000907dfc0 x24: 0000000000000009
[  292.390896] x23: ffffa0000907d478 x22: 0000000000000000
[  292.396464] x21: ffffa0000907d340 x20: ffffa0000907d340
[  292.402034] x19: ffffa000090751c0 x18: 0000000000000000
[  292.407603] x17: 0000000000000000 x16: 0000000000000000
[  292.413171] x15: 0000000000000000 x14: ffffa00000000003
[  292.418740] x13: ffffa00010dc0180 x12: 0000000000000000
[  292.424309] x11: ffff8000bfc2401d x10: 1fffe000bfc2401d
[  292.429877] x9 : dfffa00000000000 x8 : ffffa00010082c00
[  292.435445] x7 : ffff0005fe1200ef x6 : 0000000000000000
[  292.441012] x5 : dfffa00000000000 x4 : ffff0006c82e9c50
[  292.446580] x3 : ffffa0001024b848 x2 : 0000000000000001
[  292.452147] x1 : 0000000000000000 x0 : 0000000000000000
[  292.457713] Call trace:
[  292.460351]  lkdtm_SOFTLOCKUP+0x18/0x20 [lkdtm]
[  292.465147]  lkdtm_do_action+0x40/0x44 [lkdtm]
[  292.469853]  lkdtm_register_cpoint+0x44/0xbc [lkdtm]
[  292.475099]  lkdtm_module_init+0x220/0x27c [lkdtm]
[  292.480120]  do_one_initcall+0x1c8/0x40c
[  292.484244]  do_init_module+0xb4/0x330
[  292.488185]  load_module+0x3404/0x34c8
[  292.492126]  __do_sys_finit_module+0x11c/0x13c
[  292.496787]  __arm64_sys_finit_module+0x4c/0x5c
[  292.501539]  el0_svc_common.constprop.0+0x160/0x200
[  292.506647]  do_el0_svc+0x74/0xa4
[  292.510139]  el0_sync_handler+0xc4/0x104
[  292.514257]  el0_sync+0x140/0x180

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 kernel/watchdog.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index b6b1f54a7837..cbe7e2c4c5fb 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -428,6 +428,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 			}
 		}
 
+		console_verbose_start();
+
 		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
 			smp_processor_id(), duration,
 			current->comm, task_pid_nr(current));
@@ -453,6 +455,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 		if (softlockup_panic)
 			panic("softlockup: hung tasks");
 		__this_cpu_write(soft_watchdog_warn, true);
+
+		console_verbose_end();
 	} else
 		__this_cpu_write(soft_watchdog_warn, false);
 
-- 
2.25.0

