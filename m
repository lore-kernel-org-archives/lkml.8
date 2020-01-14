Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A427FC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701E124670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WEdiWoAH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgANXUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:20:07 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44458 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgANXUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:20:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id az3so5864050plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 15:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=+W/hJ8TzLATqZod3a/d6aLW1agOHCtatzoP3Zrx0ONs=;
        b=WEdiWoAHhSS5cith0JJnt9gzqlaQmn9e6YCl3KEIpAvdf9hH89FF7BxVO+fzRtd/0o
         7oiqJOUhS7lUkABkKtJ8Om4bI+38bBqx61xZr2hjaqmzQWKG0whBMAmJpZ5xa2Prk9ic
         09Tq4nNbswotDFH8GPs3GXll83WQK9hhnH4RnvfJ/MGwdRj5awsIOpTCy9yCLCPEqJQl
         SaMcgdAS62trXxEpN7dO/INmboHDOusiKbUDXNDT6hgHvNJiCEU8o6YuJpIqJ3nm3FE6
         +b99HXXPQbGDrWKDOcXFTBXfyCgQ/iJyk8ejmL3oukf0xsZW7LjFBnVurUHuYxBJJGp2
         Xs/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=+W/hJ8TzLATqZod3a/d6aLW1agOHCtatzoP3Zrx0ONs=;
        b=rzLveAxnmlvMFKPXpn2cNXcQnhbYxo/LJoZecbx/KXMfel/GqahbgVfjYlxMmWFfI1
         4LALcO+Vfk9I8g/wU/EgSsfWIl6w6xWnjvYc1sMH8RqpjuzX2Ssk1gQorW6ijMGxvX/b
         FZoR/lKDySWw9sN+YL8PObpGCY4GHedOtu3nW56M495hGvF7Tog0Fg8acUwtIIXCbI5V
         G1eanETjLSPlORirIip1YbAVj3tuLQPpQYpKbQIT1MjjVJDj8WeCQKgZQsL2Aribid7e
         9e6/2pVJzLpXzaYWVQa6cPEDKMgODF2mgB2bW+0skXe3oUYOSDbGUcVWzWzU0tPs6l6r
         MNYw==
X-Gm-Message-State: APjAAAVpOjQt1i7eyx5nJt5eW13IkAazO2oabqXFHzo2ran5yapXrNax
        w7QiuIIWkPCKjw/NmF/N2KOwirblay4=
X-Google-Smtp-Source: APXvYqx8JZSvymvRHUqirQm5dq/A28g8wevH1z+Oe5y4n6usub3bgOlLVXB2+nyjI4FvPWQM5kWTmA==
X-Received: by 2002:a17:902:b611:: with SMTP id b17mr12491949pls.23.1579044006207;
        Tue, 14 Jan 2020 15:20:06 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d22sm18150830pgg.52.2020.01.14.15.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:20:05 -0800 (PST)
Date:   Tue, 14 Jan 2020 15:20:04 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [patch] mm, oom: dump stack of victim when reaping failed
Message-ID: <alpine.DEB.2.21.2001141519280.200484@chino.kir.corp.google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a process cannot be oom reaped, for whatever reason, currently the
list of locks that are held is currently dumped to the kernel log.

Much more interesting is the stack trace of the victim that cannot be
reaped.  If the stack trace is dumped, we have the ability to find
related occurrences in the same kernel code and hopefully solve the
issue that is making it wedged.

Dump the stack trace when a process fails to be oom reaped.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 mm/oom_kill.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -26,6 +26,7 @@
 #include <linux/sched/mm.h>
 #include <linux/sched/coredump.h>
 #include <linux/sched/task.h>
+#include <linux/sched/debug.h>
 #include <linux/swap.h>
 #include <linux/timex.h>
 #include <linux/jiffies.h>
@@ -620,6 +621,7 @@ static void oom_reap_task(struct task_struct *tsk)
 
 	pr_info("oom_reaper: unable to reap pid:%d (%s)\n",
 		task_pid_nr(tsk), tsk->comm);
+	sched_show_task(tsk);
 	debug_show_all_locks();
 
 done:
