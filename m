Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F529C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B91206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="gPH3wrPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgA3O5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:57:07 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37518 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgA3O5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:57:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id w47so2671431qtk.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 06:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZNin1fkHvBE9eW3g8NlOf6UaO9vwNWq4JoMAU8rk968=;
        b=gPH3wrPiBhJ1X1dzwiOUlqSDcnz9fUG8KhH5CL2Tov+tnlNFQiCFr0vsZvf4DrD4ql
         5vMSK2C6bUevX0L/2uJd3Papwp/y4DNkymkscVJl+1U0dxB/2YsCgl5m9DdhYvTtPAFz
         LzAKkp0XTgLvew6SAzlQluIq6qj4PcN4wLMTKqArt7aZzH34dxWJ2Xta8ZD2eG32AMNM
         9Spr3lPTnBQiwNMBFpAuCioOJBR6YcHPH9tcc1CFvtOpQelhp39EOH1xYelfF8aKhRa4
         z80vCrL2qaqu2zfxF8o3EyPvBEbaxRihHPFlOfp/TwNcX8tKcxk+wuxNpdFCZOvq+6eg
         137w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZNin1fkHvBE9eW3g8NlOf6UaO9vwNWq4JoMAU8rk968=;
        b=SPT9x1pqY/0fD1ktV/Yc38T2mEIKcgRJumyC8wM318qolP5ZWdNljkGbqbDmsZpFKu
         paRaJbeW0uWwiy1ksHel5NIwzZnoWhHbnQpXLxVKFU64anlZVnSHRKenCjuRNuAppaNd
         Yy9fbIzheNE1C5F/AvEsv+EHfa04weesMANMLuYt5N2wKfGjK4XPIhciF0DLXFpMgrrM
         XpxtzxiFK1ZOnp87oylhc/LvnmGK1AXgDIAPzam7VbzJ1w0Xf3w+K1hGQ06H2mpVgqeC
         7KMYpWLEcSlM37y7QgySqcBVrO0EQuoeYlCRRd54SB8Rvz8qsedzThuvakJL5B3SKzGa
         SuXQ==
X-Gm-Message-State: APjAAAVas+WIvtFpxXejGltuBMGaZeWJLTHUs25LkfKaPEjzQ4rGgbH8
        sSXEj2UlxTkzqL1c8DHGt61lAw==
X-Google-Smtp-Source: APXvYqx8U57433kel8PKdYA6yz39yF4h49woso5+R7mtiD7se9+X7qmo36Zm/yFzJAHbhcO2yc93/w==
X-Received: by 2002:ac8:4419:: with SMTP id j25mr5229623qtn.378.1580396225480;
        Thu, 30 Jan 2020 06:57:05 -0800 (PST)
Received: from ovpn-120-129.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y27sm3219559qta.50.2020.01.30.06.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 06:57:04 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next] mm/util: annotate an intentional data race
Date:   Thu, 30 Jan 2020 09:56:49 -0500
Message-Id: <20200130145649.1240-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"vm_committed_as.count" could be accessed concurrently as reported by
KCSAN,

 read to 0xffffffff923164f8 of 8 bytes by task 1268 on cpu 38:
  __vm_enough_memory+0x43/0x280 mm/util.c:801
  mmap_region+0x1b2/0xb90 mm/mmap.c:1726
  do_mmap+0x45c/0x700
  vm_mmap_pgoff+0xc0/0x130
  vm_mmap+0x71/0x90
  elf_map+0xa1/0x1b0
  load_elf_binary+0x9de/0x2180
  search_binary_handler+0xd8/0x2b0
  __do_execve_file+0xb61/0x1080
  __x64_sys_execve+0x5f/0x70
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 write to 0xffffffff923164f8 of 8 bytes by task 1265 on cpu 41:
  percpu_counter_add_batch+0x83/0xd0 lib/percpu_counter.c:91
  exit_mmap+0x178/0x220 include/linux/mman.h:68
  mmput+0x10e/0x270
  flush_old_exec+0x572/0xfe0
  load_elf_binary+0x467/0x2180
  search_binary_handler+0xd8/0x2b0
  __do_execve_file+0xb61/0x1080
  __x64_sys_execve+0x5f/0x70
  do_syscall_64+0x91/0xb47
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The warning is almost impossible to trigger according to the commit
82f71ae4a2b8 ("mm: catch memory commitment underflow") but leave it for
now to catch any possible unbalanced vm_unacct_memory() in the future.
Since only the read is operating as lockless, mark it as an intentional
data race using the data_race() macro.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..528d2c710771 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -798,8 +798,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 {
 	long allowed;
 
-	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
-			-(s64)vm_committed_as_batch * num_online_cpus(),
+	VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as) <
+			-(s64)vm_committed_as_batch * num_online_cpus()),
 			"memory commitment underflow");
 
 	vm_acct_memory(pages);
-- 
2.21.0 (Apple Git-122.2)

