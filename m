Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 651B3C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DAB12051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OKQhEaHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgCPOnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:43:20 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:55818 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbgCPOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:43:19 -0400
Received: by mail-pj1-f65.google.com with SMTP id mj6so8327737pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hUOD29Qz9wxCb9SVIhH0cNccaL8Zv3CoOxcGYUBasmI=;
        b=OKQhEaHCLvJrzLyQutU9znaEbEJsz2oNIvcoitAbb1ZoOY2BomUgmBNsgDtmUIvcua
         HqAW/nNbGAIaVhUs+jhMkFmiS8BzqgU1IVox+sP2aeDp9Kj9ruNPMN+jFG2Uq32pfqo0
         JBcy4Ljn4WQfB6GPG5kuC8gmGZ6Dfts+ntsMs44fu+UI1Mj7qU2Ctu8fq93+6IzXpezS
         zYg0SdtJUP0N9+sVXzSOZtpPsX2sUb1ACoseDA4Zr+E2CFcRHfVDMnf25+sISJ/m6yH/
         OHJNEEWuk7TfO+a3fGA4/Pq9Z/wJ7rgUioZZEPvQ8NbXCV/uErxajozWDXl3o0EnhhH+
         unRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hUOD29Qz9wxCb9SVIhH0cNccaL8Zv3CoOxcGYUBasmI=;
        b=NbsU0cXKK1oPhuUp4h1jiFAJfRrIyro4A86wuaUCIBzUWPAO8WX2rqLUv80YjYNRZq
         kd+zhI8ApiE5LM2P2Jp3rYr4A9m1HXeeqzxDAnoOaJGligPnMmW2/3yvy0U+ACF8hR9S
         FPthi3lc5kXdZGzXFJ855mWDHsFSFD1UMU7oXuT6sGLD6Dak6/oB71XkPHdjqeil8NjN
         zJlkhcqnrMrJP1RawZRJuHjcfyFFnGZg/osNNkc7XM+Pp3guV7FzdKGHS9YYEnrJj2dV
         t5xmDxOpmVoKhJd1kIUfL5QehSsoNSgwkdAnEkljwPb7FmjZe3gmgevU7QRZ46V7Gbci
         KL0g==
X-Gm-Message-State: ANhLgQ3TC+RLkMx365uab0xjgnLpUYlGZ8cphondIJPTrGeboS2tKUxi
        qnUxiaxHzS5g1i9izEbBvr23KFiR9vVx1g==
X-Google-Smtp-Source: ADFU+vtWvYmcbAZ3UnmGb3zOfxrNUSl6PNpw6yNGQOdRv+CFsOyTJvphB8wUCvSpaqwdTsNIR9/CmQ==
X-Received: by 2002:a17:90b:1997:: with SMTP id mv23mr5931498pjb.84.1584369797646;
        Mon, 16 Mar 2020 07:43:17 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:43:16 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCHv2 48/50] sched: Print stack trace with KERN_INFO
Date:   Mon, 16 Mar 2020 14:39:14 +0000
Message-Id: <20200316143916.195608-49-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aligning with other messages printed in sched_show_task() - use
KERN_INFO to print the backtrace.

Cc: Ben Segall <bsegall@google.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2284deb3a83b..bae2c84077bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5948,7 +5948,7 @@ void sched_show_task(struct task_struct *p)
 		(unsigned long)task_thread_info(p)->flags);
 
 	print_worker_info(KERN_INFO, p);
-	show_stack(p, NULL);
+	show_stack_loglvl(p, NULL, KERN_INFO);
 	put_task_stack(p);
 }
 EXPORT_SYMBOL_GPL(sched_show_task);
-- 
2.25.1

