Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9310CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F12020674
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 12:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595678749;
	bh=A6K7t8znRQiQbAWSBNk19vniPdOsJizMevMVrUGBD/M=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ujJ5pRxe/Z8f8L1Y75s1YpqRVzRxAtR5v5h0LjIRS3NtX9MFNo2CWSpKkvbjjrGzc
	 ShRJtQCVYNqZpe5wCSAl9xNbOsBAQnlPVmfGXBjZYXVs21irUEnMXM2wBfjHE4ZOo7
	 ENHcZAt7dD1jki/cwttx5FKki8vM76OkN1fWwp4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgGYMFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 08:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgGYMFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 08:05:46 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5BC0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 05:05:44 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so12571060ejb.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 05:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=CSxGyxNsQVznG7Pen6m56Z42LrtXhMajilGgCGUvCLA=;
        b=M9ObfnSZLRoRYx7K2kFjXdQ5zKFG7NByKyTl9oK5zQDMQo+dpscU3JtqZ2fqzLpkaA
         w7vuy3CjtDvpAQGCSMydp3tvdnoJNl6NEASC81v2UUi3OlzqN1c3d9pMl71S2FyjvetV
         Uitz9Xv62LS2e2v3h8tG/ntFwxf9Kmq3/FNWGaG9CPg48Y6yZEq4kHxFsxk3tdHogMww
         QPOWVyNk9BeVNLmbVfIqHnDxPkB9RfO2bUYxPhpnpW2CTP+o6KGynmUXXd/heFFS0Vef
         RnQO++GOuIBkIwVgLoVVibpV3nn16DbAPLZe5JCmrbQBYbHTC++7PiYJ84u7OvsGak7T
         yb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=CSxGyxNsQVznG7Pen6m56Z42LrtXhMajilGgCGUvCLA=;
        b=pT3up7W9WfOONFHqPiZMjge2jGZf5q815uaekT2Ak5cDP+oIz8wAT+bRpb7PEeoNLF
         V4Nl5ympWgQbJ8J1VC/XDwi1M63RXJyQ8kr+YgmWzPGPgvmAukDhc2fAFbXMHjRZk+/A
         ENhoGdowKAoOC8f0Ecdusk1Iz7TfgirfJgr5PysM+DQFE6INdTfnb7Ze0lF88aDa1pkI
         gh4OD/K6PMQfYCtsSnX5ZMZQfaw5X5Beb8ZyjZy/YsXI+pgEf4D69sKenaHwcFiLHWea
         +yeRQeBrJRL35MJeMP2q/8bspSqu1FZwtfFdQfO6K6JwIPU9KVUXjIgX9eLsP5lnYbm7
         5/Mg==
X-Gm-Message-State: AOAM533atX9mFI2y/occkLESxvGPDJBxKHrKd0OrBrIWqdY8SaeTXtjO
        1rmfHhnQ+5cQuO3C5cdn0qsuEbs5
X-Google-Smtp-Source: ABdhPJw78BOxw6ZUtoAELYtuAsbesH9lWywNHpvL4KVIwA5DKCvOyTHyclzKXeQbbY3AK0rHKQZv3w==
X-Received: by 2002:a17:906:374f:: with SMTP id e15mr6061376ejc.528.1595678743211;
        Sat, 25 Jul 2020 05:05:43 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id v9sm2646694ejd.102.2020.07.25.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 05:05:42 -0700 (PDT)
Date:   Sat, 25 Jul 2020 14:05:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] uprobes fix
Message-ID: <20200725120540.GA1010068@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2020-07-25

   # HEAD: fe5ed7ab99c656bd2f5b79b49df0e9ebf2cead8a uprobes: Change handle_swbp() to send SIGTRAP with si_code=SI_KERNEL, to fix GDB regression

Fix a interaction/regression between uprobes based shared library tracing & GDB.

 Thanks,

	Ingo

------------------>
Oleg Nesterov (1):
      uprobes: Change handle_swbp() to send SIGTRAP with si_code=SI_KERNEL, to fix GDB regression


 kernel/events/uprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bb0862873dba..5f8b0c52fd2e 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2199,7 +2199,7 @@ static void handle_swbp(struct pt_regs *regs)
 	if (!uprobe) {
 		if (is_swbp > 0) {
 			/* No matching uprobe; signal SIGTRAP. */
-			send_sig(SIGTRAP, current, 0);
+			force_sig(SIGTRAP);
 		} else {
 			/*
 			 * Either we raced with uprobe_unregister() or we can't
