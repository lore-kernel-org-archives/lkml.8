Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C8EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5FC22CA0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595313214;
	bh=42hmmXQJOOWCmw4Tgk574pBzovphCaf9MlOYp6UqC30=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=yJZf35F+84fFdmuIAeKkVpoyn6TqbvxBLQHsheK6zNZ19If/vl6YD8SEKxjT4SDT8
	 I0XaNFiXT10rVPINp1EM73meNg+E5p92K80jaUOSmoyY/xis8iaRsV9s9NH5EBA+/9
	 5iZPlm6oyiIPP054RzwRZjfHuKZ7ox5R9OykHfe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgGUGdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:33:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36587 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgGUGdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:33:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id 88so9704409wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 23:33:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tV1LRzNgPSEgDwGe9LGBIejRICI799y9RAnDI8eKpbg=;
        b=op0tW9oUBuuQLj+2DGezQxxHW/iMjx4ZtZQ336mDHeAY3LHAFgFVg3/NBVHMU0RdOA
         ELafIXRdLKAXkCNX76n0TOsul1W7/H1D/io1Pezulryd+azs1UjD+WKFFdg2Z5ArLsWz
         hXf+xGIzkJkEUe21MYCjWA6fk4V0UBpt+NILG1twPsAuiqosetMf1vmwWrI6DAce8t3U
         moFELLbwA7Y/zjrbUGDTFN+WtDXB5h/SPmo9rxxhrlf/+WnmbDK2fO8/m+pQ0AtaOC4X
         qMw4/khZd3artIQLu94ajbBNmg3xkyIn9d6NC1lgvKMuZ+1tbSJmk1+ZTj1isCUEH8JY
         fI1Q==
X-Gm-Message-State: AOAM531IA3GKxi3v1y15pnVF3PWx+6ztvqPNY0rMHTxuWLQEuEj8K4WT
        TM7fcQZbTqco4YgZUMKo75GuSvR3
X-Google-Smtp-Source: ABdhPJxiB/dYqgFor+GO+S7YCh7ZoYChxfsvo91Dw+1AOToJGHEczK4ZX3skesAUKaqixM9i4q+sjQ==
X-Received: by 2002:a5d:6702:: with SMTP id o2mr462986wru.364.1595313210451;
        Mon, 20 Jul 2020 23:33:30 -0700 (PDT)
Received: from tiehlicka.suse.cz (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id q7sm36617204wra.56.2020.07.20.23.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 23:33:29 -0700 (PDT)
From:   Michal Hocko <mhocko@kernel.org>
To:     <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH] mm: silence soft lockups from unlock_page
Date:   Tue, 21 Jul 2020 08:32:58 +0200
Message-Id: <20200721063258.17140-1-mhocko@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michal Hocko <mhocko@suse.com>

We have seen a bug report with huge number of soft lockups during the
system boot on !PREEMPT kernel
NMI watchdog: BUG: soft lockup - CPU#1291 stuck for 22s! [systemd-udevd:43283]
[...]
NIP [c00000000094e66c] _raw_spin_lock_irqsave+0xac/0x100
LR [c00000000094e654] _raw_spin_lock_irqsave+0x94/0x100
Call Trace:
[c00002293d883b30] [c0000000012cdee8] __pmd_index_size+0x0/0x8 (unreliable)
[c00002293d883b70] [c0000000002b7490] wake_up_page_bit+0xc0/0x150
[c00002293d883bf0] [c00000000030ceb8] do_fault+0x448/0x870
[c00002293d883c40] [c000000000310080] __handle_mm_fault+0x880/0x16b0
[c00002293d883d10] [c000000000311018] handle_mm_fault+0x168/0x250
[c00002293d883d50] [c00000000006c488] do_page_fault+0x568/0x8d0
[c00002293d883e30] [c00000000000a534] handle_page_fault+0x18/0x38

on a large ppc machine. The very likely cause is a suboptimal
configuration when systed-udev spawns way too many workders to bring the
system up.

The lockup is in page_unlock in do_read_fault and I suspect that this is
yet another effect of a very long waitqueue chain which has been
addresses by 11a19c7b099f ("sched/wait: Introduce wakeup boomark in
wake_up_page_bit") previously. The commit primarily aimed at hard lockup
prevention but it doesn't really help !PREEMPT case which still has to
process all the work without any rescheduling point. This is however not
really trivial because page_unlock is called from many contexts many of
which are likely called from an atomic context.

Introducing page_unlock_sleepable is certainly an option but it seems
like a hard to maintain option which doesn't really fix the underlying
problem as the same might happen from other unlock_page callers. This
patch doesn't address the underlying problem but it reduces the visible
effect. Tell the soft lockup to shut up when retrying batches on queued
waiters. This will also allow systems configured to panic on warning to
proceed with the boot.

Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/filemap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 385759c4ce4b..74681c40a6e5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -41,6 +41,7 @@
 #include <linux/delayacct.h>
 #include <linux/psi.h>
 #include <linux/ramfs.h>
+#include <linux/nmi.h>
 #include "internal.h"
 
 #define CREATE_TRACE_POINTS
@@ -1055,6 +1056,7 @@ static void wake_up_page_bit(struct page *page, int bit_nr)
 		 */
 		spin_unlock_irqrestore(&q->lock, flags);
 		cpu_relax();
+		touch_softlockup_watchdog();
 		spin_lock_irqsave(&q->lock, flags);
 		__wake_up_locked_key_bookmark(q, TASK_NORMAL, &key, &bookmark);
 	}
-- 
2.27.0

