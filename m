Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC8C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C715324656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GjE6IBB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgBUQcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:32:18 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37435 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgBUQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:32:18 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so1681327qtk.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cXaywPD3pmPwWnHt9EIorfvYHMu3YxvGW8+pLbCFwtk=;
        b=GjE6IBB7kSgDFur2+gmu+w75yQ3pWKdgsUjmEmlwKmJfX6D990u2ssMpUcXUQAk1N0
         yAPdZnlTQZjoQZEuNF28ws2q0MzoIVYmjD8aALGeBsrLZlx2b6SQv4tS3NVrxWpwVliW
         g1Nm+9DxSG5OnUOlWsneQ25K/w3cDHuwyoPeLt4vF8k7dSb4BIs7EiHO2yQbdybynOSG
         VAmSW4jCrBHPECZG3u3+3157/iR1uW67/mi5ZjCHaexiJYH3QfKEPQB3WU2SwrN63Rj1
         19AWocC6uBZ2ehtZ9F8qy5DamGSSyn5iARwEvjd1bZsbWyD13lJsE9Ad31C0lg14QBk9
         cVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cXaywPD3pmPwWnHt9EIorfvYHMu3YxvGW8+pLbCFwtk=;
        b=X4hr1I2dYH1Nq6yiiKWNDjIYuxxNaLRB2W7BQcTP5KON8z1ggz7iDVAds1LVj0IkTb
         IOv79r2q0fwah4VDMudG/EcId0qMIOebGL9v27IUcfXosUBtQLhiduQA/cUtLtRk6Fhq
         KSMOboS9ZF+aJsKv/LwvH+CF8t/j0BukC5NuwOuAKYAJ7NBRAOVDcaVRS/x0c9g86yM2
         D+un96O//g4KJJq3lcXiHYNmMNtzhENUARLhcAJw20nuO1k9ERiTv8bJx4NsZ+h5/42d
         oVuqgUTHx4szOwL73oTadq8ZRBrBzAlMbcbHKaNx1WIxfQLoYY10SzZdtcpYXbpW6sYn
         z3hA==
X-Gm-Message-State: APjAAAXo2v+nsPJkrsRUJtl7OE9XHIJGTp6B+Q+TNOxuDCPsG7N/y837
        0NwIMOwo/fykEKKnzq4FvYwkxSk8Sqo=
X-Google-Smtp-Source: APXvYqzRT1G6f354xFAjVBF8mWhm3/fdyFxLMea7bS4t8zw6nXncb5AdQwv3Bi6DSKNKYvq7y+43qQ==
X-Received: by 2002:aed:3203:: with SMTP id y3mr33387658qtd.23.1582302737400;
        Fri, 21 Feb 2020 08:32:17 -0800 (PST)
Received: from qcai.nay.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u12sm1748006qke.67.2020.02.21.08.32.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2020 08:32:16 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     akpm@linux-foundation.org
Cc:     elver@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] percpu_counter: fix a data race at vm_committed_as
Date:   Fri, 21 Feb 2020 11:32:04 -0500
Message-Id: <1582302724-2804-1-git-send-email-cai@lca.pw>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"vm_committed_as.count" could be accessed concurrently as reported by
KCSAN,

 BUG: KCSAN: data-race in __vm_enough_memory / percpu_counter_add_batch

 write to 0xffffffff9451c538 of 8 bytes by task 65879 on cpu 35:
  percpu_counter_add_batch+0x83/0xd0
  percpu_counter_add_batch at lib/percpu_counter.c:91
  __vm_enough_memory+0xb9/0x260
  dup_mm+0x3a4/0x8f0
  copy_process+0x2458/0x3240
  _do_fork+0xaa/0x9f0
  __do_sys_clone+0x125/0x160
  __x64_sys_clone+0x70/0x90
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

 read to 0xffffffff9451c538 of 8 bytes by task 66773 on cpu 19:
  __vm_enough_memory+0x199/0x260
  percpu_counter_read_positive at include/linux/percpu_counter.h:81
  (inlined by) __vm_enough_memory at mm/util.c:839
  mmap_region+0x1b2/0xa10
  do_mmap+0x45c/0x700
  vm_mmap_pgoff+0xc0/0x130
  ksys_mmap_pgoff+0x6e/0x300
  __x64_sys_mmap+0x33/0x40
  do_syscall_64+0x91/0xb05
  entry_SYSCALL_64_after_hwframe+0x49/0xbe

The read is outside percpu_counter::lock critical section which results
in a data race. Fix it by adding a READ_ONCE() in
percpu_counter_read_positive() which could also service as the existing
compiler memory barrier.

Signed-off-by: Qian Cai <cai@lca.pw>
---
 include/linux/percpu_counter.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 4f052496cdfd..0a4f54dd4737 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -78,9 +78,9 @@ static inline s64 percpu_counter_read(struct percpu_counter *fbc)
  */
 static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
 {
-	s64 ret = fbc->count;
+	/* Prevent reloads of fbc->count */
+	s64 ret = READ_ONCE(fbc->count);
 
-	barrier();		/* Prevent reloads of fbc->count */
 	if (ret >= 0)
 		return ret;
 	return 0;
-- 
1.8.3.1

