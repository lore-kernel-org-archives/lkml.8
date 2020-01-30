Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB648C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AE72070E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="tEF/LwJu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgA3Cwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:52:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43802 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgA3Cwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:52:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so1275694qtj.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 18:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fp57d/JKXnMqmgYr0vSN02/fASnL3H+Ky3w8XxIPCaQ=;
        b=tEF/LwJupjgrD1yNKXCBInP8hYvl4p97L94ordXjGDRZuOVgeE/D4dWe5fbmDNYh2g
         BZTrzdydRdLD8pxIIaJibbW5Dl9HOVxuhoxUW2kCrKhSHcsd02TihcbxgGlj0uqOgrDs
         TNcbpbgK7KkW2tx3cl27fKI2C/Ev9lRcCBrU//n7jBRNLA6wTuilcwmjv0ECSI0yzcrs
         h389G7FOw1Zflpj9DDy19GWqHvwUhVHZbaox/6QvbDnLQcgtHVPYZo5Y0zJtZJ2Djh4E
         Fz2mR361rRrrgv4XKJjcsh1SWC+2/YLj0VAsZlLVZd5yjwtHb4JNEzIK10UAcoWX5HN+
         +0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Fp57d/JKXnMqmgYr0vSN02/fASnL3H+Ky3w8XxIPCaQ=;
        b=BSTeAfeBOenUY5751MTkFRQxLU6JmyOuoIAQpJ56mWdpOY/C8CRvFFK9Nuo0nheDl6
         ttI62c09cb2dkgwUW2i5KB/SftP7ksBGul9rAEq5rnEWGRMqBjLFGXYB4T+Fx/qylJCp
         rREpQF+JPBzq4DGYVP2hckXzyF0N8stvKJsOT+lu2yxQTnkJunm3GkZSu2PlA6/7FRUU
         hk2XOQXjgq6iL+3AsQlppMS1JsUZFdY8ajj+ego+laux7cI9tE5jM47xedXGYlh1jnto
         jK3+okO5c/Cx0ZO2+avAz8ZrfTa7KrVx1NnukAd9kkaUwBCTgMf0/wvOgCr9pqeuCg9W
         Ao4w==
X-Gm-Message-State: APjAAAWh3E2cGP9dzFktBmNmobjJhzup4lVBlVm1dXMxrX8rlni8ujey
        o57gSuhxBv1w57ICkwLm9gUYmg==
X-Google-Smtp-Source: APXvYqzmKdvh/9iYNgzjribGqy9CKBLO1mlwsETVrJbdJw981kmV06pWEvMMhXBCwLNp1ktxwY94RA==
X-Received: by 2002:ac8:1c1d:: with SMTP id a29mr2612883qtk.183.1580352754005;
        Wed, 29 Jan 2020 18:52:34 -0800 (PST)
Received: from ovpn-120-127.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 65sm2232926qtf.95.2020.01.29.18.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 18:52:33 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     dennis@kernel.org, tj@kernel.org, cl@linux.com, elver@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] mm/util: fix a data race in __vm_enough_memory()
Date:   Wed, 29 Jan 2020 21:51:33 -0500
Message-Id: <20200130025133.5232-1-cai@lca.pw>
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

Since only the read is operating as lockless, fix it by using
READ_ONLY() for it to avoid any possible false warning due to load
tearing.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..58cd8f28651c 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -798,7 +798,7 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 {
 	long allowed;
 
-	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
+	VM_WARN_ONCE(READ_ONCE(vm_committed_as.count) <
 			-(s64)vm_committed_as_batch * num_online_cpus(),
 			"memory commitment underflow");
 
-- 
2.21.0 (Apple Git-122.2)

