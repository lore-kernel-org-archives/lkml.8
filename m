Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF3C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A1220637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AvYTglIG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgCORJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:09:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51238 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728915AbgCORJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:09:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id a132so15129642wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 10:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yc4/8+r9LFoveyNvlviiorm4oDVYhtlLmMrWk1tR/FQ=;
        b=AvYTglIGHkt2gGzakwKBWFsG6tS7qnh1tfKxmLN1Qhf/Usw1oHRP4U4FE1GtYyFuHp
         m7By8cIoTWpFKc1nPMsr/RLdVquePQkibxtRx7xcnb6njCWCS6wh3VsIXQrF9Wmbgbhg
         HSXamw8RhLIjL09PGqXBmWjfM8n65QXsA47PD+sY3mivjb9rJMKUeY/LhWntudrjnjRB
         ciztiYIinVBLqCRDFZ9AKzDYBFDqe3aYtAk3K3TuKL1UBJVeckIEewJUoKEOHRrhouEL
         VT59MCJebALE6RRkNVhHhaADQg3rbqKbA7YvFOCHk8+0QC1A+B7qSK1dhYGhD5v7V0Lj
         FHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yc4/8+r9LFoveyNvlviiorm4oDVYhtlLmMrWk1tR/FQ=;
        b=iR9sw1YvubIqXOW+n8w6T4d0wKV3B35HDVNOjDdaq0rNPIClW9nIpThG6sIQoqGOJ7
         OVb8qeXPuNxOagfs9/CIN84wQvsXGbsINGywo5wSmyysrZPh6mFEambn/CUceT2avK5K
         nfh94J6j5tnytvPByAl6pYCdTrZVIK+inJhS14hrqzyvPD3tmX4UBIbJ+XPzZMMaOO9o
         yZNUua0jgx7riwJX8/uPA5L1HFRknaSJ3UGo/k0FZXFCX+9NyTl922AGm4RqffOmsYk4
         XnF6I+rWqPhusp6ukrBy2AeA5SKXodMyemMwLma5UzwdO/3LH2lRQi4nfq3focEhtk08
         xlyw==
X-Gm-Message-State: ANhLgQ2i/FZCIA0NdFIuYRAVEmndN9DlQ8GpUYgnbvjqfOwikQJBFGaq
        1sBYo9uLQ0hD70rIfl1o4jJSCqlojaVgV5EY
X-Google-Smtp-Source: ADFU+vsSRPq1z0lpvovd2o0tgcq1tUl6QnFH3+5MINTfcanV52K/pRNvKB4RbxUyJN1ZBdKd1mHbMQ==
X-Received: by 2002:a1c:418b:: with SMTP id o133mr23602224wma.165.1584292173830;
        Sun, 15 Mar 2020 10:09:33 -0700 (PDT)
Received: from localhost.localdomain (ipb218f56a.dynamic.kabel-deutschland.de. [178.24.245.106])
        by smtp.gmail.com with ESMTPSA id u25sm25874774wml.17.2020.03.15.10.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2020 10:09:33 -0700 (PDT)
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
Subject: [RFC PATCH 0/3] Fix quiet console in pre-panic scenarios
Date:   Sun, 15 Mar 2020 18:09:00 +0100
Message-Id: <20200315170903.17393-1-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear community,

The motivation behind this seris is to save days/weeks, if not months,
of debugging efforts for users who:

 * experience an issue like softlockup/hardlockup/hung task/oom, whose
   reproduction is not clear and whose occurrence rate is very low
 * are constrained to use a low loglevel value (1,2,3) in production
 * mostly rely on console logs to debug the issue post-mortem
   (e.g. saved to persistent storage via e.g. pstore)

As pointed out in the last patch from this series, under the above
circumstances, users might simply lack any relevant logs during
post-mortem analysis.

Why this series is marked as RFC is because:
 * There are several possible approaches to turn console verbosity on
   and off. Current series employs the 'ignore_loglevel' functionality,
   but an alternative way is to use the 'console_loglevel' variable. The
   latter is more intrusive, hence the former has been chosen as v1.
 * Manipulating 'ignore_loglevel' might be seen as an abuse, especially
   because it breaks the expectation of users who assume the system to
   be dead silent after passing loglevel=0 on kernel command line.

Thank you for your comments!

Eugeniu Rosca (3):
  printk: convert ignore_loglevel to atomic_t
  printk: add console_verbose_{start,end}
  watchdog: Turn console verbosity on when reporting softlockup

 include/linux/printk.h | 10 ++++++++++
 kernel/printk/printk.c | 30 ++++++++++++++++++++++++++----
 kernel/watchdog.c      |  4 ++++
 3 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.25.0

