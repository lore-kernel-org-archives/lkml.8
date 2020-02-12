Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29442C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D85206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="J7K7FCFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgBLOfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:35:25 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43807 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgBLOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:35:24 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so2202737qkh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 06:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=5H+ytVXAlSIDd672XrGaeP1xTzQC9Kh/R6V2+KHWLTY=;
        b=J7K7FCFbZRwrJb3Q+P7eJKiwdE/0J6PYJFAy0oTD5YWB7lVxPIyz7mb4kGSYB7f5ai
         GOl1OBkENvmFQh+biNB5124mMtZGq6OE+jeGeKm+fLvo0ejxGAx6b5DQ1INbFoofJvBZ
         mutqVIJ8CxHsw8LZitpsUperrnkczXQJ7H1mtFP8vfsCbziI/6XDy8MDc6MDZCf877dJ
         8duSgt1UXtpTqXbFnQig0ZAOHwyAGzILldc0Ery+QBC/B41ThIMSP99nOvrhiJBv8/fN
         6IGnCdR0gVNydp1V1iCmUxJ2e7DAnvTv9tDD+ZXAXPZJUk1cW5SmKXQ9plauBwfTxNVL
         xndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5H+ytVXAlSIDd672XrGaeP1xTzQC9Kh/R6V2+KHWLTY=;
        b=JEcu/fKgabBPog4I3+HJc4z3Qt46LiB82tMxIZtnUFw+bNX0Z7/CJ+kr88W713bXS3
         UNW9X/RvmRwVA0EjxPs+03jgcRLCX5VF7vPfRUdD1kl5zVAL5xp1HdoXj3VwQEmS8AOZ
         r1jIsp12psyOYe33MXv5enEFAA87LfA4WqiRPUssMLb2/ElMMpGqs+rEZ/ymSWEI4j2E
         avx+Jf4S0tvJZsXba5pcZQ0TBUb6RwgNiKFt1DGmqaJp7enpJxQ4LVa4ddBOQPZjMeFM
         hHxa0GLCsQy8mHle3vowCO/H2u3v98WM28MClBbn+7Tt8GMgde5LVYZ1w36ulGdB85hF
         rlhg==
X-Gm-Message-State: APjAAAXcbBQ23LkXZwwE7p7M9OiiBKM39y65Is2towDGusR47jmWGBJY
        U5Dw2m5v9OQj/At/AIcfEshAGWDErQ+P4w==
X-Google-Smtp-Source: APXvYqyEa1H60nZBFw4XsuMsuH61cc7gjm3HhNPri45OkYhkSKhHVSiCuhjTDa72DZ4gZLHmtjTFDA==
X-Received: by 2002:ae9:edc4:: with SMTP id c187mr2983448qkg.34.1581518123593;
        Wed, 12 Feb 2020 06:35:23 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v10sm245191qtp.22.2020.02.12.06.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 06:35:21 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, elver@google.com, cl@linux.com, dennis@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH -next v2] mm/util: annotate an data race at vm_committed_as
Date:   Wed, 12 Feb 2020 09:35:09 -0500
Message-Id: <1581518109-21180-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
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
data race using the data_race() macro to avoid modifying
percpu_counter_read() and still catch unintended races elsewhere.

Acked-by: Christoph Lameter <cl@linux.com>
Acked-by: Dennis Zhou <dennis@kernel.org>
Signed-off-by: Qian Cai <cai@lca.pw>
---

v2: add some code comments.

 mm/util.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/util.c b/mm/util.c
index 988d11e6c17c..cc89e2404e19 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -798,8 +798,12 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
 {
 	long allowed;
 
-	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
-			-(s64)vm_committed_as_batch * num_online_cpus(),
+	/*
+	 * A transient decrease in the value is unlikely, so no need
+	 * READ_ONCE() for vm_committed_as.count.
+	 */
+	VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as) <
+			-(s64)vm_committed_as_batch * num_online_cpus()),
 			"memory commitment underflow");
 
 	vm_acct_memory(pages);
-- 
1.8.3.1

