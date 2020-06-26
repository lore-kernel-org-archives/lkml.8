Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF84C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7414D20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 21:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8chcZTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgFZVI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 17:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZVI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 17:08:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658CCC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:08:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id u9so1094614pls.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 14:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYYBiW5KYj166vJSq/G36hCtyNGn0VKanV8kDYeJqbw=;
        b=g8chcZTR0srErqrUT8extI9VUyBH/2enu6uzhg3O8TIgSsx+JsTLgHoOqwY3M46Ay7
         sV5dTmy9gpwQsnb2tKN3VcqBBCFJ0e6kP9BWyuTlYn72sjVUduUn4RDCTRMWQ5zEoR4k
         6YqvjYzSK3Q0QF3QXcewT4VRBhdvpRZzDWkmKGkiOd5u17n9lMDNpiVcifCxXdC7rJng
         74LdlqmdvFF2gvhPDE19DzP460FubU0/zEAcqQldqT9lvMkenZN0R4WOouTcYwHgEMTV
         QEBzrD1Cea/xE/O8z6B7e0miXL/lEpFXANHCHmoN5/yfx3Vkrg+71/D9FANTaeWawmFq
         7TpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yYYBiW5KYj166vJSq/G36hCtyNGn0VKanV8kDYeJqbw=;
        b=HT/fBI3S44agROJQgMkbTGjcr5T6UuHC9Ts/GlpPaN24I6DpKZTK9vAYXQRfr8FUBj
         r3q9mGB4zj4diR8BQ2DhY5/MRJ10bYAdBDJlbSWoi9leEZJ9Cg0kyctF+UOvUb45yOYG
         iXFGTY7TMY84cF7kGv3sgPoiT+/9uglILYhMy/YbfFwRrfHTteUuE4X1VJovMN1fvAoB
         CS3NTxAnwRewwYkMPKGJEe6j0HaLFKISNp/oFyAK2xknGOTWWIhijoMHcTbqBbGs0ghp
         lWnUh3JKA6L1FijUPOWe5wLdbgLZzuoMFwcZZTkpZ8nVyQ3q4jXxJfOie7frmE0z+KSm
         R1LQ==
X-Gm-Message-State: AOAM531uPInHV1Go3W3vxzGPiPqHUUoctP+Q+W9qpNwVZDOXopLdeJzw
        uxq2rlrsEcihUv6H8yJfg08jnoCQwX4=
X-Google-Smtp-Source: ABdhPJyayLO1dEqg1VWK2Er8Yrb2W5rLHUbRoCeAfv8UMHkfhpxtIEa0woX6SD4Zx2S6YYxDXtOruQ==
X-Received: by 2002:a17:902:8544:: with SMTP id d4mr4262574plo.234.1593205706513;
        Fri, 26 Jun 2020 14:08:26 -0700 (PDT)
Received: from localhost (g2.222-224-226.ppp.wakwak.ne.jp. [222.224.226.2])
        by smtp.gmail.com with ESMTPSA id p19sm26691186pff.116.2020.06.26.14.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 14:08:25 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: [PATCH v2] init: Align init_task to avoid conflict with MUTEX_FLAGS
Date:   Sat, 27 Jun 2020 06:07:53 +0900
Message-Id: <20200626210754.3338389-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting on 32-bit machines (seen on OpenRISC) I saw this warning
with CONFIG_DEBUG_MUTEXES turned on.

    ------------[ cut here ]------------
    WARNING: CPU: 0 PID: 0 at kernel/locking/mutex.c:1242 __mutex_unlock_slowpath+0x328/0x3ec
    DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
    Modules linked in:
    CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-rc1-simple-smp-00005-g2864e2171db4-dirty #179
    Call trace:
    [<(ptrval)>] dump_stack+0x34/0x48
    [<(ptrval)>] __warn+0x104/0x158
    [<(ptrval)>] ? __mutex_unlock_slowpath+0x328/0x3ec
    [<(ptrval)>] warn_slowpath_fmt+0x7c/0x94
    [<(ptrval)>] __mutex_unlock_slowpath+0x328/0x3ec
    [<(ptrval)>] mutex_unlock+0x18/0x28
    [<(ptrval)>] __cpuhp_setup_state_cpuslocked.part.0+0x29c/0x2f4
    [<(ptrval)>] ? page_alloc_cpu_dead+0x0/0x30
    [<(ptrval)>] ? start_kernel+0x0/0x684
    [<(ptrval)>] __cpuhp_setup_state+0x4c/0x5c
    [<(ptrval)>] page_alloc_init+0x34/0x68
    [<(ptrval)>] ? start_kernel+0x1a0/0x684
    [<(ptrval)>] ? early_init_dt_scan_nodes+0x60/0x70
    irq event stamp: 0

I traced this to kernel/locking/mutex.c storing 3 bits of MUTEX_FLAGS in
the task_struct pointer (mutex.owner).  There is a comment saying that
task_structs are always aligned to L1_CACHE_BYTES.  This is not true for
the init_task.

On 64-bit machines this is not a problem because symbol addresses are
naturally aligned to 64-bits providing 3 bits for MUTEX_FLAGS.  Howerver,
for 32-bit machines the symbol address only has 2 bits available.

Fix this by setting init_task alignment to at least L1_CACHE_BYTES.

Signed-off-by: Stafford Horne <shorne@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
Changes since v1:
 - Make alignment unconditional suggested by Peter

 init/init_task.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/init_task.c b/init/init_task.c
index 15089d15010a..ab6173f8e6a8 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -65,6 +65,7 @@ struct task_struct init_task
 #ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
 	__init_task_data
 #endif
+	__aligned(L1_CACHE_BYTES)
 = {
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 	.thread_info	= INIT_THREAD_INFO(init_task),
-- 
2.26.2

