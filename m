Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D945C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FB28206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 03:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9QgZEWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbgAMDXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 22:23:19 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36822 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733020AbgAMDXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 22:23:19 -0500
Received: by mail-pj1-f66.google.com with SMTP id n59so3650540pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 19:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tuL/sUzlzZyNW35DUcDDiOxQ2sElchyKRZIw9ifc/VM=;
        b=C9QgZEWvcMn2jqlpJ+FWjpvALoeVJL2WLA7ZhF22RqsitJeARvwXpUNPpqx9Utbo2F
         +PLqRD+rxDA1j815sPkf+cG7P0QCpjx0Qiy1SCBfiRK+7wlo/1ULx3foHquOLXUgEnC9
         67yxkR7lNRtKUAJa6ELpGTR1vI04Ba/Kdcwt9QTP2B3V/fN7hgiMy6v+S+Tts7vmwXih
         GShCaADo+QLDcyyiHo4M8++zKlO/6MlpAVWWzYJN43Mg8Q4tB4YJT1i3tUliQ3pUyZnE
         jz/jRa9PN7wPy23RtDPrBauxe3uUp8FxmTwVUm5St1KhqolJLsquh98yBO3Gkaaibl9H
         8zlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tuL/sUzlzZyNW35DUcDDiOxQ2sElchyKRZIw9ifc/VM=;
        b=lnMVKzTNS0eEbcZD94/bZrS4lwyb2R0Wm1gb0H4/g8kqmcfVeJp9vFQYkK6y3fTuXQ
         Yo4WliQnGfYUvV7sLvxiEMeeqAJ0tNpPHXJNJuVEpLrwASYDZEa8TT/prPkB3kgFXcJm
         67Fwlyb5UGca18ngA/WxXTszsct677cGUHv1Sxski53mQ90rti/6zuOez1HRcIiABJrU
         KW4q0gl9k0favIA2qSeS7B+FH514zRsnc1PKQZIp1A3KX+gZ8dG1bELkgp16XlWOiY0k
         Eh80frQXYcpmysmNscHOdlgQFt1iClYQaVhy1XI+RjZaXzlvv5l+7ec6SEsPMXhq7TPW
         fdRA==
X-Gm-Message-State: APjAAAVm+fiQwL6RDto6DL7voobOD1vAcb8R25gS+lQxn3LIZdU6T3C5
        U7eFrw85Bve9zOYPc2hx6JVus1kx788=
X-Google-Smtp-Source: APXvYqxNwAQaG6At2rkySC52oLtC5VBQCeBbKacI3QcfkT37afSx+1J+ZsJbnaepWABFXrTfvZogvw==
X-Received: by 2002:a17:902:26a:: with SMTP id 97mr11701262plc.74.1578885798230;
        Sun, 12 Jan 2020 19:23:18 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id s131sm12638203pfs.135.2020.01.12.19.23.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Jan 2020 19:23:17 -0800 (PST)
From:   qiwuchen55@gmail.com
To:     christian.brauner@ubuntu.com, peterz@infradead.org,
        mingo@kernel.org, tglx@linutronix.de, oleg@redhat.com,
        elena.reshetova@intel.com, jgg@ziepe.ca, christian@kellner.me,
        aarcange@redhat.com, viro@zeniv.linux.org.uk, cyphar@cyphar.com,
        ldv@altlinux.org
Cc:     linux-kernel@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>
Subject: [PATCH] kernel/fork: put some fork variables into read-mostly section
Date:   Mon, 13 Jan 2020 11:23:13 +0800
Message-Id: <1578885793-24095-1-git-send-email-qiwuchen55@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chenqiwu <chenqiwu@xiaomi.com>

Since total_forks/nr_threads/max_threads global variables are
frequently used for process fork, putting these variables into
read_mostly section can avoid unnecessary cache line bouncing.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 kernel/fork.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 0808095..163e152 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -120,10 +120,10 @@
 /*
  * Protected counters by write_lock_irq(&tasklist_lock)
  */
-unsigned long total_forks;	/* Handle normal Linux uptimes. */
-int nr_threads;			/* The idle threads do not count.. */
+unsigned long total_forks __read_mostly; /* Handle normal Linux uptimes. */
+int nr_threads __read_mostly;  /* The idle threads do not count.. */
 
-static int max_threads;		/* tunable limit on nr_threads */
+static int max_threads __read_mostly; /* tunable limit on nr_threads */
 
 #define NAMED_ARRAY_INDEX(x)	[x] = __stringify(x)
 
-- 
1.9.1

